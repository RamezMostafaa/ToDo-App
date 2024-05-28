// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list/home/firebase_utils.dart';
// import 'package:todo_list/widget/my_them.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../models/task_model.dart';
// import '../../providers/list_provider.dart';
// import '../../providers/user_provider.dart';
// import 'alertDialog.dart';
//
// class AddTaskSheet extends StatefulWidget {
//   @override
//   State<AddTaskSheet> createState() => _AddTaskSheetState();
// }
//
// class _AddTaskSheetState extends State<AddTaskSheet> {
//   var selectedDate = DateTime.now();
//   var formKey = GlobalKey<FormState>();
//   String title = "";
//
//   String description = "";
//   late ListProvider listProvider;
//   late AppLocalizations? appLocalization;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height*50,
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//
//           children: [
//
//             Text(
//               "Add New Task",
//               style: Theme
//                   .of(context)
//                   .textTheme
//                   .titleMedium,
//             ),
//             Form(
//                 key: formKey,
//                 child: Column(
//
//
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(height: 10,),
//                     TextFormField(
//                       onChanged: (text) {
//                         title = text;
//                       },
//                       validator: (text) {
//                         if (text == null || text.isEmpty) {
//                           return 'Please enter task title';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(hintText: "Enter Task Title"),
//                     ),
//                     SizedBox(height: 10,),
//                     TextFormField(
//                       onChanged: (text) {
//                         description = text;
//                       },
//
//
//                       validator: (text) {
//                         if (text == null || text.isEmpty) {
//                           return "Please enter task description";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                           hintText: "Enter Task Description"), maxLines: 4,
//                     ),
//                     SizedBox(height: 10,),
//                     Text("Select Date", style: Theme
//                         .of(context)
//                         .textTheme
//                         .titleMedium,
//                     ),
//                     SizedBox(height: 15,),
//                     InkWell(onTap: () {
//                       ShowCalender();
//                     },
//                       child: Text('${selectedDate.day}/${selectedDate
//                           .month}/${selectedDate.year}'
//                         , textAlign: TextAlign.center,
//                         style: Theme
//                             .of(context)
//                             .textTheme
//                             .titleSmall,),
//                     ),
//                     SizedBox(height: 50,),
//                     ElevatedButton(onPressed: () {
//                       addTask();
//                     },
//                       child: Text("Add", style: Theme
//                           .of(context)
//                           .textTheme
//                           .titleLarge,
//                       ),
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                               MyTheme.primaryColor),
//                           shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18)))),)
//
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   void ShowCalender() async {
//     var chosenDate = await showDatePicker(context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime.now(),
//         lastDate: DateTime.now().add(Duration(days: 365)));
//     selectedDate = chosenDate ?? DateTime.now();
//     setState(() {
//
//     }
//     );
//   }
//
//   // void addTask() {
//   //   if (formKey.currentState?.validate() == true){
//   //     Task task =Task(title: title, description: description, datetime: selectedDate);
//   //     FirebaseUtils.addTaskToFireStore(task).timeout(Duration(milliseconds: 500),onTimeout: () {
//   //       print("task added successfully");
//   //       Navigator.pop(context);
//   //     }) ;
//   //   }
//   // }
//   Future<void> addTask() async {
//     if (formKey.currentState?.validate() == true) {
//       /// add task
//       var authProvider = Provider.of<AuthProviders>(context, listen: false);
//       DialogUtils.showLoading(context: context, loadingMessage: 'Loading...');
//       await Future.delayed(Duration(seconds: 2));
//
//       DialogUtils.hideLoading(context);
//
//       Task task =
//       Task(title: title, description: description, dateTime: selectedDate);
//       FirebaseUtils.addTaskToFiretore(task, authProvider.currentUser!.id!)
//           .then((value) {
//         /// toast , alert dialog
//         print('task added successfully');
//         // Navigator.pop(context);
//         // DialogUtils.hideLoading(context);
//         DialogUtils.showMessage(
//             context: context,
//             content: "${task.title} ${appLocalization!.adding_task_success}",
//             title: appLocalization!.success,
//             posActionsName: appLocalization!.ok,
//             posActions: (context) {
//               Navigator.of(context).pop();
//               Navigator.of(context).pop();
//               listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
//             });
//         // Navigator.pop(context);
//       }).timeout(Duration(milliseconds: 500), onTimeout: () {
//         print('task added successfully');
//
//         /// alert dialog , toast , snack bar
//         listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
//         Navigator.pop(context);
//       });
//     }
//   }
//
// }
//
