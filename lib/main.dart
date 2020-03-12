import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampovalor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CriandoTransferencia'),
        ),
        body: Column(
          children: <Widget>[
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: 'Número da conta',
                dica: '0000'
            ),
            Editor(
                controlador: _controladorCampovalor,
                rotulo: 'Valor',
                dica: '0.00',
                icone: Icons.monetization_on
            ),
            RaisedButton(
              child: Text('Confirmar'),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    debugPrint('clicou no confirmar');
    debugPrint(_controladorCampoNumeroConta.text);
    debugPrint(_controladorCampovalor.text);
    final int numeroConta =
    int.tryParse(_controladorCampoNumeroConta.text);
    final double valor =
    double.tryParse(_controladorCampoNumeroConta.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}


class ListaTransferencias extends StatefulWidget {

  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaTansferenciasState();
  }
}

class ListaTansferenciasState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTranferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return FormularioTransferencia();
            }));
        future.then((transferenciaRecebida) {
          debugPrint('Chegou no them');
          debugPrint('$transferenciaRecebida');
          widget._transferencias.add(transferenciaRecebida);
        });
      },
      ),
    );
  }
}

class ItemTranferencia extends StatelessWidget {
  final Transferencia _tranferencia;

  ItemTranferencia(this._tranferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_tranferencia.valor.toString()),
        subtitle: Text(_tranferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }


}
