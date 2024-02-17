import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';
import 'package:to_do_app/ui/utils/app_colors.dart';
import '../../../../model/todo_dm.dart';
import '../../home/to_do_widget.dart';

class ListTabs extends StatefulWidget {
   const ListTabs({Key? key}) : super(key: key);

  @override
  State<ListTabs> createState() => _ListTabsState();
}

class _ListTabsState extends State<ListTabs> {
 // List<TodoDM> todos = [];
 late ListProvider provider;
 @override
  void initState() {
    super.initState();
    /// السطر ده علشان provider يتاخر في التنفيذ لبعد build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.reFreshTdoFireStore();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
   //  /// الشرط ده علشان infiniteLoop في الداتا اللي جايه
   // if(provider.todos.isEmpty){
   //   provider.reFreshTdoFireStore();
   // }
     return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.20,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex:17,
                    child: Container(color: AppColors.primary,),
                  ),
                  Expanded(
                      flex: 83,
                      child: Container(color: AppColors.accent,))
                ],
              ),
              CalendarTimeline(
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                /// السطر ده علشان اضغط علي اليوم في  calender
                onDateSelected: (date){
                   provider.selectedDate = date;
                   provider.reFreshTdoFireStore();
                },
                leftMargin: 20,
                monthColor: Colors.white,
                dayColor: AppColors.primary,
                dotsColor: Colors.tealAccent,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: AppColors.white,
                selectableDayPredicate: (date) => date.day != 23,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context , index) =>
                TodoWidget(model: provider.todos[index])),
        ),
      ],
    );
  }

  // reFreshTdoFireStore()async {
  //   CollectionReference todosCollection =
  //   FirebaseFirestore.instance.collection(TodoDM.collectionName);
  //   QuerySnapshot todoSnapshot= await todosCollection.get();
  //   List<QueryDocumentSnapshot> docs= todoSnapshot.docs;
  //   for(int i =0; i<docs.length; i++){
  //     var singleDoc = docs[i];
  //     Map json = singleDoc.data() as Map;
  //     TodoDM todo = TodoDM.fromJson(json);
  //     todos.add(todo);
  //   }
  //   setState(() {});
  // }
}
