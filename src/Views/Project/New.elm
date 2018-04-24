module Views.Project.New exposing (..)

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


viewNewProject : Model -> Html Msg
viewNewProject model =
    div [ class "container" ]
        [ h3 [ class "row" ] [ text "New Project" ]
        , div [ class "form-group", id "NewProjectForm" ]
            [ label [] [ text "Project name:" ]
            , input
                [ class "form-control"
                , placeholder "name..."
                , onInput OnInputNewProject_Name
                ]
                []
            , p [] []
            , label [] [ text "Select customer:" ]
            , div []
                (case model.db.customers of
                    RemoteData.NotAsked ->
                        [ text "Initialising..." ]

                    RemoteData.Loading ->
                        [ text "Loading..." ]

                    RemoteData.Failure error ->
                        [ text ("Failed to retrieve data. Error message: " ++ (toString error)) ]

                    RemoteData.Success customers ->
                        Radio.radioList "myradios" (List.map func customers)
                )
            , p [] []
            , a [ class "btn btn-danger", href Routing.getProjectsPath ] [ text "back" ]
            , button
                [ class "btn btn-primary"
                , onClick (SaveNewProject model.new_project)
                ]
                [ text "Add project" ]
            , text (toString model.new_project)
            ]
        ]


func : Customer -> Radio.Radio Msg
func customer =
    Radio.create [ Radio.onClick (OnInputNewProject_CustomerId customer.id) ] customer.name



-- END
