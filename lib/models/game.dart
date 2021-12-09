class Game{
  int? id;
  String gametitle;
  String? description;
  String? image_source;
  Game({required this.gametitle, this.description, this.image_source});
  Game.withId({required this.gametitle, this.description, this.image_source,this.id});
  factory Game.fromJson(Map<String, dynamic> json)
  {
    return Game(
        gametitle:json['gametitle'],
        description:json['description'],
    );
  }
}