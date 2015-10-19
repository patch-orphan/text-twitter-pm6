use v6;
use Text::Twitter::Extractor;

# class for validating Tweet texts
class Text::Twitter::Validator {
    constant $max-tweet-length = 140;
    constant $short-url-length = 23;

    has $!extractor = Text::Twitter::Extractor.new;

    method get-tweet-length (Str $text) {
        return [+] flat(
            $text.codes,
            $!extractor.extract-urls-with-indices($text).map: {
                .start - .end,
                $short-url-length
            }
        );
    }

    method is-valid-tweet (Str $text) {
        # BOM: U+FFFE, U+FEFF
        # Special: U+FFFF
        # Direction change: U+202A..U+202E
        return $text.defined
            && $.get-tweet-length($text) ~~ 1..$max-tweet-length
            && $text !~~ m{ <[
                \x[FFFE] \x[FEFF] \x[FFFF] \x[202A]..\x[202E]
            ]> };
    }
}
