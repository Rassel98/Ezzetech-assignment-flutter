import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/todo_model.dart';

class HomeController extends GetxController {
  late List<TodoModel> todoModelList = [];
  late List<TodoModel> limitList = [];
  var isLoading = true;

  final refreshController = RefreshController(initialRefresh: true);

  //bool get isLoadings => todoModelList != 0;

  // @override
  // onInit() {
  //   getTodoData();
  //   super.onInit();
  // }

  var currentPage = 1;

  Future<bool> getTodoData({bool isRefresh = false}) async {
    final _dio = Dio();
    if (isRefresh) {
      currentPage = 1;
    }

    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/todos?_page=$currentPage&_limit=10',
      );
      if (response.statusCode == 200) {

        limitList = response.data
            .map<TodoModel>((item) => TodoModel.fromJson(item))
            .toList();
        if(isRefresh){
          todoModelList=limitList;
        }
        else{
          if(limitList.isEmpty){
            refreshController.loadNoData();
            return false;
          }
          todoModelList.addAll(limitList);
        }
        currentPage++;
        update();
        return true;
      }
    } on DioError catch (e) {
      print(e.toString());
    }
    // print(todoModelList.length);
    isLoading = false;
    update();
    return false;
  }
}
