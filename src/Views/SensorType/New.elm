module Views.SensorType.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (SensorType)
import Db.DbModels exposing (..)
import Models exposing (..)
import RemoteData
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Form.Radio as Radio
import Routing


viewNewSensorType : Model -> Html Msg
viewNewSensorType model =
    div [ class "container" ]
        [ h3 [] [ text "Register new sensor type" ]
        , div [ class "form-group", id "NewMountingLocationForm" ]
            [ input [ class "form-control", placeholder "mounting location ..." ] []
            , a [ class "btn btn-danger", href Routing.getSensorTypesPath ] [ text "Cancel" ]
            , button [ class "btn btn-primary" ] [ text "Register sensor type" ]

            -- , text (toString model.new_operator)
            ]
        ]
