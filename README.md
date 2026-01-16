# 💬 Chat App - Flutter

Um aplicativo de chat em tempo real desenvolvido em **Flutter** com **Firebase** como backend, implementando uma arquitetura profissional baseada em **MVVM** com **Dependency Injection**.

> **Projeto desenvolvido como portfólio para demonstrar conhecimentos em arquitetura limpa, padrões de design e boas práticas em desenvolvimento Flutter.**

---

## 🎯 Sobre o Projeto

### O que é?

Um aplicativo de mensagens em tempo real que permite:
- ✅ Autenticação com Firebase (Login/Register)
- ✅ Listar usuários cadastrados
- ✅ Enviar e receber mensagens em tempo real
- ✅ Suporte a Light/Dark Mode
- ✅ Navegação baseada em estado de autenticação

### Stack Tecnológico

```
Frontend:      Flutter 3.10+
Backend:       Firebase (Auth + Firestore)
State Mgmt:    Provider + AutoInjector
Architecture:  MVVM
Pattern Design: Repository, UseCase, Command
Error Handling: Result Pattern (Sealed Classes)
```

### Plataformas Suportadas
- ✅ Android
- ✅ iOS

---

## 🏗️ Arquitetura

### Estrutura de Pastas

```
lib/
├── core/
│   ├── auth/                    # Estados de autenticação
│   │   └── e_auth_state.dart
│   ├── config/
│   │   └── dependencies.dart    # Setup do AutoInjector + Provider
│   ├── provider/
│   │   └── provider.dart        # Distribuição de ViewModels
│   ├── router/
│   │   └── app_router.dart      # Navegação
│   ├── theme/
│   │   └── app_theme.dart       # Temas Light/Dark
│   └── utils/
│       ├── custom_injector.dart # Wrapper do AutoInjector
│       └── result.dart          # Result<S, E> pattern
│
├── data/
│   ├── domain/
│   │   ├── contract/            # Abstract classes
│   │   │   ├── repository.dart
│   │   │   ├── service.dart
│   │   │   ├── use_case.dart
│   │   │   └── viewmodel.dart
│   │   ├── interfaces/          # Contracts de Repository
│   │   │   ├── i_auth_repository.dart
│   │   │   ├── i_user_repository.dart
│   │   │   └── i_messager_repository.dart
│   │   ├── use_cases/           # Orquestração de negócio
│   │   │   ├── user_use_case.dart
│   │   │   └── chat_use_case.dart
│   │   └── DTOs/                # Data Transfer Objects
│   │       ├── user_dto.dart
│   │       └── send_messager_dto.dart
│   │
│   ├── models/                  # Models de domínio
│   │   ├── user_model.dart
│   │   └── message_model.dart
│   │
│   ├── repository/              # Implementações de Repository
│   │   ├── auth_repository_impl.dart
│   │   ├── user_repository_impl.dart
│   │   └── messager_repository.dart
│   │
│   └── services/                # Serviços externos (Firebase)
│       ├── auth_services.dart
│       ├── firestone_firebase_service.dart
│       └── message_service.dart
│
├── view/
│   ├── auth_view/               # Tela de Autenticação
│   │   ├── auth_view.dart
│   │   ├── auth_view_model.dart
│   │   └── auth_gate.dart       # Proteção de rotas
│   │
│   ├── home/                    # Tela principal
│   │   ├── home_view.dart
│   │   └── home_view_model.dart
│   │
│   ├── chat/                    # Tela de chat
│   │   ├── chat_view.dart
│   │   └── chat_view_model.dart
│   │
│   ├── components/              # Componentes reutilizáveis
│   │   ├── custom_button.dart
│   │   └── custom_textfield.dart
│   │
│   └── load_view/               # Tela de carregamento
│       └── load_view.dart
│
└── view_models/
    ├── command.dart             # Pattern Command para async
    ├── auth_view_model.dart
    ├── home_view_model.dart
    └── chat_view_model.dart
```

### Fluxo MVVM + DI

```
┌─────────────────────────────────────────────────────┐
│ main.dart                                           │
│ ├─ setupDependencies() ← AutoInjector               │
│ └─ MultiProvider() ← Provider distribui ViewModels  │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│ AutoInjector (dependencies.dart)                    │
│ ├─ Services (Singleton)                             │
│ ├─ Repositories (LazySingleton)                      │
│ ├─ UseCases (LazySingleton)                          │
│ └─ ViewModels (Non-Singleton)                        │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│ Widget Tree (Provider distribui)                     │
│ ├─ context.watch<ViewModel>() → Reatividade        │
│ └─ context.read<ViewModel>() → Acesso único         │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Como Rodar

### Pré-requisitos

```bash
Flutter SDK >= 3.10.1
Dart >= 3.10.1
Git
```

### Instalação

```bash
# 1. Clonar repositório
git clone <seu-repo>
cd chat

# 2. Instalar dependências
flutter pub get

# 3. Rodar app
flutter run

