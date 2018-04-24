module Views.Customer.New exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Routing


viewNewCustomer : Model -> Html Msg
viewNewCustomer model =
    div [ class "container" ]
        [ h3 [ class "row" ] [ text "New Customer" ]
        , div [ class "form-group", id "NewCustomerForm" ]
            [ label [] [ text "Project name:" ]
            , input [ class "form-control", placeholder "name...", onInput OnInputNewCustomer_Name ] []
            , p [] []
            , a [ class "btn btn-danger", href Routing.getCustomersPath ] [ text "back" ]
            , button
                [ class "btn btn-primary"
                , onClick (SaveNewCustomer model.new_customer)
                ]
                [ text "Add customer" ]
            , text (toString model.new_customer)
            ]
        ]
