
class Character {
 late int charId;
 late String name;
 late String birthday;
 late List<String> occupation;
 late String img;
 late String status;
 late String nickname;
 late List<int> appearance;
 late String portrayed;
 late String category;
 late List<dynamic>betterCallSaulAppearance;



  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'].cast<String>();
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'].cast<int>();
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance=json["better_call_saul_appearance"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['char_id'] = charId;
    data['name'] = name;
    data['birthday'] = birthday;
    data['occupation'] = occupation;
    data['img'] = img;
    data['status'] = status;
    data['nickname'] = nickname;
    data['appearance'] = appearance;
    data['portrayed'] = portrayed;
    data['category'] = category;
    data["better_call_saul_appearance"]=betterCallSaulAppearance;
    return data;
  }
}