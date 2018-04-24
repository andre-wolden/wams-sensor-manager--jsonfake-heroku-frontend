module Views.Sensor.All exposing (..)

import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)
import CommonComponents.Spinner
import RemoteData
import Db.DbModels exposing (..)
import Views.Sensor.SvgStuff as SS
import StatusCodes.StatusCodes as SC
import Routing


insertSensorTable : Model -> Html Msg
insertSensorTable model =
    let
        sensors =
            model.db.sensors

        partNumbers =
            model.db.part_numbers

        types =
            model.db.sensor_types

        projects =
            model.db.projects

        statuses =
            SC.statusCodes
    in
        case sensors of
            RemoteData.NotAsked ->
                div [] [ CommonComponents.Spinner.insertSpinner ]

            RemoteData.Loading ->
                div [] [ CommonComponents.Spinner.insertSpinner ]

            RemoteData.Failure error ->
                div [] [ CommonComponents.Spinner.insertSpinner ]

            RemoteData.Success sensors ->
                case partNumbers of
                    RemoteData.NotAsked ->
                        div [] [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Loading ->
                        div [] [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Failure error ->
                        div [] [ CommonComponents.Spinner.insertSpinner ]

                    RemoteData.Success partNumbers ->
                        case types of
                            RemoteData.NotAsked ->
                                div [] [ CommonComponents.Spinner.insertSpinner ]

                            RemoteData.Loading ->
                                div [] [ CommonComponents.Spinner.insertSpinner ]

                            RemoteData.Failure error ->
                                div [] [ CommonComponents.Spinner.insertSpinner ]

                            RemoteData.Success types ->
                                case projects of
                                    RemoteData.NotAsked ->
                                        div [] [ CommonComponents.Spinner.insertSpinner ]

                                    RemoteData.Loading ->
                                        div [] [ CommonComponents.Spinner.insertSpinner ]

                                    RemoteData.Failure error ->
                                        div [] [ CommonComponents.Spinner.insertSpinner ]

                                    RemoteData.Success projects ->
                                        createTable
                                            sensors
                                            partNumbers
                                            types
                                            projects
                                            statuses
                                            model


createTable : Sensors -> PartNumbers -> SensorTypes -> Projects -> List SC.StatusCode -> Model -> Html Msg
createTable sensors partNumbers types projects statuses model =
    div []
        (List.append
            (List.append
                [ div [ class "row tableHeader" ]
                    [ div [ class "col" ] [ text "SN" ]
                    , div [ class "col" ] [ text "PN" ]
                    , div [ class "col" ] [ text "Type" ]
                    , div [ class "col" ] [ text "Certificate" ]
                    , div [ class "col" ] [ text "Project" ]
                    , div [ class "col" ] [ text "Status" ]
                    , div [ class "col" ] []
                    ]
                ]
                (List.map
                    (\sensor ->
                        let
                            w_class_name =
                                if sensor.id == model.expandedRow then
                                    "w_show"
                                else
                                    "w_hidden"

                            w_sign =
                                if sensor.id == model.expandedRow then
                                    "fa fa-minus"
                                else
                                    "fa fa-plus"

                            w_finished =
                                if sensor.current_status == 8 then
                                    "w_background_color_green"
                                else if sensor.current_status == 7 then
                                    "w_background_color_orange"
                                else
                                    "w_background_color_red"

                            status_codes =
                                SC.statusCodes

                            status_code_id =
                                sensor.current_status
                        in
                            div []
                                [ div [ class "row expandableRow", class w_finished, onClick (ExpandRow sensor.id) ]
                                    [ div [ class "col" ] [ text sensor.sn ]
                                    , div [ class "col" ]
                                        (List.map
                                            (\pn ->
                                                if pn.id == sensor.pn then
                                                    text pn.pn
                                                else
                                                    text ""
                                            )
                                            partNumbers
                                        )
                                    , div [ class "col" ]
                                        (List.map
                                            (\typee ->
                                                if typee.id == sensor.sensor_type then
                                                    text typee.description
                                                else
                                                    text ""
                                            )
                                            types
                                        )
                                    , div [ class "col" ] [ text sensor.calibration_certificate ]
                                    , div [ class "col" ]
                                        (List.map
                                            (\project ->
                                                if project.id == sensor.project then
                                                    text project.name
                                                else
                                                    text ""
                                            )
                                            projects
                                        )
                                    , div [ class "col" ]
                                        (List.map
                                            (\status ->
                                                if status.id == sensor.current_status then
                                                    text status.status_description
                                                else
                                                    text ""
                                            )
                                            statuses
                                        )
                                    , i [ class "col", class w_sign ] []
                                    ]
                                , div [ class "row dropDownInfoBox", class w_class_name ]
                                    [ SS.insertStatusDrawing model w_class_name sensor
                                    , div [ class "jumbotronMaster" ]
                                        [ div [ class "jumbotron infoCard" ]
                                            [ div
                                                []
                                                (List.append
                                                    [ h4 [] [ text "Update Status" ]
                                                    , button [ class "btn btn-danger", onClick (DecrementSensorStatus sensor) ] [ text "Back" ]
                                                    , p [] []
                                                    , button [ class "btn btn-success", onClick (IncrementSensorStatus sensor) ] [ text "Done!" ]
                                                    , p [ class "row" ] [ text "Next on the TODO list: " ]
                                                    ]
                                                    (List.map
                                                        (\status_code ->
                                                            if status_code.id == status_code_id then
                                                                p [] [ text status_code.next_todo ]
                                                            else
                                                                p [] [ text "" ]
                                                        )
                                                        status_codes
                                                    )
                                                )
                                            ]
                                        ]
                                    , div [ class "jumbotron infoCard" ] (insertCalibrationCertificateForm sensor)
                                    ]
                                ]
                    )
                    sensors
                )
            )
            [ p [] []
            , a [ class "btn btn-success", href Routing.getNewSensorPath ] [ text "Add new sensor" ]
            ]
        )


insertCalibrationCertificateForm : Sensor -> List (Html Msg)
insertCalibrationCertificateForm sensor =
    if sensor.current_status == 6 then
        [ h4 [] [ text "Calibration Certificate" ]
        , label [] [ text "Document number:" ]
        , input [ class "form-control", placeholder sensor.calibration_certificate, onInput OnInputCalibrationCertificateName ] []
        , button [ class "btn btn-success", onClick (SaveCalibrationCertificate sensor) ] [ text "Save" ]
        ]
    else
        []



-- END
