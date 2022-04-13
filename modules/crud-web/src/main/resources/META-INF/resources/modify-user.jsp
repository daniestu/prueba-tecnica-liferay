<%@ include file="/init.jsp" %>
<%@ page import="com.ricoh.service.UsuarioLocalServiceUtil" %>
<%@ page import="com.ricoh.model.Usuario" %>
<%@ page import="java.text.SimpleDateFormat" %>

<portlet:actionURL name="update" var="update" />
<liferay-ui:success key="success" message="User saved succesfully!" />
<liferay-ui:error key="error" message="Sorry, you can´t use the form" />

<% 
	SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
	String id = renderRequest.getParameter("id"); 
	Usuario usuario = UsuarioLocalServiceUtil.getUsuario(Long.parseLong(id));
	String fecha = formatoFecha.format(usuario.getFecha_nac());
%>
<div class="container">
	<aui:form action="<%= update %>" id="frmUser" name="<portlet:namespace />fm">
	
		<aui:fieldset>
			<c:set var="nombre"><liferay-ui:message key="crudweb.nombre"/></c:set>
			<c:set var="apellidos"><liferay-ui:message key="crudweb.apellidos"/></c:set>
			<c:set var="correo"><liferay-ui:message key="crudweb.correo"/></c:set>
			<c:set var="fecha"><liferay-ui:message key="crudweb.fecha"/></c:set>
			<c:set var="aceptar"><liferay-ui:message key="crudweb.aceptar"/></c:set>
			<c:set var="cancelar"><liferay-ui:message key="crudweb.cancelar"/></c:set>
			
			<aui:input name="nombre" type="text" label="${nombre}" required="true" value="<%= usuario.getNombre() %>" >
				<aui:validator name="maxLength">50</aui:validator>
			</aui:input>
			<aui:input name="apellidos" type="text" label="${apellidos}" required="true" value="<%= usuario.getApellidos() %>">
				<aui:validator name="maxLength">50</aui:validator>
			</aui:input>
			<aui:input name="correo" type="email" label="${correo}" required="true" value="<%= usuario.getCorreo() %>">
			</aui:input>
			<aui:input name="fecha" type="date" label="${fecha}" required="true" value="<%= fecha %>">
			</aui:input>
			<aui:input type="hidden" name="id" value="<%= usuario.getUsuarioId() %>"></aui:input>
			
		</aui:fieldset>
		<aui:button-row>
			<aui:button type="submit" value="${aceptar}" />
	        <aui:button type="reset" value="${cancelar}" />
		</aui:button-row>
	</aui:form>
</div>