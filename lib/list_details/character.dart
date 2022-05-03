class Character {
  final String? avatar;
  final String? title;
  final String? description;
  final int? color;
  final String? vois;

  Character({this.avatar, this.title, this.description, this.color, this.vois});
}

//source: https://www.giantbomb.com/dragon-ball-z/3025-159/characters/
final characters = <Character>[
  Character(
      title: "GAWASA",
      description: "Me is GAWASA",
      avatar: "images/characters/gawasa.png",
      color: 0xFFE83835,
      vois: "assets/audio/me-is-gawasa.mp3"),
  Character(
      title: "osiruko",
      description: "やめてお兄ちゃん！！",
      avatar: "images/characters/osiruko.png",
      color: 0xFF238BD0,
      vois: "assets/audio/osiruko-brother.mp3"),
  Character(
      title: "kamila",
      description: "男が変態でなければ子供は生めれない",
      avatar: "images/characters/kamila.png",
      color: 0xFF354C6C,
      vois: "assets/audio/kamila-hentai.mp3"),
  Character(
      title: "pekonrua",
      description: "やめてお兄ちゃん",
      avatar: "images/characters/pekonrua.png",
      color: 0xFF6F2B62,
      vois: "assets/audio/pekonrua-brother.mp3"),
  Character(
      title: "宅汁",
      description: "がわさやりますね〜",
      avatar: "images/characters/takuziru.png",
      color: 0xFF447C12,
      vois: "assets/audio/takuziru-urusaine.mp3"),
];
