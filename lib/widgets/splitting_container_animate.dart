import 'package:flutter/material.dart';
import 'package:test_animation/model/score.dart';
import 'package:test_animation/widgets/arrow_button.dart';
import 'package:test_animation/widgets/circle_line.dart';
import 'package:test_animation/widgets/control_widget.dart';
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
  final double _defaultBorderRadius = 10;
  final double _maxHeight = 36;
  final double _maxWidth = 48;
  double _width = 2;
  double _outboundWidth = 2;
  double _height = 2;
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
      Future.delayed(Duration(milliseconds: (durationHide.inMilliseconds * 1.2 ).toInt() ), () {
      setState(() {
        _outboundWidth = _maxWidth * 0.8 ;
      });
      });
      await Future.delayed(Duration(milliseconds: (durationHide.inMilliseconds * 1.12).toInt() ), () {
      setState(() {
        _height = _maxHeight;
      });
      
    });

    await Future.delayed(durationHide, () {
        setState(() {
          _width = _maxWidth - _maxWidth * 0.1;
        });
        
      });
    await Future.delayed(durationHide * 0.4, () {
          setState(() {
            _width = _maxWidth;
          });
        });
    await Future.delayed(durationHide * 0.3, () {
          setState(() {
            _width = _maxWidth * 1.6;
          });
        });
    } else {
      setState(() {
        _outboundWidth = _defaultWidth;
        _height = _defaultHeight;
        _width = _defaultWidth;
      });
    }
    
    
  }
  
  

  @override
  Widget build(BuildContext context) {
    int maxScore = widget.scoreList.map((score) => score.score).toList().sublist(0, 3).fold(0, (accumulate, value) => accumulate + value);;
    int headerScore = ((maxScore / 300) * 100).toInt();
    double hiddenContainerWidth = widget.width - 36;
    
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
              width: hiddenContainerWidth,
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
              width: hiddenContainerWidth,
              height: 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...[16, 54].map((left) {
                    return Positioned(
                        left: left.toDouble(),
                        child: SizedBox(
                          width: 70,
                          child: Center(
                            child: AnimatedContainer(
                              duration: durationHide,
                              curve: animationCurve,
                              width: left == 16 ? _width + 2 : _width,
                              height: _height,
                              decoration: BoxDecoration(
                                  color: widget.parentBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(_defaultBorderRadius)),
                            ),
                          ),
                        ));
                  }),

                  ...[80, 115].map((left) {
                    return Positioned(
                        left: left.toDouble(),
                        child: SizedBox(
                          width: 70,
                          child: Center(
                            child: AnimatedContainer(
                              duration: durationHide,
                              curve: animationCurve,
                              width: _width * 1.1,
                              height: _height,
                              decoration: BoxDecoration(
                                  color: widget.parentBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(_defaultBorderRadius)),
                            ),
                          ),
                        ));
                  }),

                  ...[true, false].map((left) {
                    return Positioned(
                        left: left == isLeft ? -4 : null,
                        right: left == isLeft ? null : -4,
                        child: AnimatedContainer(
                          duration: durationHide * 3.5 ,
                          curve: Curves.slowMiddle,
                          width: isClick ? _outboundWidth + 24  : _defaultWidth ,
                          height: 36,
                          decoration: BoxDecoration(
                              color: widget.parentBackgroundColor,
                              // color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(_defaultBorderRadius),)
                              ),
                        ));
                  }),

                  Positioned(
                        left: -4,
                        child: AnimatedContainer(
                          duration: durationHide,
                          curve: animationCurve,
                          width:  _defaultWidth * 4  ,
                          height: 36,
                          decoration: BoxDecoration(
                              color: widget.parentBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(_defaultBorderRadius),)),
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
                              borderRadius: BorderRadius.all(Radius.circular(_defaultBorderRadius),)),
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
            top: 560,
            child: ControlWidget(
              isClick: isClick, 
              isButtonShow: _isButtonShow,
              runAnimation: runAnimation,
              showButton: showButton,
            ),
          ),

          // button arrow
          _isButtonShow ?
          AnimatedPositioned(
            top: isClick ? 170 : 346,
            duration: duration,
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(_animationController),
              child: ArrowButton(
                onPressed: runAnimation,
              ),
            ),
          )
          : SizedBox(width: widget.width,),
          
        ],
      ),
    );
  }
}


