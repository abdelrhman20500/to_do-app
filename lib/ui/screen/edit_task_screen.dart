import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/todo_dm.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';

import '../utils/app_colors.dart';

class EditTaskScreen extends StatefulWidget {
  TodoDM taskModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  EditTaskScreen({Key? key, required this.taskModel}) {
    titleController.text= taskModel.title;
    descriptionController.text= taskModel.description;
  }

@override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
 // late ListProvider provider;
   @override
  Widget build(BuildContext context) {
     var provider =Provider.of<ListProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: Stack(
        alignment: Alignment.center,
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
          Container(
            width: size.width*0.90,
            height: size.height*0.70,
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Edit Task", style: TextStyle(fontSize: 26),),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    onChanged: (text){
                      widget.taskModel.title= text;
                    },
                    controller: widget.titleController,
                    decoration: const InputDecoration(
                      hintText: "Enter title",
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: widget.descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Enter description",
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue
                  ),
                  child: MaterialButton(onPressed: ()async {
                    widget.taskModel.date = await showDatePicker(
                        context: context,
                        initialDate: widget.taskModel.date,
                        firstDate: widget.taskModel.date,
                        lastDate: widget.taskModel.date.add(const Duration(days: 30),))??
                    widget.taskModel.date;
                    setState(() {});
                  },
                    child: const Text("Select time"),),
                ),
                const SizedBox(height: 16,),
                Text("${widget.taskModel.date.day}"
                    "/${widget.taskModel.date.month}/${widget.taskModel.date.day}",
                style: const TextStyle(color: Colors.black54),),
                const SizedBox(height: 50,),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blue
                  ),
                  child: MaterialButton(onPressed: ()async {
                    widget.taskModel.description= widget.descriptionController.text;
                    await provider.clickOnSaveChanged(widget.taskModel);
                    Navigator.pop(context);
                  },
                    child:const Text("save change") ,),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
