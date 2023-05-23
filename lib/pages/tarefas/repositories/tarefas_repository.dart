import 'package:projeto_base_bloc/pages/tarefas/models/tarefas_model.dart';

class TarefasRepository {
  final List<TarefaModel> _listTarefas = [];

  Future<List<TarefaModel>> getListTarefas() async {
    _listTarefas.addAll([
      TarefaModel(nome: 'Lavar carro'),
      TarefaModel(nome: 'Fazer compras'),
      TarefaModel(nome: 'Buscar filho na escola'),
      TarefaModel(nome: 'Ir a academia'),
    ]);
    return Future.delayed(
        const Duration(milliseconds: 100), () => _listTarefas);
  }

  Future<List<TarefaModel>> postTarefa({required TarefaModel tarefa}) {
    _listTarefas.add(tarefa);

    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _listTarefas,
    );
  }

  Future<List<TarefaModel>> deleteTarefa({required TarefaModel tarefa}) {
    _listTarefas.remove(tarefa);

    return Future.delayed(
        const Duration(milliseconds: 100), () => _listTarefas);
  }
}
