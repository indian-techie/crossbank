class Services
{
 late final String?service_name;
 late final String?service_icon;

 Services(this.service_name, this.service_icon);
 Services.fromJson(Map<String,dynamic>json)
 {
   service_name=json['service_name'];
   service_icon=json['service_icon'];
 }
 Map<String,dynamic>toJson(){
   final data=<String,dynamic>{};
   data['service_name']=this.service_name;
   data['service_icon']=this.service_icon;
   return data;
 }
}