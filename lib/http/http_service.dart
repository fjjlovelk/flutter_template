import 'package:dio/dio.dart';
import 'package:flutter_template/config/http_config.dart';
import 'package:flutter_template/store/user_store.dart';
import 'package:flutter_template/utils/loading_util.dart';
import 'package:get/get.dart' as getx;

class HttpService {
  static final HttpService _instance = HttpService._internal();

  factory HttpService() => _instance;

  late Dio dio;

  HttpService._internal() {
    // 初始化
    BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: HttpConfig.connectTimeout,
      receiveTimeout: HttpConfig.receiveTimeout,
    );
    dio = Dio(options);
    // dio忽略https证书，已在全局设置
    // dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
    //   final client = HttpClient();
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return true;
    //   };
    //   return client;
    // });
    // 自定义拦截器
    dio.interceptors.add(InterceptorsWrapper(
      // 请求拦截
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (getx.Get.isRegistered<UserStore>() && UserStore.to.hasToken) {
          options.headers['X-Access-Token'] = UserStore.to.token;
        }
        return handler.next(options);
      },
      // 响应拦截
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print("onResponse---, ${response.data}");
        if (response.data['success'] == true) {
          return handler.next(response);
        }
        throw DioException(
          type: DioExceptionType.badResponse,
          message: response.data?['message'] ?? '服务器错误',
          requestOptions: response.requestOptions,
          response: null,
          error: null,
        );
      },
      // 错误拦截
      onError: (DioException e, ErrorInterceptorHandler handler) {
        onError(e);
        return handler.next(e);
      },
    ));
  }

  /// 错误处理
  void onError(DioException err) {
    print('onError---${err.toString()}');
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        break;
      case DioExceptionType.sendTimeout:
        break;
      case DioExceptionType.receiveTimeout:
        LoadingUtil.showError('响应超时');
        break;
      case DioExceptionType.badCertificate:
        LoadingUtil.showError('证书错误');
        break;
      case DioExceptionType.connectionError:
        LoadingUtil.showError('连接错误');
        break;
      case DioExceptionType.unknown:
        // 当err.type为unknown时err.error通常不为null
        LoadingUtil.showError(err.error?.toString() ?? '未知错误');
        break;
      case DioExceptionType.badResponse:
        LoadingUtil.showError(err.message ?? '服务器错误');
        break;
      default:
        break;
    }
  }

  /// get方法
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// post方法
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// put方法
  Future put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// patch方法
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// delete方法
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }
}
