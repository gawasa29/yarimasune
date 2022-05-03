import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'character.dart';
import 'detail_page.dart';

late AudioPlayer player;

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  PageController? _controller;

  _goToDetail(Character character) async {
    //ここがボイスなる仕組み
    await player.setAsset(character.vois!);
    player.play();
    final page = DetailPage(character: character);
    Navigator.of(context).push(
      PageRouteBuilder<void>(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: page,
                  );
                });
          },
          transitionDuration: const Duration(milliseconds: 400)),
    );
  }

  _pageListener() {
    setState(() {});
  }

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.6);
    _controller!.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(_pageListener);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BECOME"),
        backgroundColor: Colors.black54,
      ),
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _controller,
          itemCount: characters.length,
          itemBuilder: (context, index) {
            double? currentPage = 0;
            try {
              currentPage = _controller!.page;
            } catch (_) {}

            final num resizeFactor =
                (1 - (((currentPage! - index).abs() * 0.3).clamp(0.0, 1.0)));
            final currentCharacter = characters[index];
            return ListItem(
              character: currentCharacter,
              resizeFactor: resizeFactor as double,
              onTap: () => _goToDetail(currentCharacter),
            );
          }),
    );
  }
}

class ListItem extends StatefulWidget {
  final Character character;
  final double resizeFactor;
  final VoidCallback onTap;

  const ListItem({
    Key? key,
    required this.character,
    required this.resizeFactor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width * 0.85;
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
                width: width * widget.resizeFactor,
                height: height * widget.resizeFactor,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: height / 4,
                      bottom: 0,
                      child: Hero(
                        tag: "background_${widget.character.title}",
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Color(widget.character.color!),
                                  Colors.white,
                                ],
                                    stops: const [
                                  0.4,
                                  1.0,
                                ])),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              margin: const EdgeInsets.only(
                                left: 20,
                                bottom: 10,
                              ),
                              child: Text(
                                widget.character.title!,
                                style: TextStyle(
                                  fontSize: 24 * widget.resizeFactor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Hero(
                        tag: "image_${widget.character.title}",
                        child: Image.asset(
                          widget.character.avatar!,
                          width: width / 2,
                          height: height,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
