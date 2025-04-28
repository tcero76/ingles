import React from 'react';
import TextFormat from './TextFormat';
import Diccionario from "./Diccionario";
import { results$, setSearchQuery } from './Rxjs/searchService';

const TextEditor = () => {
  const [alertas, setAlertas] = React.useState([])
    const searchWord = (wordArray) => {
        setAlertas(wordArray)
      }
    const highlight = async (text) => {
        const params = new URLSearchParams();
        params.append("language", "en-US");
        params.append("text", text);
        const response = await fetch(`${process.env.REACT_APP_API_URL}/lt/v2/check`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: params
        });
        const result = await response.json();
        const matches = result.matches.sort((a, b) => b.offset - a.offset);
        let newHtml = text;
        for (let match of matches) {
            const start = match.offset;
            const end = start + match.length;
            const error = newHtml.slice(start, end);
            const tooltip = match.message + "\nSugerencias: " + (match.replacements.map(r => r.value).join(", ") || "Ninguna");
            const span = `<span class="highlight" contenteditable="true" title="${tooltip}">${error}</span>`; //
            newHtml = newHtml.slice(0, start) + span + newHtml.slice(end);
        }
        return newHtml;
    }
    return (
        <>
            <TextFormat highlight={highlight} searchWord={searchWord}/>
            {alertas.map((alerta,idx) => <Diccionario key={idx} alerta={alerta}/>)}
        </>)
};

export default TextEditor;