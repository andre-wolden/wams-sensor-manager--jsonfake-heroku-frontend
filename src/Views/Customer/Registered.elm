module Views.Customer.Registered exposing (..)

import Html exposing (..)
import Messages exposing (..)
import Models exposing (..)


viewRegistered : Model -> Html Msg
viewRegistered model =
    div [] [ text "New customer registered successfully" ]
