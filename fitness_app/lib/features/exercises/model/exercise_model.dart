class ExerciseModel {
  int? _time;
  String? _id;
  String? _img;
  String? _title;
  String? _desc;
  bool? _isDone;

  ExerciseModel({int? time,bool? isDone, String? id,String? img, String? title, String? desc}) {
    if (time != null) {
      _time = time;
    }
    if (img != null) {
      _img = img;
    }
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (desc != null) {
      _desc = desc;
    }
 if (isDone != null) {
   _isDone = isDone;
    }
  }

  bool? get isDone => _isDone;

  set isDone(bool? isDone) => _isDone = isDone;

  int? get time => _time;

  set time(int? time) => _time = time;

  String? get id => _id;

  set id(String? id) => _id = id;

  String? get img => _img;

  set img(String? img) => _img = img;

  String? get title => _title;

  set title(String? author) => _title = title;

  String? get desc => _desc;

  set desc(String? desc) => _desc = desc;
}
