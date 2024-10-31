class Todo {
   final int? id;
   String task ;
   String description ;
   bool isComplated;
   Todo({
     this.id,
required this.task,
required this.description,
  required this.isComplated,
  });

  //convert a Todo object into a Map(for SQLite storge)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'description': description,
      'isComplated': isComplated ? 1 : 0,
    };
  }

  //convert a map into todo object
  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      task: map['task'],
      description: map['description'],
      isComplated: map['isComplated'] == 1 ,
    );
  }
}
