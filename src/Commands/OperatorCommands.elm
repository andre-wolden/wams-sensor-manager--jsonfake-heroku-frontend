module Commands.OperatorCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (operatorDecoder)
import Messages exposing (Msg)


saveOperator : Operator -> Cmd Msg
saveOperator operator =
    request operator
        |> Http.send Messages.OnOperatorSaved


request : Operator -> Http.Request Operator
request operator =
    Http.request
        { body = operatorEncoder operator |> Http.jsonBody
        , expect = Http.expectJson operatorDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/operators"
        , withCredentials = False
        }


operatorEncoder : Operator -> Encode.Value
operatorEncoder operator =
    let
        attributes =
            [ ( "id", Encode.int operator.id )
            , ( "name", Encode.string operator.name )
            ]
    in
        Encode.object attributes
