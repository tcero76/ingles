import React, { Component } from "react";

class Table extends Component {

    renderRow() {
        return this.props.data.map((d,idx) => {
            return (<tr key={idx}>
                        <th>{d.palabra}</th>
                        <td>{d.significado}</td>
                        <td>{d.frase}</td>
                        <th>{d.level}</th>
                        <th>{d.categoria}</th>
                    </tr>)
        })
    }

    renderBody() {
        return (<tbody>
                {this.renderRow()}
                </tbody>)
    }

    render() {
        return (<table className="table mt-5">
                    <thead>
                    <tr>
                        <th scope="col">Palabra</th>
                        <th scope="col">Significado</th>
                        <th scope="col">Frase</th>
                        <th scope="col">Level</th>
                        <th scope="col">Categoria</th>
                    </tr>
                    </thead>
                    {this.renderBody()}
                </table>)
    }
}

export default Table;