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
│  CustomInjector registra:                                        │
│  ├── Services          (Singletons)                              │
│  │   └─ AuthServices                                             │
│  │   └─ FirestoneFirebaseService                                 │
│  │   └─ MessageService                                           │
│  │                                                               │
│  ├── Repositories       (LazySingletons)                         │
│  │   └─ IAuthRepository (AuthRepositoryImpl)                     │
│  │   └─ IUserRepository (UserRepositoryImpl)                     │
│  │   └─ IMessagerRepository (MessagerRepository)                 │
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
│  ✅ _injector.get<T>() ← Função para acessar o injector         │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│         provider.dart (Providers.provider)                       │
│                                                                  │
│  class Providers {                                               │
│    List<SingleChildStatelessWidget> get provider {              │
│      return [                                                    │
│        ViewModelProvider<AuthViewModel>(),                       │
│        ↑                                                         │
│        └─ Injeta via CustomInjector                              │
│                                                                  │
│        ViewModelProvider<HomeViewModel>(),                       │
│        ViewModelProvider<ChatViewModel>(),                       │
│      ];                                                          │
│    }                                                             │
│  }                                                               │
│                                                                  │
│  class ViewModelProvider<T extends Viewmodel>                    │
│      extends ChangeNotifierProvider<T> {                         │
│    ViewModelProvider({super.key, super.child})                  │
│      : super(create: (context) =>                                │
│          _injector.getViewmodel<T>()                              │
│        );                                                        │
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
│  ✅ ViewModels acessam Repositories/UseCases via CustomInjector:│
│     No construtor: AuthViewModel(                                │
│       IAuthRepository authRepository,  ← Injetado por CustomInj │
│       UserUseCase useCase,                                       │
│     )                                                            │
└─────────────────────────────────────────────────────────────────┘
```

## ✅ Benefícios desta Arquitetura

| Aspecto | Benefício |
|---------|-----------|
| **AutoInjector** | Gerencia ciclo de vida, resoluções automáticas, tipos complexos |
| **Provider** | Distribuição reativa na árvore, hot reload, rebuild automático |
| **Separação** | DI centralizado via CustomInjector, UI distribution via Providers |
| **Performance** | Services/Repos são Singletons (criados 1x), ViewModels novos |
| **Testabilidade** | Fácil mockar com `_injector.getViewmodel<Interface>()` em testes |

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
        if (authVm.isLogged) Text('Logado!'),
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
Provider chama _injector.getViewmodel<AuthViewModel>() [obtém do CustomInjector]
  ↓
CustomInjector executa:
  AuthViewModel(
    IAuthRepository authRepo,     ← _injector.getRepository<IAuthRepository>()
    UserUseCase useCase           ← _injector.getUseCase<UserUseCase>()
  )
    ↓
  IAuthRepository authRepo está já resolvido? SIM (Lazy Singleton)
    ↓
  AuthRepositoryImpl(
    AuthServices authServices     ← resolvido do Singleton
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
