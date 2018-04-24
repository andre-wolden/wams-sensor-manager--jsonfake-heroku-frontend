module Views.Sensor.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Db.DbModels exposing (Project)
import Db.DbModels exposing (..)
import Models exposing (..)
import RemoteData
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Form.Radio as Radio
import Routing
import CommonComponents.Spinner


viewNewSensorPage : Model -> Html Msg
viewNewSensorPage model =
    div [ class "container" ]
        [ h3 [ class "row" ] [ text "New Sensor" ]
        , div [ class "form-group", id "NewSensorForm" ]
            [ label [] [ text "Serial number:" ]
            , input [ class "form-control", placeholder "serial number...", onInput OnInputNewSensor_sn ] []

            -- Part Number
            , label [] [ text "Part Number:" ]
            , div []
                (case model.db.part_numbers of
                    RemoteData.NotAsked ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Loading ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Failure error ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Success part_numbers ->
                        Radio.radioList "radio_list_pn" (List.map funcPn part_numbers)
                )

            -- Sensor Type
            , label [] [ text "Sensor Type:" ]
            , div []
                (case model.db.sensor_types of
                    RemoteData.NotAsked ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Loading ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Failure error ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Success sensor_types ->
                        Radio.radioList "radio_list_sensor_type" (List.map funcType sensor_types)
                )

            -- Project
            , label [] [ text "Project" ]
            , div []
                (case model.db.projects of
                    RemoteData.NotAsked ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Loading ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Failure error ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Success projects ->
                        Radio.radioList "radio_list_project" (List.map funcProject projects)
                )
            , label [] [ text "Mounting Location" ]
            , div []
                (case model.db.mounting_locations of
                    RemoteData.NotAsked ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Loading ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Failure error ->
                        [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Success mounting_locations ->
                        Radio.radioList "radio_list_mounting_location" (List.map funcMl mounting_locations)
                )
            , p [] []
            , a [ class "btn btn-danger", href Routing.getIndexPath ] [ text "back" ]
            , button
                [ class "btn btn-primary"
                , onClick (SaveNewSensor model.new_sensor)
                ]
                [ text "Add partNumber" ]
            , text (toString model.new_sensor)
            ]
        ]


funcPn : PartNumber -> Radio.Radio Msg
funcPn part_number =
    Radio.create [ Radio.onClick (OnInputNewSensor_pn part_number.id) ] part_number.pn


funcType : SensorType -> Radio.Radio Msg
funcType sensor_type =
    Radio.create [ Radio.onClick (OnInputNewSensor_sensor_type sensor_type.id) ] sensor_type.description


funcProject : Project -> Radio.Radio Msg
funcProject project =
    Radio.create [ Radio.onClick (OnInputNewSensor_project project.id) ] project.name


funcMl : MountingLocation -> Radio.Radio Msg
funcMl mounting_location =
    Radio.create [ Radio.onClick (OnInputNewSensor_mounting_location mounting_location.id) ] mounting_location.description



-- "id": 1,
-- "sn": "SN001",
-- "pn": 1,
-- "sensor_type": 1,
-- "calibration_certificate": "doc_cc_sn001",
-- "project": 1,
-- "current_status": 1,
-- "mounting_location": 1
