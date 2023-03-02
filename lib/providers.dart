import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uno/uno.dart';
import 'datasources/cnpj_datasources.dart';
import 'repositories/i_search_cnpj_repository.dart';
import 'stores/cnpj_store.dart';

final List<SingleChildWidget> providers = [
  Provider(create: (context) => Uno()),
  Provider<CnpjDatasource>(create: (context) => CnpjUno(context.read())),
  Provider(create: (context) => CnpjRepository(context.read())),
  ChangeNotifierProvider(create: (context) => CnpjStore(context.read()))
];
