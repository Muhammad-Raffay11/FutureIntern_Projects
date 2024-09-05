// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, body_might_complete_normally_nullable, unused_local_variable, sized_box_for_whitespace, unused_import, deprecated_member_use, prefer_final_fields, unused_field, unnecessary_null_comparison, non_constant_identifier_names, use_build_context_synchronously, file_names


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

bool showPassword=true;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();



GlobalKey<FormState> form=GlobalKey<FormState>();

 var regpassword=    RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}');
  var regEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  Future<void> loginUser() async {
    print(email.text);
     print(password.text);
    
    try{
  final userCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text,password: password.text);
final user = userCredential.user;
print(user?.uid);
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TodoApp(),));
    }

    catch(e){
      print(e);
    }


     

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigoAccent,
        titleTextStyle: TextStyle(color: Colors.black87, fontSize:25),
        // leading: GestureDetector(
        //   onTap:(){
        //     Navigator.pop(context);
        //   },
        //   child: Icon(Icons.arrow_back_ios_new_rounded),
        //   ),
        title: Text('Login'),centerTitle: true,
    
        
        
      ),



      body:
      
       Form(
        key: form,
        child:
        
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 5),
        
           child: Center(
             child: Container(
              height: MediaQuery.of(context).size.height*0.95,
               child: SingleChildScrollView(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

              SizedBox(height: 180,),

                    Center(child: Text('Login!',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),)),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 20),
                    //   child: Text('SignUp!',style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold),
                    //   ),
                    
                    // ),
                    // SizedBox(height: 10),
                              
                              
                    // SizedBox(height: 220,),
                              
                        
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Container(
                             margin: EdgeInsets.all(5),
                              child: TextFormField(
                                controller: email,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Data Required!";
                                  }
                                 else if(!regEmail.hasMatch(value)){
                                  return "Incorrect Email Address";
                                 }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  prefixIcon: Icon(Icons.email_outlined,size: 25,
                                   color: Colors.black,),
                                   focusedBorder: 
                                   OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: Colors.green,
                                    ),
                                   ),
                                   hintText: "Enter Your Email !",
                                   hintStyle: TextStyle(color: Colors.black),
                            
                                ),
                              ),
                            ),
                          ),
                       
                        
                  
                    
                  
                       
                    
                  
                    
                     
                     
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                        margin: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: password,
                          validator: (name) {
                                    //  var password=    RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}');
                            if(name!.isEmpty){
                              return 'Data Required!';
                            }
                            else if(name.length<8){
                              print('Insert atleast 8 characters');
                            }
                            else if(!regpassword.hasMatch(name)){
                              return 'Incorrect Password!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: showPassword,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon: Icon(Icons.lock,size: 25,         
                             color: Colors.black,),
                             suffixIcon: GestureDetector(
                              onTap: (){
                                showPassword=!showPassword;
                                setState(() {
                                  
                                });
                              },
                               child: Icon(Icons.remove_red_eye_outlined,
                               color: Colors.black,),
                             ),
                             focusedBorder: 
                             OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.green,
                              ),
                             ),
                             hintText: "Enter Your Password !",
                             hintStyle: TextStyle(color: Colors.black),
                                     
                          ),
                        ),
                                    ),
                      ),
                        
                        
                   
                        
                        
                        
                        
                     
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          minimumSize: Size(170, 60),
                        ),
                        onPressed:(){
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash(),));
                                         //      if(!form.currentState!.validate()){
                                         // print('test');
                                         //      }
                                           //    else{
                          loginUser();
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TodoApp(),));
                                           // print('Your email is:${email.text}');
                                           //    print('Your password is:${password.text}');
                                           //    print('Your password is:${userName.text}');
                                           //    print('Your Phone Number is:${userNumber.text}');
                                           //    }
                       
                       
                       }, child: Text('Login',style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 21,
                       ),
                       ),
                       ),
                     ),
                     
                     
                     
                       ],
                       ),
               ),
             ),
           ),
         ),
      ),
      );
  
  




    
  }
}