import 'package:flutter/material.dart';
import 'package:todo_app/screen/home_page.dart';
import 'package:todo_app/screen/signup_screen.dart';
import 'package:todo_app/sharedpre/local_data_saver.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200,
                      child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                      decoration:
                      const BoxDecoration(color: Colors.greenAccent),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please input name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),

                            hintText: "Name",
                            fillColor: Colors.white,
                            filled: true,

                            prefixIcon: IconButton(
                              color: Colors.greenAccent,
                              icon: const Icon(Icons.person),
                              onPressed: () {
                                _nameController.clear();
                              },
                            )),
                        controller: _nameController,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 260.0),
                      child: Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        // focusNode: nameFocus,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please input password";
                          } else if (value.length < 8) {
                            return 'required 8 digit';
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            hintText: "Password",
                            fillColor: Colors.white,
                            filled: true,

                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () {
                                _passwordController.clear();
                              },
                            )),
                        controller: _passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "forgot password?",
                                style: TextStyle(color: Colors.white,),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            //signup();
                            loginOpen();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: const Center(
                              child: Text(
                                "Login",
                              )),
                        ),
                      ),
                    ),
                    InkWell(
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void loginOpen()async{
    String? name = await LocalDataSaver.getSaveName();
    String? password = await LocalDataSaver.getSavePassword();
    if(_nameController.text == name && _passwordController.text == password){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage()));
    }else{}
  }

}
