module Views.Operator.All exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import Views.Operator.Common exposing (..)
import Html.Attributes exposing (..)
import CommonComponents.Spinner as Spinner
import Routing


viewAllOperators : WebData Operators -> Html Msg
viewAllOperators operators =
    case operators of
        RemoteData.NotAsked ->
            Spinner.insertSpinner

        RemoteData.Loading ->
            text "Loading operator data"

        RemoteData.Failure error ->
            text ("Failed to retrieve operator data. Error message: " ++ (toString error))

        RemoteData.Success operators ->
            insertContent operators


insertContent : Operators -> Html Msg
insertContent operators =
    div [ class "container" ]
        [ table [ class "table" ]
            [ thead []
                [ tr [ class "row" ]
                    [ th [ class "col" ] [ text "Operator" ]
                    ]
                ]
            , tbody [] (insertRows operators)
            ]
        , a [ class "btn btn-success", href Routing.getOperatorNewPath ] [ text "Add new customer" ]
        ]


insertRows : Customers -> List (Html Msg)
insertRows customers =
    (List.map
        (\p ->
            tr [ class "row" ]
                [ td [ class "col" ] [ text p.name ]
                ]
        )
        customers
    )
