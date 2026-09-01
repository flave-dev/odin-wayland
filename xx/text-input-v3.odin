#+build linux
package xx
@(private)
xx_text_input_unstable_v3_types := []^interface {
	nil,
	nil,
	nil,
	nil,
	&wl.surface_interface,
	&wl.surface_interface,
	&text_input_v3_interface,
	&wl.seat_interface,
}
/* The xx_text_input_v3 interface represents text input and input methods
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
      xx_text_input_v3.enter and xx_text_input_v3.leave events. The focused
      surface must commit xx_text_input_v3.enable and
      xx_text_input_v3.disable requests as the keyboard focus moves across
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

/* Destroy the xx_text_input object. Also disables all surfaces enabled
        through this xx_text_input object. */
TEXT_INPUT_V3_DESTROY :: 0
text_input_v3_destroy :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_DESTROY, nil, proxy_get_version(cast(^proxy)text_input_v3_), 1)
}

/* Requests text input on the surface previously obtained from the enter
        event.

        This request must be issued every time the active text input changes
        to a new one, including within the current surface. Use
        xx_text_input_v3.disable when there is no longer any input focus on
        the current surface.

        Clients must not enable more than one text input on the single seat
        and should disable the current text input before enabling the new one.
        At most one instance of text input may be in enabled state per instance,
        Requests to enable the another text input when some text input is active
        must be ignored by compositor.

        This request resets all state associated with previous enable, disable,
        set_surrounding_text, set_text_change_cause, set_content_type, and
        set_cursor_rectangle requests, as well as the state associated with
        preedit_string, commit_string, delete_surrounding_text, and action
        events.

        The set_surrounding_text, set_content_type and set_cursor_rectangle
        requests must follow if the text input supports the necessary
        functionality.

        State set with this request is double-buffered. It will get applied on
        the next xx_text_input_v3.commit request, and stay valid until the
        next committed enable or disable request.

        The changes must be applied by the compositor after issuing a
        xx_text_input_v3.commit request. */
TEXT_INPUT_V3_ENABLE :: 1
text_input_v3_enable :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_ENABLE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Explicitly disable text input on the current surface (typically when
        there is no focus on any text entry inside the surface).

        State set with this request is double-buffered. It will get applied on
        the next xx_text_input_v3.commit request. */
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
        on the next xx_text_input_v3.commit request, and stay valid until the
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
        and reset to initial at the next xx_text_input_v3.commit request.

        The initial value of cause is input_method. */
TEXT_INPUT_V3_SET_TEXT_CHANGE_CAUSE :: 4
text_input_v3_set_text_change_cause :: proc "contextless" (text_input_v3_: ^text_input_v3, cause_: text_input_v3_change_cause) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_TEXT_CHANGE_CAUSE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, cause_)
}

/* Sets the content purpose and content hint. While the purpose is the
        basic purpose of an input field, the hint flags allow to modify some of
        the behavior.

        Values set with this request are double-buffered. They will get applied
        on the next xx_text_input_v3.commit request.
        Subsequent attempts to update them may have no effect. The values
        remain valid until the next committed enable or disable request.

        The initial value for hint is none, and the initial value for purpose
        is normal. */
TEXT_INPUT_V3_SET_CONTENT_TYPE :: 5
text_input_v3_set_content_type :: proc "contextless" (text_input_v3_: ^text_input_v3, hint_: text_input_v3_content_hint_flags, purpose_: text_input_v3_content_purpose) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_CONTENT_TYPE, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, hint_, purpose_)
}

/* Marks an area around the cursor as a x, y, width, height rectangle in
        surface local coordinates.

        Allows the compositor to put a window with word suggestions near the
        cursor, without obstructing the text being input.

        If the client is unaware of the position of edited text, it should not
        issue this request, to signify lack of support to the compositor.

        Values set with this request are double-buffered. They will get applied
        on the next xx_text_input_v3.commit request, and stay valid until the
        next committed enable or disable request.

        The initial values describing a cursor rectangle are empty. That means
        the text input does not support describing the cursor area. If the
        empty values get applied, subsequent attempts to change them may have
        no effect. */
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
        each xx_text_input_v3 object and use the count as the serial in done
        events. */
TEXT_INPUT_V3_COMMIT :: 7
text_input_v3_commit :: proc "contextless" (text_input_v3_: ^text_input_v3) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_COMMIT, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0)
}

