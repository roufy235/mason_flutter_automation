import 'package:fpdart/fpdart.dart';

abstract class UseCase<F, S, P> {
  Future<Either<F, S>> call(P params);
}