# 4. Para iOS
cd ios
pod install
cd ..
flutter run
```

### Configuração Firebase

1. Criar projeto no [Firebase Console](https://console.firebase.google.com)
2. Ativar **Authentication** (Email/Password)
3. Ativar **Cloud Firestore**
4. Baixar configurações e adicionar ao projeto

---

## 🎓 Padrões Implementados

### 1. **MVVM**

```dart
// VIEW acessa VIEWMODEL
final vm = context.watch<AuthViewModel>();

// VIEWMODEL orquestra lógica
class AuthViewModel extends Viewmodel {
  Future<void> login() async {
    await loginCommand.execute();
    // resultado tratado em result.when()
  }
}

// VIEWMODEL usa USECASE
class AuthViewModel {
  final UserUseCase _useCase;
  AuthViewModel(this._useCase);
}

// USECASE orquestra REPOSITORY
class UserUseCase {
  Future<Result<String, Exception>> execute(UserDto dto) async {
    // Combina múltiplos Repositories
    final authResult = await _authRepository.register(dto);
    final saveResult = await _userRepository.saveUser(...);
    return saveResult;
  }
}
```

### 2. **Dependency Injection com AutoInjector**

```dart
// Setup centralizado com genéricos explícitos
setupDependencies() {
  // Services (Singleton)
  _injector.addService<AuthServices>(AuthServices.new);
  _injector.addService<FirestoneFirebaseService>(FirestoneFirebaseService.new);
  
  // Repositories (LazySingleton) - Usa interface
  _injector.addRepository<IAuthRepository>(AuthRepositoryImpl.new);
  _injector.addRepository<IUserRepository>(UserRepositoryImpl.new);
  
  // UseCases (LazySingleton)
  _injector.addUseCase<UserUseCase>(UserUseCase.new);
  _injector.addUseCase<ChatUseCase>(ChatUseCase.new);
  
  // ViewModels (Non-Singleton) - AutoInjector resolve deps
  _injector.addViewmodel<AuthViewModel>(AuthViewModel.new);
  _injector.addViewmodel<HomeViewModel>(HomeViewModel.new);
  _injector.addViewmodel<ChatViewModel>(ChatViewModel.new);
  
  _injector.commit();  // Compila todas as dependências
}
```

**Como funciona:** AutoInjector analisa os genéricos (`<T>`) e resolve automaticamente as dependências do construtor baseado nos tipos registrados.

### 3. **Command Pattern para Async**

```dart
class Command<T> extends ChangeNotifier {
  bool _isExecuting = false;
  
  Future<void> execute() async {
    if(_isExecuting) return;  // Previne múltiplas execuções
    _isExecuting = true;
    try {
      _data = await _action();
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }
}
```

### 4. **Result Pattern com Sealed Classes**

```dart
sealed class Result<S, E extends Exception> {
  T when<T>({
    required T Function(S value) success,
    required T Function(E exception) failure
  });
}

// Uso type-safe
result.when(
  success: (data) { /* sucesso */ },
  failure: (error) { /* erro */ },
);
```

### 5. **Streams para Reatividade**

```dart
// ViewModel expõe stream
Stream<EAuthState> get authState => _repository.authState();

// View consome
StreamBuilder<EAuthState>(
  stream: vm.authState,
  builder: (context, snapshot) { ... }
)
```

---

## 🎯 Desafios Enfrentados

### ❌ **Problema 1: Resolução de Dependências Complexas**

Quando tentava usar `AuthViewModel.new` diretamente, AutoInjector não conseguia resolver as dependências sem genéricos explícitos.

**Solução:** Passar genéricos explicitamente aos métodos do AutoInjector:

```dart
// ❌ ANTES - Não resolvia genéricos
_injector.addService<AuthServices>(AuthServices.new);
_injector.addRepository<IAuthRepository>(AuthRepositoryImpl.new);

// ✅ DEPOIS - Com genéricos explícitos
_injector.addService<AuthServices>(AuthServices.new);
_injector.addRepository<IAuthRepository>(AuthRepositoryImpl.new);
_injector.addUseCase<UserUseCase>(UserUseCase.new);
_injector.addViewmodel<AuthViewModel>(AuthViewModel.new);
```

No `CustomInjector`:
```dart
class CustomInjector {
  void addService<T extends Service>(Function constructor){
    _injector.addSingleton<T>(constructor);  // ✅ Genérico passado
  }

  void addRepository<T extends Repository>(Function constructor){
    _injector.addLazySingleton<T>(constructor);  // ✅ Genérico passado
  }

  void addUseCase<T extends UseCase>(Function constructor){
    _injector.addLazySingleton<T>(constructor);  // ✅ Genérico passado
  }

