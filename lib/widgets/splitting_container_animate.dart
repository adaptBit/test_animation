import 'package:flutter/material.dart';
import 'package:test_animation/model/score.dart';
import 'package:test_animation/widgets/circle_line.dart';
import 'package:test_animation/widgets/detail_score_bar.dart';
import 'package:test_animation/widgets/header_score.dart';

const durationSticky = Duration(milliseconds: 2200);
const durationHide = Duration(milliseconds: 550);
const double outRight = -5;


class SplittingContainerAnimate extends StatefulWidget {
  final double width;
  final List<Score> scoreList;
  final Color parentBackgroundColor;
  const SplittingContainerAnimate({
    super.key, 
    this.width = 260, 
    required this.scoreList, 
    this.parentBackgroundColor = Colors.white
  });

  @override
  State<SplittingContainerAnimate> createState() => _SplittingContainerAnimateState();
}

class _SplittingContainerAnimateState extends State<SplittingContainerAnimate> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final Duration duration = const Duration(milliseconds: 700);
  Color backgroundColor = const Color.fromRGBO(56, 118, 253, 1);
  bool isClick = false;
  bool isLeft = true;
  bool _isButtonShow = true;
  final double _defaultWidth = 2;
  final double _defaultHeight = 2;
  final double _defaultBorderRadius = 16;
  final double _maxHeight = 36;
  final double _maxWidth = 48;
  double _width = 2;
  double _height = 2;
  double _borderRadius = 40;
  Cubic animationCurve = Curves.slowMiddle;

  @override
  void initState() {
   super.initState();
   _animationController = AnimationController(
     vsync: this, 
     duration: duration
   );

   _animation =
    CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInCirc);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void showButton(){
    final visible = !_isButtonShow;
    setState(() {
      _isButtonShow = visible;
    });
  }

  void runAnimation() async {
    final clickState = !isClick;
    setState(() {
      isClick = clickState;
      _width = clickState ? 8 : 36;
      if (clickState) {
        _animationController.forward(from: _animationController.value);
      } else {
        _animationController.reverse(from: _animationController.value);
      }
    });
    if(clickState) {
      await Future.delayed(Duration(milliseconds: (durationHide.inMilliseconds * 1.12).toInt() ), () {
      setState(() {
        _height = _maxHeight;
      });
      
    });

    await Future.delayed(durationHide, () {
        setState(() {
          _width = _maxWidth - _maxHeight * 0.1;
        });
        
      });
    await Future.delayed(durationHide * 0.2, () {
          setState(() {
            _width = _maxWidth;
            _borderRadius = 0 ;
          });
        });
    } else {
      setState(() {
        _height = _defaultHeight;
        _width = _defaultWidth;
        _borderRadius = _defaultBorderRadius;
      });
    }
    
    
  }
  
  

  @override
  Widget build(BuildContext context) {
    int maxScore = widget.scoreList.map((score) => score.score).toList().sublist(0, 3).fold(0, (accumulate, value) => accumulate + value);;
    int headerScore = ((maxScore / 300) * 100).toInt();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [

          //hidden middle container
          isClick ?
          Positioned(
            top: 190,
            child: SizedBox(
              width: widget.width - 60,
              child: Stack(
                children: [
                  Container(
                    height: 35,
                    color: backgroundColor,
                  ),
                ],
              ),
            ),
          )
          : const SizedBox(width: 600,),

          // container that make it look like animation
          Positioned(
            top: 190,
            // bottom: 160,
            child: SizedBox(
              width: widget.width - 60,
              height: 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ...[0, 40, 100, 140, 999].map((left) {
                  ...[16, 54, 90, 135].map((left) {
                    return Positioned(
                        left: left.toDouble(),
                        child: SizedBox(
                          width: 50,
                          child: Center(
                            child: AnimatedContainer(
                              duration: left == 16 ? durationHide * 0.95 : durationHide,
                              curve: animationCurve,
                              width: left.toDouble() == 90 || left.toDouble() == 135 ? _width * 1.3 : _width,
                              height: _height,
                              decoration: BoxDecoration(
                                  color: widget.parentBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(_borderRadius)),
                            ),
                          ),
                        ));
                  }),

                  

                  ...[true, false].map((left) {
                    return Positioned(
                        left: left == isLeft ? -4 : null,
                        right: left == isLeft ? null : -4,
                        child: AnimatedContainer(
                          duration: durationHide ,
                          curve: Curves.easeOut,
                          width: isClick ? _width : _defaultWidth ,
                          height: 36,
                          decoration: BoxDecoration(
                              color: widget.parentBackgroundColor,
                              // color: Colors.red,
                              borderRadius:
                                  BorderRadius.only(
                                    topRight: Radius.circular(left == isLeft ? _borderRadius : 0),
                                    bottomRight: Radius.circular(left == isLeft ? _borderRadius : 0),
                                    topLeft: Radius.circular(left == isLeft ? 0 : _borderRadius),
                                    bottomLeft: Radius.circular(left == isLeft ? 0 : _borderRadius),
                                    )),
                        ));
                  }),

                  Positioned(
                        left: -4,
                        right: null,
                        child: AnimatedContainer(
                          duration: durationHide,
                          curve: animationCurve,
                          width:  _defaultWidth * 4  ,
                          height: 36,
                          decoration: BoxDecoration(
                              color: widget.parentBackgroundColor,
                              borderRadius:
                                  BorderRadius.only(
                                    topRight: Radius.circular( _borderRadius),
                                    bottomRight: Radius.circular( _borderRadius),
                                    )),
                        )),
                  Positioned(
                        right: -4,
                        child: AnimatedContainer(
                          duration: durationHide,
                          curve: animationCurve,
                          width:  _defaultWidth * 4  ,
                          height: 36,
                          decoration: BoxDecoration(
                              color: widget.parentBackgroundColor,
                              borderRadius:
                                  BorderRadius.only(
                                    topLeft: Radius.circular( _borderRadius),
                                    bottomLeft: Radius.circular( _borderRadius)
                                    )),
                        )),
                ],
              ),
            ),
          ),

          //bottom container
          AnimatedPositioned(
            top: isClick ? 225 : 150,
            duration: duration,
            child: AnimatedContainer(
              duration: duration,
              width: widget.width,
              height: isClick? 232 : 220,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Padding(
                  padding: const  EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: FadeTransition(
                    opacity: _animation,
                    child:  SingleChildScrollView(
                      child: Column(
                        children: [
                          ...widget.scoreList.map((data) {
                            return DetailScoreBar(
                              title: data.title, 
                              score: data.score , 
                              width: widget.width - 32,
                              maxScore: data.title == "Total" ? 300 : 100,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          //top container
          AnimatedPositioned(
            top: isClick ? 90 : 150,
            duration: duration,
            child: AnimatedContainer(
                duration: duration,
                width: widget.width,
                height: isClick? 100 : 180,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: HeaderScore( score: headerScore,),
              ),
          ),

          
          // button arrow
          _isButtonShow ?
          AnimatedPositioned(
            top: isClick ? 170 : 500,
            duration: duration,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(_animationController),
              child: ElevatedButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  maximumSize: MaterialStatePropertyAll(Size(50, 50)),
                  minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                  alignment: Alignment.center,
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))),
                  elevation: MaterialStatePropertyAll(8),
                ),
                onPressed: runAnimation,
                child: const Center(
                  child: Icon(
                    Icons.expand_more_rounded,
                    color: Colors.black,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          )
          : SizedBox(width: widget.width,),

          Positioned(
            top: 170,
            child: FadeTransition(
              opacity: ReverseAnimation(
                  CurvedAnimation(
                    parent: _animationController, 
                    curve: Curves.easeOutExpo)
                  ),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  CircleLine(
                    width: 150,
                    height: 150,
                    startAngle: 60,
                  ),
                  CircleLine(
                    width: 100,
                    height: 100,
                    startAngle: 305,
                  ),
                ],
              ),
            ),
          ),
      
          Positioned(
            top: 600,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    maximumSize: MaterialStatePropertyAll(Size(50, 50)),
                    minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                    alignment: Alignment.center,
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))
                  ),
                  onPressed: runAnimation,
                  child: Center(
                    child: Text(
                      isClick ? 'Return': 'Play'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      maximumSize: MaterialStatePropertyAll(Size(50, 50)),
                      minimumSize: MaterialStatePropertyAll(Size(50, 50)),
                      alignment: Alignment.center,
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))))
                    ),
                    onPressed: showButton,
                    child: Center(
                      child: Text(
                        _isButtonShow ? 'Hide': 'Show'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}


