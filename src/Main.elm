module Main exposing (Model, Msg(..), update, view)

import Browser
import Bulma.Classes as Bulma
import Html exposing (Html, div, li, text, ul)
import Html.Attributes as Attributes exposing (class)


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { title : String, data : Tree }


type Tree
    = Tree (List TreeNode)


type TreeNode
    = SingleNode Node
    | XorGroup (List Node)


type Node
    = Node String Tree



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( { title = "Warnier diagrams"
      , data =
            Tree
                [ SingleNode <| Node "Toggle conditional" (Tree [ SingleNode <| Node "Is conditional?" (Tree []) ])
                , SingleNode <| Node "Other thing"
                    (Tree
                        [ XorGroup
                            [ Node "Do other thing" (Tree [])
                            , Node "Do one more thing" (Tree [])
                            ]
                        ]
                    )
                ]
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Nop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    init ()



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
            [ showTree model.data ]
        ]


showTree : Tree -> Html Msg
showTree (Tree groups) =
    case groups of
        [] ->
            div [] []

        _ ->
            div [ class "tree inline-block" ] (List.concat <| List.map showGroup groups)


showGroup : TreeNode -> List (Html Msg)
showGroup node =
    case node of

        XorGroup nodes ->
            [ div [ class "xor-group" ] (List.map showNode nodes) ]

        SingleNode n ->
            [ showNode n ]

showNode : Node -> Html Msg
showNode (Node s t) =
    ul [] [ li [] [ text s, showTree t ] ]
