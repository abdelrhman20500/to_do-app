import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/app_user.dart';
import 'package:to_do_app/model/todo_dm.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme.dart';
import '../widgets/my_text_filed.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDay= DateTime.now();
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider= Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add New Task",textAlign: TextAlign.center, style: AppTheme.bottomSheetTitleTextStyle,),
            SizedBox(height: 12),
            MyTextFiled(hintText: "enter your title", controller:titleController ,),
            SizedBox(height: 8),
            MyTextFiled(hintText: "enter your description", controller:descriptionController ,),
            SizedBox(height: 12),
            Text("Select Data", style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w600),),
            InkWell(
              onTap: (){
                showMyDataPicker();
              },
              child: Text("${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                  fontWeight:FontWeight.normal, color: AppColors.grey),),
            ),
            Spacer(),
            Container(
              color: Colors.blue,
              child: MaterialButton(onPressed: ()
              {
                addTodoFireStore();
              },
                child:Text("add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showMyDataPicker() async {
    selectedDay = await showDatePicker(
        context: context,
        initialDate: selectedDay,
        firstDate: DateTime.now(),
        /// علشان لو ضغط cancel يختار تاريخ اليوم ده السيناريو
        lastDate: DateTime.now().add(Duration(days: 365))) ?? selectedDay ;
    setState(() {});
  }
  /// add data to firebase.
 /// انا بخزن data علي هيئه json وبستقبل json برضوا 
  /// في dart بيكون json علي هيئة (value , key )
  void addTodoFireStore()async {
    CollectionReference todosCollectionRef =
    ///علشان كل مستخدم يضيف الداتا في collection لوحده
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName);
    DocumentReference newEmpty =todosCollectionRef.doc();
    await newEmpty.set({
      "id" :newEmpty.id,
      "title" :titleController.text,
      "description":descriptionController.text,
      "date":selectedDay,
      "isDone" :false,
    });
    provider.reFreshTdoFireStore();
    Navigator.pop(context);
  }
}