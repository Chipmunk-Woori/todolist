import 'package:flutter/material.dart';
import 'package:todo_list/getX/optionController.dart';
import 'package:get/get.dart';

class PickAnOption extends StatelessWidget {
  const PickAnOption({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(OptionController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),

      body: Container(
        color: Colors.black,
        width: double.infinity, 
        height: double.infinity,
        child: GetBuilder<OptionController>(
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                  ),
                  onPressed: (){
                    controller.changeXSelectedOption('X Yep!');
                    Navigator.pop(context);

                    // Navigator.pop(context, 'Yep!');
                  }, 
                  child: Text('Yep!', style: TextStyle(color: Colors.black))
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                  ),
                  onPressed: (){
                    controller.changeXSelectedOption('X Nope.');
                    Navigator.pop(context);

                    // Navigator.pop(context, 'Nope.');
                  }, 
                  child: Text('Nope.', style: TextStyle(color: Colors.black))
                )
              ],
            );
          }
        ),
      )
    );
  }
}