/* Announces the actions available for the currently active text input.

        Values set with this event are double-buffered. They will get applied
        on the next .done event.
        They get reset to the initial value on the next committed deactivate event.

        The initial value is an empty set: no actions are available.
        
        Values in the available_actions array come from text-input-v3.action. */
TEXT_INPUT_V3_SET_AVAILABLE_ACTIONS :: 8
text_input_v3_set_available_actions :: proc "contextless" (text_input_v3_: ^text_input_v3, available_actions_: array) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_SET_AVAILABLE_ACTIONS, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, available_actions_)
}

/* Notifies the input method what the currently active text input client is able to do.

        This event should come within the same .done sequence as .activate. Otherwise, the input method may ignore it.
        
        Values set with this event are double-buffered. They will get applied
        on the next .done event.
        They get reset to initial on the next committed deactivate event.

        The initial value for features is none. */
TEXT_INPUT_V3_ANNOUNCE_SUPPORTED_FEATURES :: 9
text_input_v3_announce_supported_features :: proc "contextless" (text_input_v3_: ^text_input_v3, features_: text_input_v3_supported_features_flags) {
	proxy_marshal_flags(cast(^proxy)text_input_v3_, TEXT_INPUT_V3_ANNOUNCE_SUPPORTED_FEATURES, nil, proxy_get_version(cast(^proxy)text_input_v3_), 0, features_)
}

text_input_v3_listener :: struct {
/* Notification that this seat's text-input focus is on a certain surface.

        If client has created multiple text input objects, compositor must send
        this event to all of them.

        When the seat has the keyboard capability the text-input focus follows
        the keyboard focus. This event sets the current surface for the
        text-input object. */
	enter : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, surface_: ^wl.surface),

/* Notification that this seat's text-input focus is no longer on a
        certain surface. The client should reset any preedit string previously
        set.

        The leave notification clears the current surface. It is sent before
        the enter notification for the new focus. After leave event, compositor
        must ignore requests from any text input instances until next enter
        event.

        When the seat has the keyboard capability the text-input focus follows
        the keyboard focus. */
	leave : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, surface_: ^wl.surface),

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
        and reset to initial on the next xx_text_input_v3.done event.

        The initial value of text is an empty string, and cursor_begin,
        cursor_end and cursor_hidden are all 0. */
	preedit_string : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, text_: cstring, cursor_begin_: int, cursor_end_: int),

/* Notify when text should be inserted into the editor widget. The text to
        commit could be either just a single character after a key press or the
        result of some composing (pre-edit).

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next xx_text_input_v3.done event.

        The initial value of text is an empty string. */
	commit_string : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, text_: cstring),

/* Notify when the text around the current cursor position should be
        deleted.

        Before_length and after_length are the number of bytes before and after
        the current cursor index (excluding the selection) to delete.
        
        If text is selected, it must be deleted.

        If indices exceed the available text boundaries, they should be adjusted to fit in boundaries and deletion reattempted.
        If indices do not lie on byte boundaries, then the text input client should delete at least that many bytes. In this case, the client decides the end point, but a character boundary same as when deleting using the keyboard is recommended.

        If a preedit text is present, in effect before_length is counted from
        the beginning of it, and after_length from its end (see done event
        sequence).

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next xx_text_input_v3.done event.

        The initial values of both before_length and after_length are 0. */
	delete_surrounding_text : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, before_length_: uint, after_length_: uint),

