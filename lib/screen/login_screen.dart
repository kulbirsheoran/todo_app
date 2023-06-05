import 'package:flutter/material.dart';
import 'package:todo_app/constant/string_constants.dart';

import 'package:todo_app/sharedPreference//local_data_saver.dart';

import '../constant/routes_const.dart';

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
                            StringConstant.signIn,
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
                            StringConstant.nameLogInScreen,
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
                            return StringConstant.validatorInputNameLogInScreen;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),

                            hintText: StringConstant.nameHintTextLogInScreen,
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
                        StringConstant.passwordLogInScreen,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstant.validatorInputPasswordLogInScreen;
                          } else if (value.length < 8) {
                            return StringConstant.validatorInputConditionLogInScreen;
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            hintText: StringConstant.passwordHintTextLogInScreen,
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
                                StringConstant.forgotPasswordLogInScreen,
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
                               StringConstant.signIn,
                              )),
                        ),
                      ),
                    ),
                    InkWell(
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            StringConstant.signUpLogInScreen,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context,Routes.signUp,
                             );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> loginOpen()async{
    String? name = await LocalDataSaver.getSaveName();
    String? password = await LocalDataSaver.getSavePassword();
    if(_nameController.text == name && _passwordController.text == password){
      Navigator.pushReplacementNamed(
          context,Routes.homePage,
         );
    }else{}
  }

}
