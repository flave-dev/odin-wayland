#+build linux
package text_input_v3
@(private)
text_input_unstable_v3_types := []^interface {
	nil,
	nil,
	nil,
	nil,
	&wl.surface_interface,
	&wl.surface_interface,
	&text_input_v3_interface,
	&wl.seat_interface,
}
/* The zwp_text_input_v3 interface represents text input and input methods
      associated with a seat. It provides enter/leave events to follow the
      text input focus for a seat.

      Requests are used to enable/disable the text-input object and set
      state information like surrounding and selected text or the content type.
      The information about the entered text is sent to the text-input object
      via the preedit_string and commit_string events.

      Text is valid UTF-8 encoded, indices and lengths are in bytes. Indices
      must not point to middle bytes inside a code point: they must either
      point to the first byte of a code point or to the end of the buffer.
      Lengths must be measured between two valid indices.

      Focus moving throughout surfaces will result in the emission of
      zwp_text_input_v3.enter and zwp_text_input_v3.leave events. The focused
      surface must commit zwp_text_input_v3.enable and
      zwp_text_input_v3.disable requests as the keyboard focus moves across
      editable and non-editable elements of the UI. Those two requests are not
      expected to be paired with each other, the compositor must be able to
      handle consecutive series of the same request.

      State is sent by the state requests (set_surrounding_text,
      set_content_type and set_cursor_rectangle) and a commit request. After an
      enter event or disable request all state information is invalidated and
      needs to be resent by the client. */
text_input_v3 :: struct {}
text_input_v3_set_user_data :: proc "contextless" (text_input_v3_: ^text_input_v3, user_data: rawptr) {
   proxy_set_user_data(cast(^proxy)text_input_v3_, user_data)
}

text_input_v3_get_user_data :: proc "contextless" (text_input_v3_: ^text_input_v3) -> rawptr {
   return proxy_get_user_data(cast(^proxy)text_input_v3_)
}

/* Destroy the wp_text_input object. Also disables all surfaces enabled
        through this wp_text_input object. */
TEXT_INPUT_V3_DESTROY :: 0
text_input_v3_destroy :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_DESTROY, nil, proxy_get_version(cast(^proxy)text_input_v3_), 1)
}

/* Requests text input on the surface previously obtained from the enter
        event.

        This request must be issued every time the focused text input changes
        to a new one, including within the current surface. Use
        zwp_text_input_v3.disable when there is no longer any input focus on
        the current surface.

        Clients must not enable more than one text input on the single seat
        and should disable the current text input before enabling the new one.
        Requests to enable a text input when another text input is enabled
        on the same seat must be ignored by compositor.

        This request resets all state associated with previous enable, disable,
        set_surrounding_text, set_text_change_cause, set_content_type, and
        set_cursor_rectangle requests, as well as the state associated with
        preedit_string, commit_string, and delete_surrounding_text events.

        The set_surrounding_text, set_content_type and set_cursor_rectangle
        requests must follow if the text input supports the necessary
        functionality.

        State set with this request is double-buffered. It will get applied on
        the next zwp_text_input_v3.commit request, and stay valid until the
        next committed enable or disable request.

        The changes must be applied by the compositor after issuing a
        zwp_text_input_v3.commit request. */
TEXT_INPUT_V3_ENABLE :: 1
text_input_v3_enable :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_ENABLE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Explicitly disable text input on the current surface (typically when
        there is no focus on any text entry inside the surface).

        State set with this request is double-buffered. It will get applied on
        the next zwp_text_input_v3.commit request. */
TEXT_INPUT_V3_DISABLE :: 2
text_input_v3_disable :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_DISABLE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Sets the surrounding plain text around the input, excluding the preedit
        text.

        The client should notify the compositor of any changes in any of the
        values carried with this request, including changes caused by handling
        incoming text-input events as well as changes caused by other
        mechanisms like keyboard typing.

        If the client is unaware of the text around the cursor, it should not
        issue this request, to signify lack of support to the compositor.

        Text is UTF-8 encoded, and should include the cursor position, the
        complete selection and additional characters before and after them.
        There is a maximum length of wayland messages, so text can not be
        longer than 4000 bytes.

        Cursor is the byte offset of the cursor within text buffer.

        Anchor is the byte offset of the selection anchor within text buffer.
        If there is no selected text, anchor is the same as cursor.

        If any preedit text is present, it is replaced with a cursor for the
        purpose of this event.

        Values set with this request are double-buffered. They will get applied
        on the next zwp_text_input_v3.commit request, and stay valid until the
        next committed enable or disable request.

        The initial state for affected fields is empty, meaning that the text
        input does not support sending surrounding text. If the empty values
        get applied, subsequent attempts to change them may have no effect. */
