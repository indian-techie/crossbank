import 'package:crossbank/model/login/login_response_model.dart';
import 'package:crossbank/utils/SharedService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../api/ApiClient.dart';
import '../utils/ColorSelect.dart';
class TransferToNumber extends StatefulWidget {
  const TransferToNumber({Key? key}) : super(key: key);

  @override
  State<TransferToNumber> createState() => _TransferToNumberState();
}

class _TransferToNumberState extends State<TransferToNumber> {
  final TextEditingController _amountController=TextEditingController();
  final TextEditingController _vpaController=TextEditingController();
  late final ProgressDialog progressDialog;
  late final LoginResponseModel model;
  late final String usr_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressDialog=ProgressDialog(context: context);
    SharedService sharedService=SharedService();
    sharedService.getLoginDetails().then((value){
      usr_id=value.data![0].user.toString();
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorSelect.omasery_yelow,title: Text('Transfer to Number'),),
      body: Container(
        child:Padding(
          padding:EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _vpaController,
                decoration: const InputDecoration(
                    hintText: 'Enter mobile-number'
                ),

              ),
              const SizedBox(height: 10.0,),
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
    if(_vpaController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: 'Please enter mobile-number');
    }
    else if(_amountController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: 'Please enter amount');
    }
    else {
      progressDialog.show(max: 100, msg: 'please wait');
      final Map<String, dynamic> payMap = {
        "amount": _amountController.text.trim(),
        "userid": usr_id,
        "phone": _vpaController.text.trim(),

      };
      ApiClient apiClient = ApiClient();
      apiClient.payNumber(payMap).then((value) {
        progressDialog.close();
        if (value.status == true) {
          if (value.data![0].status == "0" || value.data![0].status == "1") {
            Fluttertoast.showToast(msg: value.data![0].message!);
          }
        }
        else if (value.status == false) {

        }
      });
    }
  }

}
