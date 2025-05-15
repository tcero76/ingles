import { useRef, FC, useState, useEffect, useImperativeHandle, ForwardedRef, forwardRef } from 'react'
import { BehaviorSubject, switchMap, from, debounceTime } from 'rxjs';
import * as bootstrap from 'bootstrap'
import { TextAndPos, TextFormatProps, TextFormatType } from '../../../model/types';

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
      selection?.removeAllRanges();
      selection?.addRange(range);
    }
  };

const TextFormat = forwardRef<TextFormatType,TextFormatProps>(({ highlight, searchWord, ...props}:TextFormatProps , ref:ForwardedRef<TextFormatType>) => {
  const [textAndPos, setTextAndPos ] = useState<TextAndPos>({text:'', pos:0})
  const editorRef = useRef<HTMLDivElement>(document.createElement('div'));
  const text$ = useRef<BehaviorSubject<TextAndPos>>(new BehaviorSubject({ text:'', pos:0})).current
  useImperativeHandle(ref,() => ({
    cleanInput:() => {
      setTextAndPos({text:'', pos:0})
    }
  }))
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
  useEffect(()=> {
    const switched$ = text$.pipe(
      debounceTime(400),
      switchMap(({ text, pos }) => from(highlight(text)
        .then((highlighted:string) => ({ text: highlighted, pos }))))
      )
    .subscribe((resp) => setTextAndPos({text:resp.text ,pos:resp.pos}))
    return () => switched$.unsubscribe()
  },[])
  useEffect(() => {
    const editor = editorRef.current;
    restoreCaretPosition(editor, textAndPos.pos);
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(tooltipTriggerEl => {
      new bootstrap.Tooltip(tooltipTriggerEl);
    });
  }, [textAndPos])
  const handleChange = async () => {
    const editor = editorRef.current;
    const tP = {
      text:editor.innerText, pos:storeCaretPosition(editor)
    }
    setTextAndPos(tP)
    text$.next(tP)
  };
    return (
        <div>
          <div
            spellCheck="false"
            ref={editorRef}
            contentEditable
            onKeyUp={onKey}
            onInput={handleChange}
            dangerouslySetInnerHTML={{ __html: textAndPos.text}}
            style={{ border: '1px solid #ccc', padding: '10px', minHeight: '100px' }}
            {...props}
          />
          <style>{`
              .highlight {
                color: red;
                font-weight: bold;
              }
            `}</style>
        </div>
      );
})

export default TextFormat