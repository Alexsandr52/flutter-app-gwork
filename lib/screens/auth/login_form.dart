// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/screens/doctor/doctor_dashboard.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_dashboard.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net');
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(
        notificationIcon: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
        child: CustomBox(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildEmailField(),
                SizedBox(height: 20),
                _buildPasswordField(),
                SizedBox(height: 60),
                _buildLoginButton(),
                SizedBox(height: 20),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Themedata.navBarsColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themedata.navBarsColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введите почту";
        }
        bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
        ).hasMatch(value);
        if (!emailValid) {
          return "Неверный формат";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passController,
      obscureText: passToggle,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Themedata.navBarsColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themedata.navBarsColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Пароль",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              passToggle = !passToggle;
            });
          },
          child: Icon(
            passToggle ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введите пароль";
        } else if (value.length < 6) {
          return "Пароль должен быть не менее 6 символов";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          try{
            bool success = await apiService.login(emailController.text, passController.text);
          if (success) {
            User user = apiService.getUser();
            if (user.role == Roles.patient){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => PatientDashbord(user: user)),);}
            else{Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DoctorDashboard(user: user)),);}

          } else {
             showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Что то пошло не так'),
                content: const Text('Проверьте введенные данные'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          }catch(e){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('$e'),
                content: const Text('что то не так'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Themedata.navBarsColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            "Войти",
            style: TextStyle(
              color: Themedata.boxesColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/auth');
          },
          child: Text(
            "Регистрация",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              Themedata.navBarsColor,
            ),
          ),
        ),
      ],
    );
  }
}

class PatientDashboard {
}
