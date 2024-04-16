import 'package:equatable/equatable.dart';

// Event for My Devices
abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

abstract class DevicesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDevices extends DevicesEvent {}

// abstract class DeviceDetailsEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class Fetch extends DeviceDetailsEvent {}

abstract class AllDevicesListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllDevices extends AllDevicesListEvent {
  final String hospital;

  FetchAllDevices(this.hospital);

  @override
  List<Object> get props => [hospital];
}

// Event for Profile
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {

  @override
  List<Object> get props => [];
}

abstract class PatientListEvent extends Equatable {
  const PatientListEvent();
  @override
  List<Object> get props => [];
}

class ChangeTab extends PatientListEvent {
  const ChangeTab();
  @override
  List<Object> get props => [];
}