/* Unselects text, moves the cursor and selects text.

        This is equivalent to dragging the mouse over some text: it deselects whatever might be currently selected and selects a new range of text.

        The offsets used in arguments are in bytes relative to the current cursor position. Cursor is the new position of the cursor, and anchor is the opposite end of selection. If there's no selection, anchor should be equal to cursor.
        In terms of dragging the mouse, the anchor is the start, and cursor the end.
        
        The offsets do not take preedit contents into account, nor is preedit changed in any way with this request.
        
        Both cursor and anchor must fall on code point boundaries, otherwise text input client may ignore the request. It is therefore not recommended for an input method to move any of them beyond the text received in surrounding_text.
        <!-- Code point boundary checking must happen in the application because no one else is obliged to track the contents.
        There are two ways to handle it:
        
        1. add a request from the application informing the compositor of the mistake, so that the compositor can send an error and crash the input method, giving it the chance to reset and go back to normal
        2. just ignore the request and hope the input method can resynchronize through surrounding_text
        
        Choosing 2. because it's easier to implement.
        -->

        When surrounding_text is not supported, the offsets must not be interpreted as bytes, but as some human-readable unit at least as big as a code point, for example a grapheme.
        
        The cursor and anchor arguments can also take the following special values:
        BEGINNING := 0x8000_0000 = i32::MIN
        END := 0x7fff_ffff = i32::MAX
        meaning, respectively, the beginning and the end of of all text in the input field.

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next commit request.

        The initial values of both cursor and anchor are 0. */
	move_cursor : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, cursor_: int, anchor_: int),

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
        4. Move the cursor and selection.
        5. Calculate surrounding text to send.
        6. Insert new preedit text in cursor position.
        7. Place cursor inside preedit text.
        8. Perform the requested action.

        Serial handling starting version 2:
        
        The argument "serial" is ignored.

        Serial handling version 1:
        
        The serial number reflects the last state of the xx_text_input_v3
        object known to the compositor. The value of the serial argument must
        be equal to the number of commit requests already issued on that object.

        When the client receives a done event with a serial different than the
        number of past commit requests, it must proceed with evaluating and
        applying the changes as normal, except it should not change the current
        state of the xx_text_input_v3 object. All pending state requests
        (set_surrounding_text, set_content_type and set_cursor_rectangle) on
        the xx_text_input_v3 object should be sent and committed after
        receiving a xx_text_input_v3.done event with a matching serial. */
	done : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, serial_: uint),

/* The input method issued an action to perform on this text input.

        Values set with this event are double-buffered. They must be applied
        and reset to initial on the next .done event.

        The initial value of action is none. */
	perform_action : proc "c" (data: rawptr, text_input_v3_: ^text_input_v3, action_: text_input_v3_action),

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
	none = 0,
	completion = 1,
	spellcheck = 2,
	auto_capitalization = 3,
	lowercase = 4,
	uppercase = 5,
	titlecase = 6,
	hidden_text = 7,
	sensitive_data = 8,
	latin = 9,
	multiline = 10,
}
text_input_v3_content_hint_flags :: bit_set[text_input_v3_content_hint; u32]
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
/* A possible action to perform on a text input. */
text_input_v3_action :: enum {
	none = 1,
	finish = 0,
}
/* Client functionality over the baseline that isn't indicated implicitly.

        This does not include events coming with .enable: when the input method receives such an event, it is clear the text input supports it, e.g. content_type, available_actions.

        Baseline functionality like commit_string, set_preedit_string must always be supported for the protocol to be useful.
        
        The flags match text-input protocol versions, but should be kept general enough to support other protocols. */
text_input_v3_supported_features :: enum {
	none = 0,
	move_cursor = 1,
}
text_input_v3_supported_features_flags :: bit_set[text_input_v3_supported_features; u32]
@(private)
text_input_v3_requests := []message {
	{"destroy", "", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"enable", "", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"disable", "", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"set_surrounding_text", "sii", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"set_text_change_cause", "u", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"set_content_type", "uu", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"set_cursor_rectangle", "iiii", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"commit", "", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"set_available_actions", "2a", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"announce_supported_features", "2u", raw_data(xx_text_input_unstable_v3_types)[0:]},
}

@(private)
text_input_v3_events := []message {
	{"enter", "o", raw_data(xx_text_input_unstable_v3_types)[4:]},
	{"leave", "o", raw_data(xx_text_input_unstable_v3_types)[5:]},
	{"preedit_string", "?sii", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"commit_string", "?s", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"delete_surrounding_text", "uu", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"move_cursor", "2ii", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"done", "u", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"perform_action", "2u", raw_data(xx_text_input_unstable_v3_types)[0:]},
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

/* Destroy the xx_text_input_manager object. */
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
	{"destroy", "", raw_data(xx_text_input_unstable_v3_types)[0:]},
	{"get_text_input", "no", raw_data(xx_text_input_unstable_v3_types)[6:]},
}

text_input_manager_v3_interface : interface

@(private)
@(init)
init_interfaces_xx_text_input_unstable_v3 :: proc "contextless" () {
	text_input_v3_interface.name = "xx_text_input_v3"
	text_input_v3_interface.version = 3
	text_input_v3_interface.method_count = 10
	text_input_v3_interface.event_count = 8
	text_input_v3_interface.methods = raw_data(text_input_v3_requests)
	text_input_v3_interface.events = raw_data(text_input_v3_events)
	text_input_manager_v3_interface.name = "xx_text_input_manager_v3"
	text_input_manager_v3_interface.version = 3
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
