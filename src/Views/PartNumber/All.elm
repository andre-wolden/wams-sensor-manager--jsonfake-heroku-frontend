module Views.PartNumber.All exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import Views.PartNumber.Common exposing (..)
import Routing


viewAllPartNumbers : WebData PartNumbers -> Html Msg
viewAllPartNumbers partNumbers =
    case partNumbers of
        RemoteData.NotAsked ->
            text "Initialising..."

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Failure error ->
            text ("Failed to retrieve data. Error message: " ++ (toString error))

        RemoteData.Success partNumbers ->
            insertContent partNumbers


insertContent : PartNumbers -> Html Msg
insertContent partNumbers =
    div [ class "container" ]
        [ table [ class "table" ]
            [ thead []
                [ tr [ class "row" ]
                    [ th [ class "col" ] [ text "PartNumber" ]
                    ]
                ]
            , tbody [] (insertRows partNumbers)
            ]
        , a [ class "btn btn-success", href Routing.getPartNumberNewPath ] [ text "Add new partNumber" ]
        ]


insertRows : PartNumbers -> List (Html Msg)
insertRows partNumbers =
    (List.map
        (\p ->
            tr [ class "row" ]
                [ td [ class "col" ] [ text p.pn ]
                ]
        )
        partNumbers
    )



-- End
