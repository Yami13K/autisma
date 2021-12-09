import 'dart:math';

class Quizbrain{
  var _quizAnswer='';
  var _quiz='';
  void makeQuiz(){
    List<String> _signs=['+','-','×','÷'];
    Random _random=Random();
    var selectedsign=_signs[_random.nextInt(_signs.length)];
    var first=_random.nextInt(10)+10;
    var second=_random.nextInt(9)+1;
    var result;

    switch(selectedsign){
      case '+':
        result=first+second;
        break;
      case '-':
        result=first-second;
        break;
      case '×':
        result=first*second;
        break;
      case '÷':
        // if(first % second !=0)
        //   {
        //      if(first%2!=0)
        //        first++;
        //      for(int i=second; i>0;i--)
        //        {
        //          if(first%i==0)
        //            {
        //              second =i;
        //              break;
        //            }
        //        }
        //   }
        result= double.parse((first/second).toStringAsFixed(2));
    }
    var falseNumber=[-3,-2,-1,1,2,3];
    var choose=falseNumber[_random.nextInt(falseNumber.length)];
    var trueorfalse=_random.nextInt(2);
    _quizAnswer='true';
    if(trueorfalse==0){
      _quizAnswer='false';
      result=result+choose;

      if(result<0){
        result = result+_random.nextInt(2)+4;

      }
    }
    _quiz='$first $selectedsign $second = $result';
  }
  String get answer{
    return _quizAnswer;
  }
  String get operation{
    return _quiz;
  }
}