TEXT_INPUT_V3_SET_SURROUNDING_TEXT :: 3
text_input_v3_set_surrounding_text :: proc "contextless" (text_input_v3_: ^text_input_v3, text_: cstring, cursor_: int, anchor_: int) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_SURROUNDING_TEXT, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, text_, cursor_, anchor_)
}

/* Tells the compositor why the text surrounding the cursor changed.

        Whenever the client detects an external change in text, cursor, or
        anchor posision, it must issue this request to the compositor. This
        request is intended to give the input method a chance to update the
        preedit text in an appropriate way, e.g. by removing it when the user
        starts typing with a keyboard.

        cause describes the source of the change.

        The value set with this request is double-buffered. It must be applied
        and reset to initial at the next zwp_text_input_v3.commit request.

        The initial value of cause is input_method. */
TEXT_INPUT_V3_SET_TEXT_CHANGE_CAUSE :: 4
text_input_v3_set_text_change_cause :: proc "contextless" (text_input_v3_: ^text_input_v3, cause_: text_input_v3_change_cause) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_TEXT_CHANGE_CAUSE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, cause_)
}

/* Sets the content purpose and content hint. While the purpose is the
        basic purpose of an input field, the hint flags allow to modify some of
        the behavior.

        Values set with this request are double-buffered. They will get applied
        on the next zwp_text_input_v3.commit request.
        Subsequent attempts to update them may have no effect. The values
        remain valid until the next committed enable or disable request.

        The initial value for hint is none, and the initial value for purpose
        is normal. */
TEXT_INPUT_V3_SET_CONTENT_TYPE :: 5
text_input_v3_set_content_type :: proc "contextless" (text_input_v3_: ^text_input_v3, hint_: text_input_v3_content_hint, purpose_: text_input_v3_content_purpose) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_CONTENT_TYPE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, hint_, purpose_)
}

/* Marks an area around the cursor as a x, y, width, height rectangle in
        surface local coordinates.

        Allows the compositor to put a window with word suggestions near the
        cursor, without obstructing the text being input.

        If the client is unaware of the position of edited text, it should not
        issue this request, to signify lack of support to the compositor.

        Values set with this request are double-buffered. They will get applied
        on the next zwp_text_input_v3.commit request, and stay valid until the
        next committed enable or disable request.

        The initial values describing a cursor rectangle are empty. That means
        the text input does not support describing the cursor area. If the
        empty values get applied, subsequent attempts to change them may have
        no effect.

        As of version 2, the zwp_text_input_v3.commit request does not apply
        values sent with this request. Instead, it stores them in a separate
        "committed" area. The committed values, if still valid, get applied on
        the next wl_surface.commit request on the surface with text-input focus.
        Both committed and applied values get invalidated on:

        - the next committed enable or disable request, or
        - a change of the focused surface of the text-input (leave or enter events).

        This double stage application allows the compositor to position
        the input method popup in the same frame as the contents
        of the text on the surface are updated. */
TEXT_INPUT_V3_SET_CURSOR_RECTANGLE :: 6
text_input_v3_set_cursor_rectangle :: proc "contextless" (text_input_v3_: ^text_input_v3, x_: int, y_: int, width_: int, height_: int) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_CURSOR_RECTANGLE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, x_, y_, width_, height_)
}

/* Atomically applies state changes recently sent to the compositor.

        The commit request establishes and updates the state of the client, and
        must be issued after any changes to apply them.

        Text input state (enabled status, content purpose, content hint,
        surrounding text and change cause, cursor rectangle) is conceptually
        double-buffered within the context of a text input, i.e. between a
        committed enable request and the following committed enable or disable
        request.

        Protocol requests modify the pending state, as opposed to the current
        state in use by the input method. A commit request atomically applies
        all pending state, replacing the current state. After commit, the new
        pending state is as documented for each related request.

        Requests are applied in the order of arrival.

        Neither current nor pending state are modified unless noted otherwise.

        The compositor must count the number of commit requests coming from
        each zwp_text_input_v3 object and use the count as the serial in done
        events. */
