CREATE TABLE patients
(
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(100),
    date_of_birth DATE,
    PRIMARY KEY(id)
);

CREATE TABLE medical_histories
(
    id INT GENERATED ALWAYS AS IDENTITY, 
    admitted_at DATE,
    patient_id INT,
    status VARCHAR(100),
   CONSTRAINT "fk_patients" FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE SET NULL,
   PRIMARY KEY(id)
);


CREATE TABLE invoices
(
    id INT GENERATED ALWAYS AS IDENTITY, 
    total_amount DECIMAL,
    generated_at DATE,
    paid_at DATE,
    medical_history_id INT,
   CONSTRAINT "fk_invoices" FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id) ON DELETE SET NULL,
   PRIMARY KEY(id)
);

CREATE TABLE treatments
(
    id INT GENERATED ALWAYS AS IDENTITY, 
    type VARCHAR(100),
    name VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE invoice_items
(
    id INT GENERATED ALWAYS AS IDENTITY, 
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT "fk_invoice" FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE SET NULL,
    CONSTRAINT "fk_treatment" FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE SET NULL,
    PRIMARY KEY(id)
);

CREATE TABLE medical_history_treatments
(
    medical_history_id INT,
    treatment_id INT,
    CONSTRAINT "fk_medical_history_id" FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON DELETE SET NULL,
    CONSTRAINT "fk_treatment_id" FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE SET NULL,
    PRIMARY KEY(medical_history_id, treatment_id)
);


CREATE INDEX medical_history_treatments_index ON medical_history_treatments(medical_history_id, treatment_id);
CREATE INDEX patient_id_medical_index ON medical_histories(patient_id);
CREATE INDEX invoice_items_index ON invoice_items(invoice_id);
CREATE INDEX treatments_invoice_index ON invoice_items(treatment_id);
CREATE INDEX medical_invoice_index ON invoices(medical_history_id);



