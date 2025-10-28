// Importa a biblioteca para trabalhar com número aleatórios
import 'dart:math';
// Importa o pacote principal do Flutter (widgets, design...etc)
import 'package:flutter/material.dart';

// 1. ESTRUTURA BASE DO APP
//A função principal que inicia o app
void main() => runApp(
  const AplicativoJogodeDados()
);

//Raiz (base) do app. Definir o tema e o fluxo inicial
class AplicativoJogodeDados extends StatelessWidget {
  const AplicativoJogodeDados({super.key});


@override
Widget build(BuildContext context){
  //fazer um return do MaterialApp, que dá o visual ao projeto
  return MaterialApp(
    title: 'Jogo de Dados', //Título que aparece no gerenciador
    theme: ThemeData(
      primarySwatch: Colors.blue
    ),
    home: const TelaConfiguracaoJogadores(),
  );
 }
}

// 2. TELA DE CONFIGURAÇÃO DE JOGADORES
//Primeira tela do app. Coletar os nomes dos jogadores
class TelaConfiguracaoJogadores extends StatefulWidget {
  const TelaConfiguracaoJogadores({super.key});

  @override
  //cria o objeto de Estado que vai gerenciar o formulário do jogador
  State<TelaConfiguracaoJogadores> createState() => _EstadoTelaConfiguracaoJogadores();
}

class _EstadoTelaConfiguracaoJogadores extends State<TelaConfiguracaoJogadores>{
  //Chave Global para identificar e validar o widget
  //final é uma palavra chave do dart para criar uma variável que só recebe valor uma vez
  //FormSate é o esatdo interno desse formulário, é a parte que sabe o que está digitado e consegue validar os campos
  final _chaveFormulario = GlobalKey<FormState>();
  //Controladores para pegar o texto digitado nos campos
  final TextEditingController _controladorJogador1 = TextEditingController();
  final TextEditingController _controladorJogador2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações dos Jogadores"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), //Espaçamento Interno
        child: Form(
          key: _chaveFormulario, //Associando a chave GlobalKey ao formulário
          child: Column(
            children: [
              //Campo de texto para o jogador n°1
              TextFormField(
                controller: _controladorJogador1, //Liga o input ao controlador
                decoration: const InputDecoration(labelText: "Nome Jogador 1"),
                validator: (valor) => valor!.isEmpty ? "Digite o nome" : null,
                // condição ? valor_se_verdadeiro : valor_se_falso
                //Se o campo estiver vazio, mostre o texto "Digite um nome".
              ),
              const SizedBox(height: 20),
              //Campo de texto para o jogador n°2
              TextFormField(
                controller: _controladorJogador2, //Liga o input ao controlador
                decoration: const InputDecoration(labelText: "Nome Jogador 2"),
                validator: (valor) => valor!.isEmpty ? "Digite o nome" : null,
                // condição ? valor_se_verdadeiro : valor_se_falso
                //Se o campo estiver vazio, mostre o texto "Digite um nome".
              ),
              const Spacer(), //Ocupar o espaço vertical disponível, empurrando o botão p/ baixo
              //Fazer um botão para iniciar o jogo
              ElevatedButton(
                onPressed: (){
                  //Checar se o formulário está válido(se os campos foram preenchidos)
                  if (_chaveFormulario.currentState!.validate()){
                    //Navega para a próxima tela
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        //Cria a tela do jogo, PASSANDO os nomes digitador como Parâmetros.
                        builder: (context) => TelaJogodeDados(
                          nomeJogador1: _controladorJogador1.text,
                          nomeJogador2: _controladorJogador2.text,
                        )
                      )
                    );
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                //Botão de largura total.
                child: const Text("Inicial Jogo"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
