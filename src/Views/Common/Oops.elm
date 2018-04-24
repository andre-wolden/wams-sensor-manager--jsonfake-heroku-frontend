module Views.Common.Oops exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Messages exposing (..)


viewOops : Html Msg
viewOops =
    div []
        [ text "Oops.  Something went wrong ..."
        , i [ class "fa fa-refresh fa-spinn" ] []
        ]
