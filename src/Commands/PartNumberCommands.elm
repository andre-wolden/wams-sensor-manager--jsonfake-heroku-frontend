module Commands.PartNumberCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (partNumberDecoder)
import Messages exposing (Msg)


savePartNumber : PartNumber -> Cmd Msg
savePartNumber partNumber =
    request partNumber
        |> Http.send Messages.OnPartNumberSaved


request : PartNumber -> Http.Request PartNumber
request partNumber =
    Http.request
        { body = partNumberEncoder partNumber |> Http.jsonBody
        , expect = Http.expectJson partNumberDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/part_numbers"
        , withCredentials = False
        }


partNumberEncoder : PartNumber -> Encode.Value
partNumberEncoder partNumber =
    let
        attributes =
            [ ( "id", Encode.int partNumber.id )
            , ( "pn", Encode.string partNumber.pn )
            , ( "calibration_procedure", Encode.string partNumber.calibration_procedure )
            ]
    in
        Encode.object attributes
