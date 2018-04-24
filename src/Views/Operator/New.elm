module Views.Operator.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Routing


viewNewOperator : Model -> Html Msg
viewNewOperator model =
    div [ class "container" ]
        [ h3 [ class "row" ] [ text "New Operator" ]
        , div [ class "form-group", id "NewOperatorForm" ]
            [ input [ class "form-control", placeholder "name...", onInput OnInputNewOperator_Name ] []
            , a [ class "btn btn-danger", href Routing.getOperatorsPath ] [ text "Cancel" ]
            , button
                [ class "btn btn-primary"
                , onClick (SaveNewOperator model.new_operator)
                ]
                [ text "Add operator" ]
            , text (toString model.new_operator)
            ]
        ]
