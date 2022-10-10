import 'dart:core';
import 'dart:developer';

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:crossbank/model/services/services.dart';
import 'package:crossbank/pages/qr_amount.dart';
import 'package:crossbank/pages/transfer_number.dart';
import 'package:crossbank/pages/transfer_vpa.dart';
import 'package:crossbank/utils/ColorSelect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Services>list=[];
  late String?appname;
  late PackageInfo _packageInfo;
  @override
  void initState() {
    // TODO: implement initState
    _packageInfo=PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      appname=_packageInfo.appName;
    });
    return Scaffold(
      appBar: AppBar(title:Text(appname!),backgroundColor: ColorSelect.omasery_yelow,),
      body: Stack(
        children: [
           Container(color:ColorSelect.omasery_black,child: Column(
             children: [
               Row(
                 children: [
                   Image.asset('assets/home_bg.png')
                 ],
               )
             ],
           ),),

           Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/home_bg.png'),fit:BoxFit.cover )
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: ColorSelect.omasery_black,
                    borderRadius:BorderRadius.all(Radius.circular(20.0))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                         Flexible(
                          flex: 1,
                          child: GestureDetector(
                            child: Column(
                              children: [
                                Image.asset('assets/wallet.png',height:40.0,width: 40.0,color:ColorSelect.omasery_yelow,),
                                SizedBox(height:5,),
                                const Text('To Number',style: TextStyle(
                                  color: Colors.white
                                ),)
                              ],
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferToNumber()));
                              },
                          ),
                        ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                              child: Column(
                                children: [
                                  Image.asset('assets/bankacc.png',height:40.0,width: 40.0,color: ColorSelect.omasery_yelow,),
                                  SizedBox(height:5,),
                                  const Text('To Account',style: TextStyle(color: Colors.white),)
                                ],
                              ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferToNumber()));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          child: Column(
                                  children: [
                                    Image.asset('assets/accounting.png',height:40.0,width: 40.0,color:ColorSelect.omasery_yelow,),
                                    SizedBox(height:5,),
                                    const Text('To Vpa',style: TextStyle(
                                        color: Colors.white
                                    ),)
                                  ],
                                ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferToVpa()));
                          },
                        ),
                      ),

                      // GestureDetector(
                      //   child: Flexible(
                      //     flex: 1,
                      //     child: Column(
                      //       children: [
                      //         Image.asset('assets/bankacc.png',height:40.0,width: 40.0,color: ColorSelect.omasery_yelow,),
                      //         SizedBox(height:5,),
                      //         const Text('To Account',style: TextStyle(color: Colors.white),)
                      //       ],
                      //     ),
                      //   ),
                      //   onTap: (){
                      //
                      //   },
                      // ),
                      // GestureDetector(
                      //   child: Flexible(
                      //     flex: 1,
                      //     child: Column(
                      //       children: [
                      //         Image.asset('assets/accounting.png',height:40.0,width: 40.0,color:ColorSelect.omasery_yelow,),
                      //         SizedBox(height:5,),
                      //         const Text('To Vpa',style: TextStyle(
                      //             color: Colors.white
                      //         ),)
                      //       ],
                      //     ),
                      //   ),
                      //   onTap: (){
                      //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferToVpa()));
                      //   },
                      // ),

                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Services>>(
                    future: addServices(),
                    builder: (context,AsyncSnapshot snapshot)
                    {
                      if(snapshot.connectionState==ConnectionState.done)
                      {
                        if(snapshot.hasData)
                        {
                          return GridView.builder(
                              itemCount: list.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                              itemBuilder: (context,index)
                              {
                                return serviceTicket(list[index]);
                              }
                          );
                        }
                        else if(snapshot.hasError)
                        {
                          log(snapshot.error.toString());
                          Fluttertoast.showToast(msg: snapshot.error.toString());
                        }
                      }
                      return const Center(child: CircularProgressIndicator(),);
                    },
                  ),
                )



              ],
            ),

            // child: FutureBuilder<List<Services>>(
            //   future: addServices(),
            //   builder: (context,AsyncSnapshot snapshot)
            //   {
            //     if(snapshot.connectionState==ConnectionState.done)
            //     {
            //       if(snapshot.hasData)
            //       {
            //         return GridView.builder(
            //             itemCount: list.length,
            //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 3),
            //             itemBuilder: (context,index)
            //             {
            //               return serviceTicket(list[index]);
            //             }
            //         );
            //       }
            //       else if(snapshot.hasError)
            //       {
            //         log(snapshot.error.toString());
            //         Fluttertoast.showToast(msg: snapshot.error.toString());
            //       }
            //     }
            //     return const Center(child: CircularProgressIndicator(),);
            //   },
            // ),
          ),
           Align(alignment: Alignment.bottomCenter,child: Container(
             height: 100.0,
             child:Stack(
                 children: [
                   Align(alignment: Alignment.bottomCenter,child: Container(width: MediaQuery.of(context).size.width,height:30.0,color:ColorSelect.omasery_black,)),
                   Align(alignment:Alignment.center,child: GestureDetector(child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(50),color:ColorSelect.omasery_yelow ),child: Lottie.asset('assets/scanneri.json',width:80.0,height: 80.0)),onTap:()=>{
                     scanQR()
                   },)),
            ],
            )
           ))
        ],

      ),
    );
  }
  Future<void>scanQR() async {
    final result = await BarcodeScanner.scan();
    setState(() {
       // Fluttertoast.showToast(msg: result.rawContent);
       if(result.rawContent.startsWith('upi'))
         {
           late String pa,pn;
           getValues(result.rawContent, 0).then((value) =>{
             pa=value.toString()
           });
           getValues(result.rawContent, 1).then((value) =>{
             pn=value.toString()
           });
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>const QR_PayAmount()));
           Navigator.push(context,MaterialPageRoute(builder: (context)=>QR_PayAmount(vpa:pa,name:pn)));
         }
       else
         {
           Fluttertoast.showToast(msg:'invalid upi');
         }
    });
  }
  Future<String?>getValues(String vpa,int type)async
  {
    String?value="";
    var response=vpa.split("&");
    for(int i=0;i<response.length;i++) {
      String val = response[i].toLowerCase();
      if (type == 0) {
        if (val.startsWith("upi")) {
          if (val.contains("pa=")) {
            int from = vpa.lastIndexOf("pa=");
            String full = vpa.substring(from, val.length);
            var equalStr = full.split("=");
            if (equalStr.length >= 2) {
              value = Uri.decodeFull(equalStr[1].toLowerCase());
            }
          }
        }
        else if (val.contains("pa=")) {
          int from = vpa.lastIndexOf("pa=");
          String full = vpa.substring(from, val.length);
          var equalStr = full.split("=");
          if (equalStr.length >= 2) {
            value = Uri.decodeFull(equalStr[1].toLowerCase());
          }
        }
      }
      if (type == 1) {
        if (val.startsWith("pn")) {
          var equalStr = val.split("=");
          if (equalStr.length >= 2) {
            value = Uri.decodeFull(equalStr[1].toLowerCase());
          }
        }
      }
    }
    return value;
  }


  Widget serviceTicket(Services services)
  {
    return Container(
      child: Column(
        children: [
         Image(image: AssetImage(services.service_icon!),height:80.0,width: 80.0,),
         Text(services.service_name!)
        ],
      ),
    );
  }
  Future<List<Services>>addServices() async {
    list.clear();
    Services services=Services('Money Transfer','assets/money_tranfer.png');
    list.add(services);
    Services services1=Services('Scan & Pay','assets/scan_pay.png');
    list.add(services1);
    Services services2=Services('New Account','assets/new_account.png');
    list.add(services2);
    Services services3=Services('Recharges','assets/recharges.png');
    list.add(services3);
    Services services4=Services('FASTag','assets/fast_tag.png');
    list.add(services4);
    Services services5=Services('Bookings','assets/bookings.png');
    list.add(services5);
    Services services6=Services('Atm Services','assets/atm_services.png');
    list.add(services6);
    Services services7=Services('Shop on Chat','assets/shop_onchat.png');
    list.add(services7);
    Services services8=Services('Statements','assets/account_details.png');
    list.add(services8);
    Services services9=Services('Kseb','assets/kseb.png');
    list.add(services9);
    Services services10=Services('Land Line','assets/landline.png');
    list.add(services10);
    Services services11=Services('Water','assets/water.png');
    list.add(services11);
    Services services12=Services('Insurance','assets/insurance.png');
    list.add(services12);
    // Services services13=Services('Kseb','assets/kseb.png');
    // list.add(services13);
    // Services services3=Services('Recharges','assets/recharges.png');
    // list.add(services3);
    // Services services3=Services('Recharges','assets/recharges.png');
    // list.add(services3);
    print("length"+list.length.toString());
    return list;
  }
}
