// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.repeat,
      this.remind});
  // this function is used in the insert function in the database in the form of values
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'note': this.note,
      'isCompleted': this.isCompleted,
      'date': this.date,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'color': this.color,
      'repeat': this.repeat,
      'remind': this.remind,
    };
  }

// it is a named constructor because I'm sending data to the class so it must be a constructor

  Task.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.note = json['note'];
    this.date = json['date'];
    this.startTime = json['startTime'];
    this.endTime = json['endTime'];
    this.isCompleted = json['isCompleted'];
    this.color = json['color'];
    this.repeat = json['repeat'];
    this.remind = json['remind'];
  }

  @override
  String toString() {
    return 'fucken';
  }
}
