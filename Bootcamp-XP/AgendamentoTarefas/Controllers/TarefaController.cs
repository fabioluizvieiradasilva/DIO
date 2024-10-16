using AgendamentoTarefas.Context;
using AgendamentoTarefas.Models;
using Microsoft.AspNetCore.Mvc;

namespace AgendamentoTarefas.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TarefaController : ControllerBase
    {

        private readonly AgendaTarefaContext _context;

        public TarefaController(AgendaTarefaContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public IActionResult ObterPorId(int id)
        {
            var tarefa = _context.Tarefas.Find(id);
            if (tarefa == null)
                return NoContent();

            return Ok(tarefa);
        }

        [HttpGet("ObterTodos")]
        public IActionResult ObterTodos()
        {
            var tarefas = _context.Tarefas;
            if(tarefas.Count() == 0)
                return NoContent();
            
            return Ok(tarefas);
        }

        [HttpGet("ObterPorTitulo")]
        public IActionResult ObterPorTitulo(string titulo)
        {
            var tarefas = _context.Tarefas.Where(x => x.Titulo.Contains(titulo));
            if (tarefas.Count() == 0)
                return NoContent();

            return Ok(tarefas);
        }

        [HttpGet("ObterPorStatus")]
        public IActionResult ObterPorStatus(EnumStatusTarefa status)
        {
            var tarefas = _context.Tarefas.Where(x => x.Status == status);
            if (tarefas.Count() == 0)
                return NoContent();

            return Ok(tarefas);
        }

        [HttpGet("ObterPorData")]
        public IActionResult ObterPorData(DateTime data)
        {
            var tarefas = _context.Tarefas.Where(x => x.Data.Date == data);
            if (tarefas.Count() == 0)
                return NoContent();

            return Ok(tarefas);
        }

        [HttpPost]
        public IActionResult Criar(Tarefa tarefa)
        {
            _context.Add(tarefa);
            _context.SaveChanges();
            return CreatedAtAction(nameof(ObterPorId), new {id = tarefa.Id}, tarefa);
        }

        [HttpPut("{id}")]
        public IActionResult Atualizar (int id, Tarefa tarefa)
        {
            var tarefaBanco = _context.Tarefas.Find(id);

            if(tarefaBanco == null)
                return NotFound();

            if(tarefa.Data == DateTime.MinValue)
                return BadRequest( new { Erro = "A data da tarefa não pode ser vazia" });

            tarefaBanco.Titulo = tarefa.Titulo;
            tarefaBanco.Descricao = tarefa.Descricao;
            tarefaBanco.Data = tarefa.Data;
            tarefaBanco.Status = tarefa.Status;

            _context.Tarefas.Update(tarefaBanco);
            _context.SaveChanges();
            
            return Ok(tarefa);
        }

        [HttpDelete("{id}")]
        public IActionResult Deletar(int id)
        {
            var tarefaBanco = _context.Tarefas.Find(id);

            if (tarefaBanco == null)
                return NotFound();

            _context.Tarefas.Remove(tarefaBanco);
            _context.SaveChanges();

            return NoContent();
        }
    }
}
