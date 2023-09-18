
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%
    
    int ano = 0;
    int mes = 0;
 
    if (request.getParameter("ano") != null && request.getParameter("mes") != null) {
        ano = Integer.parseInt(request.getParameter("ano"));
        mes = Integer.parseInt(request.getParameter("mes"));
    }

    Calendar calendar = Calendar.getInstance();
    calendar.set(ano, mes - 1, 1);   
    SimpleDateFormat mesFor = new SimpleDateFormat("MMMM yyyy", Locale.getDefault());

    String[] diaSemana = {"DOMINGO", "SEGUNDA", "TERÇA", "QUARTA", "QUINTA", "SEXTA", "SABADO"};
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Calendário</title>
</head>
<body>
    <table>
        <tr>
            <% for (String diasDaSemana : diaSemana) { %>
                <th><%= diasDaSemana %></th>
            <% } %>
        </tr>
        <%
            int DiaMaximo = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            int diasDaSemana = calendar.get(Calendar.DAY_OF_WEEK);
            boolean line = true;
            int diaAtual = 1;

            while (diaAtual <= DiaMaximo) {
                if (line) {
                    out.println("<tr>");
                    line = false;                    
                    for (int i = 1; i < diasDaSemana; i++) {
                        out.println("<td></td>");
                    }
                }
                out.println("<td>" + diaAtual + "</td>");
                if (diasDaSemana == Calendar.SATURDAY) {
                    out.println("</tr>");
                    line = true;
                }
                calendar.add(Calendar.DAY_OF_MONTH, 1);
                diasDaSemana = calendar.get(Calendar.DAY_OF_WEEK);
                diaAtual++;
            }
            
        %>
    </table>
     <p><%= mesFor.format(calendar.getTime()) %></p>
</body>
</html>