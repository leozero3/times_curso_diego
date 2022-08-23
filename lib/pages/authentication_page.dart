import 'package:flutter/material.dart';
//authentication_page

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text(''),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('dat'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
            ),
          ),
        ],
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                //validator: (){}
              ),
            )
          ],
        ),
      ),
    );
  }
}
