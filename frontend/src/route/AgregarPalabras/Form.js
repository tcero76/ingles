import React, { Component } from "react";
import axios from '../../util/axios'
import { TIPOS } from '../../component/Toast'

class Form extends Component {
  
    state = { palabra: '', frase: '', significado: '' }

    render() {
        return (<form className="p-3" style={ {border: '#eee solid 0.1px'}}>
                    <div className="mb-3">
                        <label htmlFor="exampleInputEmail1" className="form-label">Palabra</label>
                        <input type="email" className="form-control"
                        onChange={e => this.onChangePalabra(e)}
                        value={this.state.palabra}
                        ></input>
                    </div>
                    <div className="mb-3">
                        <label htmlFor="exampleInputEmail1" className="form-label">Frase</label>
                        <input type="email" className="form-control"
                        onChange={e => this.onChangeFrase(e)}
                        value={this.state.frase}
                        ></input>
                    </div>
                    <div className="mb-3">
                        <label htmlFor="exampleInputEmail1" className="form-label">Significado</label>
                        <input type="email" className="form-control"
                        onChange={e => this.onChangeSignificado(e)}
                        value={this.state.significado}
                        ></input>
                    </div>
                    <button type="submit" className="btn btn-primary" onClick={e => this.onClickForm(e)}>Submit</button>
                    </form>);
      }

      onClickForm(e) {
        e.preventDefault();
        const { palabra, frase, significado } = (this.state);
        axios.put('/', {
            palabra,
            frase,
            significado,
            categoria: "PREPOSICION"
        })
        .then(res => {
          this.props.toast.current.showMsg({ msg: res.data.message, tipo: TIPOS.AVISO})
        })
        .catch(res => {
          this.props.toast.current.showMsg({ msg: res.data.message, tipo: TIPOS.ERROR})
        })
      }

      onChangePalabra(e) {
        this.setState({...this.state, palabra: e.target.value})
      }

      onChangeFrase(e) {
        this.setState({...this.state, frase: e.target.value})

      }

      onChangeSignificado(e) {
        this.setState({...this.state, significado: e.target.value})

      }
}

export default Form;