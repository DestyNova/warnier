module Main exposing (Model, Msg(..), update, view)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes as Attributes
import Bulma.Classes as Bulma


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    Int



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0
    , Cmd.none
    )



-- UPDATE


type Msg
    = Nop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( 0, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ Attributes.class Bulma.columns ]
        [ div
            [ Attributes.class Bulma.column ]
            [ text "Controls..." ]
        , div
            [ Attributes.class Bulma.column ]
            [ text "Diagram" ]
        ]
