
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:amazon_clone/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';

enum Auth{
  //Keep track the radio button
  signIn,
  signUp
}

class AuthScreen extends StatefulWidget {
  static const routeAuthScreen = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signIn;//The instance of group value
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  //27_07: Create controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reEnterPass = TextEditingController();

  //28_07: Create an error handler
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
  }

  void signUpUser(){
    authService.signUpUser(email: _emailController.text, pass: _passController.text,
        userName: _nameController.text, context: context);
  }

  void signInUser(){
    authService.sigInUser(email: _emailController.text, pass: _passController.text, ctx: context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: GlobalVars.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                  child: Text('Welcome to Amazon', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                  ),
              ),
              ListTile(
                tileColor: _auth == Auth.signUp ? GlobalVars.backgroundColor : GlobalVars.greyBackgroundColor,
                title: const Text('Create an account', style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
                leading: Radio(
                  activeColor: GlobalVars.secondaryColor,
                  onChanged: (Auth? value){
                    setState(() {
                        _auth = value!;
                    });
                  },
                  value: Auth.signUp,
                  groupValue: _auth,
                ),
              ),
              if(_auth == Auth.signUp)
                Form(
                   key: _signUpFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black38
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                              )
                          ),
                        ),
                        validator: (val){
                          if(val == null || val.isEmpty){
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black38
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                              )
                          ),
                        ),
                        validator: (val){
                          if(val == null || val.isEmpty){
                            return 'Enter a valid password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _reEnterPass,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Re-enter password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        validator: (val){
                          if(val == null || val.isEmpty){
                            return 'The re-enter password must not be empty';
                          }
                          if(val != _passController.text){
                            return 'The password does not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          border:  OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black38
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black38,
                              )
                          ),
                        ),
                        validator: (val){
                          if(val == null || val.isEmpty){
                            return 'Enter a valid user name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(buttonText: 'Sign Up', onTap: (){
                        if(_signUpFormKey.currentState!.validate()){
                          signUpUser();
                        }
                      }),
                    ],
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signIn ? GlobalVars.backgroundColor : GlobalVars.greyBackgroundColor,
                title: const Text('Sign In', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                ),
                leading: Radio(
                  activeColor: GlobalVars.secondaryColor,
                  onChanged: (Auth? val){
                    setState(() {
                      _auth = val!;
                    });
                  },
                  value: Auth.signIn,
                  groupValue: _auth,
                ),
              ),
              if(_auth == Auth.signIn)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key:  _signInFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center ,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black38
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )
                            ),
                          ),
                          validator: (val){

                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            border:  OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black38
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )
                            ),
                          ),
                          validator: (val){
                              if(val == null || val.isEmpty){
                                return 'This field must not be empty';
                              }
                              return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(buttonText: 'Sign In', onTap: (){
                            if(_signInFormKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign In successfully')));
                              signInUser();
                              //Navigator.pushNamedAndRemoveUntil(context, HomeScreen.homeScreenRouteName, (route) => false);
                            }
                        }),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
