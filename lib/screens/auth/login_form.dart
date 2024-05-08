// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
      
      appBar: CustomAppBar(),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        child: CustomBox(
          child: Form(
              key: _formfield,
              
              child: Column(
                children: [
                  
                  //login
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration:  InputDecoration(
                      labelStyle: TextStyle(color: navBarsColor),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: navBarsColor), borderRadius: BorderRadius.circular(10)),
                      labelText: "Почта",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefix: Icon(Icons.email),
                    ),
                    validator:  (value){
                      if (value!.isEmpty){return "Введите почту";}
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                      if (!emailValid){return "Неверный формат";}
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
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: navBarsColor), borderRadius: BorderRadius.circular(10)),
                      labelText: "Пароль",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                      if(value!.isEmpty){return "Придумайте пароль";}
                      else if(passController.text.length < 6){return "Длинна паролья меньше 6";}
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
                            child: Text("Войти", style: TextStyle(
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
                      TextButton(
                        onPressed: () {Navigator.of(context).pushNamed('/auth');}, 
                        child: Text(
                          "Регистрация",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(navBarsColor), // Цвет текста кнопки
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),  
          ),
      )
 
    );
  }
}