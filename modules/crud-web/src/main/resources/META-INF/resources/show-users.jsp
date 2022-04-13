<%@ include file="/init.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<portlet:renderURL var="modify">
	<portlet:param name="mvcPath" value="/modify-user.jsp" />
</portlet:renderURL>
<%
	List<Usuario> usuarios = (List<Usuario>) renderRequest.getAttribute("usuarios");
%>
<div class="container">
<c:set var="nombre"><liferay-ui:message key="crudweb.nombre"/></c:set>
<c:set var="apellidos"><liferay-ui:message key="crudweb.apellidos"/></c:set>
<c:set var="correo"><liferay-ui:message key="crudweb.correo"/></c:set>
<c:set var="fecha"><liferay-ui:message key="crudweb.fecha"/></c:set>
<c:set var="modificar"><liferay-ui:message key="crudweb.modificar"/></c:set>
<table class="table">
  <thead>
    <tr>
      <th scope="col">${nombre}</th>
      <th scope="col">${apellidos}</th>
      <th scope="col">${correo}</th>
      <th scope="col">${fecha}</th>
    </tr>
  </thead>
  <tbody>
  	<% for(Usuario usuario:usuarios){ 
  		SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
  		String fecha = formatoFecha.format(usuario.getFecha_nac());	
  	%>
  	<tr>
  		<td><%= usuario.getNombre() %></td>
  		<td><%= usuario.getApellidos() %></td>
  		<td><%= usuario.getCorreo() %></td>
  		<td><%= fecha %></td>
  		<td>
  		
  		<aui:form action="<%= modify %>" id="frmUser" name="<portlet:namespace />fm">
  			<aui:input type="hidden" name="id" value="<%= usuario.getUsuarioId() %>"/>
  			<aui:button class="btn btn-warning" type="submit" value="${modificar}"/>
  		</aui:form>
		</td>
  	</tr>
  	<%} %>
  </tbody>
</table>
</div>