import React, { Component } from 'react';
import bootstrap from 'bootstrap/dist/js/bootstrap'
const TIPOS = {
    AVISO: {
        color: '#007aff',
        tituto: 'Aviso',
    },
    ERROR: {
        color: '#ff2300',
        tituto: 'Error',

    }
}

class Toast extends Component {

    state = { msg: '', tipo: TIPOS.AVISO }


    componentDidMount() {
        const toastLiveExample = document.getElementById('liveToast')
        this.toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
    }

    showMsg(state) {
        this.setState(state)
        this.toastBootstrap.show();
    }

    render() {
        return (<div className="toast-container position-fixed top-0 end-0 p-3">
                    <div id='liveToast' className="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div className="toast-header">
                    <svg className="bd-placeholder-img rounded me-2" width="20" height="20" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill={this.state.tipo.color}></rect></svg>
                        <strong className="me-auto">{ this.state.tipo.tituto }</strong>
                        <button type="button" className="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div className="toast-body">
                        {this.state.msg}
                    </div>
                    </div>
                </div>)
    }
}

export { TIPOS };
export default Toast;