"Author: Nachum Kanovsky
"Email: nkanovsky yahoo com
"Version: 1.1
if exists("b:current_syntax")
	finish
endif

let b:current_syntax = "systemverilog"

syntax keyword svTodo TODO contained
syntax match svLineComment "//.*" contains=svTodo
syntax region svBlockComment start="/\*" end="\*/" contains=svTodo
syntax keyword svBoolean true false TRUE FALSE
syntax region svString start=+"+ skip=+\\"+ end=+"+
syntax keyword svType real realtime event reg wire integer logic bit time byte chandle genvar signed unsigned shortint shortreal string void int specparam
syntax keyword svDirection input output inout ref
syntax keyword svStorageClass parameter localparam virtual var protected rand const static automatic extern forkjoin export import
syntax match svInvPre "`\(\K\k*\)*\>"
syntax match svPreProc "`\(__FILE__\|__LINE__\|begin_keywords\|celldefine\|default_nettype\|end_keywords\|endcelldefine\|include\|line\|nounconnected_drive\|pragma\|resetall\|timescale\|unconnected_drive\|undef\|undefineall\)\>"
syntax match svPreCondit "`\(else\|elsif\|endif\|ifdef\|ifndef\)\>"
syntax match svInclude "`include\>"
syntax match svDefine "`define\>"
syntax keyword svConditional if else iff
syntax match svLabel "^\W*[a-zA-Z_]\+[a-zA-Z_0-9,\[\]\t ]*:"he=e-1 contained
syntax region svCase matchgroup=svConditional start="\<case\|casex\|casez\>" end="\<endcase\>" contains=ALL
syntax keyword svRepeat for foreach do while forever repeat
syntax keyword svKeyword fork join join_any join_none begin end module endmodule function endfunction task endtask always always_ff always_latch always_comb initial this generate endgenerate config endconfig class endclass clocking endclocking interface endinterface module endmodule package endpackage modport posedge negedge edge defparam assign deassign alias return disable wait continue and buf bufif0 bufif1 nand nor not or xnor xor tri tri0 tri1 triand trior trireg pull0 pull1 pullup pulldown cmos default endprimitive endspecify endtable force highz0 highz1 ifnone large macromodule medium nmos notif0 notif1 pmos primitive rcmos release rnmos rpmos rtran rtranif0 rtranif1 scalared small specify strong0 strong1 supply0 supply1 table tran tranif0 tranif1 vectored wand weak0 weak1 wor cell design incdir liblist library noshowcancelled pulsestyle_ondetect pulsestyle_onevent showcancelled use instance uwire assert assume before bind bins binsof break constraint context cover covergroup coverpoint cross dist endgroup endprogram endproperty endsequence enum expect extends final first_match ignore_bins illegal_bins inside intersect local longint matches new null packed priority program property pure randc randcase randsequence sequence solve struct super tagged throughout timeprecision timeunit type typedef union unique wait_order wildcard with within accept_on checker endchecker eventually global implies let nexttime reject_on restrict s_always s_eventually s_nexttime s_until s_until_with strong sync_accept_on sync_reject_on unique0 until until_with untyped weak implements interconnect nettype soft
syntax match svNumber "\<[0-9]\+\('\(h[0-9a-f]*\|d[0-9]*\|b[0-1]*\)\)\?\>"
syntax match svTime "\<[0-9]\+\(ns\|ms\|us\|fs\|ps\|s\)\>"
syntax keyword svStructure struct union enum
syntax keyword svTypedef typedef
syntax match svInvSystemFunction "\$\(\K\k*\)"
syntax match svSystemFunction "\$\(finish\|stop\|exit\|realtime\|stime\|time\|printtimescale\|timeformat\|bitstoreal\|realtobits\|bitstoshortreal\|shortrealtobits\|itor\|rtoi\|signed\|unsigned\|cast\|bits\|isunbounded\|typename\|unpacked_dimensions\|dimensions\|left\|right\|low\|high\|increment\|size\|clog2\|asin\|ln\|acos\|log10\|atan\|exp\|atan2\|sqrt\|hypot\|pow\|sinh\|floor\|cosh\|ceil\|tanh\|sin\|asinh\|cos\|acosh\|tan\|atanh\|countbits\|countones\|onehot\|onehot0\|isunknown\|fatal\|error\|warning\|info\|fatal\|error\|warning\|info\|asserton\|assertoff\|assertkill\|assertcontrol\|assertpasson\|assertpassoff\|assertfailon\|assertfailoff\|assertnonvacuouson\|assertvacuousoff\|sampled\|rose\|fell\|stable\|changed\|past\|past_gclk\|rose_gclk\|fell_gclk\|stable_gclk\|changed_gclk\|future_gclk\|rising_gclk\|falling_gclk\|steady_gclk\|changing_gclk\|coverage_control\|coverage_get_max\|coverage_get\|coverage_merge\|coverage_save\|get_coverage\|set_coverage_db_name\|load_coverage_db\|random\|urandom\|urandom_range\|dist_chi_square\|dist_erlang\|dist_exponential\|dist_normal\|dist_poisson\|dist_t\|dist_uniform\|q_initialize\|q_add\|q_remove\|q_full\|q_exam\|asyncandarray\|asyncandplane\|asyncnandarray\|asyncnandplane\|asyncorarray\|asyncorplane\|asyncnorarray\|asyncnorplane\|syncandarray\|syncandplane\|syncnandarray\|syncnandplane\|syncorarray\|syncorplane\|syncnorarray\|syncnorplane\|system\|contained\|transparent\|display\|sformat\|sformatf\)\>"

