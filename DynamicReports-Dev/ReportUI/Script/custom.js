//alert($("#input_group_widget ")+Math.random());
function dummy_fn() {
    console.log("dummy_fn");
}
function show_tab() {
    var report_option = $("#report_option").val();
    var active_class = "active";
    $("#modal-dialog2_href").css({ "opacity": "0.2" }).attr("data-toggle", "").off('click');
    if (report_option == "tbl_report") {
        $("#li_sub_report").removeClass(active_class).hide();
        $("#sub-report").removeClass(active_class);
        $("#li_tbl_report").addClass(active_class);
        $("#table-report").addClass(active_class).show();
    }
    else if (report_option == "sub_report") {
        $("#li_sub_report").removeClass(active_class).show();
        $("#sub-report").removeClass(active_class);
        $("#li_tbl_report").addClass(active_class);
        $("#table-report").addClass(active_class).show();
    }
    else if (report_option == "groupby_report") {
        console.log('GR');
        $("#modal-dialog2_href").css({ "opacity": "1" }).attr("data-toggle", "modal").on('click', dummy_fn);;//$("#modal-dialog2").attr("href","#modal-dialog2");
    }
}
$("[id^=submit_btn]").click(function () {
    var prefix = $(this).attr('name');	//alert(prefix);							
    $("#" + prefix + "-report #precond_chk").removeAttr("checked");
    $("#" + prefix + "-report #form_group_widget, #" + prefix + "-report #form_control_widget").hide();
    $("#" + prefix + "-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
});

//var precond_lbl = "Precondition - ";
////TABLE REPORT STARTS
//var tab_prefix = "table";
//function colum_radion_btn() {
//    //alert('colum_radion_btn');
//    $("#" + tab_prefix + "-report #input_group_widget input:radio").click(function () {
//        if ($(this).is(":checked")) {
//            $("#" + tab_prefix + "-report #form_group_widget").slideDown('fast');
//            var lbl = $(this).parent().next(".form-control").text();//alert($(this).parent().next().next().attr('class'));//lbl_colname
//            $("#" + tab_prefix + "-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
//            $(this).parent().next().next("#right_arrow").addClass("glyphicon glyphicon-menu-right");
//            $("#" + tab_prefix + "-report #lbl_colname").html(lbl);
//            $("#" + tab_prefix + "-report #lbl_colname2").html(precond_lbl + lbl);

//            //	$('#btnvalidate').attr("disabled", true);
//        } else {
//            $("#" + tab_prefix + "-report #form_group_widget").slideUp('fast');
//            $("#" + tab_prefix + "-report #form_control_widget").slideUp('fast');
//            $("#lbl_colname").html("");
//        }
//    });
//}
//colum_radion_btn();

function reorder_fields() {
    var tbl_report_id = "table-report";
    $('#' + tbl_report_id + " [id^=rlist]").addClass("input-group m-b-5");
    $('#' + tbl_report_id + " [id^=rspan]").addClass("input-group-addon");
    $('#' + tbl_report_id + " [id^=colname_]").addClass("form-control");

}

$("#" + tab_prefix + "-report #form_group_widget #precond_chk").click(function () {
    if ($(this).is(":checked")) {
        $("#" + tab_prefix + "-report #form_control_widget").slideDown('fast');
    } else {
        $("#" + tab_prefix + "-report #form_control_widget").slideUp('fast');
    }
});

$("#" + tab_prefix + "-report #in_between").change(function () {
    var in_between = $(this).val();
    if (in_between == "between") {
        $("#" + tab_prefix + "-report #form_control_widget #as_name").hide();
        $("#" + tab_prefix + "-report #form_control_widget #date_between").show();
    } else {
        $("#" + tab_prefix + "-report #form_control_widget #date_between").hide();
        $("#" + tab_prefix + "-report #form_control_widget #as_name").show();
    }

    if (in_between == "") {
        $("#" + tab_prefix + "-report #form_control_widget #date_between").hide();
        $("#" + tab_prefix + "-report #form_control_widget #as_name").show();
    }
});
// TABLE REPORT ENDS

// SUB REPORT STARTS
var tab_prefix2 = "sub";
$("#" + tab_prefix2 + "-report #input_group_widget input:radio").click(function () {
    if ($(this).is(":checked")) {
        $("#" + tab_prefix2 + "-report #form_group_widget").slideDown('fast');
        var lbl = $(this).parent().next(".form-control").text();//alert($(this).parent().next().next().attr('class'));//lbl_colname
        $("#" + tab_prefix2 + "-report [id^=right_arrow]").removeClass("glyphicon glyphicon-menu-right");
        $(this).parent().next().next("#right_arrow").addClass("glyphicon glyphicon-menu-right");
        $("#" + tab_prefix2 + "-report #lbl_colname").html(lbl);
        $("#" + tab_prefix2 + "-report #lbl_colname2").html(precond_lbl + lbl);
    } else {
        $("#" + tab_prefix2 + "-report #form_group_widget").slideUp('fast');
        $("#" + tab_prefix2 + "-report #form_control_widget").slideUp('fast');
        $("#lbl_colname").html("");
    }
});

$("#" + tab_prefix2 + "-report #form_group_widget #precond_chk").click(function () {
    if ($(this).is(":checked")) {
        $("#" + tab_prefix2 + "-report #form_control_widget").slideDown('fast');
    } else {
        $("#" + tab_prefix2 + "-report #form_control_widget").slideUp('fast');
    }
});

$("#" + tab_prefix2 + "-report #in_between").change(function () {
    var in_between = $(this).val();
    if (in_between == "between") {
        $("#" + tab_prefix2 + "-report #form_control_widget #as_name").hide();
        $("#" + tab_prefix2 + "-report #form_control_widget #date_between").show();
    } else {
        $("#" + tab_prefix2 + "-report #form_control_widget #date_between").hide();
        $("#" + tab_prefix2 + "-report #form_control_widget #as_name").show();
    }

    if (in_between == "") {
        $("#" + tab_prefix2 + "-report #form_control_widget #date_between").hide();
        $("#" + tab_prefix2 + "-report #form_control_widget #as_name").show();
    }
});

// SUB REPORT ENDS

/*$( ".tbl_field" ).draggable({
	//revert: "invalid",
	cursor: 'move',
    //helper: "clone",
	drag: function( event, ui ) {
		//currentDragId = $(this).attr('id');
		console.log("step 1 drag sTARTes  :");	
	},
	start: function(event, ui) { 
		
	},
	stop: function(event, ui) {                        

	}	
}); 

$("#input_group_widget").droppable({
    drop: function(event, ui) {
      var itemid = $(event.originalEvent.toElement).attr("id");
      $('.tbl_field').each(function() {
        if ($(this).attr("id") === itemid) {
          $(this).appendTo("#input_group_widget");
        }
      });
    }
  });*/
/* $(function() {
       $( "#sortable" ).sortable({ 
           placeholder: "ui-sortable-placeholder" 
       });
   });*/

/*$( "#input_group_widget" ).droppable({
	drop: function( event, ui ) {
		$( this ).addClass( "ui-state-highlight" );
		console.log("step 2 currentDragId :");			   
	}                
});*/