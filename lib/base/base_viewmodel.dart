//<t> meen that class can take any type
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/base/base_state.dart';


class BaseViewModel<T> extends StateNotifier<BaseState<T>> {
  BaseViewModel(BaseState<T> viewState) : super(viewState);
  set data(T data) => state = state.copyWith(data: data, isSuccess: true);
  set isLoad(bool isLoad) => state = state.copyWith(isLoading: isLoad);
  set error(BaseError error) => state = state.copyWith(error: error);
}
