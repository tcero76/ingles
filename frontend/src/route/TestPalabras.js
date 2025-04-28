import React, { Component } from "react";
import axios from '../util/axios'
import { TIPOS } from '../component/Toast'


const RESULTADO = {
  FALLO: 0,
  EXITO: 1,
}
class TestPalabras extends Component {

  state={ word: { palabra: '',
      frase: '',
      significado: '',
      ID: 0,
      nfallo: '',
      nintentos: ''},
    hide: true,
    restantesSize: 0,
    restantesTotal: 0
  }

  componentDidMount() {
    this.getPalabra();
  }

  getPalabra() {
    axios.get('/test/palabras')
    .then(res => {
      this.setState({
        ...this.state,
        word: res.data.palabra,
        restantesSize: res.data.size,
        restantesTotal: res.data.total,})
      })
  }

  onClickVer(e) {
    this.setState({...this.state, hide: false})
  }

  onClickResultado(e, resultado) {
    axios.put('/test/palabras', {
      id: this.state.word.ID.toString(),
      resultado
    })
    .then(res => {
      this.setState({...this.state, word: res.data.palabra, hide: true,
        restantesSize: res.data.size,
        restantesTotal: res.data.total})
      this.props.toast.current.showMsg({ msg: 'Datos enviados', tipo: TIPOS.AVISO} )
    })
    .catch(res => {
      this.props.toast.current.showMsg({ msg: 'Error en envío', tipo: TIPOS.ERROR} )
    })
  }

  render() {
    const { frase, significado, palabra, ID } = this.state.word;
    const { hide } = this.state;
    return <div className="card">
      <div className="card-header">{this.state.restantesSize}/{this.state.restantesTotal}</div>
            <div className="card-body">
            <h5 className="card-title">Test Palabras</h5>
              <p className="card-text">Palabra: <b>{ ID === 0 ? '-' : palabra }</b><i>({this.state.word.nfallos}/{this.state.word.nintentos})</i></p>
              <p className="card-text">Frase: { hide ? 'oculto' :  frase }</p>
              <p className="card-text">Significado: { hide ? 'oculto' :  significado }</p>
              <div>
                <button type="button" className="btn btn-primary mx-2" onClick={e => this.onClickResultado(e, RESULTADO.EXITO)}>Recordada</button>
                <button type="button" className="btn btn-danger mx-2" onClick={e => this.onClickResultado(e, RESULTADO.FALLO)}>Fallo</button>
                <button type="button" className="btn btn-success mx-2" onClick={e => this.onClickVer(e)}>Ver</button>
              </div>
            </div>
            
          </div>
  }

}

export default TestPalabras;