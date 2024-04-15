import 'package:equatable/equatable.dart';

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
