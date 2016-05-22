$(document).ready(function() {
   $('#blocks').bind('cocoon:before-insert', function(e,block_to_be_added) {
        block_to_be_added.fadeIn('slow');
    });

    $('#blocks').bind('cocoon:after-insert', function(e, added_block) {
        //added_block.css("background","red");
    });

    $('#blocks').on('cocoon:before-remove', function(e, block) {
        $(this).data('remove-timeout', 1000);
        block.fadeOut('slow');
    })
});