TEXT_INPUT_V3_COMMIT :: 7
text_input_v3_commit :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_COMMIT, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Set the actions available for this text input.

        Values set with this request are double-buffered. They will get applied
        on the next zwp_text_input_v3.commit request.

        If the available_actions array contains the none action, or contains the
        same action multiple times, the compositor must raise the invalid_action
        protocol error.

        Initially, no actions are available. */
TEXT_INPUT_V3_SET_AVAILABLE_ACTIONS :: 8
text_input_v3_set_available_actions :: proc "contextless" (text_input_v3_: ^text_input_v3, available_actions_: array) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_AVAILABLE_ACTIONS, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, available_actions_)
}

/* Requests an input panel to be shown (e.g. a on-screen keyboard).

	This request only hints the desired interaction pattern from the
	client side, and its effect may be ignored by compositors given
	other environmental factors. Repeated calls will be ignored. */
TEXT_INPUT_V3_SHOW_INPUT_PANEL :: 9
text_input_v3_show_input_panel :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SHOW_INPUT_PANEL, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Requests an input panel to be hidden.

	This request only hints the desired interaction pattern from the
	client side, and its effect may be ignored by compositors given
	other environmental factors. Repeated calls will be ignored. */
TEXT_INPUT_V3_HIDE_INPUT_PANEL :: 10
text_input_v3_hide_input_panel :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_HIDE_INPUT_PANEL, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

text_input_v3_listener :: struct {
/* Notification that this seat's text-input focus is on a certain surface.

        If client has created multiple text input objects, compositor must send
        this event to all of them.

        When the seat has the keyboard capability the text-input focus follows
        the keyboard focus. This event sets the current surface for the
        text-input object. */
	enter : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, surface_: ^wl.surface),

/* Notification that this seat's text-input focus is no longer on a
        certain surface. The client should reset any preedit string previously
        set.

        The leave notification clears the current surface. It is sent before
        the enter notification for the new focus. After leave event, compositor
        must ignore requests from any text input instances until next enter
        event.

        When the seat has the keyboard capability the text-input focus follows
        the keyboard focus. */
	leave : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, surface_: ^wl.surface),

/* Notify when a new composing text (pre-edit) should be set at the
        current cursor position. Any previously set composing text must be
        removed. Any previously existing selected text must be removed.

        The argument text contains the pre-edit string buffer.

        The parameters cursor_begin and cursor_end are counted in bytes
        relative to the beginning of the submitted text buffer. Cursor should
        be hidden when both are equal to -1.

        They could be represented by the client as a line if both values are
        the same, or as a text highlight otherwise.

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next zwp_text_input_v3.done event.

        The initial value of text is an empty string, and cursor_begin,
        cursor_end and cursor_hidden are all 0. */
	preedit_string : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, text_: cstring, cursor_begin_: int, cursor_end_: int),

/* Notify when text should be inserted into the editor widget. The text to
        commit could be either just a single character after a key press or the
        result of some composing (pre-edit).

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next zwp_text_input_v3.done event.

        The initial value of text is an empty string. */
	commit_string : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, text_: cstring),

/* Notify when the text around the current cursor position should be
        deleted.

        Before_length and after_length are the number of bytes before and after
        the current cursor index (excluding the selection) to delete.

        If a preedit text is present, in effect before_length is counted from
        the beginning of it, and after_length from its end (see done event
        sequence).

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next zwp_text_input_v3.done event.

        The initial values of both before_length and after_length are 0. */
	delete_surrounding_text : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, before_length_: uint, after_length_: uint),

/* Instruct the application to apply changes to state requested by the
        preedit_string, commit_string delete_surrounding_text, and action
        events.

        The state relating to these events is double-buffered, and each one
        modifies the pending state. This event replaces the current state with
        the pending state.

        The application must proceed by evaluating the changes in the following
        order:

        1. Replace existing preedit string with the cursor.
        2. Delete requested surrounding text.
        3. Insert commit string with the cursor at its end.
        4. Calculate surrounding text to send.
        5. Insert new preedit text in cursor position.
        6. Place cursor inside preedit text.
        7. Perform the requested action.

        The serial number reflects the last state of the zwp_text_input_v3
        object known to the compositor. The value of the serial argument must
        be equal to the number of commit requests already issued on that object.

        When the client receives a done event with a serial different than the
        number of past commit requests, it must proceed with evaluating and
        applying the changes as normal, except it should not change the current
        state of the zwp_text_input_v3 object. All pending state requests
        (set_surrounding_text, set_content_type and set_cursor_rectangle) on
        the zwp_text_input_v3 object should be sent and committed after
        receiving a zwp_text_input_v3.done event with a matching serial. */
	done : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, serial_: uint),

