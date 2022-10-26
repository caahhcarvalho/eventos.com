<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/painel/header.jsp" />

<!-- Pagina com o Conteudo -->
<div class="content-wrapper">
    <div class="content-header">
        <div class="container-fluid">
            <!-- Page Heading -->
            <p class="mb-4">Planilha de Registros</p>
            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <table id="datatable" class="display">
                        <thead>
                            <tr>
                                <th align="center">ID</th>
                                <th align="center">Descri��o</th>
                                <th align="center"></th>
                                <th align="center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tipoTrabalho" items="${tipoTrabalhos}">
                                <tr>
                                    <td align="right">${tipoTrabalho.idTipoTrabalho}</td>
                                    <td align="left">${tipoTrabalho.descricao}</td>
                                    <td align="center">
                                        <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                           data-id="" onclick="setDadosModal(${tipoTrabalho.idTipoTrabalho})">
                                            <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                    </td>
                                    <td align="center">
                                        <a href="#" onclick="deletar(${tipoTrabalho.idTipoTrabalho}, '${tipoTrabalho.situacao}')">
                                            <button class="btn
                                                    <c:out value="${tipoTrabalho.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                <i class="fas fa-fw
                                                   <c:out value="${tipoTrabalho.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                <Strong>
                                                    <c:out value="${tipoTrabalho.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>
                                                </Strong>
                                            </button></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="modaladicionar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-x1">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idtipotrabalho" id="idtipotrabalho" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <label>Descri��o</label>
                                <input class="form-control" type="text" name="descricao" id="descricao" value=""/>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <a href="#" onclick="validarCampos()">
                                    <button type="button" class="btn btn-success">Salvar</button>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<style type="text/css">
    .inputfile{
        /* visibility: hidden etc. wont work */
        width: 0.1px;
        height: 0.1px;
        opacity: 0;
        overflow: hidden;
        position: absolute;
        z-index: -1;}
    .inputfile:focus + label{
        /* keyboard navigation */
        outline: 1px dotted #000;
        outline: -webkit-focus-ring-color auto 5px;}
    .inputfile + label * {
        pointer-events: none;}
    .borda{
        position: relative;
        margin: 0 20px 30px 0;
        padding: 10px;
        border: 1px solid #e1e1e1;
        border-radius: 3px;
        background: #fff;
        -webkit-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        -moz-box-shadow: 0px 0px 3px rgba(0,0,0,0.06);
        box-shadow: 0px 0px 3px rgba(0,0,0,0.06);}
</style>

<script>
    $(document).ready(function () {
        console.log('entrei ready');
        //Carregamos a datatable
        $('#datatable').DataTable({
            "oLanguage": {
                "sProcessing": "Processando...",
                "sLengthMenu": "Mostrar _MENU_ registros",
                "sZeroRecords": "Nenhum registro encontrado.",
                "sInfo": "Mostrando de _START_ at� _END_ de _TOTAL_ registros",
                "sInfoEmpty": "Mostrando de 0 at� 0 de 0 registros",
                "sInfoFiltered": "",
                "sinfoPostFix": "",
                "sSearch": "Buscar:",
                "sUrl": "",
                "oPaginate": {
                    "sFirst": "Primeiro",
                    "sPrevious": "Anterior",
                    "sNext": "Seguinte",
                    "sLast": "�ltimo"
                }
            }
        });
    });

    var cidade = ''; //variavel para controle do carregamento de cidades
    function limparDadosModal() {
        $('#idtipotrabalho').val("0");
        $('#descricao').val("");
        $('#situacao').val("");
    }

    function setDadosModal(valor) {
        limparDadosModal();
        document.getElementById('idtipotrabalho').value = valor;
        var idTipoTrabalho = valor;
        if (idTipoTrabalho != "0") {
            $.getJSON('TipoTrabalhoCarregar', {idTipoTrabalho: idTipoTrabalho}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idTipoTrabalho;
                if (id != "0") {
                    $('#idtipotrabalho').val(respostaServlet.idTipoTrabalho);
                    $('#descricao').val(respostaServlet.descricao);
                    $('#situacao').val(respostaServlet.situacao);
                }
            });
        }
    }

    function deletar(codigo, situacao) {
        var id = codigo;
        console.log(codigo);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        if (situacao == 'I') {
            titulo = "Voc� deseja realmente ativar o tipo de trabalho?";
            confirmButtonText = "Sim, ative o tipo de trabalho!";
            tituloConfirmacao = "Tipo de trabalho ativado com sucesso!";

        } else {
            titulo = "Voc� deseja realmente inativar o tipo de trabalho?";
            confirmButtonText = "Sim, inative o tipo de trabalho!";
            tituloConfirmacao = "Tipo de trabalho inativado com sucesso!";
        }

        Swal.fire({
            title: 'Voc� tem certeza?',
            text: titulo,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: confirmButtonText,
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/TipoTrabalhoExcluir',
                    data: {
                        idTipoTrabalho: id
                    },
                    success:
                            function (data) {
                                if (data == 1) {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'success',
                                        title: 'Sucesso',
                                        text: tituloConfirmacao,
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'N�o foi poss�vel ativar/inativar o Tipo de Trabalho!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na valida��o de campos");
        if (document.getElementById("descricao").value == '') {
            Swal.fire({
                position: 'center',
                icon: 'error',
                title: 'Verifique a descri��o do Tipo do Trabalho',
                showConfirmButton: true,
                timer: 2000
            });
            $("#descricao").focus();
        } else {
            gravarDados();
        }
    }

    function gravarDados() {
        console.log("Gravando dados ....");

        $.ajax({
            type: 'post',
            url: 'TipoTrabalhoCadastrar',
            data: {
                idtipotrabalho: $('#idtipotrabalho').val(),
                descricao: $('#descricao').val(),
                situacao: $("#situacao").val()
            },
            success:
                    function (data) {
                        console.log("reposta servlet->");
                        console.log(data);
                        if (data == 1) {
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Sucesso',
                                text: 'Tipo de trabalho gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'N�o foi poss�vel gravar o Tipo do Trabalho!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/TipoTrabalhoListar";
                    }
        });
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Tipo de Trabalho</strong>";
        document.getElementById('agrupamentofornecedor').classList.add("menu-open");
        document.getElementById('menufornecedoragrupamento').classList.add("active");
        document.getElementById('menutipotrabalho').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

</script>
<%@include file="/painel/footer.jsp"%>