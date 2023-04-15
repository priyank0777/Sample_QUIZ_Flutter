class Question{
  //define how a question will look like.
  //each question will have an id.
  final String id;
  // every question will have a title, it's the question itself
  final String title;
  //each questions will have options
  final Map<String,bool> options;
  //options will be like {'1':true} = something like these
  //create a constructor
  Question({
    required this.id,
    required this.title,
    required this.options,
});
  @override
  String toString() {
    return 'Question(id:$id,title: $title, options: $options)';
  }
}