module CommonComponents.Spinner exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (Msg)


insertSpinner : Html Msg
insertSpinner =
    div []
        [ i [ class "fa fa-spinner fa-spin", style [ ( "font-size", "24px" ) ] ] []
        ]
