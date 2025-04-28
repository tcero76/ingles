import { useRef, FC } from 'react'

const storeCaretPosition = (editor:HTMLDivElement):number => {
    const selection = window.getSelection();
    if (!selection) return;
    if (!selection.rangeCount) return;
    const range = selection.getRangeAt(0);
    const preCaretRange = range.cloneRange();
    preCaretRange.selectNodeContents(editor);
    preCaretRange.setEnd(range.endContainer, range.endOffset);
    return preCaretRange.toString().length;
}
const restoreCaretPosition = (element:HTMLDivElement, offset:number) => {
    const selection = window.getSelection();
    const range = document.createRange();
    let currentNode = null;
    let currentOffset = 0;
    const walker = document.createTreeWalker(element, NodeFilter.SHOW_TEXT, null);
    while (walker.nextNode()) {
      const node = walker.currentNode;
      const length = node.nodeValue.length;
      if (currentOffset + length >= offset) {
        currentNode = node;
        break;
      }
      currentOffset += length;
    }
    if (currentNode) {
      range.setStart(currentNode, offset - currentOffset);
      range.collapse(true);
      selection.removeAllRanges();
      selection.addRange(range);
    }
  };

type TextFormatProps = {
  searchWord:(words:string[]) => void
  highlight:(text:string) => Promise<string>
}

const TextFormat:FC<TextFormatProps> = ({ highlight, searchWord }) => {
  const editorRef = useRef<HTMLDivElement>(document.createElement('div'));
  const onKey = () => {
    const selection = window.getSelection();
    if (!selection || selection.rangeCount === 0) return;
    const range = selection.getRangeAt(0);
    const walker = document.createTreeWalker(editorRef.current, NodeFilter.SHOW_TEXT, null);
    let currentOffset = 0, offset = 0, start = 0, end = 0, inicio = false;
    while (walker.nextNode()) {
      if(!walker?.currentNode.nodeValue) continue
        if (walker.currentNode === range.startContainer) {
            start = currentOffset + range.startOffset
            end = currentOffset + range.endOffset
            offset = end - start
            inicio = true
        } else if (walker.currentNode === range.endContainer) {
            offset = currentOffset + range.endOffset
            end = start + offset
            break;
        } else if(inicio) {
            offset += walker.currentNode.nodeValue.length;
        }
        currentOffset += walker.currentNode.nodeValue.length;
    }
    const preCaretRange = range.cloneRange();
    preCaretRange.selectNodeContents(editorRef.current);
    preCaretRange.setEnd(range.endContainer, range.endOffset);
    const text = preCaretRange.toString()
    const word = text.substring(start, end)
    const wordArray = word.match(/\b[a-zA-Z']+\b/g);
    if (wordArray)
      if(wordArray.length)
        searchWord(wordArray)
  }
  const handleChange = async () => {
    const editor = editorRef.current;
    const caretOffset = storeCaretPosition(editor);
    editor.innerHTML = await highlight(editor.innerText)
    restoreCaretPosition(editor, caretOffset);
  };
    return (
        <div>
          <div
            spellCheck="false"
            ref={editorRef}
            contentEditable
            onKeyUp={onKey}
            onInput={handleChange}
            style={{ border: '1px solid #ccc', padding: '10px', minHeight: '100px' }}
          />
          <style>{`
              .highlight {
                color: red;
                font-weight: bold;
              }
            `}</style>
        </div>
      );
}

export default TextFormat