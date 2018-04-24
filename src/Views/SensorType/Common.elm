module Views.SensorType.Common exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (..)


viewSensorType : SensorType -> Html Msg
viewSensorType sensorType =
    div []
        [ text ("SensorType name: " ++ sensorType.name)
        ]
