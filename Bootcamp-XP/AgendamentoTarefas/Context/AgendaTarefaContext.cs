using AgendamentoTarefas.Models;
using Microsoft.EntityFrameworkCore;

namespace AgendamentoTarefas.Context
{
    public class AgendaTarefaContext: DbContext
    {
        public AgendaTarefaContext(DbContextOptions<AgendaTarefaContext> options) : base(options) { }


        public DbSet<Tarefa> Tarefas { get; set; }
    }
}
