import 'package:crossbank/utils/SharedService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../api/ApiClient.dart';
import '../utils/ColorSelect.dart';
class TransferToVpa extends StatefulWidget {
  const TransferToVpa({Key? key}) : super(key: key);

  @override
  State<TransferToVpa> createState() => _TransferToVpaState();
}

class _TransferToVpaState extends State<TransferToVpa> {
  final TextEditingController _amountController=TextEditingController();
  final TextEditingController _vpaController=TextEditingController();
  late final ProgressDialog progressDialog;
  late final String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressDialog=ProgressDialog(context: context);
    SharedService sharedService=SharedService();
    sharedService.getLoginDetails().then((value) {
      id=value.data![0].user.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorSelect.omasery_yelow,title: Text('Transfer to vpa'),),
      body: Container(
        child:Padding(
          padding:EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextField(
                controller: _vpaController,
                decoration: InputDecoration(
                  hintText: 'Enter vpa-id'
                ),
              ),
              SizedBox(height: 10.0,),
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
        Fluttertoast.showToast(msg: 'Please enter vpa-id');
      }
    else if(_amountController.text.isEmpty)
      {
        Fluttertoast.showToast(msg: 'Please enter amount');
      }
    else {
      progressDialog.show(max: 100, msg: 'please wait');
      final Map<String, dynamic> payMap = {
        "vpa": _vpaController.text.toString(),
        "amount": _amountController.text.trim(),
        "userid":id,
        "name": '',
        "email": '',
        "phone": '',
        "address": '',

      };
      ApiClient apiClient = ApiClient();
      apiClient.payQr(payMap).then((value) {
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
