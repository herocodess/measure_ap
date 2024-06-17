import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:kochanet_measure_app/core/exceptions/failure_response.dart';
import 'package:kochanet_measure_app/core/utils/typedefs.dart';

ResponseFormat<FailureResponse, T> runFirestoreOperation<T>(
    Future<T> Function() operation) async {
  try {
    final result = await operation();
    return Right(result);
  } on SocketException catch (e) {
    return Left(FailureResponse(e.message));
  } on FirebaseException catch (e) {
    return Left(FailureResponse(e.message ?? ''));
  }
}
