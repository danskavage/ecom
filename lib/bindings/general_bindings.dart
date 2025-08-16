

import 'package:flutter_application_2/features/authentication/models/network_manager.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class GeneralBindings extends Bindings{
  get get => null;

  @override
  void dependencies(){
    get.put(NetworkManager());
  }
}