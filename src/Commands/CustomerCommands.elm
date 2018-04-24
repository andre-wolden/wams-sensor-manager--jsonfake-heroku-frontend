module Commands.CustomerCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (customerDecoder)
import Messages exposing (Msg)


saveCustomer : Customer -> Cmd Msg
saveCustomer customer =
    request customer
        |> Http.send Messages.OnCustomerSaved


request : Customer -> Http.Request Customer
request customer =
    Http.request
        { body = customerEncoder customer |> Http.jsonBody
        , expect = Http.expectJson customerDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/customers"
        , withCredentials = False
        }


customerEncoder : Customer -> Encode.Value
customerEncoder customer =
    let
        attributes =
            [ ( "id", Encode.int customer.id )
            , ( "name", Encode.string customer.name )
            ]
    in
        Encode.object attributes
