module Views.PartNumber.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Routing


viewNewPartNumber : Model -> Html Msg
viewNewPartNumber model =
    div [ class "container" ]
        [ h3 [ class "row" ] [ text "New PartNumber" ]
        , div [ class "form-group", id "NewPartNumberForm" ]
            [ label [] [ text "Part Number:" ]
            , input [ class "form-control", placeholder "name...", onInput OnInputNewPartNumber_PartNumber ] []
            , label [] [ text "Calibration Procedure Document Number:" ]
            , input [ class "form-control", placeholder "calibration procedure ...", onInput OnInputNewPartNumber_CalibrationProcedure ] []
            , p [] []
            , a [ class "btn btn-danger", href Routing.getPartNumberPath ] [ text "back" ]
            , button
                [ class "btn btn-primary"
                , onClick (SaveNewPartNumber model.new_part_number)
                ]
                [ text "Add partNumber" ]
            , text (toString model.new_part_number)
            ]
        ]
