window.disable_payment = function() {
  return $(".payment-method").hide();
};

window.enable_payment = function() {
  return $(".payment-method").show();
};

$(document).ready(function() {
  Iugu.setAccountID("e1b83f70-191a-473c-b10a-24f357047206");

  $("#credit_card_details .credit_card_number").formatter({
    'pattern': '{{9999}} {{9999}} {{9999}} {{9999}}',
    'persistent': false
  });
  $("#credit_card_details .credit_card_expiration").formatter({
    'pattern': '{{99}}/{{99}}',
    'persistent': false
  });
  $("#credit_card_details .credit_card_cvv").formatter({
    'pattern': '{{9999}}'
  });
  $("#credit_card_details .credit_card_number").on("keyup", function(evt) {
    var brand, number;
    number = $(this).val();
    number = number.replace(/\ /g, "");
    number = number.replace(/\-/g, "");
    $("#credit_card_details").removeClass("visa");
    $("#credit_card_details").removeClass("mastercard");
    $("#credit_card_details").removeClass("amex");
    brand = Iugu.utils.getBrandByCreditCardNumber(number);
    if (brand) {
      $("#credit_card_details").addClass(brand);
      if (brand === "amex") {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{9999999}} {{99999}}');
      } else if (brand === "diners") {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{999999}} {{9999}}');
      } else {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{9999}} {{9999}} {{9999}}');
      }
    }
    return true;
  });
  $("form").submit(function(evt) {
    var form, name, tokenResponseHandler;
    form = $(this);
    form.find("button .btn-danger").prop('disabled', true);
    if ($('input[name=payment_method]:checked').val() === "credit_card" && $('input[name=credit_card_token]').val().length === 0) {
      evt.preventDefault();
      if ($('.payment-method').is(':hidden')) {
        return form.get(0).submit();
      }
      $("#credit_card_details").removeClass("has-error");
      name = $("#credit_card_details .credit_card_name").val().split(" ");
      $("#credit_card_details .credit_card_first_name").val(name.shift());
      $("#credit_card_details .credit_card_last_name").val(name.join(" "));
      tokenResponseHandler = function(data) {
        if (data.errors) {
          form.find("button .btn-danger").prop('disabled', false);
          return $("#credit_card_details").addClass("has-error");
        } else {
          $("#credit_card_token").val(data.id);
          return form.get(0).submit();
        }
      };
      Iugu.createPaymentToken(this, tokenResponseHandler);
    }
    return true;
  });
  if ($('#credit_card_token').val() !== "") {
    $("#credit_card_details").hide();
    disable_payment();
  }
  if ($('input[name=payment_method]:checked').val() === "bank_slip") {
    $("#credit_card_details").hide();
  }
  $(".payment-select label.credit_card").on("click", function(e) {
    return $("#credit_card_details").show();
  });
  $(".payment-select label.bank_slip").on("click", function(e) {
    return $("#credit_card_details").hide();
  });
  $('#bt_buscar_cep').bind('ajax:before', function() {
    return $(this).data('params', {
      cep: $('#cep').val()
    });
  });
  return $('#bt_buscar_cep').bind("ajax:success", function(evt, data, status, xhr) {
    $('#endereco').val(data.type + " " + data.description);
    $('#cidade').val(data.city);
    $('#estado').val(data.state);
    $('#bairro').val(data.neighborhood);
    return $('#uf').val(data.state);
  });
});
