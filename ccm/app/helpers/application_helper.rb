module ApplicationHelper

  # utility to make a colapsable html/javascript string
  def colapsestring(idstring, instring, maxLen, isOpen, activeText)
    len = instring.length
    isOpen = ((isOpen != nil) ? isOpen : false)
    activeText = ((activeText != nil) ? activeText : false)
    
    out = ""
    if (len <= maxLen) then
      out = instring
    else
      #head = instring[0..maxLen]
      head = getDisplayString(instring, maxLen)
      out = <<EOF

<!--img src=/images/nolines_#{((isOpen) ? "minus" : "plus")}.gif id=ci#{idstring} border=0 onClick=showHide#{idstring}()-->
<div id=csc#{idstring} style="display:'#{((!isOpen) ? "" : "none")}'"#{((activeText) ? " onClick=showHide#{idstring}()" : "")}>
<img src=/images/nolines_plus.gif id=ci#{idstring}1 border=0#{((!activeText) ? " onClick=showHide#{idstring}()" : "")}>
#{head} ...</div>
<div id=cso#{idstring} style="display:'#{((isOpen) ? "" : "none")}'"#{((activeText) ? " onClick=showHide#{idstring}()" : "")}>
<img src=/images/nolines_minus.gif id=ci#{idstring}2 border=0#{((!activeText) ? " onClick=showHide#{idstring}()" : "")}>
#{instring}
</div>
<script language=javascript><!--
    function showHide#{idstring} () {
        myImg = document.getElementById('ci#{idstring}');
        mySectionOpen = document.getElementById('cso#{idstring}');
        mySectionClosed = document.getElementById('csc#{idstring}');
        if (mySectionOpen.style.display=='none') {
            mySectionOpen.style.display='block';
            mySectionClosed.style.display='none';
            //myImg.src='/images/nolines_minus.gif';
        } else {
            mySectionOpen.style.display='none';
            mySectionClosed.style.display='block';
            //myImg.src='/images/nolines_plus.gif';
        }
    }
    // Firefox hack
    mySectionOpen = document.getElementById('cso#{idstring}');
    mySectionClosed = document.getElementById('csc#{idstring}');
    mySectionOpen.style.display='#{((isOpen) ? "block" : "none")}';
    mySectionClosed.style.display='#{((isOpen) ? "none" : "block")}';

    //-->
</script>
EOF
      out
    end
  end
  
  # get the label for the application
  def applicationLabel
    conf = Configvalue.where(:name => :applicationlabel).first
    label = conf.value
    label
  end
  
  # truncate a string to a given length
  def getDisplayString(item, maxLen)
    out = item
    if (item.length > maxLen) then
      out = out[0..maxLen]
      out = out.gsub(/\s\S+\z/, '')
      out = out.gsub(/\s+\z/, '')
      out = out.gsub(/<[^>]*\z/, '')
    end
    out
  end

  # generate the string of who is logged in where
  def logged_in_string
    s = "Logged in on #{Rails.env} as #{current_user.email}"
    g = current_user.group_name
    s += " (#{current_user.group_name})" unless g.blank? or g == 'user'
    s
  end

end
