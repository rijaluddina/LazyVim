((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

;;; extends -- add this in TSEditQuery injection html html/injection
;
;; AlpineJS attributes --
;(attribute
;  (attribute_name) @_attr
;    (#lua-match? @_attr "^x%-%l")
;  (quoted_attribute_value
;    (attribute_value) @injection.content)
;  (#set! injection.language "javascript"))
;
;; Blade escaped JS attributes --
;; <x-foo ::bar="baz" /> --
;(element
;  (_
;    (tag_name) @_tag
;      (#lua-match? @_tag "^x%-%l")
;  (attribute
;    (attribute_name) @_attr
;      (#lua-match? @_attr "^::%l")
;    (quoted_attribute_value
;      (attribute_value) @injection.content)
;    (#set! injection.language "javascript"))))
;
;; Blade PHP attributes --
;; <x-foo :bar="$baz" /> --
;(element
;  (_
;    (tag_name) @_tag
;      (#lua-match? @_tag "^x%-%l")
;    (attribute
;      (attribute_name) @_attr
;        (#lua-match? @_attr "^:%l")
;      (quoted_attribute_value
;        (attribute_value) @injection.content)
;      (#set! injection.language "php_only"))))
;