  void addViewmodel<T extends Viewmodel>(Function constructor){
    _injector.add<T>(constructor);  // ✅ Genérico passado
  }
}
```

**Resultado:** AutoInjector agora consegue:
- ✅ Resolver automaticamente as dependências por tipo
- ✅ Manter type-safety durante toda cadeia
- ✅ Injetar automaticamente nos construtores---

### ❌ **Problema 2: Múltiplas Execuções de Comando**

Usuário clicava 5x em "buscar usuários" → 5 requisições simultâneas.

**Solução:** Guard clause no Command:
```dart
if(_isExecuting) return;  // Ignora novas execuções enquanto roda
```

---

### ❌ **Problema 3: Memory Leaks com Listeners**

ViewModels não limpavam listeners de Command.

**Solução:** Implementar `dispose()` apropriadamente:
```dart
@override
void dispose() {
  getUsersCommand.removeListener(notifyListeners);
  logoutCommand.removeListener(notifyListeners);
  super.dispose();
}
```

---

### ❌ **Problema 4: Proteção de Rotas com Auth**

Usuário logado via "Voltar" voltava para login.

**Solução:** Usar `AuthGate` com StreamBuilder:
```dart
StreamBuilder<EAuthState>(
  stream: vm.authState,
  builder: (context, snapshot) {
    if (snapshot.data == EAuthState.authenticated) {
      return HomePage();
    } else {
      return AuthView();
    }
  },
)
```

---

## 🚀 Próximos Passos

### **Curto Prazo (1-2 semanas)** 📝

- [ ] ✅ **Testes Unitários**
  - [ ] Tests/unit/auth_view_model_test.dart
  - [ ] Tests/unit/home_view_model_test.dart
  - [ ] Tests/unit/user_use_case_test.dart
  - Target: +80% cobertura

- [ ] 🔒 **Validações Robustas**
  - [ ] Email validation em UserDto
  - [ ] Password strength validation
  - [ ] Nome não vazio

- [ ] 📊 **Melhorar Command Pattern**
  - [ ] Adicionar `CommandState` enum (idle, loading, success, error)
  - [ ] Capturar error message específica
  - [ ] Diferençar entre sucesso e erro

### **Médio Prazo (2-4 semanas)** 🎯

- [ ] 🛡️ **Tratamento de Erros Avançado**
  - [ ] Exceções específicas (FirebaseAuthException)
  - [ ] Mensagens amigáveis ao usuário
  - [ ] Firebase Crashlytics integration

- [ ] 🔄 **Abstração de Streams**
  - [ ] `Stream<List<MessageModel>>` ao invés de `QuerySnapshot`
  - [ ] Centralizar transformações no ViewModel
  - [ ] Melhorar type-safety

- [ ] ✨ **Melhorias na UI/UX**
  - [ ] Remover setters de state nas views
  - [ ] Timestamp nas mensagens
  - [ ] Avatar dos usuários
  - [ ] Indicador de digitação

- [ ] 📱 **Offline Support**
  - [ ] Firestore offline persistence
  - [ ] Sincronização automática
  - [ ] Indicador de status de conexão

### **Longo Prazo (1-2 meses)** 🌟

- [ ] 💬 **Features Avançadas**
  - [ ] Grupos de chat
  - [ ] Compartilhamento de imagens
  - [ ] Notificações push
  - [ ] Busca de mensagens

- [ ] ⚡ **Performance**
  - [ ] Lazy loading de mensagens
  - [ ] Paginação de usuários
  - [ ] Cache local

- [ ] 📚 **Documentação**
  - [ ] Dart docs no código
  - [ ] Exemplos de uso
  - [ ] Video tutorial

- [ ] 🚀 **Deploy**
  - [ ] GitHub Actions CI/CD
  - [ ] Publicar no Google Play
  - [ ] Publicar na App Store

---

## 📊 Métricas Atuais

| Métrica | Status |
|---------|--------|
| **Arquivos** | 40+ |
| **Linhas de Código** | ~3.000+ |
| **ViewModels** | 3 ✅ |
| **Repositories** | 3 ✅ |
| **UseCases** | 2 ✅ |
| **Cobertura Testes** | 0% ❌ → 80%+ 🎯 |
| **Documentação** | Básica ⚠️ |

---

## 🔧 Tech Stack

```yaml
Flutter: ^3.10
Firebase Core: ^4.3.0
Firebase Auth: ^6.1.3
Cloud Firestore: ^6.1.1
Provider: ^6.1.5
AutoInjector: ^2.0.0

# Dev
flutter_test: (built-in)
flutter_lints: ^6.0.0
# Será adicionado:
# mocktail: ^1.0.0
```

---

## 📝 Learnings

Este projeto me ensinou:

1. ✅ **Importância da Arquitetura Limpa**
   - Código testável, manutenível e escalável

2. ✅ **Padrões de Design em Dart**
   - Command, Repository, UseCase, Result patterns

3. ✅ **Firebase em Tempo Real**
   - Streams, Firestore, Authentication

4. ✅ **State Management Profissional**
   - Provider com AutoInjector integration

5. ✅ **Tratamento de Erros Robusto**
   - Result Pattern, exceções específicas

---

## 📄 License

MIT License - veja `LICENSE` para detalhes.

---

**Última atualização:** Janeiro 2026  
**Status:** Em desenvolvimento ativo 🚀
