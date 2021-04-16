module Page exposing (footers, layout, main, markdown, navbar)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes exposing (alt, attribute, class, href, src)
import List exposing (append)
import Markdown


markdown : String -> Html Never
markdown s =
    let
        mdOptions : Markdown.Options
        mdOptions =
            { defaultHighlighting = Just "elm"
            , githubFlavored = Just { tables = False, breaks = False }
            , sanitize = False
            , smartypants = True
            }
    in
    Markdown.toHtmlWith mdOptions [ attribute "class" "markdown" ] s


navbar : List (Html Never)
navbar =
    [ header [ class "navbar navbar-expand-md navbar-dark bd-navbar" ]
        [ nav [ class "container-xxl flex-wrap flex-md-nowrap" ]
            [ a [ class "navbar-brand p-0 me-2", href "/" ]
                [ img
                    [ alt "Gemonicko Art"
                    , src "img/gemonickoLogo.svg"
                    , attribute "height" "70"
                    ]
                    []
                ]
            , ul [ class "navbar-nav me-2 mb-2 mb-lg-0" ]
                [ li [ class "nav-item" ]
                    [ a [ class "nav-link", href "/posts" ]
                        [ text "Posts" ]
                    ]
                , li [ class "nav-item" ]
                    [ a [ class "nav-link", href "/about" ]
                        [ text "About" ]
                    ]
                , li [ class "nav-item" ]
                    [ a [ class "nav-link", href "/contact" ]
                        [ text "Contact" ]
                    ]
                ]
            ]
        ]
    ]


footers : Html Never
footers =
    footer [ class "bd-footer p-3 p-md-5 mt-5 bg-light text-center text-sm-start" ]
        [ div [ class "container-xxl navbar" ]
            [ img
                [ alt "Gemonicko Art"
                , src "img/gemonickoLogo.svg"
                , attribute "width" "100"
                ]
                []
            , div [ class "link" ]
                [ ul [ class "bd-footer-links ps-0 mb-3" ]
                    [ li [ class "d-inline-block" ] [ text "first" ]
                    , li [ class "d-inline-block ms-3" ] [ text "second" ]
                    , li [ class "d-inline-block ms-3" ] [ text "some" ]
                    , li [ class "d-inline-block ms-3" ] [ button [ class "btn btn-bd-primary" ] [ text "more" ] ]
                    ]
                ]
            ]
        ]


layout : String -> List (Html Never) -> List (Html Never)
layout title contentItems =
    navbar
        ++ [ div [ class "container-xxl my-md-4 bd-layout" ]
                [ main_ [ class "bd-main order-1" ]
                    [ div [ class "bd-intro ps-lg-4" ]
                        (append [ h2 [] [ text title ] ] contentItems)
                    ]
                ]
           , footers
           , Elmstatic.stylesheet "styles.css"
           , script
                "//cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
           ]


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePage <|
        \content ->
            Ok <| layout content.title [ markdown content.content ]
