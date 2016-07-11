$(document).ready(function() {
   $('#blocks').bind('cocoon:before-insert', function(e,block_to_be_added) {
        block_to_be_added.fadeIn('slow');
    });

    $('.block_links').bind('cocoon:after-insert', function(e, added_block) {
        added_block.append("<br> <hr> <br>");
        added_block.prepend("<h4> Novo Bloco </h4>");
    });

    $('#blocks').on('cocoon:before-remove', function(e, block) {
        $(this).data('remove-timeout', 1000);
        block.fadeOut('slow');
    })



    $(".add_modulos a").
      data("association-insertion-method", 'prepend').
      data("association-insertion-node", $(".components_form") );

   // $(".add_images a").
   //   data("association-insertion-method", 'prepend').
   //   data("association-insertion-node", $(".order_images_form") );

    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })

    $('#').tooltip('show')
});
