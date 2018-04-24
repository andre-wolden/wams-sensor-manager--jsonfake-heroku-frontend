module Main exposing (main)

import Navigation exposing (..)
import View exposing (view)
import Models exposing (Model, initialModel, Route)
import Update exposing (update)
import Messages exposing (Msg)
import Routing exposing (parseLocation)
import Commands


init : Location -> ( Model, Cmd Msg )
init location =
    ( initialModel (parseLocation location)
    , Cmd.batch
        [ Commands.fetchSensorsData
        , Commands.fetchPartNumbersData
        , Commands.fetchSensorTypesData
        , Commands.fetchProjectsData
        , Commands.fetchCustomersData
        , Commands.fetchStatusCodesData
        , Commands.fetchMountingLocationsData
        , Commands.fetchOperatorsData
        , Commands.fetchStatusLogData
        ]
    )


main : Program Never Model Msg
main =
    Navigation.program Messages.OnLocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
