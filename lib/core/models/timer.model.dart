class TimerModel {
  int focus, rest;

  TimerModel({
    this.focus,
    this.rest
  });

  Map toJson() => {
    'focus': this.focus,
    'rest': this.rest
  };

  factory TimerModel.fromJson(dynamic json) {
    return TimerModel(focus: json['focus'] as int, rest: json['rest'] as int);
  }

  String toString() {
    return '{ focus: ${this.focus}, rest: ${this.rest} }';
  }
}
