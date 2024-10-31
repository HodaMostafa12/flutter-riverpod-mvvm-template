import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvvm_template/base/base_state.dart';
import 'base_viewmodel.dart';


typedef BaseStateProvider<S, V extends BaseViewModel<S>>
    = StateNotifierProvider<V, BaseState<S>>;
