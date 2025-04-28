import React, { Component} from 'react';
import Header from '../header';
import { Routes, Route } from 'react-router-dom';
import AgregarPalabra from './AgregarPalabras/Index';
import TestPalabras from './TestPalabras';
import TextEditor from '../component/TextEditor';
import Toast from '../component/Toast'

class App extends Component {

  constructor(props) {
    super(props)
    this.toast = React.createRef();
  }

  componentDidMount() {
  }

  render() {
    return (<div>
              <Header/>
                <div className="container">
                  <Toast ref={this.toast}/>
                  <Routes>
                    <Route exact path="/form" element={<AgregarPalabra toast={this.toast}/>} />
                    <Route exact path="/" element={<TestPalabras toast={this.toast}/>} />
                    <Route exact path="/" element={<TestPalabras toast={this.toast}/>} />
                    <Route exact path="/lenguaje" element={<TextEditor/>} />
                  </Routes>
                </div>
            </div>)
  }
}
export default App;
