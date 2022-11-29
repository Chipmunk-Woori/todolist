import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_list/pickAnOption.dart';
import 'package:get/get.dart';
import 'package:todo_list/getX/optionController.dart';
import 'package:todo_list/getX/tasksController.dart';


//balck 색상
const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;



void main() {
  // runApp(
  //   MyApp()
  // );
  runApp(GetMaterialApp(home: MyApp()));
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  //task 목록
  final List todoList = [
    {
      'done': true,
      'task': '할 일 1',
    },
    {
      'done': false,
      'task': '할 일 2',
    },
    {
      'done': false,
      'task': '할 일 3',
    },
    {
      'done': false,
      'task': '할 일 4',
    },
    {
      'done': false,
      'task': '할 일 5',
    }
  ];

  //task 추가
  addTodoList (task, dialogContext) {
    if (task != '') {
      setState((){
        todoList.add(
          {
            'done': false,
            'task': task
          }
        );
      });

      Navigator.pop(dialogContext);
    } else {
      Fluttertoast.showToast(
        msg: '내용을 입력해주세요.',
        gravity: ToastGravity.CENTER,
        fontSize: 15,
        textColor: Colors.black,
        backgroundColor: Color.fromARGB(251, 251, 251, 251),
        toastLength: Toast.LENGTH_SHORT
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryBlack,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none
          ),
        )
      ),
      home: MyHomePage(title: 'All Tasks', addTodoList: addTodoList, todoList: todoList),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.addTodoList, required this.todoList});

  final String title;
  final addTodoList;
  final todoList;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  
  int selectedTab = 0;
  var inputData = TextEditingController(); 
  var selectedOption = '';

  void onItemTapped (int index) {
    setState(() {
      selectedTab = index;
    });
  }

  void _addTask() {
    BuildContext dialogContext;
    showDialog(
      context: context, 
      builder: (context) {
        dialogContext = context;
        return Dialog(
          child: Container(
            height: 300,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: '어떤 일을 하시겠습니까?',
                  ),
                  onSubmitted: (text) {
                    widget.addTodoList(text, dialogContext);
                  },
                  controller: inputData,
                  keyboardType: TextInputType.multiline,
                  maxLines: null
                ),

                TextButton(
                  child: Text('추가'),
                  onPressed: (){
                    widget.addTodoList(inputData.text, dialogContext);
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }


  moveToPickAnOption (BuildContext context) async {
    final result = await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => PickAnOption())
    );

    setState(() {
      if (result != null) {
        selectedOption = result;
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    Get.put(OptionController());
    Get.put(TasksController());

    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        title: selectedTab == 0 ? Text('All Tasks') : Text('Returning Data Demo'),
      ),


      body: [

        //BottomNavigationBar_1
        Container( // 1 (내용 전체 박스)
          color: Colors.black,
          width: double.infinity, 
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GetBuilder<TasksController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container( // 2 (todoList 박스)
                      padding: const EdgeInsets.only(bottom:0, top: 0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(251, 251, 251, 251),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      
                      child: (
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 0),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.xTodoList.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left:0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        margin: const EdgeInsets.only(right: 20),
                                        child: Checkbox(
                                          value: controller.xTodoList[index]['done'], 
                                          // value: widget.todoList[index]['done'], 

                                          onChanged: (value) {
                                            controller.changeCheck(index, value);
                                          },
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     widget.todoList[index]['done'] = value;
                                          //   });
                                          // },


                                          checkColor: const Color.fromARGB(251, 251, 251, 251),
                                          activeColor: Colors.black,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), 
                                        ),
                                      ),
                                    ),
                                  ),
                        
                                  
                                  Flexible(
                                    // ignore: sort_child_properties_last
                                    child: Text(
                                      '${controller.xTodoList[index]['task']}',
                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                    ),
                                    flex: 6,
                                    fit: FlexFit.tight,
                                  ),


                                  Flexible(
                                    // ignore: sort_child_properties_last
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        icon: Icon(Icons.cancel_outlined),
                                        color: Colors.black,
                                        iconSize: 15.0,
                                        
                                        onPressed: (){
                                          controller.xRemoveTask(index);
                                        },
                                        // onPressed: (){
                                        //   setState(() {
                                        //     widget.todoList.removeAt(index);
                                        //   });
                                        // },
                                      ),
                                    ),
                                    flex: 1,
                                    fit: FlexFit.tight,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),

        //BottomNavigationBar_2
        Container(
          color: Colors.black,
          width: double.infinity, 
          height: double.infinity,
          child: GetBuilder<OptionController>(
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(selectedOption, style: TextStyle(color: Colors.white, fontSize: 25)),
                  Text('X : ${controller.XSelectedOption}', style: TextStyle(color: Colors.white, fontSize: 25)),

                  SizedBox(height: 20,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                    ),
                    onPressed: (){
                      moveToPickAnOption(context);
                    }, 
                    child: Text('Pick an option, any options!', style: TextStyle(color: Colors.black))
                  )
                ],
              );
            }
          ),
        ),

      ][selectedTab],

      
      floatingActionButton: Visibility(
        visible: selectedTab == 0 ? true : false,
        child: GetBuilder<TasksController>(
          builder: (controller) {
            return FloatingActionButton(
              backgroundColor: const Color.fromARGB(251, 251, 251, 251),

              // onPressed: _addTask,
              onPressed: () {
                BuildContext dialogContext;
                showDialog(
                  context: context, 
                  builder: (context) {
                    dialogContext = context;
                    return Dialog(
                      child: Container(
                        height: 300,
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: '어떤 일을 하시겠습니까?',
                              ),

                              // onSubmitted: (text) {
                              //   widget.addTodoList(text, dialogContext);
                              // },
                              onSubmitted: (text){
                                if (text != '') {
                                  controller.xAddTodoList(text);
                                  Navigator.pop(dialogContext);
                                  setState(() {
                                    text = '';
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: '내용을 입력해주세요.',
                                    gravity: ToastGravity.CENTER,
                                    fontSize: 15,
                                    textColor: Colors.black,
                                    backgroundColor: Color.fromARGB(251, 251, 251, 251),
                                    toastLength: Toast.LENGTH_SHORT
                                  );
                                }
                              },

                              controller: inputData,
                              keyboardType: TextInputType.multiline,
                              maxLines: null
                            ),

                            TextButton(
                              child: Text('추가'),

                              // onPressed: (){
                              //   widget.addTodoList(inputData.text, dialogContext);
                              // },
                              onPressed: (){
                                if (inputData.text != '') {
                                  controller.xAddTodoList(inputData.text);
                                  Navigator.pop(dialogContext);
                                  setState(() {
                                    inputData.text = '';
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: '내용을 입력해주세요.',
                                    gravity: ToastGravity.CENTER,
                                    fontSize: 15,
                                    textColor: Colors.black,
                                    backgroundColor: Color.fromARGB(251, 251, 251, 251),
                                    toastLength: Toast.LENGTH_SHORT
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add, color: Colors.black),
            );
          }
        ),
      ), 


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle), 
            label: 'tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets), 
            label: 'footprint')
        ],
        currentIndex: selectedTab,
        selectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index){
          setState(() {
            selectedTab = index;
          });
        },
      ),
    );
  }
}




