package com.neuralbank.domain.entity;

import com.neuralbank.domain.enums.CustomerType;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Entity
@Table(name = "cliente", schema = "core")
public class Customer extends PanacheEntityBase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cliente_id")
    public Long id;

    @Column(unique = true, nullable = false, length = 50)
    public String identificacion;

    @Column(name = "tipo_identificacion", length = 20)
    public String tipoIdentificacion;

    @Column(nullable = false, length = 150)
    public String nombre;

    @Column(length = 150)
    public String apellido;

    @Column(name = "nombre_completo", length = 300, insertable = false, updatable = false)
    public String nombreCompleto;

    @Column(name = "fecha_nacimiento")
    public LocalDate fechaNacimiento;

    @Column(unique = true, length = 150)
    public String email;

    @Column(length = 20)
    public String telefono;

    @Column(name = "telefono_alternativo", length = 20)
    public String telefonoAlternativo;

    @Column(length = 300)
    public String direccion;

    @Column(length = 100)
    public String ciudad;

    @Column(name = "estado_provincia", length = 100)
    public String estadoProvincia;

    @Column(name = "codigo_postal", length = 20)
    public String codigoPostal;

    @Column(name = "pais_id")
    public Long paisId;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_cliente", nullable = false)
    public CustomerType tipoCliente = CustomerType.PERSONAL;

    @Column(name = "score_crediticio", precision = 5, scale = 2)
    public BigDecimal scoreCrediticio;

    @Column(name = "nivel_riesgo", length = 20)
    public String nivelRiesgo;

    @Column(name = "fecha_registro")
    public LocalDate fechaRegistro = LocalDate.now();

    @Column(nullable = false)
    public Boolean activo = true;

    @Column(name = "sucursal_id")
    public Long sucursalId;

    @Column(name = "ejecutivo_id")
    public Long ejecutivoId;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "metadata", columnDefinition = "jsonb")
    public Map<String, Object> metadata = new HashMap<>();

    @Column(name = "created_at", updatable = false)
    public LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    public LocalDateTime updatedAt = LocalDateTime.now();

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }
}