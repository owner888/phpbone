UE.registerUI('dialog',function(editor,uiName){
    //����dialog
    var url = window.location.href;
    url = url.replace(/ac=(.*)/,"ac=index&_t="+new Date().getTime());
    var dialog = new UE.ui.Dialog({
        //ָ����������ҳ���·��������ֻ��֧��ҳ��,��Ϊ��addCustomizeDialog.js��ͬĿ¼�����������·��
        iframeUrl:url,
        //��Ҫָ����ǰ�ı༭��ʵ��
        editor:editor,
        //ָ��dialog������
        name:uiName,
        //dialog�ı���
        title:"insert_link",
        //ָ��dialog����Χ��ʽ
        cssRules:"width:880px;height:440px;",
        //���������buttons�ʹ���dialog��ȷ����ȡ��
        buttons:[
            {
                className:'edui-okbutton',
                label:'confirm',
                onclick:function () {
                    var iframeWindow =  document.getElementById(dialog.id+'_iframe');
                    var iframeDoc = iframeWindow.contentDocument || iframeWindow.contentWindow.document;
                    var checkBox = iframeDoc.getElementsByName('id[]');
                    var text = null;
                    var jiaochengID = '';
                    var linkObj = {
                        'href' : '',
                        'target' :'_blank',
                        'title' : '',
                        '_href': ''
                    };
                    var count = 0;
                    for(var i = 0; i < checkBox.length; i++) {
                        if (checkBox[i].checked) {
                            jiaochengID = checkBox[i].value;
                            if (!isNaN(jiaochengID)) {
                                text = iframeDoc.getElementById(jiaochengID).innerHTML;
                                if (text != null) {
                                    if (count > 0) {
                                        editor.execCommand('insertHtml', '&nbsp;');
                                    }
                                    linkObj.href = text;
                                    linkObj.title = text;
                                    linkObj._href = 'http://www.xiazaiba.com/gonglue/'+jiaochengID+'.html';
                                    editor.execCommand('link', linkObj);
                                    count++;
                                }
                            }
                        }
                   }
                   dialog.close(true);
                }
            },
            {
                className:'edui-cancelbutton',
                label:'cancel',
                onclick:function () {
                    dialog.close(false);
                }
            }
        ]});

    //�ο�addCustomizeButton.js
    var btn = new UE.ui.Button({
        name:'dialogbutton' + uiName,
        title:'������������',
        //��Ҫ��ӵĶ�����ʽ��ָ��iconͼ�꣬����Ĭ��ʹ��һ���ظ���icon
        cssRules :'background-position: -500px 0;',
        onclick:function () {
            //��Ⱦdialog
            dialog.render();
            dialog.open();
        }
    });

    return btn;
}/*index ָ����ӵ��������ϵ��Ǹ�λ�ã�Ĭ��ʱ׷�ӵ����,editorId ָ�����UI���Ǹ��༭��ʵ���ϵģ�Ĭ����ҳ�������еı༭��������������ť*/);