// ignore_for_file: prefer_const_constructors
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  
  bool passToggle = true;

  static const Color constBackgroundColor = Color(0xffe2ecec);
  static const Color navBarsColor = Color(0xff089bab);
  static const Color boxesColor = Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constBackgroundColor,
      
      appBar: AppBar(
          backgroundColor: navBarsColor,
          title: Text('InjuryInsight'),
          leading: Icon(Icons.menu),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person_2_outlined))],
          centerTitle: true,
        ),
      
      body: SingleChildScrollView(
        child: Padding( 
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
          child: Container(
            decoration: BoxDecoration(
              color: boxesColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            child: Form(
              key: _formfield,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  //Email
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration:  InputDecoration(
                      labelStyle: TextStyle(color: navBarsColor),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: navBarsColor)),
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.email),
                    ),
                    validator:  (value){
                      if (value!.isEmpty){return "Enter email";}
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                      if (!emailValid){return "Enter valid email";}
                    },
                  ),

                  //Пароль
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passController,
                    obscureText: passToggle,
                    decoration:  InputDecoration(
                      labelStyle: TextStyle(color: navBarsColor),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: navBarsColor)),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            passToggle = !passToggle;
                          });
                        },
                        child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){return "Enter password";}
                      else if(passController.text.length < 6){return "Password length should not be less then 6 chars";}
                    },
                  ),

                  //Кнопка
                  SizedBox(height: 60,),
                  InkWell(
                      onTap: (){
                        if (_formfield.currentState!.validate()){
                          print("success");
                          emailController.clear();
                          passController.clear();
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: navBarsColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                          child: Center(
                            child: Text("Log in", style: TextStyle(
                              color: boxesColor,
                              fontSize: 20,
                              ),
                            ),
                          ),
                      ),
                    ),

                  //Последняя строка
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Alredy have an accaunt?", style: TextStyle(fontSize: 16),),

                      TextButton(
                        onPressed: () {}, 
                        child: Text(
                          "Sing up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Форма регистрации
          
        ),
      ),
    );
  }
}