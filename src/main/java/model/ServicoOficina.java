package model;

import java.util.Date;

public class ServicoOficina {
    private int id;
    private String descricaoServico;
    private String placaMoto;
    private Date dataEntrada;
    private double orcamento;
    private boolean servicoConcluido;

    private User cliente;

    public ServicoOficina() {
    }

    public ServicoOficina(int id) {
        this.id = id;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricaoServico() {
        return descricaoServico;
    }

    public void setDescricaoServico(String descricaoServico) {
        this.descricaoServico = descricaoServico;
    }

    public String getPlacaMoto() {
        return placaMoto;
    }

    public void setPlacaMoto(String placaMoto) {
        this.placaMoto = placaMoto;
    }

    public Date getDataEntrada() {
        return dataEntrada;
    }

    public void setDataEntrada(Date dataEntrada) {
        this.dataEntrada = dataEntrada;
    }

    public double getOrcamento() {
        return orcamento;
    }

    public void setOrcamento(double orcamento) {
        this.orcamento = orcamento;
    }

    public boolean isServicoConcluido() {
        return servicoConcluido;
    }

    public void setServicoConcluido(boolean servicoConcluido) {
        this.servicoConcluido = servicoConcluido;
    }

    public User getCliente() {
        return cliente;
    }

    public void setCliente(User cliente) {
        this.cliente = cliente;
    }
}