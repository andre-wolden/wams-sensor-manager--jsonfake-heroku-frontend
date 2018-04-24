module Views.MountingLocation.All exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import CommonComponents.ErrorSymbol
import CommonComponents.Spinner
import Routing
import Models exposing (Model)


viewMountingLocationAll : Model -> Html Msg
viewMountingLocationAll model =
    let
        webdata_mounting_locations =
            model.db.mounting_locations
    in
        case webdata_mounting_locations of
            RemoteData.NotAsked ->
                CommonComponents.Spinner.insertSpinner

            RemoteData.Loading ->
                CommonComponents.Spinner.insertSpinner

            RemoteData.Failure err ->
                CommonComponents.Spinner.insertSpinner

            RemoteData.Success mounting_locations ->
                getMountingLocationTable mounting_locations


getMountingLocationTable : MountingLocations -> Html Msg
getMountingLocationTable mountingLocations =
    div [ class "container" ]
        [ table [ class "table" ]
            [ thead []
                [ tr [ class "row" ]
                    [ th [ class "col" ] [ text "Mounting Locations" ]
                    ]
                ]
            , tbody [] (insertRows mountingLocations)
            ]
        , a [ class "btn btn-success", href Routing.getMountingLocationsNewPath ] [ text "Register new" ]
        ]


insertRows : MountingLocations -> List (Html Msg)
insertRows sensorTypes =
    (List.map
        (\p ->
            tr [ class "row" ]
                [ td [ class "col" ] [ text p.description ]
                ]
        )
        sensorTypes
    )
