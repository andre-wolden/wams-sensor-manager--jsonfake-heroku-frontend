module Commands.SensorCommands exposing (..)

import Db.DbModels exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Commands exposing (sensorDecoder)
import Messages exposing (Msg)


saveSensor : Sensor -> Cmd Msg
saveSensor sensor =
    request sensor
        |> Http.send Messages.OnSensorSaved


request : Sensor -> Http.Request Sensor
request sensor =
    Http.request
        { body = sensorEncoder sensor |> Http.jsonBody
        , expect = Http.expectJson sensorDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = "http://localhost:4001/sensors"
        , withCredentials = False
        }


sensorEncoder : Sensor -> Encode.Value
sensorEncoder sensor =
    let
        attributes =
            [ ( "id", Encode.int sensor.id )
            , ( "sn", Encode.string sensor.sn )
            , ( "pn", Encode.int sensor.pn )
            , ( "sensor_type", Encode.int sensor.sensor_type )
            , ( "calibration_certificate", Encode.string sensor.calibration_certificate )
            , ( "project", Encode.int sensor.project )
            , ( "current_status", Encode.int sensor.current_status )
            , ( "mounting_location", Encode.int sensor.mounting_location )
            ]
    in
        Encode.object attributes


updateSensor : Sensor -> Cmd Msg
updateSensor sensor =
    update sensor
        |> Http.send Messages.OnSensorUpdated


update : Sensor -> Http.Request Sensor
update sensor =
    Http.request
        { body = sensorEncoder sensor |> Http.jsonBody
        , expect = Http.expectJson sensorDecoder
        , headers = []
        , method = "PUT"
        , timeout = Nothing
        , url = "http://localhost:4001/sensors" ++ "/" ++ (toString sensor.id)
        , withCredentials = False
        }



-- End
