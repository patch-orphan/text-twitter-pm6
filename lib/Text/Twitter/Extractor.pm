use v6;
use Text::Twitter::Extractor::Entity;

class Text::Twitter::Extractor {
    has $.extract-url-without-protocol = True;

    # extract URL references from Tweet text
    method extract-urls-with-indices (Str $text) {
        # performance optimization: if text doesn’t contain '.' or ':' at all,
        # text doesn't contain a URL, so we can simply return an empty list
        return ()
            if !$text.defined
            || !$text.index($.extract-url-without-protocol ?? '.' !! ':');

        my Text::Twitter::Extractor::Entity @urls;

        return @urls;
    }
}