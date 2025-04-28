export enum CategoriaEnum {
    PREPOSICION = 'Preposición',
    VERBO_COMPUESTO = 'Verbo Compuesto',
    VERBO = 'Verbo',
    ADJETIVO = 'Adjetivo',
    NOMBRE = 'Nombre',
    ADVERBIO = 'Adverbio',
    ADVERBIOS_COMUNES = 'Adverbios Comunes',
    CONECTORES_LOGICOS = 'Conectores Lógicos',
    ADJETIVOS_FRECUENTES = 'Adjetivos Frecuentes',
    SUSTANTIVOS_ABSTRACTOS = 'Sustantivos Abstractos',
    MODISMOS_Y_EXPRESIONES_COMUNES = 'Modismos y Expresiones Comunes',
    FORMAS_VERBALES_IRREGULARES_Y_ESTRUCTURAS_GRAMATICALES_CLAVE = 'Formas Verbales Irregulares y Estructuras Gramaticales Clave'
}

export enum StatusEnum {
    PENDIENTE,
    COMPLETADA
}

export type PalabraType = {
    ID:number
    palabra:string
    frase:string
    significado:string
    status:StatusEnum
    level:number
    categoria:CategoriaEnum
    nintentos:number
    nfallos:number
}

export type GetPalabraResType = {
    palabra: PalabraType
    size:number
    total:number
}

export type TablePageType = {
    rows:PalabraType[]
    page:number
    limit:number
    totalPages:number
    totalRows:number
}

export type TableProps = {
    data:PalabraType[]
}
//

export enum ResultadoEnum {
    FALLO = 0,
    EXITO = 1,
  }

export type TestPayloadType = {
    id: number
    resultado:ResultadoEnum
}


type softwareType = {
    name:string
    version:string
    buildDate:string
    apiVersion:number
    premium:boolean
    premiumHint:string
    status:string
}

type warningsType = {
    incompleteResults:boolean
}

type LanguageType = {
    name:string,
    code:string,
}

type ValueType = {
    value:string
}

type ContextType = {
    text:string
    offset:number
    length:number
}

type RuleType = {
    id:string
    subId:string
    sourceFile:string
    description:string
    issueType:string
    category: {
        id: string
        name: string
    }
}

type TypeType = {
    typeName: string
}

type MatchesType = {
    message: string
    shortMessage:string
    replacements: ValueType[],
    offset:number,
    length:number,
    context: ContextType,
    sentence:string
    type:TypeType
    rule:RuleType
    ignoreForIncompleteSentence:boolean
    contextForSureMatch:number
}

export type LangToolType = {
    software:softwareType
    warnings:warningsType,
    language:LanguageType,
    matches: MatchesType[],
    sentenceRanges: []
    extendedSentenceRanges: [
    ]
}

export type DiccionarioProps = {
    word:string
}

export type WordNetType = {
    meanings: MeaningsType[]
    word:string
}

export type MeaningsType = {
    antonyms: []
    definition:string
    examples:string[]
    lemas:string[]
    name:string
    part_of_speech:string
}