module Views.Operator.ById exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)
import RemoteData exposing (WebData)
import Views.Operator.Common exposing (..)


viewOperatorById : WebData Operators -> String -> Html Msg
viewOperatorById operators operatorIdString =
    case operators of
        RemoteData.NotAsked ->
            text "Initialising"

        RemoteData.Loading ->
            text "Loading"

        RemoteData.Failure error ->
            text ("Error: " ++ toString error)

        RemoteData.Success operators ->
            let
                operatorId =
                    String.toInt operatorIdString
            in
                case operatorId of
                    Ok id ->
                        let
                            maybeOperator =
                                operators
                                    |> List.filter (\operator -> operator.id == id)
                                    |> List.head
                        in
                            case maybeOperator of
                                Just operator ->
                                    viewOperator operator

                                Nothing ->
                                    text "No operator with this ID number"

                    Err error ->
                        text "error"
