// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_typing_uninitialized_variables, curly_braces_in_flow_control_structures, body_might_complete_normally_nullable, unused_local_variable, sized_box_for_whitespace, unused_import, deprecated_member_use, prefer_final_fields, unused_field, unnecessary_null_comparison, non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/Auth/Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

bool showPassword=true;
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController userName = TextEditingController();
TextEditingController userNumber = TextEditingController();



GlobalKey<FormState> form=GlobalKey<FormState>();

 var regpassword=    RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}');
var regUserName = RegExp(r'^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*');
  var regEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  Future<void> registerUser() async {
    print(email.text);
     print(password.text);
    
    try{
  final userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text,password: password.text);
final user = userCredential.user;
print(user?.uid);
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),));
    }

    catch(e){
      print(e.toString());
    }


     

  }

  File? _image;
final ImagePicker _picker = ImagePicker();
  
  pickImage() async {

final PickedFile = await _picker.pickImage(source: ImageSource.gallery);
print(PickedFile!.path);
setState(() {
  _image= File(PickedFile.path);
});
imageStoreStorage();

  }
  
  imageStoreStorage() async {
    try{

       FirebaseStorage storage = FirebaseStorage.instance;
   Reference storageRef = storage.ref().child("user/${_image!.path}");
   UploadTask upload = storageRef.putFile(_image!);
   TaskSnapshot snapShot = await upload.whenComplete(()=>());
   String downloadUrl = await snapShot.ref.getDownloadURL();
   print(downloadUrl);
  
    }
    catch(e){
      print(e);
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigoAccent,
          titleTextStyle: TextStyle(color: Colors.black87, fontSize:25),
          // leading: GestureDetector(
          //   onTap:(){
          //     Navigator.pop(context);
          //   },
          //   child: Icon(Icons.arrow_back_ios_new_rounded),
          //   ),
          title: Text('Sign Up'),centerTitle: true,
      
          
          
        ),
      
      
      
        body:
        
         Form(
          key: form,
          child:
          
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 5),
          
             child: Center(
               child: Container(
                height: MediaQuery.of(context).size.height*0.99,
                 child: SingleChildScrollView(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(bottom: 20),
                      //   child: Text('SignUp!',style: TextStyle(fontSize: 35,fontWeight:FontWeight.bold),
                      //   ),
                      
                      // ),
                      // SizedBox(height: 10),
                                
                                
                      GestureDetector(
                        onTap: (){
                          pickImage();
                        },
                        child: _image== null ?
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.black,
                              style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                             NetworkImage('https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1328.jpg?w=740') ),
                        )
                                
                           :
                                
                              Container(
                                 decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.black,
                              style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(115),
                          ),
                                child: CircleAvatar(
                                  radius: 110,
                                  backgroundImage:
                                   FileImage(_image!)
                                ),
                              ) 
                          ,
                      ),
                                
                      SizedBox(height: 30,),
                                
                    Container(
                      margin: EdgeInsets.all(5),
                      child:TextFormField(
                        controller: userName,
                        validator: (nameValue) {
                          if(nameValue!.isEmpty){
                            return 'Data Required!';
                          }
                          else if(!regUserName.hasMatch(nameValue)){
                            return 'Incorrect UserName';
                          }
                          else{
                            return null;             
                          }             
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          prefixIcon: Icon(Icons.person_outline_outlined,size: 20,
                          color: Colors.black,),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3,
                            color: Colors.green),        
                          ),
                         hintText: 'Username !',
                         hintStyle: TextStyle(color: Colors.black), 
                        ),
                        
                      ),
                    ),
                         
                          
                          
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: TextFormField(
                            controller: userNumber,
                            validator:(numberValue) {
                              if(numberValue!.isEmpty){
                                return 'Data Required!';
                              }
                              else if(!numberValue.toString().substring(0,2).startsWith('03')){
                                return 'Enter Correct Number!';
                              }
                              else if(numberValue.length==11){
                                return null;
                              }
                              else{return null;}
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              prefixIcon: Icon(Icons.call,size: 20,color: Colors.black,),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 3,
                                color: Colors.green),
                              ),
                              hintText: "Enter Phone Number !",
                               hintStyle: TextStyle(color: Colors.black),
                            ),
                            
                          ),
                        ),
                      ),
                          
                          
                          
                          
                          
                          
                       
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          minimumSize: Size(200, 60),
                        ),
                        onPressed:(){
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash(),));
                    //      if(!form.currentState!.validate()){
                    // print('test');
                    //      }
                      //    else{
                          registerUser();
                      // print('Your email is:${email.text}');
                      //    print('Your password is:${password.text}');
                      //    print('Your password is:${userName.text}');
                      //    print('Your Phone Number is:${userNumber.text}');
                      //    }
                       
                       
                       }, child: Text('Create',style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 21,
                       ),
                       ),
                       ),
                                
                                SizedBox(height: 15,),
                          
                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          minimumSize: Size(100, 50),
                        ),
                        onPressed:(){
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splash(),));
                                           //      if(!form.currentState!.validate()){
                                           // print('test');
                                           //      }
                                             //    else{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                             // print('Your email is:${email.text}');
                                             //    print('Your password is:${password.text}');
                                             //    print('Your password is:${userName.text}');
                                             //    print('Your Phone Number is:${userNumber.text}');
                                             //    }
                       
                       
                       }, child: Text('Login User',style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 21,
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
        ),
    );
  
  




    
  }
}