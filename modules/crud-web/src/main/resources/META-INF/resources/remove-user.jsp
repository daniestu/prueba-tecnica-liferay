<%@ include file="/init.jsp" %>
<%@ page import="com.ricoh.service.UsuarioLocalServiceUtil" %>

<portlet:actionURL name="remove" var="remove" />
<liferay-ui:success key="success" message="User saved succesfully!" />
<liferay-ui:error key="error" message="Sorry, you can´t use the form" />

<div class="container">
	<aui:form action="<%= remove %>" id="frmUser" name="<portlet:namespace />fm">
	
		<aui:fieldset>
			<c:set var="seleccionar"><liferay-ui:message key="crudweb.seleccionar"/></c:set>
			<c:set var="eliminar"><liferay-ui:message key="crudweb.eliminar"/></c:set>
			<c:set var="cancelar"><liferay-ui:message key="crudweb.cancelar"/></c:set>
			<aui:select name="idSelected" id="select" label="${seleccionar}">
				<%
					final List<Usuario> usuarios = UsuarioLocalServiceUtil.getUsuarios(-1, -1);
					for (Usuario usuario:usuarios) {
						
				%>
	            <aui:option value="<%= usuario.getUsuarioId() %>" class="form-control" id="exampleFormControlSelect1" name="idUsuario"><% out.print(usuario.getUsuarioId() + ", " + usuario.getNombre() + " " + usuario.getApellidos()); %></aui:option>
				<%	} %>
			</aui:select>
			
		</aui:fieldset>
		<aui:button-row>
			<aui:button type="submit" value="${eliminar}" />
	        <aui:button type="reset" value="${cancelar}" />
		</aui:button-row>
	</aui:form>

</div>