/* An action was performed on this text input.

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next zwp_text_input_v3.done event.

        The initial value of action is none. */
	action : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, action_: text_input_v3_action, serial_: uint),

/* Notify the application of language used by the input method.

        This event will be sent on creation if known and for all subsequent changes.

        The language should be specified as an IETF BCP 47 tag.
        Setting an empty string will reset any known language back to the default unknown state. */
	language : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, language_: cstring),

/* Notify of contextual hints for the pre-edit string. This
        event is always sent together with a zwp_text_input_v3.preedit_string
        event.

        The parameters start and end are counted in bytes relative to the
        beginning of the text buffer submitted through
        zwp_text_input_v3.preedit_string, and represent the substring in the
        pre-edit text affected by the hint.

        Multiple events may be submitted if the preedit string has different
        sections. The extent of hints may overlap. The parts of the preedit
        string that are not covered by any zwp_text_input_v3.preedit_hint event,
        the text will be considered unhinted. This is also the case if no
        preedit_hint event is sent.

        Clients should provide recognizable visuals to these hints. if they are
        unable to comply with this requisition, it may be preferable for them
        keep the preedit_shown content hint disabled.

        Values set with this event are double-buffered. They must be applied
        and reset on the next zwp_text_input_v3.done event. */
	preedit_hint : proc "c" (data: rawptr, text_input_v3: ^text_input_v3, start_: uint, end_: uint, hint_: text_input_v3_preedit_hint),

}
text_input_v3_add_listener :: proc "contextless" (text_input_v3_: ^text_input_v3, listener: ^text_input_v3_listener, data: rawptr) {
	proxy_add_listener(cast(^proxy)text_input_v3_, cast(^generic_c_call)listener,data)
}
/* Reason for the change of surrounding text or cursor posision. */
text_input_v3_change_cause :: enum {
	input_method = 0,
	other = 1,
}
/* Content hint is a bitmask to allow to modify the behavior of the text
        input. */
text_input_v3_content_hint :: enum {
	none = 0x0,
	completion = 0x1,
	spellcheck = 0x2,
	auto_capitalization = 0x4,
	lowercase = 0x8,
	uppercase = 0x10,
	titlecase = 0x20,
	hidden_text = 0x40,
	sensitive_data = 0x80,
	latin = 0x100,
	multiline = 0x200,
	on_screen_input_provided = 0x400,
	no_emoji = 0x800,
	preedit_shown = 0x1000,
}
/* The content purpose allows to specify the primary purpose of a text
        input.

        This allows an input method to show special purpose input panels with
        extra characters or to disallow some characters. */
text_input_v3_content_purpose :: enum {
	normal = 0,
	alpha = 1,
	digits = 2,
	number = 3,
	phone = 4,
	url = 5,
	email = 6,
	name = 7,
	password = 8,
	pin = 9,
	date = 10,
	time = 11,
	datetime = 12,
	terminal = 13,
}
/*  */
text_input_v3_error :: enum {
	invalid_action = 0,
}
/* A possible action to perform on a text input.

        The submit action is intended for input entries that expect some sort of
        activation after user interaction, e.g. the URL entry in a browser. */
text_input_v3_action :: enum {
	none = 0,
	submit = 1,
}
/* Style hints for the preedit string. */
text_input_v3_preedit_hint :: enum {
	whole = 1,
	selection = 2,
	prediction = 3,
	prefix = 4,
	suffix = 5,
	spelling_error = 6,
	compose_error = 7,
}
@(private)
text_input_v3_requests := []message {
	{"destroy", "", raw_data(text_input_unstable_v3_types)[0:]},
	{"enable", "", raw_data(text_input_unstable_v3_types)[0:]},
	{"disable", "", raw_data(text_input_unstable_v3_types)[0:]},
	{"set_surrounding_text", "sii", raw_data(text_input_unstable_v3_types)[0:]},
	{"set_text_change_cause", "u", raw_data(text_input_unstable_v3_types)[0:]},
	{"set_content_type", "uu", raw_data(text_input_unstable_v3_types)[0:]},
	{"set_cursor_rectangle", "iiii", raw_data(text_input_unstable_v3_types)[0:]},
	{"commit", "", raw_data(text_input_unstable_v3_types)[0:]},
	{"set_available_actions", "2a", raw_data(text_input_unstable_v3_types)[0:]},
	{"show_input_panel", "2", raw_data(text_input_unstable_v3_types)[0:]},
	{"hide_input_panel", "2", raw_data(text_input_unstable_v3_types)[0:]},
}

