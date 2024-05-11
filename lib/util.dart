import 'package:http/http.dart' as http;

class Util {
  Util._privateConstructor();
  static final Util _util = Util._privateConstructor();
  factory Util() => _util;

  Future<bool> make_bool_request(bool flag) async {
    var url = Uri.parse('http://150.230.254.127:8080/api/test/' + flag.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // 요청이 성공했을 때
      print('응답 데이터: ${response.body}');
      return response.body == "true";
    } else {
      // 요청이 실패했을 때
      print('요청 실패: ${response.reasonPhrase}');
      return false;
    }
  }
}