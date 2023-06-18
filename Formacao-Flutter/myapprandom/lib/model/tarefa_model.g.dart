// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TarefaAdapter extends TypeAdapter<Tarefa> {
  @override
  final int typeId = 1;

  @override
  Tarefa read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tarefa()
      .._descricao = fields[1] as String
      .._concluido = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Tarefa obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._descricao)
      ..writeByte(2)
      ..write(obj._concluido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TarefaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
