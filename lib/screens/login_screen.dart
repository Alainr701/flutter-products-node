import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //media query 
    final size = MediaQuery.of(context).size;
    return   Scaffold(
          body:  AuthBackground(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.40),
                  CardContainer(child: Column(
                    children: [
                   const SizedBox(height: 10),
                   const Text('LOGIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                   ChangeNotifierProvider( create: (_)=>LoginFormProvider(),child: _LoginForm()),
                   const Spacer(),        
                   const Text('Crea una nueva cuenta',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                   const SizedBox(height: 50),   
                    ],
                  )),
               
                ],
              ),
            )
          )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'example@gmail.com',
                labelText: 'Email',
                icon: Icons.email,
              ),  
              onChanged: (value) => loginForm.email = value,

              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  =  RegExp(pattern);
                return regExp.hasMatch(value??'') ? null : 'Email no válido';
              },      
              ),
            
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                hintText: '************',
                labelText: 'Contraseña',
                icon: Icons.lock,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >=6)? null : 'Contraseña no válida';
              },

            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              color: Colors.blue,
              
              child: Container(
                margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: loginForm.isLoading ?
                const CircularProgressIndicator(color: Colors.white) : 
                const Text('Iniciar sesión', style: TextStyle(color: Colors.white,fontSize: 20)),
                // child:Text(
                //   loginForm.isLoading? 'Cargando...' : 'Iniciar sesión',
                //   style: TextStyle(color: Colors.white,fontSize: 20)),
              ),
              onPressed:  loginForm.isLoading? null : () async {
                FocusScope.of(context).unfocus();
                if (!loginForm.isValidForm()) return;
                loginForm.isLoading =true;
                await Future.delayed(const Duration(seconds: 2));
                loginForm.isLoading = false;
                Navigator.pushNamed(context, 'home');
              },
              
            )

          ],
        )),
    );
  }
}