import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class Api {
  late Dio _dio;

  Api() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
        headers: {
          Headers.contentTypeHeader: 'application/json',
          Headers.acceptHeader: 'application/json',
        },
      ),
    );
    _dio.interceptors.add(ApiInterceptor());
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(dio: _dio));
  }

  Dio get dio => _dio;

}

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[HttpHeaders.authorizationHeader] = '';
    //final token = await UserToken.getUserToken();
    log(options.path);
    // log("token: $token");
    // if (token != null && token.isNotEmpty) {
    //   log("token: $token");
    //   // options.headers['X-Auth-Token'] = token;
      //options.headers[HttpHeaders.authorizationHeader] = 'Bearer token';
    log("headers: ${options.headers}");
    return handler.next(options);

  }

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(response.statusCode.toString());
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('${err.response}, ${err.message}');

    if (err.response?.statusCode == 400) {
    } else if (err.response?.statusCode == 404) {
      log(err.response!.data['message']);
    } else if (err.response?.statusCode == 500) {
      log('Server Error');
    }
    return handler.next(err);
  }

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final Dio dio;

  RetryOnConnectionChangeInterceptor({
    required this.dio,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetryOnHttpException(err)) {
      try {
        handler.resolve(await DioHttpRequestRetrier(dio: dio)
            .requestRetry(err.requestOptions)
            .catchError((e) {
          handler.next(err);
          return e;
        }));
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetryOnHttpException(DioException err) {
    return err.type == DioExceptionType.unknown &&
        err.message != null &&
        ((err.error is HttpException &&
            err.message!.contains(
                'Connection closed before full header was received')));
  }
}

/// Retrier
class DioHttpRequestRetrier {
  final Dio dio;

  DioHttpRequestRetrier({
    required this.dio,
  });

  Future<Response> requestRetry(RequestOptions requestOptions) async {
    return dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        contentType: requestOptions.contentType,
        headers: requestOptions.headers,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        followRedirects: requestOptions.followRedirects,
        listFormat: requestOptions.listFormat,
        maxRedirects: requestOptions.maxRedirects,
        method: requestOptions.method,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        responseType: requestOptions.responseType,
        validateStatus: requestOptions.validateStatus,
      ),
    );
  }
}
