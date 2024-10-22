import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'pagination_state_model.freezed.dart';

@freezed
abstract class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.data(List<T> items) = _Data;
  const factory PaginationState.loading() = _Loading;
  const factory PaginationState.myError(String error) = _MyError;
  const factory PaginationState.error(Object? e, [StackTrace? stk]) = _Error;
  const factory PaginationState.onGoingLoading(List<T> items) = _OnGoingLoading;
  const factory PaginationState.onGoingError(List<T> items, Object? e, [StackTrace? stk]) = _OnGoingError;
}