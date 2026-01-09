sealed class Result<S, E extends Exception> {
  const Result();
  T when<T>({
    required T Function(S value) success,
    required T Function(E exception) failure
  }){
    return switch (this){
      Success(value: final v) => success(v),
      Failure(exception: final e) => failure(e),
    };
  }
}


class Success<S, E extends Exception> extends Result<S, E>{
  final S value;
  const Success(this.value);
}

class Failure<S, E extends Exception> extends Result<S, E> {
  final E exception;
  const Failure(this.exception);
}