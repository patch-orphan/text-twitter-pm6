use v6;

class Text::Twitter::Extractor::Entity {
    enum Type <Url Hashtag Mention Cashtag>;

    has Int $.start;
    has Int $.end;
    has Str $.value;
    has Str $.list-slug;  # used to store the list portion of @mention/list
    has Type $.type;

    has Str $.display-url;
    has Str $.expanded-url;
}