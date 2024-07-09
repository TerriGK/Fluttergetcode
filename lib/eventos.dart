class Evento {
  final int eventoId;
  final String nombre;
  final String fechaInicio;
  final String fechaTermino;
  final String hora;
  final String tipoEventoNombre;
  final String categoriaNombre;
  final int organizadorId;
  final int categoriaId;
  final String ubicacion;
  final int maxPer;
  final String estado;
  final int autorizadoPorId;
  final String autorizadoPorNombre;
  final String fechaAutorizacion;

  Evento({
    required this.eventoId,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.hora,
    required this.tipoEventoNombre,
    required this.categoriaNombre,
    required this.organizadorId,
    required this.categoriaId,
    required this.ubicacion,
    required this.maxPer,
    required this.estado,
    required this.autorizadoPorId,
    required this.autorizadoPorNombre,
    required this.fechaAutorizacion,
  });

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      eventoId: json['evento_id'],
      nombre: json['nombre'],
      fechaInicio: json['fecha_inicio'],
      fechaTermino: json['fecha_termino'],
      hora: json['hora'],
      tipoEventoNombre: json['tipo_evento_nombre'],
      categoriaNombre: json['categoria_nombre'],
      organizadorId: json['organizador_id'],
      categoriaId: json['categoria_id'],
      ubicacion: json['ubicacion'],
      maxPer: json['max_per'],
      estado: json['estado'],
      autorizadoPorId: json['autorizado_por_id'],
      autorizadoPorNombre: json['autorizado_por_nombre'],
      fechaAutorizacion: json['fecha_autorizacion'],
    );
  }
}
