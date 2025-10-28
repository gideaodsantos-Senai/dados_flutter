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
  final _chaveFormulario = GlobalKey<FormState>();
}