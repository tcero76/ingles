import React, { Component } from "react";
import { Link } from 'react-router-dom';

class Header extends Component {
    render() {
        return (
            <nav className="navbar navbar-expand-md navbar-dark bg-dark mb-4 nav__component px-3" style={{zIndex: 100}}>
              <span className="navbar-brand">Vocabulario</span>
              <div className="collapse navbar-collapse" id="navbarTogglerDemo02">
                <ul className="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li className="nav-item">
                        <Link className="nav-link" to="/">Testear</Link>
                    </li>
                    <li className="nav-item">
                        <Link className="nav-link" to="/form">Agregar Palabras</Link>
                    </li>
                    <li className="nav-item">
                        <Link className="nav-link" to="/lenguaje">Lenguaje</Link>
                    </li>
                </ul>
                </div>
            </nav>)
    }
}

export default Header;