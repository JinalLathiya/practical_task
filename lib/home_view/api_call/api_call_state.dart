import 'package:equatable/equatable.dart';
import 'package:practical_task/Model/post_data.dart';

sealed class ApiCallState extends Equatable {
  const ApiCallState();

  @override
  List<Object?> get props => [];
}

class InitialApiCallState extends ApiCallState {
  const InitialApiCallState();
}

class ApiCallLoadingState extends ApiCallState {
  const ApiCallLoadingState();
}

class ApiCallSuccessState extends ApiCallState {
  const ApiCallSuccessState({required this.postData});

  final PostData postData;

  @override
  List<Object?> get props => [postData];
}

class ApiCallFailureState extends ApiCallState {
  const ApiCallFailureState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
