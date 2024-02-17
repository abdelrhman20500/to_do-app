import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo_dm.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';
import 'package:to_do_app/ui/screen/edit_task_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
   TodoWidget({super.key, required this.model});
  final TodoDM model;

  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          /// type of motion
          motion: const BehindMotion(),
          /// size of delete icon
          extentRatio: 0.33,
          children: [
            SlidableAction(
              onPressed: (_) {
                // FirebaseFirestore.instance
                //     .collection(TodoDM.collectionName)
                //     .doc(model.id)
                //     .delete()
                //     .timeout(const Duration(milliseconds: 200), onTimeout: () {
                //   provider.reFreshTdoFireStore();
                // });
                provider.clickOnDelete(model.id);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) {
                // FirebaseFirestore.instance
                //     .collection(TodoDM.collectionName)
                //     .doc(model.id)
                //     .delete()
                //     .timeout(const Duration(milliseconds: 200), onTimeout: () {
                //   provider.reFreshTdoFireStore();
                // });
                // put here navigate to new scree
                // provider.clickOnSaveChanged(model);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> EditTaskScreen(taskModel: model),
                ));
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),


          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height * .13,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
               VerticalDivider(
                color:model.isDone ?Colors.green : AppColors.primary,
                thickness: 3,
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(model.title, style: AppTheme.taskTitleTextStyle.copyWith(color: model.isDone?
                    Colors.green :Colors.black),
                    ),
                    SizedBox(height: 8,),
                    Text(model.description, textAlign: TextAlign.start,
                      style: AppTheme.taskDescriptionTextStyle.copyWith(color: model.isDone ?
                      Colors.green : Colors.black),
                    )
                  ],
                ),
              ),
               InkWell(
                 onTap: (){
                   model.isDone = !model.isDone;
                   provider.clickOnIsDone(model);
                 },
                 child:model.isDone? Text("Done !", style: TextStyle(
                   color: Colors.green, fontWeight: FontWeight.bold, fontSize: 30),)
                     : Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 32,
                    )),
               ),
              const SizedBox(
                width: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
