module Views.MountingLocation.New exposing (..)

import Db.DbModels exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import RemoteData exposing (WebData)
import CommonComponents.ErrorSymbol
import CommonComponents.Spinner
import Routing
import Models exposing (..)


viewMountingLocationNewForm : Model -> Html Msg
viewMountingLocationNewForm model =
    div [ class "container" ]
        [ h3 [] [ text "Register new mounting location option" ]
        , div [ class "form-group" ]
            [ label [] [ text "description" ]
            , input [ class "form-control", onInput OnInputMountingLocation, placeholder model.new_mounting_location.description ] []
            , a [ class "btn btn-danger", href Routing.getMountingLocationsPath ] [ text "back" ]
            , button [ class "btn btn-success", onClick (SaveMountingLocation model.new_mounting_location) ] [ text "Save" ]
            ]
        ]
