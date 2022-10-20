import 'package:ezze_assignment/controller/home_controller.dart';
import 'package:ezze_assignment/views/todo_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ScrollController scrollController;
    // final controller=Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: Text('Home',style: TextStyle(color: Colors.black),),),
      ),
        body: GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) =>
          SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onLoading: ()async{
                final status=await controller.getTodoData();
                if(status){
                  controller.refreshController.loadComplete();
                }
                else{
                  controller.refreshController.loadFailed();
                }
              },
              onRefresh: ()async{
                final status=await controller.getTodoData(isRefresh: true);
                if(status){
                  controller.refreshController.refreshCompleted();
                }
                else{
                  controller.refreshController.refreshFailed();
                }
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.todoModelList.length,
                itemBuilder: (context, index) {
                  final user = controller.todoModelList[index];
                  return ListTile(
                    leading: Text(user.id.toString()),
                    title: Text('Title: ${user.title}'),
                    subtitle: Text('User Id:${user.userId}'),
                    trailing: Checkbox(
                      value: user.completed,
                      onChanged: (value) {},
                    ),
                    onTap: () =>
                        Get.to(const TodoDetailsScreen(), arguments: user.id),
                  );
                },
              ),
            ),
    ));
  }
}
