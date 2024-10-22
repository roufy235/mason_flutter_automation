import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state_model.freezed.dart';

@freezed
abstract class DataStateModel<T> with _$DataStateModel<T> {
  const factory DataStateModel.data(T data) = _Data;
  const factory DataStateModel.loading() = _Loading;
  const factory DataStateModel.myError(String error) = _MyError;
}
