

import 'package:fitness_app/core/networking/base_client.dart';
import 'package:fitness_app/core/networking/base_response.dart';
import 'package:fitness_app/core/networking/end_points.dart';

import 'quotes_data_source.dart';

class QuotesRemoteDataSourceImpl implements QuotesRemoteDataSource {

  @override
  Future<BaseResponse?> getSeries() async {
    try {
      var response =
      await ApiManager.get(ApiEndpoints.getSeries(),);
      if (response?.status == Status.completed) {
        return response?.baseResponse;
      } else if (response?.status == Status.error) {
        if (response?.baseResponse == null) {
          return BaseResponse(errorMessage: response?.errMessage);
        } else {
         // updateErrorToUI(response?.errMessage);
        }
      } else {
       // updateErrorToUI(response?.errMessage);
      }
    } catch (e) {
     // printErrorToConsole(e);
    }
  }

}
