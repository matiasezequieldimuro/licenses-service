using { sap.common.CodeList } from '@sap/cds/common';

namespace hexagon.licenseapplications.masters;

entity Areas : CodeList {
    key ID  : Integer @mandatory;
    roles   : Composition of Roles on roles.area = $self;
}

entity Roles : CodeList {
    key ID      : Integer @mandatory;
    area        : Association to Areas @assert.target @mandatory;
}

entity States : CodeList {
    key ID      : Integer @mandatory;
}

entity LicenseTypes: CodeList {
    key ID      : Integer @mandatory;
    days        : Integer @mandatory;
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

type GenreID : String(2) enum {
    Masculin    = 'M';
    Feminin     = 'F';
    NonBinary   = 'NB';
    Other       = 'O';
}
