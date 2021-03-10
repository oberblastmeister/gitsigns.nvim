
global _: any

global record CacheEntry
  file          : string
  vcs           : VCS
  relpath       : string
  object_name   : string
  mode_bits     : string
  toplevel      : string
  gitdir        : string
  staged        : string
  abbrev_head   : string
  has_conflicts : boolean
  hunks         : {Hunk}
  staged_diffs  : {Hunk}
  pending_signs : {number:Sign}
  index_watcher : vim.loop.FSPollObj          -- Timer object watching the files index
end

global enum SignName
  "GitSignsAdd"
  "GitSignsDelete"
  "GitSignsChange"
  "GitSignsTopDelete"
  "GitSignsChangeDelete"
end

global record SignsConfig
  show_count: boolean
  hl: string
  text: string
  numhl: string
  linehl: string
  keymaps: {string:string}
end

global record StatusObj
    added: number
    removed: number
    changed: number
    head: string
end

global record Config
    debug_mode: boolean
    diff_algorithm: string
    signs: {SignType: SignsConfig}
    count_chars: {string|number:string}
    numhl: boolean
    linehl: boolean
    sign_priority: number
    keymaps: {string:any}
    record watch_index
        interval: number
    end
    max_file_length: number
    update_debounce: number
    status_formatter: function(StatusObj): string
    _use_internal_diff: boolean
    use_decoration_api: boolean
    record YadmConfig
      enable: boolean
    end
    yadm: YadmConfig
end

global enum SignType
  "add"
  "delete"
  "change"
  "topdelete"
  "changedelete"
end

global record Sign
  type: SignType
  count: number
end

global record Hunk
  enum Type
    "add"
    "change"
    "delete"
  end

  type: Type
  head: string
  lines: {string}
  start: number
  dend: number

  record Node
    start: number
    count: number
  end

  added: Node
  removed: Node
end

global type cb_function = function(function(...: any))
global type async_function = function(...: any): cb_function

global record VCS
  get_staged_text: function(string, string, number): cb_function
  get_staged: function(string, string, number, string): cb_function
  run_diff: function(string, {string}, string): cb_function
  add_file: function(string, string): cb_function
  stage_lines: function(string, {string}): cb_function
  file_info: function(string, string): cb_function
  run_blame: function(string, string, {string}, number): cb_function
  get_repo_info: function(string): cb_function
  is_managed: function(string, string): cb_function
end

