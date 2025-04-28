import React, { Component } from "react";
import Form from './Form';
import Table from './Tabla';
import Pagination from './Pagination'
import axios from '../../util/axios'


class Index extends Component {

    state = { data:[],
        page:1,
        rows: 10,
        totalPages: 0,
    }

    componentDidMount() {
        const { page, rows} = this.state;
        this.getData(page, rows);
    }

    getDisplacement = (displacement, rows) => {
        let page = this.state.page + displacement
        axios.get(`/palabras?page=${page}&rows=${rows}`)
        .then(res => {
            this.setState({...this.state, data: res.data.rows, page, totalPages: res.data.totalPages});
        })
        .catch(res => {
            console.error(res);
        })
    }

    getData = (page, rows) => {
        axios.get(`/palabras?page=${page}&rows=${rows}`)
        .then(res => {
            this.setState({...this.state, data: res.data.rows, page, totalPages: res.data.totalPages});
        })
        .catch(res => {
            console.error(res);
        })
    }
    
    render() {
        return (
            <div>
                <Form toast={this.props.toast}/>
                <Table data={this.state.data} />
                <Pagination totalPages={this.state.totalPages}
                    page={this.state.page}
                    getDisplacement={this.getDisplacement}
                    getData={this.getData}
                />
            </div>
        )
    }
}

export default Index;