
import 'package:fitness_app/core/networking/base_response.dart';
abstract class QuotesRemoteDataSource {
  Future<BaseResponse?> getSeries();
}