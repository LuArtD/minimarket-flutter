sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T get data {
    if (this case Success<T>(:final data)) return data;
    throw StateError('Called data on a Failure');
  }

  String get errorMessage {
    if (this case Failure<T>(:final message)) return message;
    throw StateError('Called errorMessage on a Success');
  }

  Exception? get exception {
    if (this case Failure<T>(:final exception)) return exception;
    return null;
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(String message, Exception? exception) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Failure<T>(:final message, :final exception) => failure(message, exception),
    };
  }

  Result<R> map<R>(R Function(T) transform) {
    return switch (this) {
      Success<T>(:final data) => Success<R>(transform(data)),
      Failure<T>(:final message, :final exception) => Failure<R>(message, exception),
    };
  }
}

class Success<T> extends Result<T> {
  @override
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Success($data)';
}

class Failure<T> extends Result<T> {
  final String message;
  @override
  final Exception? exception;
  const Failure(this.message, [this.exception]);

  @override
  String toString() => 'Failure($message${exception != null ? ': $exception' : ''})';
}

class MinimarketException implements Exception {
  final String message;
  const MinimarketException(this.message);

  @override
  String toString() => 'MinimarketException: $message';
}

class InsufficientStockException extends MinimarketException {
  final int productId;
  final double requested;
  final double available;

  const InsufficientStockException({
    required this.productId,
    required this.requested,
    required this.available,
  }) : super('Stock insuficiente para producto $productId: solicitado $requested, disponible $available');
}

class ProductNotFoundException extends MinimarketException {
  final int productId;
  const ProductNotFoundException(this.productId) : super('Producto no encontrado: $productId');
}

class CategoryNotFoundException extends MinimarketException {
  final int categoryId;
  const CategoryNotFoundException(this.categoryId) : super('Categoría no encontrada: $categoryId');
}

class SupplierNotFoundException extends MinimarketException {
  final int supplierId;
  const SupplierNotFoundException(this.supplierId) : super('Proveedor no encontrado: $supplierId');
}

class PurchaseNotFoundException extends MinimarketException {
  final int purchaseId;
  const PurchaseNotFoundException(this.purchaseId) : super('Compra no encontrada: $purchaseId');
}

class SaleNotFoundException extends MinimarketException {
  final int saleId;
  const SaleNotFoundException(this.saleId) : super('Venta no encontrada: $saleId');
}

class InvalidAdjustmentTypeException extends MinimarketException {
  const InvalidAdjustmentTypeException(String type)
      : super('Tipo de ajuste inválido: $type. Debe ser "entrada" o "salida"');
}

class InvalidPaymentMethodException extends MinimarketException {
  const InvalidPaymentMethodException(String method)
      : super('Método de pago inválido: $method. Debe ser "efectivo", "tarjeta" o "transferencia"');
}
