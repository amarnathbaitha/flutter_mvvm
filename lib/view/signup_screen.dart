import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/component/round_button.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _obscuredPassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    _obscuredPassword.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height *1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: "email",
                labelText: "email",
                prefixIcon: Icon(
                  Icons.alternate_email,
                ),
              ),
              onFieldSubmitted: (val){
                Utils.filedFocusChanged(context, emailFocusNode, passwordFocusNode);
              },
            ),
            ValueListenableBuilder(valueListenable: _obscuredPassword, builder: (context,value, child){
              return TextFormField(
                controller: _passwordController,
                obscureText: _obscuredPassword.value,
                obscuringCharacter: "a",
                focusNode: passwordFocusNode,
                decoration:  InputDecoration(
                  hintText: "password",
                  labelText: "password",
                  prefixIcon: const Icon(
                    Icons.lock_open_outlined,
                  ),
                  suffixIcon: InkWell(
                      onTap: (){
                        _obscuredPassword.value = !_obscuredPassword.value;
                      },
                      child: _obscuredPassword.value?const Icon(Icons.visibility_off,):const Icon(Icons.visibility_sharp)),
                ),
              );
            }),
            SizedBox(height: height * 0.085,),
            RoundedButton(title: "SignUp",onPress: (){
              if(_emailController.text.isEmpty){
                Utils.flushBarErrorMessage("Please enter email", context);
              }else if(_passwordController.text.isEmpty){
                Utils.flushBarErrorMessage("Please enter password", context);
              }else if(_passwordController.text.length < 6){
                Utils.flushBarErrorMessage("Password should be 6 digits", context);
              }else{
                Map data = {
                  "email":_emailController.text.toString(),
                  "password":_passwordController.text.toString(),
                };
                authViewModel.singUpApi(data,context);
                print("api hit");
              }
            },loading: authViewModel.sighUpLoading,),
            SizedBox(height: height * 0.02,),
            Text("Already have an account?Login"),
          ],
        ),
      ),
    );
  }
}
