module Views.SensorType.All exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import CommonComponents.ErrorSymbol
import CommonComponents.Spinner
import Routing


viewAllSensorTypes : WebData SensorTypes -> Html Msg
viewAllSensorTypes sensorTypes =
    case sensorTypes of
        RemoteData.NotAsked ->
            CommonComponents.Spinner.insertSpinner

        RemoteData.Loading ->
            CommonComponents.Spinner.insertSpinner

        RemoteData.Failure error ->
            CommonComponents.Spinner.insertSpinner

        RemoteData.Success sensor_types ->
            getSensorTypesTable sensor_types


getSensorTypesTable : SensorTypes -> Html Msg
getSensorTypesTable sensorTypes =
    div [ class "container" ]
        [ table [ class "table" ]
            [ thead []
                [ tr [ class "row" ]
                    [ th [ class "col" ] [ text "SensorType" ]
                    ]
                ]
            , tbody [] (insertRows sensorTypes)
            ]
        , a [ class "btn btn-success", href Routing.getSensorTypesNewPath ] [ text "Add new sensorType" ]
        ]


insertRows : SensorTypes -> List (Html Msg)
insertRows sensorTypes =
    (List.map
        (\p ->
            tr [ class "row" ]
                [ td [ class "col" ] [ text p.description ]
                ]
        )
        sensorTypes
    )



-- End
