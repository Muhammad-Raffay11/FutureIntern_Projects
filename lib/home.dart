// ignore_for_file: prefer_const_constructors, prefer_is_empty, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_print, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, unused_local_variable

import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List todoData = [];
  List oldData = [];
  TextEditingController controller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();


  final ScrollController listcontroller = ScrollController();
  bool editStatus = false;
  var currentindex;

  void addTodo() {
    todoData=oldData;
    if (controller.text.length == 0) {
      const snackBar = SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning,
              color: Colors.yellow,
            ),
            Text('Please enter data'),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar,
      );
      // controller.text = "pleaese enter data";
    } else {
      // todoData.add(controller.text);
      todoData.insert(0, controller.text);
      controller.clear();
      if (listcontroller.hasClients) {
        var position = listcontroller.position.minScrollExtent;
        listcontroller.animateTo(position,
            duration: Duration(microseconds: 1), curve: Curves.easeInOutBack);
      }

      oldData=todoData;

      setState(() {});
    }
  }

  void deleteTodo(index) {
    // print(todoData[index]);
    todoData.removeAt(index);
    setState(() {});
  }

  void searchData(){
    todoData=oldData;
    print(searchcontroller.text);
    if(searchcontroller.text.isNotEmpty){
      var data = [];
      todoData.forEach((element) { 
      if( element.contains(searchcontroller.text)){
        data.add(element);
      }
      });
      print(todoData.length);
      oldData=todoData;
      todoData=data;
      print(oldData.length);
      setState(() {
        
      });

    }
  }

  void editTodo(){
    if(controller.text.isNotEmpty){
        todoData[currentindex] = controller.text;
        editStatus = false;
        controller.text = "";
        setState(() {
          
        });

    }
  


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 229, 225, 225),
            centerTitle: true,
            title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Icon(Icons.menu,
              color: Colors.black,
              size: 30,),

              Container(
                height: 45,
                width: 45,
                child: CircleAvatar(
                  backgroundImage: AssetImage('image/assets/My_Pic.jpg')
                   
                  ),
              )

              ],
            ),
           
          ),
        ),
        
      
        body: Container(
          color: Color.fromARGB(255, 229, 225, 225),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                if (editStatus==true) {
                  controller.text = "";
                  editStatus = false;
                }
                else{
                  todoData=oldData;
                  setState(() {});
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(width: 2,color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: searchcontroller,
                        decoration: InputDecoration(
                           hintText: 'Search',
                          contentPadding: EdgeInsets.all(12),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: IconButton(icon:Icon(Icons.search,color: Colors.black,size: 30,),
                             onPressed: () {
                              searchData();
                             },),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            maxHeight: 25,
                            minWidth: 25
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(width: 2,color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: TextField(
                              controller: controller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(14),
                                  hintText: "Enter data",
                                  border: InputBorder.none,
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide:
                                  //         BorderSide(width: 2, color: Colors.black)),
                                  
                                  suffixIcon: Container(
                                    width: 20,
                                    height: 20,
                                    margin: EdgeInsets.all(4),
                                    // decoration: BoxDecoration(
                                    //     color: Colors.red,
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     border: Border.all(
                                    //         width: 2, color: Colors.red)),
                                       decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: IconButton(
                                          onPressed: editStatus
                                              ? () {
                                                editTodo();
                                              }
                                              : () {
                                                  addTodo();
                                                },
                                          icon: Icon(
                                            editStatus ? Icons.edit : Icons.add,
                                            size: 25,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                  
                              ),
                              ),
                        )
                      ],
                    ),
                  ),
          
          
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 25,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Text('My ToDo:',style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                            ],
                          ),
                        ),
                        
                        todoData.length==0?
                        Padding(
                          padding: const EdgeInsets.only(top: 85),
                          child: Text('No Data Found!',style: 
                          TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold),
                          ),
                        )
                        :Text(''),
                        Container(
                          height: 430,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: todoData.length,
                              controller: listcontroller,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onDoubleTap: () {
                                    controller.text = todoData[index];
                                    editStatus = true;
                                    currentindex =index;
                                    setState(() {});
                                    print(todoData[index]);
                                  },
                                  child: Container(
                                    height: 70,
                                    margin: EdgeInsets.only(left: 15, right: 15),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 25,
                                      child: ListTile(
                                          title: Text(
                                            todoData[index],
                                            style: TextStyle(color: Colors.black,
                                            fontWeight:FontWeight.bold ),
                                            
                                          ),
                                          leading: Icon(Icons.arrow_forward_ios,
                                          color: Colors.black,),
                                          trailing: IconButton(
                                            onPressed: () {
                                              deleteTodo(index);
                                            },
                                            icon: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.black
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    
    ),
    );
  }
}