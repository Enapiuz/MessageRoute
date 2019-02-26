module Main exposing (main)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Browser
import Html exposing (..)
import Html.Attributes exposing (checked, style, type_, value)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Subscription =
    String


type alias Subscriptions =
    List Subscription


type alias Model =
    { userEmail : String
    , subscriptions : Subscriptions
    }


init : Model
init =
    { userEmail = "test@example.com"
    , subscriptions = [ "one", "two" ]
    }


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newText ->
            { model | userEmail = newText }


renderSubscriptions : Subscriptions -> Html Msg
renderSubscriptions subscriptions =
    subscriptions
        |> List.map
            (\s ->
                li []
                    [ label []
                        [ input [ type_ "checkbox" ] []
                        , span
                            [ style "margin-left" "4px"
                            , value s
                            ]
                            [ text s
                            ]
                        ]
                    ]
            )
        |> ul [ style "list-style-type" "none" ]


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ h1 [] [ text "User config" ]
                , h5 [ onClick (Change "test-test@example.com") ] [ text model.userEmail ]
                , renderSubscriptions model.subscriptions
                ]
            ]
        ]
