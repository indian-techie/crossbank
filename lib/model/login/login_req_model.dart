class LoginReqModel
{
  late final String? mpin;
  late final String? username;
  late final String? agent_email;
  late final String? ip;
  late final String? device_token;
  late final String? device_type;

  LoginReqModel(this.mpin, this.username, this.agent_email, this.ip,
      this.device_token, this.device_type);

  LoginReqModel.fromJson(Map<String,dynamic>json)
  {
    mpin=json['mpin'];
    username=json['username'];
    agent_email=json['agent_email'];
    ip=json['ip'];
    device_token=json['device_token'];
    device_type=json['device_type'];
  }

  Map<String,dynamic>toJson()
  {
    final _data=<String,dynamic>{};
    _data['mpin=']=mpin;
    _data['username=']=username;
    _data['agent_email=']=agent_email;
    _data['ip=']=ip;
    _data['device_token=']=device_token;
    _data['device_type=']=device_type;

    return _data;
  }
}