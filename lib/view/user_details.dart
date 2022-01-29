import 'package:the_cake_land/Config/Theme.dart';
import 'package:flutter/material.dart';
import 'package:the_cake_land/view/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as enc;

final key = enc.Key.fromUtf8('put32charactershereeeeeeeeeeeee!'); //32 chars
final iv = enc.IV.fromUtf8('put16characters!'); //16 chars

//encrypt
String encryptMyData(String text) {
  final e = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  final encryptedData = e.encrypt(text, iv: iv);
  return encryptedData.base64;
}

//dycrypt
String decryptMyData(String text) {
  final e = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
  final decryptedData = e.decrypt(enc.Encrypted.fromBase64(text), iv: iv);
  return decryptedData;
}

class UserDetails extends StatefulWidget {
  final String phoneNo="7010607327";
  const UserDetails({Key? key}) : super(key: key);



  @override
  State<UserDetails> createState() => _UserDetailsState(phoneNo: phoneNo);
}

class _UserDetailsState extends State<UserDetails> {
  final String phoneNo;
  _UserDetailsState({required this.phoneNo});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                shadowColor: Color(0x33CECECE),
                clipBehavior: Clip.antiAlias,
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Color(0xffB1B1B1),
                        fontSize: 15,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                shadowColor: Color(0x33CECECE),
                clipBehavior: Clip.antiAlias,
                child: TextField(
                  controller: _rCodeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Referral Code',
                      hintStyle: TextStyle(
                        color: Color(0xffB1B1B1),
                        fontSize: 15,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {

                        final String rCode = encryptMyData(phoneNo);
                        _rCodeController.text=rCode;
                        final String originalNo = decryptMyData(rCode);
                        _nameController.text=originalNo;

                      },
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 18,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.66,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                vertical: 15, horizontal: 120)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ThemeColors.green),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: ThemeColors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
