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
            <a href="#modaladicionar" class="btn btn-success mb-4 adicionar" data-toggle="modal" data-target=".bd-example-modal-lg" data-ad="" onclick="setDadosModal(${0})">
                <i class="fas fa-plus fa-fw"></i>Adicionar</a>
            <div class="card shadow">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="datatable" class="display">
                            <thead>
                                <tr>
                                    <th align="center">ID</th>
                                    <th align="center">Nome</th>
                                    <th align="center">CPF/CNPJ</th>
                                    <th align="center">Cidade - UF</th>
                                    <th align="center"></th>
                                    <th align="center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="organizador" items="${organizadores}">
                                    <tr>
                                        <td align="right">${organizador.idOrganizador}</td>
                                        <td align="left">${organizador.nomeRazaoPessoa}</td>
                                        <td align="left">${organizador.cpfCnpjPessoa}</td>
                                        <td align="left">${organizador.cidade.nomeCidade} - ${organizador.cidade.estado.siglaEstado}</td>
                                        <td align="center">
                                            <a href="#modaladicionar" class="btn btn-group-lg btn-primary" data-toggle="modal"
                                               data-id="" onclick="setDadosModal(${organizador.idOrganizador})">
                                                <i class="fas fa-edit"></i><Strong> Alterar </Strong> </a>
                                        </td>
                                        <td align="center">
                                            <a href="#" onclick="deletar(${organizador.idOrganizador}, '${organizador.situacao}')">
                                                <button class="btn
                                                        <c:out value="${organizador.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                    <i class="fas fa-fw
                                                       <c:out value="${organizador.situacao == 'A' ? 'fa-times' : 'fas fa-check'}"/>"></i>
                                                    <Strong>
                                                        <c:out value="${organizador.situacao == 'A' ? 'Inativar' : 'Ativar'}"/>
                                                    </Strong>
                                                </button></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal fade bd-example-modal-lg" id="modaladicionar" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Adicionar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group">
                                <input class="form-control" type="hidden" name="idpessoa" id="idpessoa" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="idorganizador" id="idorganizador" value="" readonly="readonly"/>
                                <input class="form-control" type="hidden" name="situacao" id="situacao" value="" readonly="readonly"/>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label id="labelcpfcnpj">CPF/CNPJ</label>
                                        <input class="form-control" type="text" name="cpfcnpjpessoa" id="cpfcnpjpessoa" value=""/>
                                    </div>
                                    <div class="col-sm">
                                        <label>RG/IE</label>
                                        <input class="form-control" type="text" name="rgiepessoa" id="rgiepessoa" value=""/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>Nome/Raz�o Social</label>
                                        <input class="form-control" type="text" name="nomerazaopessoa" id="nomerazaopessoa"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Logradouro</label>
                                        <input class="form-control" type="text" name="logradouropessoa" id="logradouropessoa"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>N�mero</label>
                                        <input class="form-control" type="text" name="numlogradouropessoa" id="numlogradouropessoa" value=""/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Bairro</label>
                                        <input class="form-control" type="text" name="bairropessoa" id="bairropessoa" value=""/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>CEP</label>
                                        <input class="form-control" type="text" name="ceppessoa" id="ceppessoa" value="" placeholder="00000-000" oninput="criaMascaraCEP()" maxLength="8"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>Estado</label>
                                        <select class="form-control" name="idestado" id="idestado" onchange="BuscarCidadesPorEstado()" required>
                                            <option value="nulo">Selecione</option>
                                            <c:forEach var="estado" items="${estados}">
                                                <option value="${estado.idEstado}" ${organizador.cidade.estado.idEstado == estado.idEstado ? "selected" : ""}>
                                                    ${estado.nomeEstado}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-sm">
                                        <label>Cidade</label>
                                        <select class="form-control" name="idcidade" id="idcidade" required>
                                            <option value="nulo">Selecione</option>
                                            <c:forEach var="cidade" items="${cidades}">
                                                <option value="${cidade.idCidade}" ${organizador.cidade.idCidade == cidade.idCidade ? "selected" : ""}>
                                                    ${cidade.nomeCidade} 
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label>Telefone</label>
                                        <input class="form-control" type="tel" name="telefonepessoa" id="telefonepessoa" value="" placeholder="(00) 00000-0000" oninput="criaMascaraTelefone()" maxLength="11"/>
                                    </div>
                                    <div class="col-sm">
                                        <label>E-mail</label>
                                        <input class="form-control" type="email" name="emailpessoa" id="emailpessoa" placeholder="exemplo@email.com"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="form-line row">
                                    <div class="col-sm">
                                        <label class="m-t-0 header-title">Data Nascimento/Funda��o</label>
                                        <input class="form-control" type="date" name="datanascfundpessoa" id="datanascfundpessoa" value=""/>
                                    </div>
                                    <div class="col-sm">
                                        <label id="labellogin">Login</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="inputGroupPrepend2">@</span>
                                            </div>
                                            <input class="form-control" type="text" name="login" id="login" value="" size="20" maxlength="20" required/>
                                        </div>
                                    </div>
                                    <div class="col-sm">
                                        <label>Senha</label>
                                        <input class="form-control" type="password" name="senha" id="senha" value="" size="20" maxlength="20" required/>
                                    </div>
                                </div>
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
        //$("#datatable").DataTable({});
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
        $('#idpessoa').val("0");
        $('#idorganizador').val("0");
        $('#situacao').val("");
        $('#cpfcnpjpessoa').val("");
        $('#rgiepessoa').val("");
        $('#nomerazaopessoa').val("");
        $('#datanascfundPessoa').val("");
        $('#telefonepessoa').val("");
        $('#logradouropessoa').val("");
        $('#numlogradouropessoa').val("");
        $('#bairropessoa').val("");
        $('#ceppessoa').val("");
        $('#emailpessoa').val("");
        $('#login').val("");
        $('#senha').val("");
        $('#idestado').val("0");
        //cidade = 0;
        //BuscarCidadesPorEstado(); //atualiza lista de cidades
    }

    function setDadosModal(valor) {
        limparDadosModal();
        document.getElementById('idpessoa').value = valor;
        document.getElementById('idorganizador').value = valor;
        document.getElementById('login').readOnly = false;
        document.getElementById('labellogin').innerHTML = "Login";
        document.getElementById('login').classList.remove("is-invalid");
        document.getElementById('login').classList.remove("is-valid");
        document.getElementById('labelcpfcnpj').innerHTML = "CPF/CNPJ";
        document.getElementById('cpfcnpjpessoa').classList.remove("is-valid");
        document.getElementById('cpfcnpjpessoa').classList.remove("is-invalid");
        var idAdm = valor;
        if (idAdm != "0") {
            //existe organizador para buscar (altera��o)
            $.getJSON('OrganizadorCarregar', {idOrganizador: idAdm}, function (respostaServlet) {
                console.log(respostaServlet);
                var id = respostaServlet.idOrganizador;
                if (id != "0") {
                    $('#idpessoa').val(respostaServlet.idPessoa);
                    $('#idorganizador').val(respostaServlet.idOrganizador);
                    $('#situacao').val(respostaServlet.situacao);
                    $('#cpfcnpjpessoa').val(respostaServlet.cpfCnpjPessoa);
                    $('#rgiepessoa').val(respostaServlet.rgIePessoa);
                    $('#nomerazaopessoa').val(respostaServlet.nomeRazaoPessoa);
                    $('#datanascfundpessoa').val(respostaServlet.dataNascFundPessoa);
                    $('#telefonepessoa').val(respostaServlet.telefonePessoa);
                    $('#logradouropessoa').val(respostaServlet.logradouroPessoa);
                    $('#numlogradouropessoa').val(respostaServlet.numLogradouroPessoa);
                    $('#bairropessoa').val(respostaServlet.bairroPessoa);
                    $('#ceppessoa').val(respostaServlet.cepPessoa);
                    $('#emailpessoa').val(respostaServlet.emailPessoa);
                    $('#login').val(respostaServlet.login);
                    $('#senha').val(respostaServlet.senha);
                    $('#idestado').val(respostaServlet.cidade.estado.idEstado);
                    cidade = respostaServlet.cidade.idCidade;
                    BuscarCidadesPorEstado(); //atualiza lista de cidades
                    document.getElementById('login').readOnly = true;
                }
                criaMascaraTelefone();
                trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                criaMascaraCEP();
            });
        }
    }

    function carregarPessoa(v) {
        //console.log("Entrou");
        var idM = v;
        var tipoPessoa = 'organizador';
        //console.log("Usuario = " + idM);
        $(document).ready(function () {
            $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaAdm) {
                console.log(respostaAdm);
                //var id = respostaAdm.idOrganizador;
                if (respostaAdm != null) {
                    $('#idorganizador').val(respostaAdm.idOrganizador);
                    $('#idpessoa').val(respostaAdm.idPessoa);
                    $('#situacao').val(respostaAdm.situacao);
                    $('#cpfcnpjpessoa').val(respostaAdm.cpfCnpjPessoa);
                    $('#rgiepessoa').val(respostaAdm.rgIePessoa);
                    $('#nomerazaopessoa').val(respostaAdm.nomeRazaoPessoa);
                    $('#datanascfundpessoa').val(respostaAdm.dataNascFundPessoa);
                    $('#telefonepessoa').val(respostaAdm.telefonePessoa);
                    $('#logradouropessoa').val(respostaAdm.logradouroPessoa);
                    $('#numlogradouropessoa').val(respostaAdm.numLogradouroPessoa);
                    $('#bairropessoa').val(respostaAdm.bairroPessoa);
                    $('#ceppessoa').val(respostaAdm.cepPessoa);
                    $('#emailpessoa').val(respostaAdm.emailPessoa);
                    $('#login').val(respostaAdm.login);
                    $('#senha').val(respostaAdm.senha);
                    var datanasc = respostaAdm.dataNascFundPessoa;
                    console.log(datanasc);
                    $('#datanascfundpessoa').val(datanasc);
                    $('#idestado').val(respostaAdm.cidade.estado.idEstado);
                    cidade = respostaAdm.cidade.idCidade;
                    BuscarCidadesPorEstado();
                    if ($('#login').val() != '') {
                        document.getElementById('login').readOnly = true;
                    }
                } else {
                    //se n�o encontrou organizador busca por pessoa somente
                    tipoPessoa = 'pessoa';
                    $.getJSON('PessoaBuscarCpfCnpj', {cpfcnpjpessoa: idM, tipopessoa: tipoPessoa}, function (respostaPessoa) {
                        console.log(respostaPessoa);
                        var id = respostaPessoa.idPessoa;
                        if (id != "0")
                        {
                            $('#idpessoa').val(respostaPessoa.idPessoa);
                            $('#cpfcnpjpessoa').val(respostaPessoa.cpfCnpjPessoa);
                            $('#rgiepessoa').val(respostaPessoa.rgIePessoa);
                            $('#nomerazaopessoa').val(respostaPessoa.nomeRazaoPessoa);
                            $('#datanascfundpessoa').val(respostaPessoa.dataNascFundPessoa);
                            $('#telefonepessoa').val(respostaPessoa.telefonePessoa);
                            $('#logradouropessoa').val(respostaPessoa.logradouroPessoa);
                            $('#numlogradouropessoa').val(respostaPessoa.numLogradouroPessoa);
                            $('#bairropessoa').val(respostaPessoa.bairroPessoa);
                            $('#ceppessoa').val(respostaPessoa.cepPessoa);
                            $('#emailpessoa').val(respostaPessoa.emailPessoa);
                            $('#login').val(respostaPessoa.login);
                            $('#senha').val(respostaPessoa.senha);
                            var datanasc = respostaPessoa.dataNascFundPessoa;
                            console.log(datanasc);
                            $('#datanascfundpessoa').val(datanasc);
                            $('#idestado').val(respostaPessoa.cidade.estado.idEstado);
                            cidade = respostaPessoa.cidade.idCidade;
                            BuscarCidadesPorEstado();
                            if ($('#login').val() != '') {
                                document.getElementById('login').readOnly = true;
                            }
                        }
                        criaMascaraTelefone();
                        trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                        criaMascaraCEP();
                    });
                }
                criaMascaraTelefone();
                trocaMascaraCpfCnpj($('#cpfcnpjpessoa').val());
                criaMascaraCEP();
            });
        });
        document.getElementById('labelcpfcnpj').innerHTML = "<FONT COLOR='green'>CPF/CNPJ v�lido</FONT>";
        document.getElementById('cpfcnpjpessoa').classList.add("is-valid");
        document.getElementById('cpfcnpjpessoa').classList.remove("is-invalid");
    }

    function deletar(codigo, situacao) {
        var id = codigo;
        console.log(codigo);

        var titulo = "";
        var tituloConfirmacao = "";
        var confirmButtonText = "";

        if (situacao == 'I') {
            titulo = "Voc� deseja realmente ativar o organizador?";
            confirmButtonText = "Sim, ative o organizador!";
            tituloConfirmacao = "Organizador ativado com sucesso!";

        } else {
            titulo = "Voc� deseja realmente inativar o organizador?";
            confirmButtonText = "Sim, inative o organizador!";
            tituloConfirmacao = "Organizador inativado com sucesso!";
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
                    url: '${pageContext.request.contextPath}/OrganizadorExcluir',
                    data: {
                        idOrganizador: id
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
                                        window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                                    })
                                } else {
                                    Swal.fire({
                                        position: 'center',
                                        icon: 'error',
                                        title: 'Erro',
                                        text: 'N�o foi poss�vel ativar/inativar organizador!',
                                        showConfirmButton: true,
                                        timer: 10000
                                    }).then(function () {
                                        window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                                    })
                                }
                            },
                    error:
                            function (data) {
                                window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                            }
                });
            }
            ;
        });
    }

    function validarCampos() {
        console.log("entrei na valida��o de campos");

        url = "PessoaVerificarLogin?login=" + document.getElementById("login").value;
        $.getJSON(url, function (result) {
            console.log(result);
            if (document.getElementById("cpfcnpjpessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o CPF/CNPJ!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#cpfcnpjpessoa").focus();
            } else if (document.getElementById('cpfcnpjpessoa').classList == "form-control is-invalid") {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o CPF/CNPJ!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#cpfcnpjpessoa").focus();
            } else if (document.getElementById("nomerazaopessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Nome!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#nomerazaopessoa").focus();
            } else if (document.getElementById("idcidade").value == 'nulo') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Cidade!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#idcidade").focus();
            } else if (document.getElementById("login").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Login!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#login").focus();
            } else if ((result == 1) && (document.getElementById('login').readOnly == false)) {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique o Login!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#login").focus();
            } else if (document.getElementById("senha").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Senha!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#senha").focus();
            } else if (document.getElementById("datanascfundpessoa").value == '') {
                Swal.fire({
                    position: 'center',
                    icon: 'error',
                    title: 'Verifique a Data de Nascimento/Funda��o!',
                    showConfirmButton: true,
                    timer: 2000
                });
                $("#datanascfundpessoa").focus();
            } else {
                gravarDados();
            }
        }).fail(function (obj, textStatus, error) {
            alert('Erro do servidor: ' + textStatus + ', ' + error);
        });
    }

    function gravarDados() {
        console.log("Gravando dados ....");
        let telefonepessoa = document.getElementById(`telefonepessoa`).value.replace(/([^0-9])+/g, "");
        let ceppessoa = document.getElementById(`ceppessoa`).value.replace(/([^0-9])+/g, "");

        $.ajax({
            type: 'post',
            url: 'OrganizadorCadastrar',
            data: {
                idorganizador: $('#idorganizador').val(),
                idpessoa: $('#idpessoa').val(),
                cpfcnpjpessoa: $('#cpfcnpjpessoa').unmask().val(),
                rgiepessoa: $('#rgiepessoa').val(),
                nomerazaopessoa: $('#nomerazaopessoa').val(),
                datanascfundpessoa: $('#datanascfundpessoa').val(),
                telefonepessoa: telefonepessoa,
                logradouropessoa: $('#logradouropessoa').val(),
                numlogradouropessoa: $('#numlogradouropessoa').val(),
                bairropessoa: $('#bairropessoa').val(),
                ceppessoa: ceppessoa,
                emailpessoa: $('#emailpessoa').val(),
                login: $("#login").val(),
                senha: $("#senha").val(),
                idcidade: $("#idcidade").val(),
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
                                text: 'Organizador gravado com sucesso!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                            })
                        } else {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Erro',
                                text: 'N�o foi poss�vel gravar o organizador!',
                                showConfirmButton: true,
                                timer: 10000
                            }).then(function () {
                                window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                            })
                        }
                    },
            error:
                    function (data) {
                        window.location.href = "${pageContext.request.contextPath}/OrganizadorListar";
                    }
        });
    }

    function BuscarCidadesPorEstado() {
        $('#idcidade').empty();
        idEst = $('#idestado').val();
        console.log("entrou buscar estado");
        if (idEst != 'null') {
            console.log("estado = " + idEst);
            url = "CidadeBuscarPorEstado?idestado=" + idEst;
            //console.log(url);
            $.getJSON(url, function (result) {
                //alert(result);
                $.each(result, function (index, value) {
                    $('#idcidade').append('<option id="cidade_' + value.idCidade + '"value="' + value.idCidade + '">' + value.nomeCidade + '</option>');
                    console.log(value.idCidade);
                    if (cidade !== '') {
                        $('#cidade_' + cidade).prop({selected: true});
                    } else {
                        $('#cidade_').prop({selected: true});
                    }
                });
            }).fail(function (obj, textStatus, error) {
                alert('Erro do servidor: ' + textStatus + ', ' + error);
            });
        }
    }

    function criaMascaraTelefone() {
        const maximoInput = document.getElementById(`telefonepessoa`).maxLength;
        let valorInput = document.getElementById(`telefonepessoa`).value;
        let valorSemPonto = document.getElementById(`telefonepessoa`).value.replace(/([^0-9])+/g, "");
        const mascaras = valorInput.replace(/[^\d]/g, "").replace(/^(\d{2})(\d{5})(\d{4})/, "($1) $2-$3");

        valorInput.length === maximoInput ? document.getElementById(`telefonepessoa`).value = mascaras
                : document.getElementById(`telefonepessoa`).value = valorSemPonto;
    }

    function criaMascaraCEP() {
        const maximoInput = document.getElementById(`ceppessoa`).maxLength;
        let valorInput = document.getElementById(`ceppessoa`).value;
        let valorSemPonto = document.getElementById(`ceppessoa`).value.replace(/([^0-9])+/g, "");
        const mascaras = valorInput.replace(/[^\d]/g, "").replace(/(\d{5})(\d{3})/, "$1-$2");

        valorInput.length === maximoInput ? document.getElementById(`ceppessoa`).value = mascaras
                : document.getElementById(`ceppessoa`).value = valorSemPonto;
    }

    function menuAtivo() {
        document.getElementById('titulopainel').innerHTML = "<strong>Organizador</strong>";
        document.getElementById('agrupamentocadastrosgerais').classList.add("menu-open");
        document.getElementById('menucadastrosgerais').classList.add("active");
        document.getElementById('menuorganizador').classList.add("active");
    }

    $(document).ready(function () {
        menuAtivo();
    });

    //verificao do login
    $('#login').blur(function verificarLogin() {
        var login = $('#login').val();

        if (document.getElementById('login').readOnly == false) {

            if (login == '') {
                document.getElementById('labellogin').innerHTML = "<FONT COLOR='red'>Login inv�lido</FONT>";
                document.getElementById('login').classList.remove("is-valid");
                document.getElementById('login').classList.add("is-invalid");
            } else {
                var login = $('#login').val();
                console.log("entrou no verificar login: " + login);
                if (login != '') {
                    url = "PessoaVerificarLogin?login=" + login;
                    $.getJSON(url, function (result) {
                        console.log(result);
                        if (result == 1) {
                            document.getElementById('labellogin').innerHTML = "<FONT COLOR='red'>Login indispon�vel</FONT>";
                            document.getElementById('login').classList.remove("is-valid");
                            document.getElementById('login').classList.add("is-invalid");
                        } else if (result == 0) {
                            document.getElementById('labellogin').innerHTML = "<FONT COLOR='green'>Login dispon�vel</FONT>";
                            document.getElementById('login').classList.remove("is-invalid");
                            document.getElementById('login').classList.add("is-valid");
                        }
                    }).fail(function (obj, textStatus, error) {
                        alert('Erro do servidor: ' + textStatus + ', ' + error);
                    });
                }
            }
        }
    });
</script>
<%@include file="/painel/footer.jsp"%>