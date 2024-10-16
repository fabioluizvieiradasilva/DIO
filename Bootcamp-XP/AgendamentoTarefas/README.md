# DIO e XP Inc. - Trilha .NET - API e Entity Framework


## Desafio de projeto
Para este desafio, voc� precisar� usar seus conhecimentos adquiridos no m�dulo de API e Entity Framework, da trilha .NET da DIO.

## Contexto
Voc� precisa construir um sistema gerenciador de tarefas, onde voc� poder� cadastrar uma lista de tarefas que permitir� organizar melhor a sua rotina.

Essa lista de tarefas precisa ter um CRUD, ou seja, dever� permitir a voc� obter os registros, criar, salvar e deletar esses registros.

A sua aplica��o dever� ser do tipo Web API ou MVC, fique a vontade para implementar a solu��o que achar mais adequado.

A sua classe principal, a classe de tarefa, deve ser a seguinte:

![Diagrama da classe Tarefa](diagrama.png)

N�o se esque�a de gerar a sua migration para atualiza��o no banco de dados.

## M�todos esperados
� esperado que voc� crie o seus m�todos conforme a seguir:


**Swagger**


![M�todos Swagger](swagger.png)


**Endpoints**


| Verbo  | Endpoint                | Par�metro | Body          |
|--------|-------------------------|-----------|---------------|
| GET    | /Tarefa/{id}            | id        | N/A           |
| PUT    | /Tarefa/{id}            | id        | Schema Tarefa |
| DELETE | /Tarefa/{id}            | id        | N/A           |
| GET    | /Tarefa/ObterTodos      | N/A       | N/A           |
| GET    | /Tarefa/ObterPorTitulo  | titulo    | N/A           |
| GET    | /Tarefa/ObterPorData    | data      | N/A           |
| GET    | /Tarefa/ObterPorStatus  | status    | N/A           |
| POST   | /Tarefa                 | N/A       | Schema Tarefa |

Esse � o schema (model) de Tarefa, utilizado para passar para os m�todos que exigirem

```json
{
  "id": 0,
  "titulo": "string",
  "descricao": "string",
  "data": "2022-06-08T01:31:07.056Z",
  "status": "Pendente"
}
```
