import 'package:http/http.dart';

class Helpers{
static var currentResponse;
  static postRequest(url,body)async{
    currentResponse= await post(url,body: body,headers: {"Content-type": "application/json"});

  }
  static getRequest(url)async{
    currentResponse= await get(url);
  }
}