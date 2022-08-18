local domfilter = require "make4ht-domfilter"

-- Based on https://tex.stackexchange.com/a/654379/224985 ( https://creativecommons.org/licenses/by-sa/4.0/ ).
local process = domfilter {
  function(dom)
    -- copy current page title from <title> to <meta property="og:title">
    local head = dom:query_selector("head")[1]
    -- find head element for faster processing
    if head then
      -- extract site title
      local title
      for _, el in ipairs(head:query_selector("title")) do
        title = el:get_text()
      end
      -- copy tite to og:title
      if title then
        for _, meta in ipairs(head:query_selector("meta[property='og:title']")) do
          meta:set_attribute("content", title)
        end
      end
      -- extract date modified
      local dateModified
      for _, meta in ipairs(head:query_selector("meta[http-equiv='last-modified']")) do
        dateModified = meta:get_attribute("content")
      end
      -- extract author
      local author
      for _, meta in ipairs(head:query_selector("meta[name='author']")) do
        author = meta:get_attribute("content")
      end
      -- create and append JSON-LD rich metadata
      if title and dateModified and author then
        -- Based on https://stackoverflow.com/q/2761260/9679188
        local function interp_string(s, tab)
          return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
        end
        local json_ld = head:create_element("script", { type='application/ld+json' })
        json = [[
{ 
  "@context": "http://schema.org/",
  "@type": "Article",
  "headline": "${title}",
  "dateModified": "${dateModified}",
  "author": {
    "@type": "Person",
    "name": "${author}"
  }
}
]]
        json_interpolated = interp_string(json, { title = title,
                                                  dateModified = dateModified,
                                                  author = author })
        json_ld:add_child_node(json_ld:create_text_node(json_interpolated))
        head:add_child_node(json_ld)
      end
    end
    return dom
  end
}

Make:match("html$", process)
