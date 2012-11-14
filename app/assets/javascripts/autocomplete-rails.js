/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" autocomplete="/url/to/autocomplete">
*       
*/

$(document).ready(function(){
  $('input[autocomplete], input[data-autocomplete]').each(function(i){
    $(this).autocomplete({
      source: $(this).attr('autocomplete'),
      select: function(ui, li){
          var item = li.item;
          $(this).val(item.value)
          $("#search_form").submit();
        }
      });
  });



  $('input[member-name-autocomplete]').each(function(i){
    $(this).autocomplete({
      source: $(this).attr('member-name-autocomplete'),
      select: function(ui, li){
          var item = li.item;
          $('#members_card_member_id').val(item.id)
        }
      });
  });
});

function orderAutocomplete(){
	$('input[order_autocomplete]').each(function(i){
		$(this).autocomplete({
	      source:  $(this).attr('order_autocomplete'),
	      select:  function(ui,li){
	        var item = li.item;
	        var reqest_url  = "/book_records/complete_member_infos?id=" + item.id;
	        $.get(reqest_url,function(returned_data)
	        {
	          $('#rel_member').html(returned_data);
	        });
	      }			
		});
	});
}


function userAutocomplete(){
	$('input[user_autocomplete]').each(function(i){
		$(this).autocomplete({
	      source:  $(this).attr('user_autocomplete'),
	      select:  function(ui,li){
	        var item = li.item;
                var reqest_url  = "/members/" + item.id + "/member_cards_list";
                $('#member_id').val(item.id);
                
	        $.get(reqest_url,function(returned_data)
	        {
                options = '';
                $(returned_data).each(function(i,node){ options +=("<option value='" + node.members_card.id +
                    "' order_tip_message='" + node.members_card.members_card_info + 
                    "' can_buy_good='" + node.members_card.can_buy_good+ 
                    "' member_info='" + node.members_card.remaining_money_and_amount_in_chinese + 
                    "' card_info='" + node.members_card.card_info+ 
                    "'>"
                    + node.members_card.card_serial_num + "</option>") 
                    });



                $('#cards').html( "<select name='member_card_id'>" + options + "</select>");
                $('#cards select').live('change',function(){
                  var selected = $(this).find("option:selected");
                  $('#member_info').text(selected.attr('order_tip_message'));
                  $('#member_card_info').text(selected.attr('member_info'));
                  if(selected.attr('can_buy_good') == "no"){ $('#member_card_info').append("  [此卡不可消费商品]");}
                });
                $('#cards select').trigger("change");
	        });
	      }			
		});
	});
}



function goodAutocomplete(){
  $('input[good_autocomplete]').each(function(i){
    $(this).autocomplete({
      source:  $(this).attr('good_autocomplete'),
      select:  function(ui,li){
               var item = li.item;
               var sub_total = item.price;
               $('#price').text(item.price);
               $('#good_id').val(item.id);
               if($('#quantity').val() != "1"){
                sub_total = Number(item.price) * parseInt($('#quantity').val());
               }
               $('#sub_total').text(sub_total);
             }
    }		);	
  });
}


function member_card_Autocomplete(){
	$('input[member_card_autocomplete]').each(function(i){
		$(this).autocomplete({
	      source:  $(this).attr('member_card_autocomplete'),
	      select:  function(ui,li){
	        var item = li.item;
	        var reqest_url  = "/balances/member_by_member_card_serial_num?serial_num=" + item.value;
	        $.get(reqest_url,function(returned_data)
	        {
                $("#member_name").val(returned_data.name);
                $("#member_id").val(returned_data.id);
                $("#member_card_hidden_id").val(returned_data.id);
	        });

	      }			
		});
	});
}


