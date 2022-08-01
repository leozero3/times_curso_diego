import 'package:times_curso_diego/models/time.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';
class HomeController {

  TimesRepository? timesRepository;

  List<Time> get tabela => timesRepository!.times;


  HomeController(){
    timesRepository = TimesRepository();
  }
}
