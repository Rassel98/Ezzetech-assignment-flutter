import 'package:ezze_assignment/controller/todo_details_controller.dart';
import 'package:ezze_assignment/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoDetailsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Todo Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder<TodoModel?>(
        future: controller.getSingleTodoData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Err');
          }
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  ListTile(
                    leading: Text(user.id.toString()),
                    title: Text('User Id: ${user.id}'),
                    subtitle: Text('Title: ${user.title}',style: TextStyle(color: Colors.black,fontSize: 20),),

                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: Row(
                      children: [
                        Checkbox(value: user.completed, onChanged: (value) {

                        },),
                       user.completed==true? const Text('Complete'):const Text('Incomplete')
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