@(private)
text_input_v3_events := []message {
	{"enter", "o", raw_data(text_input_unstable_v3_types)[4:]},
	{"leave", "o", raw_data(text_input_unstable_v3_types)[5:]},
	{"preedit_string", "?sii", raw_data(text_input_unstable_v3_types)[0:]},
	{"commit_string", "?s", raw_data(text_input_unstable_v3_types)[0:]},
	{"delete_surrounding_text", "uu", raw_data(text_input_unstable_v3_types)[0:]},
	{"done", "u", raw_data(text_input_unstable_v3_types)[0:]},
	{"action", "2uu", raw_data(text_input_unstable_v3_types)[0:]},
	{"language", "2s", raw_data(text_input_unstable_v3_types)[0:]},
	{"preedit_hint", "2uuu", raw_data(text_input_unstable_v3_types)[0:]},
}

text_input_v3_interface : interface

/* A factory for text-input objects. This object is a global singleton. */
text_input_manager_v3 :: struct {}
text_input_manager_v3_set_user_data :: proc "contextless" (text_input_manager_v3_: ^text_input_manager_v3, user_data: rawptr) {
   proxy_set_user_data(cast(^proxy)text_input_manager_v3_, user_data)
}

text_input_manager_v3_get_user_data :: proc "contextless" (text_input_manager_v3_: ^text_input_manager_v3) -> rawptr {
   return proxy_get_user_data(cast(^proxy)text_input_manager_v3_)
}

/* Destroy the wp_text_input_manager object. */
TEXT_INPUT_MANAGER_V3_DESTROY :: 0
text_input_manager_v3_destroy :: proc "contextless" (text_input_manager_v3_: ^text_input_manager_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_manager_v3_, TEXT_INPUT_MANAGER_V3_DESTROY, nil, proxy_get_version(cast(^proxy)text_input_manager_v3_), 1)
}

/* Creates a new text-input object for a given seat. */
TEXT_INPUT_MANAGER_V3_GET_TEXT_INPUT :: 1
text_input_manager_v3_get_text_input :: proc "contextless" (text_input_manager_v3_: ^text_input_manager_v3, seat_: ^wl.seat) -> ^text_input_v3 {
	ret := proxy_marshal_flags(cast(^proxy)text_input_manager_v3_, TEXT_INPUT_MANAGER_V3_GET_TEXT_INPUT, &text_input_v3_interface, proxy_get_version(cast(^proxy)text_input_manager_v3_), 0, nil, seat_)
	return cast(^text_input_v3)ret
}

@(private)
text_input_manager_v3_requests := []message {
	{"destroy", "", raw_data(text_input_unstable_v3_types)[0:]},
	{"get_text_input", "no", raw_data(text_input_unstable_v3_types)[6:]},
}

text_input_manager_v3_interface : interface

@(private)
@(init)
init_interfaces_text_input_unstable_v3 :: proc "contextless" () {
	text_input_v3_interface.name = "zwp_text_input_v3"
	text_input_v3_interface.version = 2
	text_input_v3_interface.method_count = 11
	text_input_v3_interface.event_count = 9
	text_input_v3_interface.methods = raw_data(text_input_v3_requests)
	text_input_v3_interface.events = raw_data(text_input_v3_events)
	text_input_manager_v3_interface.name = "zwp_text_input_manager_v3"
	text_input_manager_v3_interface.version = 2
	text_input_manager_v3_interface.method_count = 2
	text_input_manager_v3_interface.event_count = 0
	text_input_manager_v3_interface.methods = raw_data(text_input_manager_v3_requests)
}

// Functions from libwayland-client
import wl ".."
fixed_t :: wl.fixed_t
proxy :: wl.proxy
message :: wl.message
interface :: wl.interface
array :: wl.array
generic_c_call :: wl.generic_c_call
proxy_add_listener :: wl.proxy_add_listener
proxy_get_listener :: wl.proxy_get_listener
proxy_get_user_data :: wl.proxy_get_user_data
proxy_set_user_data :: wl.proxy_set_user_data
proxy_get_version :: wl.proxy_get_version
proxy_marshal :: wl.proxy_marshal
proxy_marshal_flags :: wl.proxy_marshal_flags
proxy_marshal_constructor :: wl.proxy_marshal_constructor
proxy_destroy :: wl.proxy_destroy
