import 'package:get/get.dart';


class OptionController extends GetxController {
  var XSelectedOption = 'X';

  void changeXSelectedOption (newOption) {
    if (newOption != null) {
      XSelectedOption = newOption;

      update(); //이 controller를 바라보고있는 모든 코드에 업데이트 알림
    }
  }
}