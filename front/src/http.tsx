import axios, { AxiosResponse } from "axios"
import {
    type TablePageType,
    type GetPalabraResType,
    type TestPayloadType,
    type LangToolType,
    type WordNetType, 
    CategoriaEnum} from "./model/httpModel"

export const getPalabra = ():Promise<AxiosResponse<GetPalabraResType>> => {
    return axios.get('/api/test/palabras')
}

export const putTestPalabra = (payload:TestPayloadType):Promise<AxiosResponse<GetPalabraResType>> => {
    return axios.put('/api/test/palabras', payload)
}

export const getPage = (page:number, rows:number):Promise<AxiosResponse<TablePageType>> => {
    return axios.get(`/api/palabras?page=${page}&rows=${rows}`)
}

export const putPalabra = (palabra:string, frase:string, significado:string, categoria:CategoriaEnum):Promise<AxiosResponse<GetPalabraResType>> => {
    return axios.put(`${import.meta.env.VITE_API_URL}/api/`, {
        palabra,
        frase,
        significado,
        categoria
    })
}

export const postCheck = (text:string):Promise<AxiosResponse<LangToolType>> => {
    const params = new URLSearchParams();
        params.append("language", "en-US");
        params.append("text", text);
        return axios(`${import.meta.env.VITE_API_URL}/lt/v2/check`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            data: params
        });
}

export const getWord = (word:string):Promise<AxiosResponse<WordNetType>> => {
    return axios
        .get(`${import.meta.env.VITE_API_URL}/wn/word/${word}`)
}