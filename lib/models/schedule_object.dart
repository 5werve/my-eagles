// Model for a schedule object to list on the schedule page
class ScheduleObject {
  late String className;
  late String classTeacher;
  late String classRoom;
  late String classPeriod;

  ScheduleObject(
      {required this.className,
      required this.classTeacher,
      required this.classRoom,
      required this.classPeriod});
}
