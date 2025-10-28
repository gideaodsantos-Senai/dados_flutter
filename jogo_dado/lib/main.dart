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

//3. TELA PRINCIPAL DO JOGO

//Aqui eu vou receber os nomes como propriedades
class TelaJogodeDados extends StatefulWidget {
  //Variáveis finais que armazenam os nomes recebidos da dela anterior
  final String nomeJogador1;
  final String nomeJogador2;
  //TETLAJOGODEDADOS é o corpo de um robô
  const TelaJogodeDados ({
    super.key,
    //o required garante que esses valores devem ser passados.
    required this.nomeJogador1,
    required this.nomeJogador2,
    });

    @override
    //Ei tio flutter, quando essa tela for criada, use essa classe chamada _EstadoTelaJogoDeDados
    //para guardar e controlar o estado dela
    //ESTADOTELAJOGODEJOGADOR é o cérebro do robô que guarda o que está acontecendo.
    //o createstate é o botão que coloca o cerébro dentro do robô
    State<TelaJogodeDados> createState() => _EstadoTelaJogoDeDados();
}

class _EstadoTelaJogoDeDados extends State<TelaJogodeDados>{
  final Random _aleatorio = Random(); //gerador de números aleatórios
  //Lista dos 3 valores de cada jogador.
  List<int> _lancamentosJogador1 = [1,1,1];
  List<int> _lancamentosJogador2 = [1,1,1];
  String _mensagemResultado = ''; //Mensagem de resultado da rodada.

  //Mapear as associações do número dado referente ao link
  final Map<int, String> imagensDados = {
    1: 'https://i.imgur.com/1xqPfjc.png&#39',
    2: 'https://i.imgur.com/5ClIegB.png&#39',
    3: 'https://i.imgur.com/hjqY13x.png&#39',
    4: 'https://i.imgur.com/CfJnQt0.png&#39',
    5: 'https://i.imgur.com/6oWpSbf.png&#39',
    6: 'https://i.imgur.com/drgfo7s.png&#39',
  };

  // Lógica da pontuação: verifica combinações para aplicar os multiplicadores.
  int _calculadorPontuacao(List<int> lancamentos){
    //reduce percorre toda a lista somando tudo
    final soma = lancamentos.reduce((a,b) => a + b);
    // [4,4,1] > 4 + 4 = 8 > 8 + 1 = 9 > soma = 9
    final valoresUnicos = lancamentos.toSet().length;
    //toSet remove repetidos
    if (valoresUnicos == 1){ //Ex: [5,5,5]. Três iguais = 3x a soma
      return soma * 3;
    } else if (valoresUnicos == 2){ //Ex: [4,4,1] dois iguais = 2x a soma
      return soma * 2;
    } else { // Ex: [1,3,6]. Todos diferentes = soma pura.
      return soma;
    }
  }
  //Função chamada pelo botão para lançar os dados
  void _lancarDados(){ //eu uso o sublinhado "_" significa que ela é privada, só pode ser usada
     //dentro dessa classe
     //comando crucial p/ forçar atualização da tela
    setState(() {
      _lancamentosJogador1 = List.generate(3, (_) => _aleatorio.nextInt(6) + 1);
      _lancamentosJogador2 = List.generate(3, (_) => _aleatorio.nextInt(6) + 1);

      final pontuacao1 = _calculadorPontuacao(_lancamentosJogador1);
      final pontuacao2 = _calculadorPontuacao(_lancamentosJogador2);

      if (pontuacao1 > pontuacao2) {
        _mensagemResultado = '${widget.nomeJogador1} Venceu! ($pontuacao1 x $pontuacao2)';
      } else if (pontuacao2 > pontuacao1) {
        _mensagemResultado = '${widget.nomeJogador2} Venceu! ($pontuacao2 x $pontuacao1)';
      } else {
        _mensagemResultado = 'Empate! Joguem novamente.';
      }
    });
  }

}
