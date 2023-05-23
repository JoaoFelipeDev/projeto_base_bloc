import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:projeto_base_bloc/pages/tarefas/blocs/tarefa_event.dart';
import 'package:projeto_base_bloc/pages/tarefas/blocs/tarefa_state.dart';
import 'package:projeto_base_bloc/pages/tarefas/models/tarefas_model.dart';
import 'package:projeto_base_bloc/pages/tarefas/repositories/tarefas_repository.dart';

class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
  final _repository = TarefasRepository();

  // final StreamController<TarefaEvent> _inputTarefaController =
  //     StreamController<TarefaEvent>();

  // final StreamController<TarefaState> _outputTarefaController =
  //     StreamController<TarefaState>();

  // Sink<TarefaEvent> get inputTarefa => _inputTarefaController.sink;
  // Stream<TarefaState> get outputTarefa => _outputTarefaController.stream;

  TarefaBloc() : super(TarefaInitialState()) {
    // _inputTarefaController.stream.listen(_mapEventToState);
    on(_mapEventToState);
  }

  void _mapEventToState(TarefaEvent event, Emitter emit) async {
    List<TarefaModel> tarefas = [];

    emit(TarefaLoadingState());

    if (event is GetTarefa) {
      tarefas = await _repository.getListTarefas();
    } else if (event is PostTarefa) {
      tarefas = await _repository.postTarefa(tarefa: event.tarefa);
    } else if (event is DeleteTarefa) {
      tarefas = await _repository.deleteTarefa(tarefa: event.tarefa);
    }

    emit(TarefaLoadedState(tarefas: tarefas));
  }
}
