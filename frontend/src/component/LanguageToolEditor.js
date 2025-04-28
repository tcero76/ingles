import React, { useRef, useState } from "react";
import "./LanguageToolEditor.css";
import Diccionario from "./Diccionario";

const LanguageToolEditor = () => {
  const editorRef = useRef(null);
  const [rawText, setRawText] = useState("She dont go to the market yesterday. He go to school.");
  const [alertas, setAlertas] = useState([])
  const restoreCursorFromVisibleOffset = (offset) => {
    let currentOffset = 0;
    const treeWalker = document.createTreeWalker(
      editorRef.current,
      NodeFilter.SHOW_TEXT,
      {
        acceptNode: (node) => {
          if (
            node.parentElement &&
            node.parentElement.closest(".tooltip")
          ) {
            return NodeFilter.FILTER_REJECT;
          }
          return NodeFilter.FILTER_ACCEPT;
        },
      }
    );

    while (treeWalker.nextNode()) {
      const node = treeWalker.currentNode;
      const nextOffset = currentOffset + node.textContent.length;
      if (offset <= nextOffset) {
        const range = document.createRange();
        range.setStart(node, offset - currentOffset);
        range.collapse(true);

        const sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
        break;
      }
      currentOffset = nextOffset;
    }
  };
  const onKey = () => {
    const selection = window.getSelection();
    if (!selection || selection.rangeCount === 0) return;
    const range = selection.getRangeAt(0);
    const node = range.startContainer;
    const text = node.textContent;
    const word = text.substring(range.startOffset, range.endOffset)
    const wordArray = word.match(/\b[\w']+\b/g)
    console.log("🚀 ~ onKey ~ wordArray:", wordArray)
    if (wordArray)
      if(wordArray.length)
        setAlertas(wordArray)
    
  }
  const onInputText = async (text) => {
    const selection = window.getSelection();
    if (!selection || selection.rangeCount === 0) return;
    const range = selection.getRangeAt(0);
    const preCaretRange = range.cloneRange();
    preCaretRange.selectNodeContents(editorRef.current);
    preCaretRange.setEnd(range.endContainer, range.endOffset);
    console.log(range.endOffset - range.startOffset)
    const fragment = preCaretRange.cloneContents();
    const tooltips = fragment.querySelectorAll('.tooltip');
    tooltips.forEach(node => node.remove());
    const visibleText = fragment.textContent;
    const offset = visibleText.length;

    const plainText = editorRef.current.innerText;
    const params = new URLSearchParams();
    params.append("language", "en-US");
    params.append("text", plainText);

    setRawText(text)

    const response = await fetch(`${process.env.REACT_APP_API_URL}/lt/v2/check`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: params
    });
    const result = await response.json();
    const matches = result.matches.sort((a, b) => b.offset - a.offset);
    let newHtml = plainText;
    for (let match of matches) {
      const start = match.offset;
      const end = start + match.length;
      const error = newHtml.slice(start, end);
      const tooltip = match.message + "\nSugerencias: " + (match.replacements.map(r => r.value).join(", ") || "Ninguna");
      const span = `<span class="highlight" contenteditable="true">${error}<span class="tooltip">${tooltip}</span></span>`;
      newHtml = newHtml.slice(0, start) + span + newHtml.slice(end);
    }
    editorRef.current.innerHTML = newHtml;
    restoreCursorFromVisibleOffset(offset);
  };
  return (
    <div>
      <h2>LanguageTool Checker</h2>
      <div
        id="editor"
        spellCheck="false"
        ref={editorRef}
        contentEditable
        className="editor"
        suppressContentEditableWarning={true}
        onKeyUp={(e) => onKey(e)}
        onInput={(e) => onInputText(e.currentTarget.innerText)}
        dangerouslySetInnerHTML={{ __html: rawText }}
      />
      {alertas.map((alerta,idx) => <Diccionario key={idx} alerta={alerta}/>)}
    </div>
  );
};

export default LanguageToolEditor;
