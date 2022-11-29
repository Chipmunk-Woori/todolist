import 'package:get/get.dart';


class TasksController extends GetxController {

  //task 목록
  List xTodoList = [
    {
      'done': true,
      'task': 'X_할 일 1',
    },
    {
      'done': false,
      'task': 'X_할 일 2',
    },
    {
      'done': false,
      'task': 'X_할 일 3',
    },
    {
      'done': false,
      'task': 'X_할 일 4',
    },
    {
      'done': false,
      'task': 'X_할 일 5',
    }
  ];


  //task 추가
  void xAddTodoList (task) {
    if (task != '') {
      xTodoList.add(
        {
          'done': false,
          'task': task
        }
      );

      update();
    } 
  }


  //task 삭제
  void xRemoveTask (index) {
    xTodoList.removeAt(index);

    update();
  }


  //check 변경
  void changeCheck (index, value) {
    xTodoList[index]['done'] = value;

    update();
  }

}