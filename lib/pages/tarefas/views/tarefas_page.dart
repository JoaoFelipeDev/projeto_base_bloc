import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_base_bloc/pages/tarefas/blocs/tarefa_bloc.dart';
import 'package:projeto_base_bloc/pages/tarefas/blocs/tarefa_event.dart';
import 'package:projeto_base_bloc/pages/tarefas/blocs/tarefa_state.dart';
import 'package:projeto_base_bloc/pages/tarefas/models/tarefas_model.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late final TarefaBloc _tarefaBloc;

  @override
  void initState() {
    super.initState();
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefa());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bloc pattern',
        ),
      ),
      body: BlocBuilder<TarefaBloc, TarefaState>(
          bloc: _tarefaBloc,
          builder: (context, state) {
            if (state is TarefaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TarefaLoadedState) {
              final list = state.tarefas;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Center(
                        child: Text(
                          list[index].nome[0],
                        ),
                      ),
                    ),
                    title: Text(list[index].nome),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _tarefaBloc.add(
                          DeleteTarefa(
                            tarefa: list[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Sem tarefas hoje!'));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tarefaBloc.add(
            PostTarefa(
              tarefa: TarefaModel(nome: 'Fazer caminhada'),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }
}
