import 'package:dio/dio.dart';
import 'package:ezze_assignment/model/todo_model.dart';
import 'package:get/get.dart';

class TodoDetailsController extends GetxController{
  TodoModel? todoModel;
  var isLoading=true;

  Future<TodoModel?> getSingleTodoData(arguments) async {
    final _dio = Dio();

    try {
      final response = await _dio
          .get('https://jsonplaceholder.typicode.com/todos/$arguments',);

      if (response.statusCode == 200) {
        todoModel=TodoModel.fromJson(response.data);
        return todoModel;
      }
    } on DioError catch (e) {
      print(e.toString());
    }
    print(todoModel!.title.toString());
    isLoading=false;
    update();
    return null;
  }

}