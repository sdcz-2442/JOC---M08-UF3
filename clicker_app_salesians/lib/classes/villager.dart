class Villager {
  int id;
  String num;
  String name;
  String personality;
  String birthdayString;
  String birthday;
  String species;
  String gender;
  String subtype;
  String hobby;
  String catchPhrase;
  String iconUri;
  String imageUri;
  String bubbleColor;
  String textColor;
  String saying;

  Villager(
      {this.id,
        this.num,
        this.name,
        this.personality,
        this.birthdayString,
        this.birthday,
        this.species,
        this.gender,
        this.subtype,
        this.hobby,
        this.catchPhrase,
        this.iconUri,
        this.imageUri,
        this.bubbleColor,
        this.textColor,
        this.saying});

  Villager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    num = json['num'];
    name = json['name'];
    personality = json['personality'];
    birthdayString = json['birthday-string'];
    birthday = json['birthday'];
    species = json['species'];
    gender = json['gender'];
    subtype = json['subtype'];
    hobby = json['hobby'];
    catchPhrase = json['catch-phrase'];
    iconUri = json['icon_uri'];
    imageUri = json['image_uri'];
    bubbleColor = json['bubble-color'];
    textColor = json['text-color'];
    saying = json['saying'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num'] = this.num;
    data['name'] = this.name;
    data['personality'] = this.personality;
    data['birthday-string'] = this.birthdayString;
    data['birthday'] = this.birthday;
    data['species'] = this.species;
    data['gender'] = this.gender;
    data['subtype'] = this.subtype;
    data['hobby'] = this.hobby;
    data['catch-phrase'] = this.catchPhrase;
    data['icon_uri'] = this.iconUri;
    data['imageUri'] = this.imageUri;
    data['bubble-color'] = this.bubbleColor;
    data['text-color'] = this.textColor;
    data['saying'] = this.saying;
    return data;
  }
}
