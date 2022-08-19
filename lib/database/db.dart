import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:times_curso_diego/models/time.dart';
import 'package:times_curso_diego/repositories/times_repositoty.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await initDataBase();
  }

  //INSTANCIA PARA PODER FAZER ALTERAÇOES NO BANCO
  static get() async {
    return await DB.instance.database;
  }

  //INICIALIZA E ABRE O BANCO
  initDataBase() async {
    return await openDatabase(join(await getDatabasesPath(), 'dados.db'),
        version: 1, onCreate: (db, versao) async {
      await db.execute(times);
      await db.execute(titulos);
      await setupTimes(db);
    });
  }

  //SETUP INICIAL QUE SERÁ EXECUTADO UMA UNICA VEZ(usando dentro do onCreate)
  setupTimes(db) {
    for (Time time in TimesRepository.setupTimes()) {
      db.insert('times', {
        'nome': time.nome.toString(),
        'brasao': time.brasao.toString(),
        'pontos': time.pontos!.toInt(),
        'cor': time.cor.toString().replaceAll('Color(', '').replaceAll(')', ''),
      });
    }
  }

  String get times => '''
    CREATE TABLE times(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      pontos INTEGER,
      brasao TEXT,
      cor TEXT
    );
  ''';

  String get titulos => '''
    CREATE TABLE titulos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      campeonato TEXT,
      ano TEXT,
      time_id INTEGER,
      FOREIGN KEY (time_id) REFERENCES times(id) ON DELETE CASCADE
    );
  ''';
}


