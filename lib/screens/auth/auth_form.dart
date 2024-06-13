// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:gwork_flutter_application_1/api_service.dart';
import 'package:gwork_flutter_application_1/const_themedata.dart';
import 'package:gwork_flutter_application_1/models/users.dart';
import 'package:gwork_flutter_application_1/screens/patient/patient_dashboard.dart';
import 'package:gwork_flutter_application_1/widgets/widgets.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final apiService = ApiService('https://alexsandr52-database-management-graduate-work-4add.twc1.net');
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themedata.constBackgroundColor,
      appBar: CustomAppBar(notificationIcon: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
          child: Container(
            decoration: BoxDecoration(
              color: Themedata.boxesColor,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  _buildNameField(),
                  SizedBox(height: 20),
                  _buildEmailField(),
                  SizedBox(height: 20),
                  _buildPasswordField(),
                  SizedBox(height: 60),
                  _buildRegisterButton(),
                  SizedBox(height: 20),
                  _buildLoginLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: nameController,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Themedata.navBarsColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Themedata.navBarsColor),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: "Имя",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Введите имя";
        }
        return null;
      },
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
        labelText: "Почта",
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
          return "Придумайте пароль";
        } else if (value.length < 6) {
          return "Пароль должен быть не менее 6 символов";
        }
        return null;
      },
    );
  }

  Widget _buildRegisterButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          var user = {
            'first_name': nameController.text,
            'email': emailController.text,
            'password': passController.text
          };
          String registrationResult = await apiService.register(user);
          // Проверка результата регистрации
          if (registrationResult == 'Успешно') {
            
            bool success = await apiService.login(emailController.text, passController.text);
            if (success) {
              User user = apiService.getUser();
              if (user.role == Roles.patient){Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => PatientDashbord(user: user)), (route) => false,);}
              else{Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => PatientDashbord(user: user)), (route) => false,);}

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
            
          } else {
            print('Registration failed: $registrationResult');
          }

          emailController.clear();
          passController.clear();
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
            "Зарегистрироваться",
            style: TextStyle(
              color: Themedata.boxesColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Уже есть аккаунт?",
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Войти",
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
