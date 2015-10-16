use v6;
use Text::Twitter::Extractor;

# class for validating Tweet texts
class Text::Twitter::Validator {
    constant $max-tweet-length = 140;

    has Int $.short-url-length       = 23;
    has Int $.short-url-length-https = 23;

    has $!extractor = Text::Twitter::Extractor.new;

    method get-tweet-length (Str $text) {
        return [+] flat(
            $text.codes,
            $!extractor.extract-urls-with-indices($text).map: {
                .start - .end,
                .value ~~ m:i{ ^ 'https://' }
                    ?? $.short-url-length-https
                    !! $.short-url-length
            }
        );
    }

    method is-valid-tweet (Str $text) {
        # BOM: U+FFFE, U+FEFF
        # Special: U+FFFF
        # Direction change: U+202A..U+202E
        return
            so $text.defined
            && $text.chars
            && $text !~~ m{ <[
                \x[FFFE] \x[FEFF] \x[FFFF]
                \x[202A]..\x[202E]
            ]> }
            && $.get-tweet-length($text) <= $max-tweet-length;
    }
}