import 'package:flutter/cupertino.dart';
import 'package:mvvm/respository/branch_repository.dart';
import 'package:mvvm/view/Login_screen/login_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/heirarchy_model.dart';
import '../../respository/heirarchy repository.dart';
import '../model/branch_model.dart';
import '../model/company_execution_model.dart';
import '../model/measures.dart';
import '../model/team_company.dart';
import '../respository/api_services.dart';
import '../respository/company_execution_repository.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
 static final salesRepo = HeirarchyRepository();
  static final companyRepo = company_execution_Repository();
  static final branchesRepo = branch_Repository();
  static final GetApiService apiService = GetApiService();

  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    await initializeDatabase();
    return _database!;
  }

  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_details11_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user_details (
            EmpDesignation TEXT,
            EmpCode TEXT PRIMARY KEY,
            EmpName TEXT,
            ReportTo TEXT,
            is_check INTEGER,
            Depth INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE team_company (
            Product_Company_Name TEXT,
            Product_Company_ID TEXT,
            is_check INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE branch (
            Branch_Branch_Report_Name TEXT,
            Branch_Branch_Code TEXT,
            is_check INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE codes (
            Branch_Branch_Report_Name TEXT,
            Branch_Branch_Code TEXT,
            is_check INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS selected_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item TEXT
          )
        ''');

        return db.execute(
          'CREATE TABLE IF NOT EXISTS measures('
              'id INTEGER PRIMARY KEY, measureName TEXT,'
              ' measureGroupName TEXT, measureDisplayFolder TEXT)',
        );
      },
    );
  }

  /////// heirarchy /////


  static Future<void> getHeirarchy() async {
    try {
      // Fetch user details from remote API or repository
      final List<UserDetails> value = await salesRepo.fetchUserDetails();

      if (value.isNotEmpty) {
        // Save the fetched data into the local SQLite DB
        await save_heirarchy_in_local_db(value);
      }
    } catch (error) {
      print("Error fetching hierarchy data: $error");
      // Optional: Handle error with snackbar, dialog, or log it
    }
  }

  static Future<void> save_heirarchy_in_local_db(List<UserDetails> userDetailsList) async {

    await _database?.delete('user_details');
    await _database?.insert('user_details',
      {
        'EmpCode': empcode.auth,
        'EmpName': empcode.name,
        'Depth': empcode.depth,
        'is_check': 1,
        'ReportTo': empcode.auth,
        'EmpDesignation': empcode.designation
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert new data
    for (var userDetails in userDetailsList) {
      await _database?.insert(
        'user_details',
        userDetails.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    List<Map<String, dynamic>> allUserDetails = await _database!.query(
        'user_details');


    for (var userDetails in allUserDetails) {
      print('EmpCode: ${userDetails['EmpCode']}');
    }

  }

static Future<List<UserDetails>> fetch_heirarchy() async {

    List<UserDetails> userDetailsList = [];
    final List<Map<String, dynamic>> maps = await _database!.query(
      'user_details',
      columns: ['EmpDesignation', 'EmpCode', 'EmpName', 'Depth', 'ReportTo'],
      where: 'Depth > ?',
      whereArgs: [empcode.depth],  // Filtering
      orderBy: 'Depth ASC',
      groupBy: 'EmpDesignation',
    );
    for (var map in maps) {
      userDetailsList.add(
          UserDetails(
            designation: map['EmpDesignation'],
            empCode: map['EmpCode'] ?? '',
            empName: map['EmpName'] ?? '',
            reportingTo: map['ReportTo'] ?? '',
            Depth: map['Depth'] ?? '',
          )
      );}
    userDetailsList.removeWhere((element) =>
    element.designation == "DSF" || element.designation == "SUP");


    return userDetailsList;
  }

static  Future<List<UserDetails>> heirarchy_for_search() async {
    try {
      final List<Map<String, dynamic>> maps = await _database!.query(
        'user_details',
        where: 'EmpDesignation != ? AND EmpName != ?', // Filter condition
        whereArgs: ['DSF', 'Untagged'], // Value to exclude
        orderBy: 'Depth ASC',
      );

      return List.generate(maps.length, (i) {
        return UserDetails(
          designation: maps[i]['EmpDesignation'],
          empCode: maps[i]['EmpCode'],
          empName: maps[i]['EmpName'],
          Depth: maps[i]['Depth'],
          reportingTo: maps[i]['ReportTo'],
          isCheck: maps[i]['is_check'] == 0,
        );
      });
    } catch (e) {
      print("Error: ${e.toString()}");
      return [];
    }
  }


 static Future<List<UserDetails>> select(String empcode, String isfirst) async {
    if (
    empcode == '99938'
    ) {
      if (isfirst == '1')
      {
        final List<Map<String, dynamic>> maps = await _database!.query(
          'user_details',
          columns: [
            'EmpDesignation',
            'EmpCode',
            'EmpName',
            'Depth',
            'ReportTo',
            'is_check'
          ],
          where: 'EmpCode = ? ',
          whereArgs: [ empcode ],
          groupBy: 'EmpName',
        );


        return List.generate(maps.length, (i) {
          return UserDetails(
            designation: maps[i]['EmpDesignation'],
            empCode: maps[i]['EmpCode'],
            empName: maps[i][ 'EmpName' ],
            Depth: maps[i][ 'Depth' ],
            reportingTo: maps[i]['ReportTo'],
            isCheck: maps[i]['is_check'] == 0,
          );
        });
      }
      else
      {

        final List<Map<String, dynamic>> maps = await _database!.query('user_details',
            columns: [
              'EmpDesignation',
              'EmpCode',
              'EmpName',
              'Depth',
              'ReportTo',
              'is_check'
            ],
            where: 'ReportTo = ? AND EmpCode != ReportTo',
            whereArgs: [ empcode ],
            groupBy: 'EmpName'
        );

        return List.generate(maps.length, (i) {
          return UserDetails(
            designation: maps[i]['EmpDesignation'],
            empCode: maps[i]['EmpCode'],
            empName: maps[i]['EmpName'],
            Depth: maps[i]['Depth'],
            reportingTo: maps[i]['ReportTo'],
            isCheck: maps[i]['is_check'] == 0,
          );
        }
        );
      }
    }
    else {
      if (isfirst == '1') {

        final List<Map<String, dynamic>> maps = await _database!.query(
          'user_details',
          columns: [
            'EmpDesignation',
            'EmpCode',
            'EmpName',
            'Depth',
            'ReportTo',
            'is_check'
          ],
          where: 'EmpCode = ? ',
          whereArgs: [empcode],
        );


        return List.generate(maps.length, (i) {
          return
            UserDetails(
              designation: maps[i]['EmpDesignation'],
              empCode: maps[i]['EmpCode'],
              empName: maps[i]['EmpName'],
              Depth: maps[i]['Depth'],
              reportingTo: maps[i]['ReportTo'],
              isCheck: maps[i]['is_check'] == 0,
            );
        }
        );
      }

      else
      {
        final List<Map<String, dynamic>> maps = await _database!.query(
          'user_details',
          columns: [
            'EmpDesignation',
            'EmpCode',
            'EmpName',
            'Depth',
            'ReportTo',
            'is_check'
          ],
          where: 'ReportTo = ? AND EmpCode != ReportTo',
          whereArgs: [empcode],
        );


        return List.generate(maps.length, (i) {
          return UserDetails(
              designation: maps[i]['EmpDesignation'],
              empCode: maps[i]['EmpCode'],
              empName: maps[i]['EmpName'],
              Depth: maps[i]['Depth'],
              reportingTo: maps[i]['ReportTo'],
              isCheck: maps[i]['is_check'] == 0);});
      }
    }
  }


  static Future<bool> isheirarchyEmpty() async {
    final List<Map<String, dynamic>> result = await _database!.rawQuery('SELECT COUNT(*) as count FROM user_details');
    final int? count = Sqflite.firstIntValue(result);
    return count == 0;
  }

 static Future<List<UserDetails>> select_through_depth(String depth) async {
    print("object");
    int depthInt = int.parse(depth);
    int nextDepth = depthInt;


    final List<Map<String, dynamic>> maps = await _database!.query(
        'user_details',
        columns: ['EmpDesignation', 'EmpCode', 'EmpName', 'Depth', 'ReportTo'],
        where: 'Depth = ?',
        orderBy: 'Depth ASC',
        whereArgs: [nextDepth.toString()] );

    List<UserDetails> userDetailsList = [];


    for ( var map in maps ) {
      userDetailsList.add(
          UserDetails(
            designation: map['EmpDesignation'],
            empCode: map['EmpCode'] ?? '',
            empName: map['EmpName'] ?? '',
            reportingTo: map['ReportTo'] ?? '',
            Depth: map['Depth'] ?? '',
          ));
    }
    for (int i=0; i<userDetailsList.length; i++) {
      print(userDetailsList.length);
    }
    return userDetailsList;
  }


  //// companies ////


 static Future<void> get_companies() async {
    //teamcomapnyList(ApiResponse.loading());

    try {
      final List<company_execution_model> value = await companyRepo.fetchData();

      if (value.isNotEmpty) {

        await save_companies_in_local_db(value);
        print('Fetched Team Company Data: $value');

        //teamcomapnyList(ApiResponse.completed(value));
      }
    } catch (error) {
     // teamcomapnyList(ApiResponse.error(error.toString()));
    }
  }

  static  Future<void> save_companies_in_local_db(List<company_execution_model> teamcompanyList) async {

    await _database!.delete('team_company');


    for (var team in teamcompanyList) {
      await _database!.insert(
        'team_company',
        {
          'Product_Company_ID': team.Compnay_ID,
          'Product_Company_Name': team.Company,
          'is_check': team.is_check
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  //  _dataFetched = true;
  }

  static Future<List<Team_compnay>> fetch_companies() async {
    final List<Map<String, dynamic>> maps = await _database!.query(
      'team_company',
      columns: [
        'Product_Company_Name',
        'Product_Company_ID',
        'is_check'
      ],
    );
    return List.generate(maps.length, (i) {
      return Team_compnay(
          companyID: maps[i]['Product_Company_Name'],
          companyName: maps[i]['Product_Company_ID'],
          ischecked: maps[i]['is_check'] == 1

      );
    });
  }

  static Future<List<Map<String, dynamic>>> searchItems(TextEditingController searchTexts) async
  {
    //final Database db = await _database;
    final String searchText = searchTexts.text;
    try {
      List<Map<String, dynamic>> result = await _database!.rawQuery('SELECT * FROM team_company WHERE Product_Company_Name LIKE ?', ['%$searchText%']);
      print(result);
      return result;
    } catch (e) {
      print('Error searching items: $e');
      return [];
    }
  }


 static void updateIsCheckValue(String id, bool newValue)
  async {
    await _database!.rawUpdate('UPDATE team_company SET is_check = ? WHERE Product_Company_ID = ?', [newValue ? 1 : 0, id],);
  }

  static Future<List<String>> name() async
  {

    List<Map<String, dynamic>> result = await _database!.rawQuery('SELECT Product_Company_Name FROM team_company WHERE is_check = 1',);
    List<String> companyNames = result.map((e) => e['Product_Company_Name'] as String).toList();
    return companyNames;
  }

  static  void updateCheck(bool newValue) async
  {

    await _database!.rawUpdate('UPDATE team_company SET is_check = ?', [newValue ? 1 : 0],);
  }
  ////// branches //////////


  static Future<void> get_branches() async {
    //branchList(ApiResponse.loading());

    try {
      final List<Branch_compnay> value = await branchesRepo.team_company_fetchData();

      if (value.isNotEmpty) {

        await save_branches_in_local_db(value);
        print('Fetched Branch Company Data: $value');

       // branchList(ApiResponse.completed(value));
      } else {

        //branchList(ApiResponse.error("Branchdetails are empty"));
      }
    } catch (error) {
      //teamcomapnyList(ApiResponse.error(error.toString()));
    }
  }

  static Future<void> save_branches_in_local_db(List<Branch_compnay> teamcompanyList) async {

    await _database!.delete('branch');


    for (var team in teamcompanyList) {
      await _database!.insert(
        'branch',
        team.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //_dataFetched = true;
    }
  }

  static Future<List<Branch_compnay>> fetch_branch() async {
    final List<Map<String, dynamic>> maps = await _database!.query(
      'branch',
      columns: [
        'Branch_Branch_Report_Name',
        'Branch_Branch_Code',
        'is_check'
      ],
    );


    return List.generate(maps.length, (i) {
      return Branch_compnay(
          BranchName: maps[i]['Branch_Branch_Report_Name'],
          BranchID: int.parse(maps[i]['Branch_Branch_Code']),
          ischecked: maps[i]['is_check'] == 1

      );
    });
  }

  static   Future<List<Map<String, dynamic>>> searchbranch(TextEditingController searchTexts) async {
    //final Database db = await _database;
    final String searchText = searchTexts.text;

    try {
      List<Map<String, dynamic>> result = await _database!.rawQuery('SELECT * FROM branch WHERE Branch_Branch_Report_Name LIKE ?', ['%$searchText%']);
      print(result);
      return result;
    } catch (e)

    {
      print('Error searching items: $e');
      return [];
    }
  }


  static   void updateIsCheckValuebranch(String id, bool newValue) async
  {

    await _database!.rawUpdate('UPDATE branch SET is_check = ? WHERE Branch_Branch_Code = ?', [newValue ? 1 : 0, id],);
  }

  ////// Measures ///////


 static Future<List<Measure>> get_measures() async {
    final url = 'https://api.psplbi.com/api/measurenames';
    print(url);
    final requestData = [];

    final List<Measure> measures = await apiService.getData(url, requestData, (data) =>
    List<Measure>.from(data.map((json) => Measure.fromJson(json)))
    );
    print("measure: ${measures}");
    await saveMeasures(measures);

    return measures;
  }

  static Future<void> saveMeasures(List<Measure> measures) async {
    // final Database db = await database();

    // Insert the measures into the database.
    await _database!.transaction((txn) async {
      for (final measure in measures) {
        await txn.insert(
          'measures',
          measure.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  static  Future<List<Measure>> getAllMeasures() async {

    final List<Map<String, dynamic>> maps = await _database!.query('measures');

    print("Maps : ${maps}");
    return List.generate(maps.length, (i) {
      return Measure(

        measureName: maps[i]['measureName'],
        measureGroupName: maps[i]['measureGroupName'],
        measureDisplayFolder: maps[i]['measureDisplayFolder'],
      );
    });
  }

  static Future<void> printAllMeasures() async {
    final List<Measure> measures = await getAllMeasures();
    measures.forEach((measure) {
      print('Measure Name: ${measure.measureName}');
      print('Measure Group Name: ${measure.measureGroupName}');
      print('Measure Display Folder: ${measure.measureDisplayFolder}');
      print('-------------------------');
    });


  }

  static  Future<List<Measure>> getAllMeasuresGroupByGroupName() async {

    final List<Map<String, dynamic>> maps = await _database!.query(
      'measures',
      groupBy: 'measureGroupName',
    );

    // Convert the List<Map<String, dynamic>> into a List<Measure>.
    return List.generate(maps.length, (i) {
      return Measure(
        measureName: maps[i]['measureName'],
        measureGroupName: maps[i]['measureGroupName'],
        measureDisplayFolder: maps[i]['measureDisplayFolder'],
      );
    });
  }

  static Future<List<String>> getDisplayFoldersByGroupName(String groupName) async {

    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      'SELECT DISTINCT measureDisplayFolder FROM measures WHERE measureGroupName = ?',
      [groupName],
    );
    print("data1: $maps");


    return List.generate(maps.length, (i) {
      return maps[i]['measureDisplayFolder'];
    });
  }

  static Future<List<String>> getDisplayFoldersByName(String groupName, String foldername) async {

    final List<Map<String, dynamic>> maps = await _database!.rawQuery(
      'SELECT DISTINCT measureName FROM measures WHERE measureDisplayFolder = ? AND measureGroupName = ?',
      [groupName,foldername], // Pass foldername first, then groupName
    );
    print("groupname: $groupName");
    print("foldername: $foldername");

    print("data2: $maps");


    // Extract the measureDisplayFolder values from the result.
    return List.generate(maps.length, (i) {
      return maps[i]['measureName'];
    });
  }





 static Future<void> deletetable() async
  {
    await _database!.delete('user_details');
    await _database!.delete('team_company');
    await _database!.delete('branch');
    await _database!.delete('codes');
    await _database!.delete('measures');
  }


}
