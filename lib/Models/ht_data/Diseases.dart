import 'package:flutter/material.dart';

class Dengue {
  int fever;
  int headache;
  int rashes;
  int nausea_vomiting;
  int eyepain;
  int musclepain;
  int jointpain;
  int loss_of_appetite;
  int fatigue;
  int bleeding;
  int days;

  bool is_valid(){
    if (this.fever != null && this.headache != null && this.rashes != null && this.nausea_vomiting != null && this.eyepain != null && this.musclepain != null
        && this.jointpain != null && this.loss_of_appetite != null && this.fatigue != null && this.bleeding != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
}

class Chikungunya{
  int fever;
  int headache;
  int rashes;
  int jointpain;
  int musclepain;
  int fatigue;
  int swelling;
  int chronic;
  int days;

  bool is_valid(){
    if (this.fever != null && this.headache != null && this.rashes != null && this.musclepain != null
        && this.jointpain != null && this.swelling != null && this.fatigue != null && this.chronic != null && this.days != null){
      return true;
    }
    else{
      return false;
    }
  }
}