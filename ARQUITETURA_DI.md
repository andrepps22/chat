# 🏗️ Arquitetura de Dependency Injection

## Fluxo de Funcionamento

```
┌─────────────────────────────────────────────────────────────────┐
│                        main.dart                                 │
│  1. setupDependencies()  ← Inicializa AutoInjector             │
│  2. runApp(MultiProvider(                                        │
│       providers: Providers().provider  ← Distribui na árvore    │
│     ))                                                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│           dependencies.dart (setupDependencies)                  │
│                                                                  │
│  AutoInjector registra:                                          │
│  ├── Services          (Singletons)                              │
│  │   └─ AuthServices                                             │
│  │   └─ FirestoneFirebaseService                                 │
│  │   └─ MessageService                                           │
│  │                                                               │
│  ├── Repositories       (LazySingletons)                         │
│  │   └─ IAuthRepository (impl)                                   │
│  │   └─ IUserRepository (impl)                                   │
│  │   └─ IMessagerRepository (impl)                               │
│  │                                                               │
│  ├── UseCases           (LazySingletons)                         │
│  │   └─ UserUseCase                                              │
│  │   └─ ChatUseCase                                              │
│  │                                                               │
│  └── ViewModels         (Não-Singletons - nova instância)       │
│      └─ AuthViewModel                                            │
│      └─ HomeViewModel                                            │
│      └─ ChatViewModel                                            │
│                                                                  │
│  ✅ _injector.commit() ← Compila todas as dependências           │
│  ✅ getIt<T>() ← Função global para acessar o injector          │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│            provider.dart (Providers.provider)                    │
│                                                                  │
│  class Providers {                                               │
│    List<SingleChildStatelessWidget> get provider {              │
│      return [                                                    │
│        ChangeNotifierProvider<AuthViewModel>(                    │
│          create: (_) => getIt<AuthViewModel>()                  │
│          ↑                   ↑                                    │
│          │                   └─ AutoInjector fornece             │
│          └─ Provider distribui na árvore                         │
│        ),                                                        │
│        ChangeNotifierProvider<HomeViewModel>(                    │
│          create: (_) => getIt<HomeViewModel>()                  │
│        ),                                                        │
│        ChangeNotifierProvider<ChatViewModel>(                    │
│          create: (_) => getIt<ChatViewModel>()                  │
│        ),                                                        │
│      ];                                                          │
│    }                                                             │
│  }                                                               │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│                  Widget Tree                                     │
│                                                                  │
│  ✅ Views acessam via Provider:                                  │
│     context.watch<AuthViewModel>()   ← Reatividade              │
│     context.read<AuthViewModel>()    ← Acesso único              │
│                                                                  │
│  ✅ ViewModels acessam Repositories via AutoInjector:           │
│     No construtor: AuthViewModel(                                │
│       IAuthRepository authRepository,  ← Injetado por AutoInj   │
│       UserUseCase useCase,                                       │
│     )                                                            │
└─────────────────────────────────────────────────────────────────┘
```

## ✅ Benefícios desta Arquitetura

| Aspecto | Benefício |
|---------|-----------|
| **AutoInjector** | Gerencia ciclo de vida, resoluções automáticas, tipos complexos |
| **Provider** | Distribuição reativa na árvore, hot reload, rebuild automático |
| **Separação** | DI centralizado, UI distribution centralizado |
| **Performance** | Services/Repos são Singletons (criados 1x), ViewModels novos |
| **Testabilidade** | Fácil mockar com `getIt<Interface>()` em testes |

## 📝 Exemplo de Uso nas Views

```dart
// ✅ AuthView
class AuthView extends StatefulWidget {
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    // Reatividade automática com Provider
    final authVm = context.watch<AuthViewModel>();
    
    return Column(
      children: [
        // UI que rebuilda quando authVm muda
        if (authVm.islogged) Text('Logado!'),
      ],
    );
  }
}

// ✅ HomeView
class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Acesso único sem rebuild
    context.read<HomeViewModel>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final homeVm = context.watch<HomeViewModel>();
    // Usar homeVm.usersList, etc.
  }
}
```

## 🔄 Fluxo de Criação de Instâncias

```
1º Clique em "Login"
  ↓
context.read<AuthViewModel>() [obtém do Provider]
  ↓
Provider chama getIt<AuthViewModel>() [obtém do AutoInjector]
  ↓
AutoInjector executa:
  AuthViewModel(
    IAuthRepository authRepo,     ← getIt<IAuthRepository>()
    UserUseCase useCase           ← getIt<UserUseCase>()
  )
    ↓
  IAuthRepository authRepo está já resolvido? SIM (Lazy Singleton)
    ↓
  AuthRepositoryImpl(
    AuthServices authServices     ← getIt<AuthServices>()
  )
    ↓
  AuthServices já criado? SIM (Singleton)
    ↓
✅ AuthViewModel criado e retornado ao Provider
  ↓
✅ Provider distribui na árvore
```

## 🎯 Resumo: Quem faz o quê?

| Componente | Responsabilidade |
|-----------|------------------|
| **AutoInjector** | Criar e gerenciar instâncias (DI container) |
| **Provider** | Distribuir ViewModels na árvore de widgets |
| **Views** | Consumir ViewModels via context.watch/read |
| **ViewModels** | Lógica de negócio e estado da UI |
| **Repositories** | Acesso a dados (abstraem Services) |
| **Services** | Comunicação externa (Firebase, APIs) |
