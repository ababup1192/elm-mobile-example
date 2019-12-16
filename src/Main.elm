module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (attribute, class, type_, value)
import Html.Events exposing (onClick, onInput)
import Set as Set
import Svg as Svg
import Svg.Attributes as SvgAttr


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { searchWord : String
    , historyWords : List String
    , hintWords : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { searchWord = ""
      , historyWords = []
      , hintWords = [ "elm guide", "elm package", "elm-spa", "elm-jp", "google", "amazon", "apple" ] ++ someWords
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateSearchWord String
    | DeleteHistory String
    | SaveHistory String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSearchWord searchWord ->
            ( { model | searchWord = searchWord }, Cmd.none )

        SaveHistory historyWord ->
            ( { model | historyWords = historyWord :: model.historyWords }, Cmd.none )

        DeleteHistory historyWord ->
            ( { model | historyWords = List.filter (not << (==) historyWord) model.historyWords }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ searchView model.searchWord
        , searchSuggestions model
        ]


searchView : String -> Html Msg
searchView searchWord =
    div [ class "search" ]
        [ button [ class "Cdl0yb", type_ "button" ]
            [ div []
                [ span []
                    [ Svg.svg [ attribute "focusable" "false", SvgAttr.viewBox "0 0 24 24", attribute "xmlns" "http://www.w3.org/2000/svg" ]
                        [ Svg.path [ SvgAttr.d "M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z" ]
                            []
                        ]
                    ]
                ]
            ]
        , div [ class "SDkEP" ]
            [ div [ class "a4bIc" ]
                [ input [ value searchWord, onInput UpdateSearchWord, attribute "autocapitalize" "off", attribute "autocomplete" "off", class "gLFyf", attribute "maxlength" "2048", type_ "search" ]
                    []
                ]
            ]
        , button [ class "Tg7LZd", onClick <| SaveHistory searchWord ]
            [ div [ class "gBCQ5d" ]
                [ span [ class "z1asCe" ]
                    [ Svg.svg [ attribute "focusable" "false", SvgAttr.viewBox "0 0 24 24", attribute "xmlns" "http://www.w3.org/2000/svg" ]
                        [ Svg.path [ SvgAttr.d "M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" ]
                            []
                        ]
                    ]
                ]
            ]
        ]


searchSuggestions : Model -> Html Msg
searchSuggestions model =
    let
        { searchWord } =
            model
    in
    div [ class "UUbT9" ]
        [ ul [ class "aajZCb" ]
            (let
                historySuggestions =
                    model.historyWords
                        |> List.filter (String.startsWith searchWord)
                        |> List.take
                            limitSuggestion
                        |> List.map
                            (historySuggestion searchWord)

                hintSuggestions =
                    Set.diff (Set.fromList model.hintWords) (Set.fromList model.historyWords)
                        |> Set.toList
                        |> List.filter (String.startsWith searchWord)
                        |> List.map (hintSuggestion searchWord)
             in
             if String.isEmpty searchWord then
                historySuggestions

             else
                historySuggestions ++ List.take (limitSuggestion - List.length historySuggestions) hintSuggestions
            )
        ]


historySuggestion : String -> String -> Html Msg
historySuggestion searchWord suggestion =
    li [ class "sbct" ]
        [ div [ class "sbic sb42" ]
            []
        , div [ class "sbtc" ]
            [ div [ class "sbl1" ]
                [ span []
                    [ text searchWord
                    , b []
                        [ text <| dropLeftSuggestion searchWord suggestion ]
                    ]
                ]
            ]
        , div [ class "sbei" ]
            []
        , div [ class "sbab", onClick <| DeleteHistory suggestion ]
            [ span [ class "sbqa" ]
                [ text "x" ]
            ]
        ]


hintSuggestion : String -> String -> Html Msg
hintSuggestion searchWord suggestion =
    li [ class "sbct" ]
        [ div [ class "sbic sb43", onClick <| SaveHistory suggestion ]
            []
        , div [ class "sbtc", onClick <| SaveHistory suggestion ]
            [ div [ class "sbl1" ]
                [ span []
                    [ text searchWord
                    , b []
                        [ text <| dropLeftSuggestion searchWord suggestion ]
                    ]
                ]
            ]
        , div [ class "sbei" ]
            []
        , div [ class "sbab", onClick <| UpdateSearchWord suggestion ]
            [ div [ class "sbqb" ]
                []
            ]
        ]


dropLeftSuggestion : String -> String -> String
dropLeftSuggestion searchWord suggestion =
    String.dropLeft (String.length searchWord) suggestion


limitSuggestion : Int
limitSuggestion =
    8


someWords : List String
someWords =
    [ "able", "about", "according to", "account", "acid", "across", "act", "addition", "adjustment", "advertisement", "after", "again", "against", "agreement", "air", "all", "almost", "already", "also", "among", "amount", "amusement", "and", "angle", "angry", "animal", "answer", "ant", "any", "apple", "approval", "arch", "argument", "arm", "army", "around", "art", "as", "at", "attack", "attempt", "attention", "attraction", "authority", "automatic", "awake", "baby", "back", "bad", "bag", "balance", "ball", "band", "base", "basin", "basket", "bath", "be", "beautiful", "because", "bed", "bee", "before", "behaviour", "belief", "bell", "bent", "berry", "between", "bird", "birth", "bit", "bite", "bitter", "black", "blade", "blood", "blow", "blue", "board", "boat", "body", "boiling", "bone", "book", "boot", "bottle", "box", "boy", "brain", "brake", "branch", "breath", "brick", "bridge", "bright", "broken", "brother", "brown", "brush", "bucket", "building", "bulb", "burn", "burst", "business", "but", "button", "by", "cake", "camera", "card", "care", "carriage", "cart", "cat", "cause", "certain", "chain", "chance", "change", "cheap", "cheese", "chemical", "chest", "chief", "chin", "church", "circle", "clean", "clear", "clock", "cloth", "cloud", "coat", "cold", "collar", "color", "comb", "come", "comfort", "committee", "common", "company", "comparison", "competition", "complete", "complex", "condition", "connection", "conscious", "control", "cook", "copper", "copy", "cord", "cotton", "cough", "country", "cover", "cow", "crack", "credit", "crime", "cruel", "crush", "cry", "cultivate", "cup", "current", "curtain", "curve", "cushion", "cut", "damage", "danger", "dark", "data", "daughter", "day", "dead", "dear", "death", "debt", "decision", "deep", "degree", "dependent", "design", "desire", "destruction", "detail", "development", "different", "direction", "dirty", "discovery", "discussion", "disease", "disgust", "distance", "distribution", "division", "do", "dog", "door", "doubt", "down", "drain", "drawer", "dress", "drink", "driving", "drop", "dry", "dust", "ear", "early", "earth", "east", "economic", "edge", "education", "effect", "egg", "elastic", "electric", "end", "engine", "enough", "equal", "error", "even", "event", "ever", "every", "example", "exchange", "existence", "expansion", "experience", "expert", "eye", "face", "fact", "fall", "family", "far", "farm", "fat", "father", "fear", "feather", "feeble", "feeling", "female", "fertile", "fiction", "field", "fight", "financial", "finger", "fire", "first", "fish", "fixed", "flag", "flame", "flat", "flight", "floor", "flower", "fly", "fold", "food", "foolish", "foot", "for", "force", "fork", "form", "forward", "fowl", "frame", "free", "frequent", "friend", "from", "front", "fruit", "full", "future" ] ++ [ "garden", "general", "get", "girl", "give", "glass", "glove", "go", "goat", "gold", "good", "government", "grain", "grass", "gray", "great", "green", "grip", "group", "growth", "guide", "gun", "hair", "hammer", "hand", "hanging", "happy", "harbor", "hard", "harmony", "hat", "hate", "have", "head", "healthy", "hearing", "heart", "heat", "help", "here", "high", "history", "hole", "hollow", "hook", "hope", "horn", "horse", "hospital", "hour", "house", "how", "humor", "ice", "idea", "if", "ill", "important", "impulse", "in", "increase", "industry", "information", "ink", "insect", "instrument", "insurance", "interest", "international", "into", "invention", "iron", "island", "jelly", "jewel", "join", "journey", "judge", "jump", "keep", "kettle", "key", "kick", "kind", "kiss", "knee", "knife", "knot", "knowledge", "land", "language", "last", "late", "laugh", "law", "lead", "leaf", "learning", "left", "leg", "let", "letter", "level", "library", "lift", "light", "like", "limit", "line", "lip", "liquid", "list", "little", "living", "lock", "long", "look", "loose", "loss", "loud", "love", "low", "machine", "make", "male", "man", "manager", "map", "mark", "market", "married", "mass", "match", "material", "may", "meal", "measure", "meat", "medical", "meeting", "memory", "metal", "middle", "military", "milk", "mind", "mine", "minute", "mist", "mixed", "mobile", "money", "monkey", "month", "moon", "morning", "mother", "motion", "mountain", "mouth", "move", "much", "muscle", "music", "nail", "name", "narrow", "nation", "natural", "near", "necessary", "neck", "need", "needle", "nerve", "net", "new", "news", "night", "no", "noise", "normal", "north", "nose", "note", "now", "number", "nuts", "observation", "of", "off", "offer", "office", "oil", "old", "on", "only", "open", "operation", "opinion", "opposite", "or", "orange", "order", "organization", "ornament", "other", "out", "oven", "over", "owner", "page", "pain", "paint", "paper", "parallel", "parcel", "part", "past", "paste", "payment", "peace", "pen", "pencil", "person", "physical", "picture", "pig", "pin", "pipe", "place", "plane", "plant", "plate", "play", "please", "pleasure", "pocket", "point", "poison", "polish", "political", "poor", "porter", "position", "possible", "pot", "potato", "powder", "power", "present", "president", "price", "print", "prison", "private", "probable", "process", "produce", "profit", "property", "prose", "protest", "public", "pull", "pump", "punishment", "purpose", "push", "put", "quality", "question", "quick", "quiet", "quite", "rail", "rain", "range", "rat", "rate", "ray", "reaction", "reading", "ready", "reason", "receipt", "record", "red", "regret", "regular", "relation", "religion", "representative", "request", "respect", "responsible", "rest", "reward", "rhythm", "rice", "right", "ring", "river", "road", "rod", "roll", "roof", "room", "root", "rough", "round", "rub", "rule", "run", "sad", "safe", "sail", "salt", "same", "sand", "say", "scale", "school", "science", "scissors", "screw", "sea", "seat", "second", "secret", "secretary", "see", "seed", "seem", "selection", "self", "send", "sense", "separate", "serious", "servant", "sex", "shade", "shake", "shame", "sharp", "sheep", "shelf", "ship", "shirt", "shock", "shoe", "short", "shut", "side", "sign", "silk", "silver", "simple", "sister", "size", "skin", "skirt", "sky", "sleep", "slip", "slope", "slow", "small", "smash", "smell", "smile", "smoke", "smooth", "snake", "sneeze", "snow", "so", "soap", "social", "society", "sock", "soft", "solid", "some", "son", "song", "sort", "sound", "soup", "south", "space", "spade", "special", "sponge", "spoon", "spring", "square", "stage", "stamp", "star", "start", "statement", "station", "steam", "steel", "stem", "step", "stick", "sticky", "stiff", "still", "stitch", "stocking", "stomach", "stone", "stop", "store", "story", "straight", "strange", "street", "stretch", "strong", "structure", "substance", "such", "sudden", "sugar", "suggestion", "summer", "sun", "support", "surprise", "sweet", "swim", "system", "table", "tail", "take", "talk", "tall", "taste", "tax", "teaching", "tendency", "test", "than", "then", "theory", "there", "thick", "thin", "thing", "though", "thought", "thread", "throat", "through", "thumb", "thunder", "ticket", "tight", "till", "time", "tin", "tired", "to", "together", "tomorrow", "tongue", "tooth", "top", "touch", "town", "trade", "train", "transport", "tray", "tree", "trick", "trouble", "trousers", "turn", "twist", "umbrella", "under", "unit", "up", "use", "value", "verse", "very", "vessel", "view", "violent", "voice", "waiting", "walk", "wall", "war", "warm", "wash", "waste", "watch", "water", "wave", "wax", "way", "weather", "week", "weight", "well", "west", "wet", "wheel", "when", "where", "while", "whip", "whistle", "white", "why", "wide", "will", "wind", "window", "wine", "wing", "winter", "wire", "wise", "with", "woman", "wood", "wool", "word", "work", "world", "worm", "wound", "writing", "wrong", "year", "yellow", "yes", "yesterday", "young" ]
