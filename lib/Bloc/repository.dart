import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:agva_app/Bloc/models.dart';
import 'package:agva_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Map<String, bool> expansionStates = {};
List<Map<String, dynamic>> associationlist = [];

class PostRepository {
  Future<List<PostModel>> fetchPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    try {
      final response = await http.get(Uri.parse(gethospitallist), headers: {
        "Authorization": 'Bearer $mytoken',
      });
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['data'];
        print(data);
        return (data as List<dynamic>).map((e) {
          return PostModel(
              hospitalname: e['Hospital_Name'],
              city: e['Hospital_Address'],
            );
        }).toList();
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw Exception('Error while fetching data');
    } on TimeoutException {}
    throw Exception('error while fetching');
  }
}

class ProfileRepository {
  Future<List<ProfileModel>> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    String? userID = prefs.getString('userID');
    try {
      final response =
          await http.get(Uri.parse('$getProfile/$userID'), headers: {
        "Authorization": 'Bearer $mytoken',
      });
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = body['data'];
        associationlist = List<Map<String, dynamic>>.from(data['profile']);
        print(associationlist);
        return (associationlist as List<Map<String, dynamic>>).map((e) {
          return ProfileModel(
            associationName: e['associationName'],
            workAddress: e['workAddress'],
            workEmail: e['workEmail'],
            department: e['department'],
          );
        }).toList();
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw Exception('Error while fetching data');
    } on TimeoutException {}
    throw Exception('error while fetching');
  }
}

class DevicesRepository {
  List<Map<String, dynamic>> focusedDevices = [];
  bool isLoading = true;
  Future<List<DeviceModel>> fetchFocusedDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    try {
      if (mytoken != null) {
        final response =
            await http.get(Uri.parse(getDeviceForDoctor), headers: {
          "Authorization": 'Bearer $mytoken',
        });
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var data = jsonResponse['data']['data'];
          print(focusedDevices);
          focusedDevices = List<Map<String, dynamic>>.from(data)
              .where((device) =>
                  device['addTofocus'] == true && device['isAssigned'] == true)
              .toList();

          print('/ next data');
          print(focusedDevices);

          return (focusedDevices as List<dynamic>).map((e) {
            return DeviceModel(
              wardno: e['deviceInfo']?[0]['Ward_No'],
              hospital: e['deviceInfo']?[0]['Hospital_Name'],
              devicetype: e['deviceInfo']?[0]['DeviceType'],
              deviceId: e['deviceInfo']?[0]['DeviceId'],
              message: e['message'],
            );
          }).toList();
        }
      }
    } on SocketException {
      throw Exception('Error while fetching data');
    } on TimeoutException {}
    throw Exception('error while fetching');
  }
}

class AllDevicesRepository {
  List<Map<String, dynamic>> focusedDevices = [];
  bool isLoading = true;
  Future<List<DeviceModel>> fetchFocusedDevices(String hospital) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    try {
      if (mytoken != null) {
        final response =
            await http.get(Uri.parse(getDeviceForDoctor), headers: {
          "Authorization": 'Bearer $mytoken',
        });
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          var data = jsonResponse['data']['data'];
          focusedDevices = List<Map<String, dynamic>>.from(data)
              .where((device) =>
                  device['isAssigned'] == true &&
                  device['deviceInfo'][0]?['Hospital_Name'] == hospital)
              .toList();
          return (focusedDevices as List<dynamic>).map((e) {
            return DeviceModel(
              wardno: e['deviceInfo']?[0]['Ward_No'],
              hospital: e['deviceInfo']?[0]['Hospital_Name'],
              devicetype: e['deviceInfo']?[0]['DeviceType'],
              deviceId: e['deviceInfo']?[0]['DeviceId'],
              message: e['message'],
              addTofocus: e['addTofocus'],
            );
          }).toList();
        }
      }
    } on SocketException {
      throw Exception('Error while fetching data');
    } on TimeoutException {}
    throw Exception('error while fetching');
  }
}
