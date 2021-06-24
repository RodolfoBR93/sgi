import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sgi/core/core.dart';
import 'package:sgi/core/uteis.dart';
import 'package:sgi/database/dao/user_dao.dart';
import 'package:sgi/manage_access/manage_access_page.dart';
import 'package:sgi/models/user.dart';
import 'package:sgi/register/Widgets/app_bar_register_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AccessCode extends StatefulWidget {
  static const String routeName = "/login";
  //String user;
  AccessCode();

  @override
  _AccessCodeState createState() => _AccessCodeState();
}

class _AccessCodeState extends State<AccessCode> {
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  StreamController<ErrorAnimationType> errorController;
  Endereco endereco = new Endereco();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String user;
  final UserDao _dao = UserDao();
  _AccessCodeState();

  @override
  Future<void> initState() async {
    List<User> users = await _dao.findAll();
    user = users[0].getuserProtheus.toString();
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarRegisterWidget(),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(AppImages.otp),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Verificação de Acesso',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Informe o código recebido por E-mail",
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      onTap: clearError,
                      dialogConfig: DialogConfig(
                        dialogTitle: "Colar código",
                        dialogContent: 'Você deseja colar este código: ',
                        affirmativeText: "Colar",
                        negativeText: "Cancelar",
                      ),
                      backgroundColor: AppColors.white,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 6) {
                          return "Código incompleto";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        inactiveFillColor: AppColors.white,
                        inactiveColor: AppColors.lightGrey,
                        selectedColor: AppColors.lightGrey,
                        selectedFillColor: AppColors.white,
                        activeColor: Colors.green,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: hasError ? Colors.white : Colors.white,
                      ),
                      cursorColor: AppColors.blue,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completo");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Permitindo colar $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Código inválido." : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não recebeu o código? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        WidgetsUteis.exibeSnackBar(
                            context, _scaffoldKey, "Código reenviado!!",
                            duracao: 2);
                        //snackBar("Código reenviado!!");
                      },
                      child: Text(
                        "Reenviar",
                        style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      formKey.currentState.validate();
                      // conditions for validating
                      if (currentText.length != 6) {
                        // errorController.add(ErrorAnimationType
                        //     .shake); // Triggering error shake animation
                        // setState(() {
                        //   hasError = true;
                        // });
                        var ret = checkCode(user, currentText);
                        setState(
                          () {
                            if (ret == 1) {
                              hasError = false;
                              snackBar("Código verificado!!");
                            } else if (ret == 2) {
                              errorController.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() {
                                hasError = true;
                              });
                            }
                          },
                        );
                      } else {
                        setState(
                          () {
                            var ret = checkCode(user, currentText);
                            if (ret == 1) {
                              hasError = false;
                              snackBar("Código verificado!!");
                            } else if (ret == 2) {
                              errorController.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() {
                                hasError = true;
                              });
                            }
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "Verificar".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> checkCode(String usuario, String code) async {
    WidgetsUteis.showLoadingDialog(context, _keyLoader, "Aguarde...");
    await new Future.delayed(const Duration(seconds: 1));
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.post("${endereco.getEndereco}valida_codigo",
          data: {"usuario": usuario, "codigo": code});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.of(context).pop();
        if (response.data["id"] == 1) {
          WidgetsUteis.exibeSnackBar(
              context, _scaffoldKey, "Código verificado com sucesso.");
          await new Future.delayed(const Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageAccess(usuario)),
          );
        } else {
          WidgetsUteis.exibeSnackBar(context, _scaffoldKey, "Código inválido!");
        }
      } else {
        Navigator.of(context).pop();
        WidgetsUteis.exibeSnackBar(
            context, _scaffoldKey, "Não foi possível conectar");
      }

      return response.data["id"];
    } catch (e) {
      Navigator.of(context).pop();
      WidgetsUteis.exibeSnackBar(
          context, _scaffoldKey, "Não foi possível conectar");
      print(e);
    }
    return response.data["id"];
  }

  void clearError() {
    if (currentText.length == 6) {
      setState(() {
        hasError = false;
      });
    }
  }
}
