import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../logger/logger_abstract.dart';
import '../logger/logger_impl.dart';

@injectable
class HttpLoggerInterceptor extends Interceptor {
  final LoggerAbstract _logger;

  final bool _printRequest = true;
  final bool _printRequestHeaders = true;
  final bool _printRequestBody = true;
  final bool _printResponse = true;
  final bool _printResponseHeaders = true;
  final bool _printResponseBody = true;

  HttpLoggerInterceptor({@factoryParam LoggerAbstract? logger})
    : _logger =
          logger ??
          LoggerImpl(
            logger: Logger(
              printer: PrettyPrinter(
                printTime: false,
                colors: false,
                printEmojis: true,
                methodCount: 2,
                errorMethodCount: 8,
                lineLength: 150,
                noBoxingByDefault: false,
              ),
            ),
          );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra = <String, dynamic>{'start_time': DateTime.now().millisecondsSinceEpoch};
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final message = _formatLog(response.requestOptions, response);
    if (message != '') {
      _logger.info(message);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message = _formatLog(err.requestOptions, err.response);
    if (message != '') {
      _logger.error(message);
    }
    return super.onError(err, handler);
  }

  /// Pretty printing a JSON or returning a regular String
  String _getBody(dynamic data, String? contentType) {
    if (contentType != null && contentType.toLowerCase().contains('application/json')) {
      const encoder = JsonEncoder.withIndent('  ');
      // the JSON can be a Map or a List
      dynamic jsonBody;
      if (data is String && data.isNotEmpty) {
        jsonBody = jsonDecode(data);
      } else {
        jsonBody = data;
      }
      return encoder.convert(jsonDecode(jsonEncode(jsonBody)));
    } else {
      return data.toString();
    }
  }

  /// format the request and response logs
  String _formatLog(RequestOptions? requestOptions, Response? response) {
    var requestLog = '', responseLog = '';

    if (_printRequest) {
      requestLog = 'REQUEST:\n\n';
      requestLog +=
          '${requestOptions?.method ?? ''} ${requestOptions?.baseUrl ?? ''}${requestOptions?.path ?? ''}\n';

      if (_printRequestHeaders) {
        for (final header in (requestOptions?.headers ?? {}).entries) {
          requestLog += '${header.key}: ${header.value}\n';
        }
      }

      if (_printRequestBody && requestOptions?.data != null) {
        requestLog += '\n\n${_getBody(requestOptions?.data, requestOptions?.contentType)}';
      }

      requestLog += '\n\n';
    }

    if (_printResponse && response != null) {
      responseLog =
          'RESPONSE [${response.statusCode}/${response.statusMessage}]: '
          '${requestOptions?.extra['start_time'] != null ? '[Time elapsed: ${DateTime.now().millisecondsSinceEpoch - requestOptions?.extra['start_time']} ms]' : ''}'
          '\n\n';

      if (_printResponseHeaders) {
        for (final header in response.headers.map.entries) {
          responseLog += '${header.key}: ${header.value}\n';
        }
      }

      if (_printResponseBody && response.data != null) {
        responseLog += '\n\n${_getBody(response.data, response.headers.value('content-type'))}';
      }
    }

    return requestLog + responseLog;
  }
}
