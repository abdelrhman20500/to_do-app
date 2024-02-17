import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/model/app_user.dart';
import 'package:to_do_app/ui/provider/list_provider.dart';
import 'package:to_do_app/ui/screen/home/auth/login/login.dart';
import 'package:to_do_app/ui/utils/app_colors.dart';
import '../../bottom_sheet/add_bottom_sheet.dart';
import '../tabs/list_tabs/list_tabs.dart';
import '../tabs/settings_tabs/settings_tabs.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);
  static String routeName ="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedIndex=0;
 late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: currentSelectedIndex==0 ?  const ListTabs() : const SettingsTabs(),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: (){
        showModalBottomSheet(context: context,
            isScrollControlled: true,
            builder: (_){
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: AddBottomSheet(),
          );
        });
      },
      child: Icon(Icons.add),
    );
  }

  BottomAppBar buildBottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      clipBehavior: Clip.hardEdge,
      child: BottomNavigationBar(
        currentIndex: currentSelectedIndex,
        onTap: (index){
          currentSelectedIndex= index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label:  ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label:  ""),

        ],
      ),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Text("Welcome ${AppUser.currentUser!.userName}"),
      actions: [
        InkWell(
            onTap: (){
              AppUser.currentUser = null;
              provider.todos.clear();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: const Icon(Icons.logout)),
      ],
    );
  }
}
