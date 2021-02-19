import 'package:health_guard/Models/ht_data/Diseases.dart';
import 'package:health_guard/health_test_design/ds_screens/Covid_screen.dart';
import 'package:health_guard/health_test_design/ds_screens/Dengue_screen.dart';
import 'package:health_guard/health_test_design/ds_screens/Chikungunya_screen.dart';
import 'package:health_guard/health_test_design/ds_screens/General_screen.dart';
import 'package:health_guard/health_test_design/ds_screens/Malaria_screen.dart';

var Diseases = {
  'General': General_screen(),
  'Dengue': Dengue_screen(),
  'Chikungunya': Chikungunya_screen(),
  'Malaria': Malaria_screen(),
  'Covid': Covid_screen(),
};
