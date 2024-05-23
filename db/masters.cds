using { sap.common.CodeList } from '@sap/cds/common';
// using { 
    // hexagon.licenseapplications.schema.Employees, 
    // hexagon.licenseapplications.schema.Licenses 
// } from './schema';

namespace hexagon.licenseapplications.masters;

entity Areas : CodeList {
    key ID  : Integer @mandatory;
    roles   : Composition of Roles on roles.area = $self;
}

entity Roles : CodeList {
    key ID      : Integer @mandatory;
    area        : Association to Areas @assert.target @mandatory;
    // TODO: Chequear qué pasa si no pongo ésta línea.
    // employees   : Association to many Employees on employees.role = $self;
}

entity States : CodeList {
    key ID      : Integer @mandatory;
    // licenses    : Association to many Licenses on licenses.state = $self;
}

entity LicenseTypes: CodeList {
    key ID      : Integer @mandatory;
    days        : Integer @mandatory;
    // TODO: Chequear qué pasa si no pongo ésta línea.
    // licenses    : Association to many Licenses on licenses.licenseType = $self;
}

/**
 * Se busca generar una tabla con los géneros existentes,
 * donde la clave sea un caracter (M, F, NB, O) y las
 * descripciones (Masculino, Femenino ...) cuenten con 
 * internacionalización (i18n).
 */
type Genre : Association to many Genres;

entity Genres : CodeList {
    key ID  : GenreID @mandatory;
}

type GenreID : String(1) enum {
    Masculin    = 'M';
    Feminin     = 'F';
    NonBinary   = 'NB';
    Other       = 'O';
}
