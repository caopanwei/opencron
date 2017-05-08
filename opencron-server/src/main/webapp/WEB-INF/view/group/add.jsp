<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cron" uri="http://www.opencron.org" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/common/resource.jsp"/>

    <script type="text/javascript">

        function save() {
            var name = $("#name").val();
            if (!name) {
                alert("请填写/执行器组名称!");
                return false;
            }
        }

        $(document).ready(function () {

            $("#name").blur(function () {
                if (!$("#name").val()) {
                    $("#checkName").html("<font color='red'>" + '<i class="glyphicon glyphicon-remove-sign"></i>&nbsp;请填写/执行器组名' + "</font>");
                    return false;
                }
                $.ajax({
                    headers: {"csrf": "${csrf}"},
                    type: "POST",
                    url: "${contextPath}/group/checkname",
                    data: {
                        "name": $("#name").val()
                    },
                    success: function (data) {
                        if (data == "true") {
                            $("#checkName").html("<font color='green'>" + '<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;/执行器组名可用' + "</font>");
                            return false;
                        } else {
                            $("#checkName").html("<font color='red'>" + '<i class="glyphicon glyphicon-remove-sign"></i>&nbsp;/执行器组名已存在' + "</font>");
                            return false;
                        }
                    },
                    error: function () {
                        alert("网络繁忙请刷新页面重试!");
                        return false;
                    }
                });
            }).focus(function () {
                $("#checkName").html('<b>*&nbsp;</b>/执行器组名称必填');
            });

        });

    </script>

</head>
<jsp:include page="/WEB-INF/common/top.jsp"/>

<!-- Content -->
<section id="content" class="container">

    <!-- Messages Drawer -->
    <jsp:include page="/WEB-INF/common/message.jsp"/>

    <!-- Breadcrumb -->
    <ol class="breadcrumb hidden-xs">
        <li class="icon">&#61753;</li>
        当前位置：
        <li><a href="">opencron</a></li>
        <li><a href="">/执行器组管理</a></li>
        <li><a href="">添加/执行器组</a></li>
    </ol>
    <h4 class="page-title"><i aria-hidden="true" class="fa fa-plus"></i>&nbsp;添加执行器组</h4>

    <div style="float: right;margin-top: 5px">
        <a onclick="goback();" class="btn btn-sm m-t-10" style="margin-right: 16px;margin-bottom: -4px"><i
                class="fa fa-mail-reply" aria-hidden="true"></i>&nbsp;返回</a>
    </div>

    <div class="block-area" id="basic">
        <div class="tile p-15">
            <form class="form-horizontal" role="form" id="agent" action="${contextPath}/group/add" method="post"></br>
                <input type="hidden" name="csrf" value="${csrf}">
                <div class="form-group">
                    <label for="name" class="col-lab control-label"><i class="glyphicon glyphicon-leaf"></i>&nbsp;&nbsp;执行器组名：</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control input-sm" id="name" name="name">
                        <span class="tips" id="checkName"><b>*&nbsp;</b>执行器组名称必填</span>
                    </div>
                </div>
                <br>

                <div class="form-group" id="agentsDiv" style="display: ${u.roleId eq 999 ? 'none' : 'block'}">
                    <label class="col-lab control-label"><i class="fa fa-desktop" aria-hidden="true"></i>&nbsp;执行器成员：</label>
                    <div class="col-md-10">
                        <input type="checkbox" id="checkAllInput">全选<span class="tips">&nbsp;&nbsp;&nbsp;<b>*&nbsp;</b>该组下的执行器成员</span></br>
                        <div class="form-control m-b-10 input-sm" id="agent-content" style="height: 150px;overflow: hidden;">
                            <c:forEach var="w" items="${agents}" varStatus="index">
                                <input type="checkbox" name="agentIds" value="${w.agentId}" id="agent_${w.agentId}" class="each-box form-control input-sm">${w.name}&nbsp;&nbsp;${w.ip}<br>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="comment" class="col-lab control-label"><i class="glyphicon glyphicon-magnet"></i>&nbsp;&nbsp;描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述：</label>
                    <div class="col-md-10">
                        <textarea class="form-control input-sm" id="comment" name="comment"></textarea>
                    </div>
                </div>
                <br>

                <div class="form-group">
                    <div class="col-md-offset-1 col-md-10">
                        <button type="button" onclick="save()" class="btn btn-sm m-t-10"><i class="icon">&#61717;</i>&nbsp;保存
                        </button>&nbsp;&nbsp;
                        <button type="button" onclick="history.back()" class="btn btn-sm m-t-10"><i class="icon">&#61740;</i>&nbsp;取消
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</section>
<br/><br/>

<jsp:include page="/WEB-INF/common/footer.jsp"/>
