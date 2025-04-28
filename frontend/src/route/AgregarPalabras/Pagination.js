import React from "react";

class Pagination extends React.Component {

    rows = 10

    renderNumbers() {
        const arr = Array.from({length: this.props.totalPages}, (_, index) => index + 1);
        return arr.map(p => {
            const active = p===this.props.page ? ' active' : ''
            return <li key={p} className="page-item"><button className={`page-link${active}`} onClick={e => this.props.getData(p, this.rows)}>{p}</button></li>
        })
    }

    render() {
        return(
            <nav aria-label="Page navigation example">
                <ul className="pagination">
                    <li className="page-item"><button className="page-link" onClick={e => this.props.getDisplacement(-1, this.rows)}>Previous</button></li>
                    {this.renderNumbers()}
                    <li className="page-item"><button className="page-link" onClick={e => this.props.getDisplacement(1, this.rows)}>Next</button></li>
                </ul>
            </nav>
        )
    }
}

export default Pagination;