"syntax match svObjectFunctions "\.\(num\|size\|delete\|exists\|first\|last\|next\|prev\|insert\|pop_front\|pop_back\|push_front\|push_back\|find\|find_index\|find_first\|find_first_index\|find_last\|find_last_index\|min\|max\|reverse\|sort\|rsort\|shuffle\|sum\|product\|and\|or\|xor\)\>\(\s\|\n\)*("he=e-1

syntax match svOperator "\(\~\|&\||\|\^\|=\|!\|?\|:\|@\)"
syntax match svDelimiter "\({\|}\|(\|)\)"


""""""""""" copied """"""""""

syn match   verilogGlobal      "`begin_\w\+"
syn match   verilogGlobal      "`end_\w\+"
syn match   verilogGlobal      "`remove_\w\+"
syn match   verilogGlobal      "`restore_\w\+"

""" use this to highligh everything starts with ` symbol
"syn match   verilogGlobal      "`[a-zA-Z0-9_]\+\>"

syn match   verilogNumber      "\<[0-9][0-9_\.]\=\([fpnum]\|\)s\>"
syn match   verilogNumber      "\<[0-9][0-9_\.]\=step\>"

syn match  verilogMethod       "atobin"
syn match  verilogMethod       "atohex\>"
syn match  verilogMethod       "atoi\>"
syn match  verilogMethod       "atooct\>"
syn match  verilogMethod       "atoreal\>"
syn match  verilogMethod       "bintoa\>"
syn match  verilogMethod       "hextoa\>"
syn match  verilogMethod       "itoa\>"
syn match  verilogMethod       "octtoa\>"
syn match  verilogMethod       "realtoa\>"
syn match  verilogMethod       "len\>"
syn match  verilogMethod       "getc\>"
syn match  verilogMethod       "putc\>"
syn match  verilogMethod       "toupper\>"
syn match  verilogMethod       "tolower\>"
syn match  verilogMethod       "compare\>"
syn match  verilogMethod       "icompare\>"
syn match  verilogMethod       "substr\>"
syn match  verilogMethod       "num\>"
syn match  verilogMethod       "exists\>"
syn match  verilogMethod       "first\>"
syn match  verilogMethod       "last\>"
syn match  verilogMethod       "name\>"
syn match  verilogMethod       "index\>"
syn match  verilogMethod       "find\>"
syn match  verilogMethod       "find_first\>"
syn match  verilogMethod       "find_last\>"
syn match  verilogMethod       "find_index\>"
syn match  verilogMethod       "find_first_index\>"
syn match  verilogMethod       "find_last_index\>"
syn match  verilogMethod       "min\>"
syn match  verilogMethod       "max\>"
syn match  verilogMethod       "unique\>"
syn match  verilogMethod       "unique_index\>"
syn match  verilogMethod       "sort\>"
syn match  verilogMethod       "rsort\>"
syn match  verilogMethod       "shuffle\>"
syn match  verilogMethod       "reverse\>"
syn match  verilogMethod       "sum\>"
syn match  verilogMethod       "product\>"
syn match  verilogMethod       "xor\>"
syn match  verilogMethod       "status\>"
syn match  verilogMethod       "kill\>"
syn match  verilogMethod       "self\>"
syn match  verilogMethod       "await\>"
syn match  verilogMethod       "suspend\>"
syn match  verilogMethod       "resume\>"
syn match  verilogMethod       "get\>"
syn match  verilogMethod       "put\>"
syn match  verilogMethod       "peek\>"
syn match  verilogMethod       "try_get\>"
syn match  verilogMethod       "try_peek\>"
syn match  verilogMethod       "try_put\>"
syn match  verilogMethod       "data\>"
syn match  verilogMethod       "eq\>"
syn match  verilogMethod       "neq\>"
syn match  verilogMethod       "next\>"
syn match  verilogMethod       "prev\>"
syn match  verilogMethod       "new\>"
syn match  verilogMethod       "size\>"
syn match  verilogMethod       "delete\>"
syn match  verilogMethod       "empty\>"
syn match  verilogMethod       "pop_front\>"
syn match  verilogMethod       "pop_back\>"
syn match  verilogMethod       "push_front\>"
syn match  verilogMethod       "push_back\>"
syn match  verilogMethod       "front\>"
syn match  verilogMethod       "back\>"
syn match  verilogMethod       "insert\>"
syn match  verilogMethod       "insert_range\>"
syn match  verilogMethod       "erase\>"
syn match  verilogMethod       "erase_range\>"
syn match  verilogMethod       "set\>"
syn match  verilogMethod       "swap\>"
syn match  verilogMethod       "clear\>"
syn match  verilogMethod       "purge\>"
syn match  verilogMethod       "start\>"
syn match  verilogMethod       "finish\>"

syn match   verilogAssertion   "\<\w\+\>\s*:\s*\<assert\>\_.\{-});"

syn match   vmmType     "vmm_[a-zA-Z0-9_]\+\>"
syn match   tlmType     "tlm_[a-zA-Z0-9_]\+\>"
syn match   urmType     "urm_[a-zA-Z0-9_]\+\>"
syn match   ovmType     "ovm_[a-zA-Z0-9_]\+\>"
syn match   uvcType     "uvc_[a-zA-Z0-9_]\+\>"
syn match   verilogType "\[$\]\>"


syn keyword verilogTodo contained TODO

syn match   verilogOperator "[&|~><!)(*#%@+/=?:;}{,.\^\-\[\]]"

syn region  verilogComment start="/\*" end="\*/" contains=verilogTodo
syn match   verilogComment "//.*" contains=verilogTodo

"syn match verilogGlobal "`[a-zA-Z0-9_]\+\>"
syn match verilogGlobal "`celldefine"
syn match verilogGlobal "`default_nettype"
syn match verilogGlobal "`define"
syn match verilogGlobal "`else"
syn match verilogGlobal "`elsif"
syn match verilogGlobal "`endcelldefine"
syn match verilogGlobal "`endif"
syn match verilogGlobal "`ifdef"
syn match verilogGlobal "`ifndef"
syn match verilogGlobal "`include"
syn match verilogGlobal "`line"
syn match verilogGlobal "`nounconnected_drive"
syn match verilogGlobal "`resetall"
syn match verilogGlobal "`timescale"
syn match verilogGlobal "`unconnected_drive"
syn match verilogGlobal "`undef"
"syn match   verilogGlobal "$[a-zA-Z0-9_]\*\>"

syn match   verilogConstant "\<[A-Z][A-Z0-9_]\*\>"

syn match   verilogNumber "\(\<\d\+\|\)'[bB]\s*[0-1_xXzZ?]\+\>"
syn match   verilogNumber "\(\<\d\+\|\)'[oO]\s*[0-7_xXzZ?]\+\>"
syn match   verilogNumber "\(\<\d\+\|\)'[dD]\s*[0-9_xXzZ?]\+\>"
syn match   verilogNumber "\(\<\d\+\|\)'[hH]\s*[0-9a-fA-F_xXzZ?]\+\>"
syn match   verilogNumber "\<[+-]\=[0-9_]\+\(\.[0-9_]*\|\)\(e[0-9_]*\|\)\>"

syn region  verilogString start=+"+ skip=+\\"+ end=+"+ contains=verilogEscape
syn match   verilogEscape +\\[nt"\\]+ contained
syn match   verilogEscape "\\\o\o\=\o\=" contained

" Directives
syn match   verilogDirective   "//\s*synopsys\>.*$"
syn region  verilogDirective   start="/\*\s*synopsys\>" end="\*/"
syn region  verilogDirective   start="//\s*synopsys dc_script_begin\>" end="//\s*synopsys dc_script_end\>"

syn match   verilogDirective   "//\s*\$s\>.*$"
syn region  verilogDirective   start="/\*\s*\$s\>" end="\*/"
syn region  verilogDirective   start="//\s*\$s dc_script_begin\>" end="//\s*\$s dc_script_end\>"

"Modify the following as needed.  The trade-off is performance versus
"functionality.
syn sync lines=50
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_verilog_syn_inits")
  if version < 508
     let did_verilog_syn_inits = 1
     command -nargs=+ HiLink hi link <args>
  else
     command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlighting.

  "HiLink verilogMethod          Function
  HiLink verilogTypeDef         TypeDef
  HiLink verilogAssertion       Include
  HiLink verilogCharacter       Character
  HiLink verilogConditional     Conditional
  HiLink verilogRepeat          Repeat
  HiLink verilogString          String
  HiLink verilogTodo            Todo
  HiLink verilogComment         Comment
  HiLink verilogConstant        Constant
  HiLink verilogLabel           Label
  HiLink verilogNumber          Number
  HiLink verilogOperator        Special
  HiLink verilogStatement       Type
  HiLink verilogGlobal          Define
  HiLink verilogDirective       SpecialComment
  HiLink verilogEscape          Special
  HiLink verilogType            Statement
  HiLink tlmType                Library
  HiLink urmType                Library
  HiLink ovmType                Library
  HiLink uvcType                Library
  HiLink vmmType                Library
  delcommand HiLink
endif

""""""""""" copied """"""""""

syntax keyword uvm_keyword uvm_object
syntax keyword uvm_keyword uvm_agent
syntax keyword uvm_keyword uvm_transaction
syntax keyword uvm_keyword uvm_sequence_item
syntax keyword uvm_keyword uvm_sequence
syntax keyword uvm_keyword uvm_sequencer
syntax keyword uvm_keyword uvm_report_object
syntax keyword uvm_keyword uvm_component
syntax keyword uvm_keyword uvm_monitor
syntax keyword uvm_keyword uvm_scoreboard
syntax keyword uvm_keyword uvm_driver
syntax keyword uvm_keyword uvm_test
syntax keyword uvm_keyword uvm_env
syntax keyword uvm_keyword uvm_subscriber
syntax keyword uvm_keyword uvm_config
syntax keyword uvm_keyword uvm_config_db
syntax keyword uvm_keyword uvm_analysis_port
syntax keyword uvm_keyword uvm_tlm_extension
syntax keyword uvm_keyword uvm_tlm_if
syntax keyword uvm_keyword uvm_field_int
syntax keyword uvm_keyword uvm_config_db

syntax keyword uvm_function seq_item_port
syntax keyword uvm_function get_next_item
syntax keyword uvm_function try_next_item
syntax keyword uvm_function build_phase
syntax keyword uvm_function connect_phase
syntax keyword uvm_function run_phase
syntax keyword uvm_function uvm_phase
syntax keyword uvm_function raise_objection
syntax keyword uvm_function drop_objection
syntax keyword uvm_function run_test

""""""""""""""
syntax match svDefine "`uvm_register_cb\>"
syntax match svDefine "`uvm_set_super_type\>"
syntax match svDefine "`uvm_do_callbacks\>"
syntax match svDefine "`uvm_do_obj_callbacks\>"
syntax match svDefine "`uvm_do_callbacks_exit_on\>"
syntax match svDefine "`uvm_do_obj_callbacks_exit_on\>"
syntax match svDefine "`uvm_cb_trace\>"
syntax match svDefine "`uvm_cb_trace_noobj\>"
syntax match svDefine "`uvm_cb_trace\>"
syntax match svDefine "`m_uvm_register_sequence\>"
syntax match svDefine "`uvm_sequence_utils_begin\>"
syntax match svDefine "`uvm_sequence_utils_end\>"
syntax match svDefine "`uvm_sequence_utils\>"
syntax match svDefine "`uvm_declare_sequence_lib\>"
syntax match svDefine "`uvm_update_sequence_lib\>"
syntax match svDefine "`uvm_update_sequence_lib_and_item\>"
syntax match svDefine "`uvm_sequencer_utils\>"
syntax match svDefine "`uvm_sequencer_utils_begin\>"
syntax match svDefine "`uvm_sequencer_param_utils\>"
syntax match svDefine "`uvm_sequencer_param_utils_begin\>"
syntax match svDefine "`uvm_sequencer_utils_end\>"
syntax match svDefine "`uvm_package\>"
syntax match svDefine "`uvm_end_package\>"
syntax match svDefine "`uvm_sequence_library_package\>"
syntax match svDefine "`uvm_file\>"
syntax match svDefine "`uvm_line\>"
syntax match svDefine "`uvm_info\>"
syntax match svDefine "`uvm_warning\>"
syntax match svDefine "`uvm_error\>"
syntax match svDefine "`uvm_fatal\>"
syntax match svDefine "`uvm_info_context\>"
syntax match svDefine "`uvm_warning_context\>"
syntax match svDefine "`uvm_error_context\>"
syntax match svDefine "`uvm_fatal_context\>"
syntax match svDefine "`uvm_message_begin\>"
syntax match svDefine "`uvm_message_end\>"
syntax match svDefine "`uvm_message_context_begin\>"
syntax match svDefine "`uvm_message_context_end\>"
syntax match svDefine "`uvm_info_begin\>"
syntax match svDefine "`uvm_info_end\>"
syntax match svDefine "`uvm_warning_begin\>"
syntax match svDefine "`uvm_warning_end\>"
syntax match svDefine "`uvm_error_begin\>"
syntax match svDefine "`uvm_error_end\>"
syntax match svDefine "`uvm_fatal_begin\>"
syntax match svDefine "`uvm_fatal_end\>"
syntax match svDefine "`uvm_info_context_begin\>"
syntax match svDefine "`uvm_info_context_end\>"
syntax match svDefine "`uvm_warning_context_begin\>"
syntax match svDefine "`uvm_warning_context_end\>"
syntax match svDefine "`uvm_error_context_begin\>"
syntax match svDefine "`uvm_error_context_end\>"
syntax match svDefine "`uvm_fatal_context_begin\>"
syntax match svDefine "`uvm_fatal_context_end\>"
syntax match svDefine "`uvm_message_add_tag\>"
syntax match svDefine "`uvm_message_add_int\>"
syntax match svDefine "`uvm_message_add_string\>"
syntax match svDefine "`uvm_message_add_object\>"
syntax match svDefine "`uvm_field_utils_begin\>"
syntax match svDefine "`uvm_field_utils_end\>"
syntax match svDefine "`uvm_object_utils\>"
syntax match svDefine "`uvm_object_param_utils\>"
syntax match svDefine "`uvm_object_utils_begin\>"
syntax match svDefine "`uvm_object_param_utils_begin\>"
syntax match svDefine "`uvm_object_utils_end\>"
syntax match svDefine "`uvm_component_utils\>"
syntax match svDefine "`uvm_component_param_utils\>"
syntax match svDefine "`uvm_component_utils_begin\>"
syntax match svDefine "`uvm_component_param_utils_begin\>"
syntax match svDefine "`uvm_component_utils_end\>"
syntax match svDefine "`uvm_field_int\>"
syntax match svDefine "`uvm_field_real\>"
syntax match svDefine "`uvm_field_enum\>"
syntax match svDefine "`uvm_field_object\>"
syntax match svDefine "`uvm_field_event\>"
syntax match svDefine "`uvm_field_string\>"
syntax match svDefine "`uvm_field_array_enum\>"
syntax match svDefine "`uvm_field_array_int\>"
syntax match svDefine "`uvm_field_sarray_int\>"
syntax match svDefine "`uvm_field_sarray_enum\>"
syntax match svDefine "`uvm_field_array_object\>"
syntax match svDefine "`uvm_field_sarray_object\>"
syntax match svDefine "`uvm_field_array_string\>"
syntax match svDefine "`uvm_field_sarray_string\>"
syntax match svDefine "`uvm_field_queue_enum\>"
syntax match svDefine "`uvm_field_queue_int\>"
syntax match svDefine "`uvm_field_queue_object\>"
syntax match svDefine "`uvm_field_queue_string\>"
syntax match svDefine "`uvm_field_aa_int_string\>"
syntax match svDefine "`uvm_field_aa_string_string\>"
syntax match svDefine "`uvm_field_aa_object_string\>"
syntax match svDefine "`uvm_field_aa_int_int\>"
syntax match svDefine "`uvm_field_aa_int_int_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_integer\>"
syntax match svDefine "`uvm_field_aa_int_integer_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_byte\>"
syntax match svDefine "`uvm_field_aa_int_byte_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_shortint\>"
syntax match svDefine "`uvm_field_aa_int_shortint_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_longint\>"
syntax match svDefine "`uvm_field_aa_int_longint_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_key\>"
syntax match svDefine "`uvm_field_aa_string_int\>"
syntax match svDefine "`uvm_field_aa_object_int\>"
syntax match svDefine "`uvm_field_utils_begin\>"
syntax match svDefine "`uvm_field_utils_end\>"
syntax match svDefine "`uvm_object_utils\>"
syntax match svDefine "`uvm_object_param_utils\>"
syntax match svDefine "`uvm_object_utils_begin\>"
syntax match svDefine "`uvm_object_param_utils_begin\>"
syntax match svDefine "`uvm_object_utils_end\>"
syntax match svDefine "`uvm_component_utils\>"
syntax match svDefine "`uvm_component_param_utils\>"
syntax match svDefine "`uvm_component_utils_begin\>"
syntax match svDefine "`uvm_component_param_utils_begin\>"
syntax match svDefine "`uvm_component_utils_end\>"
syntax match svDefine "`uvm_object_registry\>"
syntax match svDefine "`uvm_component_registry\>"
syntax match svDefine "`uvm_new_func\>"
syntax match svDefine "`m_uvm_object_create_func\>"
syntax match svDefine "`m_uvm_get_type_name_func\>"
syntax match svDefine "`m_uvm_object_registry_internal\>"
syntax match svDefine "`m_uvm_object_registry_param\>"
syntax match svDefine "`m_uvm_component_registry_internal\>"
syntax match svDefine "`m_uvm_component_registry_param\>"
syntax match svDefine "`uvm_field_int\>"
syntax match svDefine "`uvm_field_object\>"
syntax match svDefine "`uvm_field_string\>"
syntax match svDefine "`uvm_field_enum\>"
syntax match svDefine "`uvm_field_real\>"
syntax match svDefine "`uvm_field_event\>"
syntax match svDefine "`uvm_field_sarray_int\>"
syntax match svDefine "`uvm_field_sarray_object\>"
syntax match svDefine "`uvm_field_sarray_string\>"
syntax match svDefine "`uvm_field_sarray_enum\>"
syntax match svDefine "`uvm_field_array_int\>"
syntax match svDefine "`uvm_field_array_object\>"
syntax match svDefine "`uvm_field_array_string\>"
syntax match svDefine "`uvm_field_array_enum\>"
syntax match svDefine "`uvm_field_queue_int\>"
syntax match svDefine "`uvm_field_queue_object\>"
syntax match svDefine "`uvm_field_queue_string\>"
syntax match svDefine "`uvm_field_queue_enum\>"
syntax match svDefine "`uvm_field_aa_int_string\>"
syntax match svDefine "`uvm_field_aa_object_string\>"
syntax match svDefine "`uvm_field_aa_string_string\>"
syntax match svDefine "`uvm_field_aa_object_int\>"
syntax match svDefine "`uvm_field_aa_int_int\>"
syntax match svDefine "`uvm_field_aa_int_int_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_integer\>"
syntax match svDefine "`uvm_field_aa_int_integer_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_byte\>"
syntax match svDefine "`uvm_field_aa_int_byte_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_shortint\>"
syntax match svDefine "`uvm_field_aa_int_shortint_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_longint\>"
syntax match svDefine "`uvm_field_aa_int_longint_unsigned\>"
syntax match svDefine "`uvm_field_aa_int_key\>"
syntax match svDefine "`uvm_field_aa_int_enumkey\>"
syntax match svDefine "`m_uvm_print_int\>"
syntax match svDefine "`m_uvm_record_int\>"
syntax match svDefine "`m_uvm_record_string\>"
syntax match svDefine "`m_uvm_record_object\>"
syntax match svDefine "`m_uvm_record_qda_int\>"
syntax match svDefine "`m_uvm_record_qda_enum\>"
syntax match svDefine "`m_uvm_record_qda_object\>"
syntax match svDefine "`m_uvm_record_qda_string\>"
syntax match svDefine "`uvm_record_field\>"
syntax match svDefine "`uvm_pack_intN\>"
syntax match svDefine "`uvm_pack_enumN\>"
syntax match svDefine "`uvm_pack_sarrayN\>"
syntax match svDefine "`uvm_pack_arrayN\>"
syntax match svDefine "`uvm_pack_queueN\>"
syntax match svDefine "`uvm_pack_int\>"
syntax match svDefine "`uvm_pack_enum\>"
syntax match svDefine "`uvm_pack_string\>"
syntax match svDefine "`uvm_pack_real\>"
syntax match svDefine "`uvm_pack_sarray\>"
syntax match svDefine "`uvm_pack_array\>"
syntax match svDefine "`uvm_pack_queue\>"
syntax match svDefine "`uvm_unpack_intN\>"
syntax match svDefine "`uvm_unpack_enumN\>"
syntax match svDefine "`uvm_unpack_sarrayN\>"
syntax match svDefine "`uvm_unpack_arrayN\>"
syntax match svDefine "`uvm_unpack_queueN\>"
syntax match svDefine "`uvm_unpack_int\>"
syntax match svDefine "`uvm_unpack_enum\>"
syntax match svDefine "`uvm_unpack_string\>"
syntax match svDefine "`uvm_unpack_real\>"
syntax match svDefine "`uvm_unpack_sarray\>"
syntax match svDefine "`uvm_unpack_array\>"
syntax match svDefine "`uvm_unpack_queue\>"
syntax match svDefine "`m_uvm_task_phase\>"
syntax match svDefine "`m_uvm_topdown_phase\>"
syntax match svDefine "`m_uvm_bottomup_phase\>"
syntax match svDefine "`uvm_builtin_task_phase\>"
syntax match svDefine "`uvm_builtin_topdown_phase\>"
syntax match svDefine "`uvm_builtin_bottomup_phase\>"
syntax match svDefine "`uvm_user_task_phase\>"
syntax match svDefine "`uvm_user_topdown_phase\>"
syntax match svDefine "`uvm_user_bottomup_phase\>"
syntax match svDefine "`uvm_print_int\>"
syntax match svDefine "`uvm_print_int3\>"
syntax match svDefine "`uvm_print_int4\>"
syntax match svDefine "`uvm_print_enum\>"
syntax match svDefine "`uvm_print_object\>"
syntax match svDefine "`uvm_print_object2\>"
syntax match svDefine "`uvm_print_string\>"
syntax match svDefine "`uvm_print_string2\>"
syntax match svDefine "`uvm_print_array_int\>"
syntax match svDefine "`uvm_print_array_int3\>"
syntax match svDefine "`uvm_print_sarray_int3\>"
syntax match svDefine "`uvm_print_qda_int4\>"
syntax match svDefine "`uvm_print_qda_enum\>"
syntax match svDefine "`uvm_print_queue_int\>"
syntax match svDefine "`uvm_print_queue_int3\>"
syntax match svDefine "`uvm_print_array_object\>"
syntax match svDefine "`uvm_print_sarray_object\>"
syntax match svDefine "`uvm_print_array_object3\>"
syntax match svDefine "`uvm_print_sarray_object3\>"
syntax match svDefine "`uvm_print_object_qda4\>"
syntax match svDefine "`uvm_print_object_queue\>"
syntax match svDefine "`uvm_print_object_queue3\>"
syntax match svDefine "`uvm_print_array_string\>"
syntax match svDefine "`uvm_print_array_string2\>"
syntax match svDefine "`uvm_print_sarray_string2\>"
syntax match svDefine "`uvm_print_string_qda3\>"
syntax match svDefine "`uvm_print_string_queue\>"
syntax match svDefine "`uvm_print_string_queue2\>"
syntax match svDefine "`uvm_print_aa_string_int\>"
syntax match svDefine "`uvm_print_aa_string_int3\>"
syntax match svDefine "`uvm_print_aa_string_object\>"
syntax match svDefine "`uvm_print_aa_string_object3\>"
syntax match svDefine "`uvm_print_aa_string_string\>"
syntax match svDefine "`uvm_print_aa_string_string2\>"
syntax match svDefine "`uvm_print_aa_int_object\>"
syntax match svDefine "`uvm_print_aa_int_object3\>"
syntax match svDefine "`uvm_print_aa_int_key4\>"
syntax match svDefine "`uvm_create\>"
syntax match svDefine "`uvm_do\>"
syntax match svDefine "`uvm_do_pri\>"
syntax match svDefine "`uvm_do_with\>"
syntax match svDefine "`uvm_do_pri_with\>"
syntax match svDefine "`uvm_create_on\>"
syntax match svDefine "`uvm_do_on\>"
syntax match svDefine "`uvm_do_on_pri\>"
syntax match svDefine "`uvm_do_on_with\>"
syntax match svDefine "`uvm_do_on_pri_with\>"
syntax match svDefine "`uvm_send\>"
syntax match svDefine "`uvm_send_pri\>"
syntax match svDefine "`uvm_rand_send\>"
syntax match svDefine "`uvm_rand_send_pri\>"
syntax match svDefine "`uvm_rand_send_with\>"
syntax match svDefine "`uvm_rand_send_pri_with\>"
syntax match svDefine "`uvm_create_seq\>"
syntax match svDefine "`uvm_do_seq\>"
syntax match svDefine "`uvm_do_seq_with\>"
syntax match svDefine "`uvm_add_to_seq_lib\>"
syntax match svDefine "`uvm_sequence_library_utils\>"
syntax match svDefine "`uvm_declare_p_sequencer\>"
syntax match svDefine "`uvm_blocking_put_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_put_imp_decl\>"
syntax match svDefine "`uvm_put_imp_decl\>"
syntax match svDefine "`uvm_blocking_get_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_get_imp_decl\>"
syntax match svDefine "`uvm_get_imp_decl\>"
syntax match svDefine "`uvm_blocking_peek_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_peek_imp_decl\>"
syntax match svDefine "`uvm_peek_imp_decl\>"
syntax match svDefine "`uvm_blocking_get_peek_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_get_peek_imp_decl\>"
syntax match svDefine "`uvm_get_peek_imp_decl\>"
syntax match svDefine "`uvm_blocking_master_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_master_imp_decl\>"
syntax match svDefine "`uvm_master_imp_decl\>"
syntax match svDefine "`uvm_blocking_slave_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_slave_imp_decl\>"
syntax match svDefine "`uvm_slave_imp_decl\>"
syntax match svDefine "`uvm_blocking_transport_imp_decl\>"
syntax match svDefine "`uvm_nonblocking_transport_imp_decl\>"
syntax match svDefine "`uvm_non_blocking_transport_imp_decl\>"
syntax match svDefine "`uvm_transport_imp_decl\>"
syntax match svDefine "`uvm_analysis_imp_decl\>"

"""""""""""""""
highlight! default link svTodo Todo
highlight! default link svLineComment Comment
highlight! default link svBlockComment Comment
highlight! default link svBoolean Boolean
highlight! default link svString String
highlight! default link svType Type
highlight! default link svDirection StorageClass
highlight! default link svStorageClass StorageClass
highlight! default link svPreProc PreProc
highlight! default link svPreCondit PreCondit
highlight! default link svInclude Include
highlight! default link svDefine Define
highlight! default link svMacro Macro
highlight! default link svConditional Conditional
highlight! default link svLabel Label
highlight! default link svRepeat Repeat
highlight! default link svKeyword Keyword
highlight! default link svNumber Number
highlight! default link svTime Number
highlight! default link svStructure Structure
highlight! default link svTypedef Typedef
highlight! default link svSystemFunction Function
highlight! default link svOperator Operator
highlight! default link svDelimiter Delimiter
highlight! default link svObjectFunctions Function
highlight! default link verilogMethod Function
highlight! default link uvm_keyword Function
highlight! default link uvm_function Function

highlight! default link svFunction none
highlight! default link svCase none
highlight! default link svPreprocessor none
highlight! default link svSystemFunctionName none
highlight! default link svInvPre none
highlight! default link svInvSystemFunction none
