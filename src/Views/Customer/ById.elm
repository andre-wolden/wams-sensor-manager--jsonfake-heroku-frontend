module Views.Customer.ById exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)
import RemoteData exposing (WebData)
import Views.Customer.Common exposing (..)


viewCustomerById : WebData Customers -> String -> Html Msg
viewCustomerById customers customerIdString =
    case customers of
        RemoteData.NotAsked ->
            text "Initialising"

        RemoteData.Loading ->
            text "Loading"

        RemoteData.Failure error ->
            text ("Error: " ++ toString error)

        RemoteData.Success customers ->
            let
                customerId =
                    String.toInt customerIdString
            in
                case customerId of
                    Ok id ->
                        let
                            maybeCustomer =
                                customers
                                    |> List.filter (\customer -> customer.id == id)
                                    |> List.head
                        in
                            case maybeCustomer of
                                Just customer ->
                                    viewCustomer customer

                                Nothing ->
                                    text "No customer with this ID number"

                    Err error ->
                        text "error"
