import 'package:gezdunyayigorkonyayi/pages/loginloading.dart';
import 'package:gezdunyayigorkonyayi/pages/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(.75),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      hintText: 'E-Mail',
                      prefixText: ' ',
                      hintStyle: TextStyle(color: Colors.white),
                      focusColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      hintText: 'Parola',
                      prefixText: ' ',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                      )),
                    )),
                SizedBox(
                  height: size.height * 0.08,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginLoading(
                                email: _emailController.text,
                                password: _passwordController.text)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        //color: colorPrimaryShade,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Text(
                        "Giriş yap",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child:
                      Text("Kayıt Ol", style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
