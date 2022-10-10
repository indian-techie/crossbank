import 'dart:convert';
import 'dart:io';

import 'package:crossbank/api/ApiClient.dart';
import 'package:crossbank/api/ApiConstants.dart';
import 'package:crossbank/model/login/login_req_model.dart';
import 'package:crossbank/pages/home_page.dart';
import 'package:crossbank/utils/ColorSelect.dart';
import 'package:crossbank/utils/PermissionService.dart';
import 'package:crossbank/utils/SharedService.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final TextEditingController username_controller=TextEditingController();
  final TextEditingController mpin_controller=TextEditingController();
  final PermissionService permissionService=PermissionService();
  final ApiClient apiClient=ApiClient();
  final SharedService sharedService=SharedService();
  late final String fcm_token,ipAddress,platform;
  late ProgressDialog progressDialog;

  Future<void>login()async
  {

    if(username_controller.text.isEmpty)
      {
        Fluttertoast.showToast(msg: 'please enter user-name');
      }
    else if(mpin_controller.text.isEmpty)
      {
        Fluttertoast.showToast(msg: 'please enter m-pin');
      }
    else if(mpin_controller.text.length<6)
      {
        Fluttertoast.showToast(msg: 'please enter a valid m-pin');
      }
    else
      {
        progressDialog.show(max: 100, msg: 'please wait');
        LoginReqModel reqModel=LoginReqModel(mpin_controller.text, username_controller.text,ApiConstants.agent_email,ipAddress,fcm_token,platform);
        apiClient.login(reqModel).then((data)
        {
          progressDialog.close();
          print(jsonEncode(data));
          if(data.status==true)
            {
              // print(jsonEncode(data.data));
              sharedService.setLoginDetails(data);
              Fluttertoast.showToast(msg: data.message!);
              Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context)=>const HomePage()));
            }
          else if(data.status==false)
            {
              // print(jsonEncode(data.errors![0].message));
              Fluttertoast.showToast(msg: data.errors![0].message!);
            }
        });
      }
  }
  Future<void> askPermission()
  async {
    if(await permissionService.hasPhonePermission(Permission.camera)&& await permissionService.hasPhonePermission(Permission.storage))
      {
        
      }
    else
      {
        permissionService.requestPermission(onPermissionDenied: (){

        });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    askPermission();
    //
    Future<String?> authToken =sharedService.getFcmToken();
    authToken.then((data) {
      fcm_token=data.toString();
    },onError: (e) {
      print(e);
    });
    if(Platform.isAndroid)
      {
        platform='Android';
      }
    else if(Platform.isIOS)
      {
        platform='ios';
      }
    Future<String>ip=Ipify.ipv4();
    ip.then((value) => {
      ipAddress=value
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      progressDialog=ProgressDialog(context:context);
    });
    return Scaffold(
     body: Container(
       decoration: const BoxDecoration(
         image: DecorationImage(
             image:AssetImage("assets/new_bg.png"),
             fit: BoxFit.cover,
         ),
       ),
       child: Padding(
         padding: EdgeInsets.all(20.0),
           child: ListView(
             children: [
               const Image(image: AssetImage("assets/omasserybanklogo.png"),height:200,width: 200,),
               Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: new BorderRadius.circular(10.0),
               ),
               child: Padding(
                   padding: EdgeInsets.all(5),
                   child: TextFormField(
                     controller: username_controller,
                       decoration: const InputDecoration(
                         border: InputBorder.none,
                         hintText: "Enter user-name"
                       )))),
               Container(margin:const EdgeInsets.only(top: 10.0),),
               const Text('M-PIN',),
               SizedBox(height:3,),
               PinInputTextField(pinLength: 6,controller: mpin_controller,decoration: BoxLooseDecoration(bgColorBuilder: PinListenColorBuilder(Colors.white, Colors.white), strokeColorBuilder:PinListenColorBuilder(Colors.black, Colors.black)),),
               Container(margin:const EdgeInsets.only(top: 20.0),),
               ElevatedButton(onPressed:(){login();},style: ButtonStyle(elevation:MaterialStateProperty.all(10),padding:MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                 backgroundColor:MaterialStateProperty.all(ColorSelect.omasery_black)
               ), child: const Text('Login',style: TextStyle(color: Colors.white),),)

             ],
           ),
         ),
     ),
    );
  }

}
