/**
 * Created by mingfei on 6/27/17.
 */
$(function () {
//            $.fn.bootstrapSwitch.defaults.size = 'mini';
    $("[name='night-mode']").bootstrapSwitch();
    $("[name='font-mode']").bootstrapSwitch();
    $('#sign-up').click(function () {
        console.log('sign up...');
        window.location.href = "sign_up.jsp";
    });
    $('#write-note').click(function () {
        window.location.href = 'write_note.jsp';
    });
});