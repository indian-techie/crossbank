import 'package:permission_handler/permission_handler.dart';

class PermissionService{
  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if(statuses==PermissionStatus.granted)
      {
       return true;
      }
    // var result = await _permissionHandler.requestPermissions([PermissionGroup.phone,PermissionGroup.contacts,PermissionGroup.sms]);
    // if (result == PermissionStatus.granted) {
    //   return true;
    // }
    return false;
  }

  Future<bool> requestPermission({required Function onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> hasPhonePermission(Permission permission) async {
    return hasPermission(permission);
  }

  Future<bool> hasPermission(Permission permission) async {
    var permissionStatus =permission.status;
    return permissionStatus == PermissionStatus.granted;
  }
}