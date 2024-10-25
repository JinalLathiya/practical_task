import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/Model/post_data.dart';
import 'package:practical_task/components/components.dart';
import 'package:practical_task/home_view/api_call/api_call.dart';

final class ApiCallBloc extends Bloc<ApiCallEvent, ApiCallState> {
  ApiCallBloc({
    required this.context,
  }) : super(const InitialApiCallState()) {
    on<ApiCallRequested>(_onApiCallRequested);
  }

  final BuildContext context;

  Future<void> _onApiCallRequested(ApiCallRequested event, Emitter<ApiCallState> emit) async {
    emit(const ApiCallLoadingState());
    try {
      var client = DioClient();
      await client.dio.get("posts/1").then((value) {
        final PostData result = PostData.fromJson(value.data as Map<String,dynamic>);
        showSuccessMessage(context: context, content: 'Data Fetch Successfully!!');
        emit(ApiCallSuccessState(postData: result));
      }).catchError((error) {
        showErrorMessage(context: context, content: error.toString());
        emit(ApiCallFailureState(errorMessage: error.toString()));
      });
    } catch (e) {
      showErrorMessage(context: context, content: e.toString());
      emit(ApiCallFailureState(errorMessage: e.toString()));
    }
  }
}
