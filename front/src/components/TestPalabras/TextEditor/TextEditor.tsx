import { ComponentPropsWithoutRef, ForwardedRef, forwardRef, useImperativeHandle, useRef, useState } from 'react';
import TextFormat from './TextFormat';
import Diccionario from "./Diccionario";
import { postCheck } from '../../../http';
import { TextEditorType, TextFormatType } from '../../../model/types';

const TextEditor = forwardRef<TextEditorType,ComponentPropsWithoutRef<'div'>>(({ ...props },ref:ForwardedRef<TextEditorType>) => {
  const [alertas, setAlertas] = useState<string[]>([])
  const textFormatRef = useRef<TextFormatType>({ cleanInput:() => null });
  useImperativeHandle(ref,()=>({
    cleanInput:() => textFormatRef.current.cleanInput()
  }))
    const searchWord = (wordArray:string[]) => {
        setAlertas(wordArray)
      }
    const highlight = async (text:string):Promise<string> => {
        const result = await postCheck(text)
        const matches = result.data.matches.sort((a, b) => b.offset - a.offset);
        let newHtml = text;
        for (const match of matches) {
            const start = match.offset;
            const end = start + match.length;
            const error = newHtml.slice(start, end);
            const tooltip = match.message + "\nSugerencias: " + (match.replacements.map(r => r.value).join(", ") || "Ninguna");
            const span = `<span class="highlight" contenteditable="true" class="btn btn-secondary" data-bs-toggle="tooltip"
              data-bs-placement="bottom" data-bs-title="${tooltip}">${error}</span>`; //
            newHtml = newHtml.slice(0, start) + span + newHtml.slice(end);
        }
        return newHtml;
    }
    return (<div>
                <TextFormat highlight={highlight} searchWord={searchWord} ref={textFormatRef} { ...props }/>
                {alertas.map((alerta,idx) => {
                    if(alerta) return <Diccionario key={idx} word={alerta}/>
                })}
            </div>)
});

export default TextEditor;