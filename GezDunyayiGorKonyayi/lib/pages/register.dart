import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gezdunyayigorkonyayi/pages/registerloading.dart';
import 'package:gezdunyayigorkonyayi/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();

  AuthService _authService = AuthService();
  ImagePicker picker = ImagePicker();

  String? profileImageSource;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(.75),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.75),
                      blurRadius: 10,
                      spreadRadius: 2)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 480,
                            maxWidth: 480);
                        final bytes = File(image!.path).readAsBytesSync();
                        String base64Image = base64Encode(bytes);
                        setState(() {
                          profileImageSource = base64Image;
                        });
                      },
                      child: SizedBox(
                        child: profileImageSource == null
                            ? Image.asset("assets/images/avatar.png")
                            : SizedBox(
                                child: ClipRRect(
                                child: Image.memory(
                                  Uint8List.fromList(
                                      base64Decode(profileImageSource!)),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                              )),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Divider(
                      height: 40,
                    ),
                    TextField(
                        controller: _nameController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          hintText: 'Kullanıcı adı',
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
                        controller: _passwordAgainController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.white,
                          ),
                          hintText: 'Parola Tekrar',
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
                      height: size.height * 0.08,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterLoading(
                                      userName: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      profileImageSource:
                                          profileImageSource.toString(),
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                              child: Text(
                            "Kaydı Tamamla",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: size.height * .06, left: size.width * .02),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        )
      ],
    ));
  }
}
