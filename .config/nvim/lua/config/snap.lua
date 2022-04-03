local snap = require "snap"

-- snap.run {
--     producer = snap.get "consumer.fzy"(snap.get "producer.ripgrep.file"),
--     select = snap.get "select.file".select,
--     multiselect = snap.get "select.file".multiselect,
--     views = {snap.get "preview.file"}
-- }
-- snap.config.file {try = {"git.file", "ripgrep.file"}}
snap.run {
    prompt = "Help>",
    producer = snap.get "consumer.fzy"(snap.get "producer.vim.help"),
    select = snap.get "select.help".select,
    views = {snap.get "preview.help"}
}
