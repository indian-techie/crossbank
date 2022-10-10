import 'dart:math';

import 'package:crossbank/api/ApiClient.dart';
import 'package:crossbank/model/login/login_response_model.dart';
import 'package:crossbank/utils/ColorSelect.dart';
import 'package:crossbank/utils/SharedService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

// class Screen2Arguments {
//   late final String?vpa;
//   late final String?name;
//
//   Screen2Arguments({
//     @required this.vpa,
//     @required this.name
//   });
// }


class QR_PayAmount extends StatefulWidget {
  final String?vpa;
  final String?name;

  const QR_PayAmount({Key? key,this.vpa,this.name}) : super(key: key);
  @override
  State<QR_PayAmount> createState() => _QR_PayAmountState();
}

class _QR_PayAmountState extends State<QR_PayAmount> {
  late final String?vpa;
  late final String?name;
  late final String?id;
  late final LoginResponseModel model;
  late ProgressDialog progressDialog;
  TextEditingController _amountController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vpa=widget.vpa;
    name=widget.name;
    SharedService sharedService=SharedService();
    sharedService.getLoginDetails().then((value) {
      id=value.data![0].user.toString();
    });
    // getId().then((value){
    //   print(value);
    // });


  }
  // Future<String>getId()async{
  //   String id="";
  //   new SharedService().getLoginDetails().then((value) {
  //    id=value.toString();
  //   });
  //   return id;
  // }
  @override
  Widget build(BuildContext context) {
    setState(() {
      progressDialog=ProgressDialog(context: context);
    });
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorSelect.omasery_yelow,title: Text('Pay now'),),
      body: Container(
        child:Padding(
          padding:EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: _amountController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.currency_rupee),
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1.0),
                              ),
                              hintText: "Enter amount"
                          ),
                      ))),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed:(){PayNow();},style: ButtonStyle(elevation:MaterialStateProperty.all(10),padding:MaterialStateProperty.all(const EdgeInsets.all(15.0)),
                  backgroundColor:MaterialStateProperty.all(ColorSelect.omasery_black)
              ), child: const Text('Pay',style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),
      ),
    );
  }
  Future<void>PayNow() async {
    progressDialog.show(max: 100, msg: 'please wait');
    final Map<String, dynamic> payMap = {
      "vpa":vpa,
      "amount":_amountController.text.trim(),
      "userid":id,
      "name":name,
      "email":'',
      "phone":'',
      "address":'',

    };
    ApiClient apiClient=ApiClient();
    apiClient.payQr(payMap).then((value) {
       progressDialog.close();
       if(value.status==true)
         {
           if(value.data![0].status=="0"||value.data![0].status=="1")
             {
               Fluttertoast.showToast(msg: value.data![0].message!);
             }
         }
       else if(value.status==false)
         {

         }

    });
  }
}
