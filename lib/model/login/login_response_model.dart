import 'dart:convert';
class LoginResponseModel {
  bool?status;
  Meta?meta;
  List<Data>?data;
  String?message;
  List<ErrorRes>?errors;
  LoginResponseModel({this.status,this.meta,this.data,this.message,this.errors});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status=json['status'];
    meta=Meta.fromJson(json['meta']);
    message=json['message'];
    if(json['errors']!=null)
      {
        errors=<ErrorRes>[];
        json['errors'].forEach((v) {
          errors!.add(new ErrorRes.fromJson(v));
        });
      }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['meta']=this.meta!.toJson();
    data['message']=this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ErrorRes
{
 late final String?message;
 late final String?token;

 ErrorRes({this.message,this.token});
 ErrorRes.fromJson(Map<String,dynamic>json)
 {
  message=json['message'];
  token=json['token'];
 }
 Map<String,dynamic>toJson(){
   final _data=<String,dynamic>{};
   _data['message']=this.message;
   _data["token"]=this.token;
   return _data;
 }
}
class Data
{
  late final bool? response;
  late final String?token;
  late final int?user;
  late final LoginUserData?userdetails;
  late final bool?fasttag;
  late final bool?authenticate;
  late final bool?alertstatus;
  late final  bool?sms;

  Data(this.response, this.token, this.user, this.userdetails, this.fasttag,
      this.authenticate, this.alertstatus, this.sms);

  Data.fromJson(Map<String,dynamic>json)
  {
   response= json['response'];
   token=json['token'];
   user=json['user'];
   userdetails=LoginUserData.fromJson(json['userdetails']);
   fasttag=json['fasttag'];
   authenticate=json['authenticate'];
   alertstatus=json['alertstatus'];
   sms=json['sms'];
  }
  Map<String,dynamic>toJson(){
    final _data=<String,dynamic>{};
    _data['response']=response;
    _data['token']=token;
    _data['user']=user;
    _data['userdetails']=userdetails!.toJson();
    _data['fasttag']=fasttag;
    _data['authenticate']=authenticate;
    _data['alertstatus']=alertstatus;
    _data['sms']=sms;
    return _data;
  }
}

class LoginUserData {
  late final int? id;
  late final String?refid;
  late final String?name;
  late final String?accno;
  late final String?mobileno;
  late final String?email;
  late final String?gender;
  late final String?address;
  late final String?dob;
  late final String?pincode;
  late final String?idtype;
  late final String?idnumber;
  late final String?image;
  late final String?txnlimit;
  late final String?unique_pass;
  late final String?credate;
  late final int?kycstatus;
  late final int?agent_id;
  late final int?employee_id;
  late final String?type;
  late final String?token;
  late final String?login_token;
  late final String?log_tkn_time;
  late final int? sta_app;
  late final String?status;
  late final int? otp_app;
  late final String?api_reg;

  LoginUserData(
      this.id,
      this.refid,
      this.name,
      this.accno,
      this.mobileno,
      this.email,
      this.gender,
      this.address,
      this.dob,
      this.pincode,
      this.idtype,
      this.idnumber,
      this.image,
      this.txnlimit,
      this.unique_pass,
      this.credate,
      this.kycstatus,
      this.agent_id,
      this.employee_id,
      this.type,
      this.token,
      this.login_token,
      this.log_tkn_time,
      this.sta_app,
      this.status,
      this.otp_app,
      this.api_reg);

  LoginUserData.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    refid=json['refid'];
    name=json['name'];
    accno=json['accno'];
    mobileno=json['mobileno'];
    gender=json['gender'];
    address=json['address'];
    dob=json['dob'];
    pincode=json['pincode'];
    idtype=json['idtype'];
    idnumber=json['idnumber'];
    image=json['image'];
    txnlimit=json['txnlimit'];
    unique_pass=json['unique_pass'];
    credate=json['credate'];
    kycstatus=json['kycstatus'];
    agent_id=json['agent_id'];
    employee_id=json['employee_id'];
    type=json['type'];
    token=json['token'];
    login_token=json['login_token'];
    log_tkn_time=json['log_tkn_time'];
    sta_app=json['sta_app'];
    status=json['status'];
    otp_app=json['otp_app'];
    api_reg=json['api_reg'];



  }
  Map<String,dynamic>toJson(){
    final _data=<String,dynamic>{};
    _data['id']=id;
    _data['refid']=refid;
    _data['name']=name;
    _data['accno']=accno;
    _data['mobileno']=mobileno;
    _data['gender']=gender;
    _data['address']=address;
    _data['pincode']=pincode;
    _data['idtype']=idtype;
    _data['image']=image;
    _data['txnlimit']=txnlimit;
    _data['unique_pass']=unique_pass;
    _data['credate']=credate;
    _data['kycstatus']=kycstatus;
    _data['agent_id']=agent_id;
    _data['employee_id']=employee_id;
    _data['type']=type;
    _data['token']=token;
    _data['login_token']=login_token;
    _data['log_tkn_time']=log_tkn_time;
    _data['sta_app']=sta_app;
    _data['status']=status;
    _data['otp_app']=otp_app;
    _data['api_reg']=api_reg;




    return _data;

  }
}
class Meta
{
  late final int?code;
  late final String?message;

  Meta(this.code, this.message);

  Meta.fromJson(Map<String,dynamic>json)
  {
    code=json['code'];
    message=json['message'];
  }
  Map<String,dynamic>toJson()
  {
    final _data=<String,dynamic>{};
    _data['code']=code;
    _data['message']=message;
    return _data;
  }
}