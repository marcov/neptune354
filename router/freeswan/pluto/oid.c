/* List of some useful object identifiers (OIDs)
 * Copyright (C) 2003 Andreas Steffen, Zuercher Hochschule Winterthur
 * 
 * This file has been automatically generated by the script oid.pl
 * Do not edit manually!
 */

#include <stdlib.h>

#include "oid.h"

const oid_t oid_names[] = {
  {0x09,                      11, 1, "data"                   },  /*   0 */
  {  0x92,                     0, 1, ""                       },  /*   1 */
  {    0x26,                   0, 1, ""                       },  /*   2 */
  {      0x89,                 0, 1, ""                       },  /*   3 */
  {        0x93,               0, 1, ""                       },  /*   4 */
  {          0xF2,             0, 1, ""                       },  /*   5 */
  {            0x2C,           0, 1, ""                       },  /*   6 */
  {              0x64,         0, 1, "pilot"                  },  /*   7 */
  {                0x01,       0, 1, "pilotAttributeType"     },  /*   8 */
  {                  0x01,    10, 0, "UID"                    },  /*   9 */
  {                  0x19,     0, 0, "DC"                     },  /*  10 */
  {0x55,                      39, 1, "X.500"                  },  /*  11 */
  {  0x04,                    27, 1, "X.509"                  },  /*  12 */
  {    0x03,                  14, 0, "CN"                     },  /*  13 */
  {    0x04,                  15, 0, "S"                      },  /*  14 */
  {    0x05,                  16, 0, "SN"                     },  /*  15 */
  {    0x06,                  17, 0, "C"                      },  /*  16 */
  {    0x07,                  18, 0, "L"                      },  /*  17 */
  {    0x08,                  19, 0, "ST"                     },  /*  18 */
  {    0x0A,                  20, 0, "O"                      },  /*  19 */
  {    0x0B,                  21, 0, "OU"                     },  /*  20 */
  {    0x0C,                  22, 0, "T"                      },  /*  21 */
  {    0x0D,                  23, 0, "D"                      },  /*  22 */
  {    0x29,                  24, 0, "N"                      },  /*  23 */
  {    0x2A,                  25, 0, "G"                      },  /*  24 */
  {    0x2B,                  26, 0, "I"                      },  /*  25 */
  {    0x2D,                   0, 0, "ID"                     },  /*  26 */
  {  0x1d,                     0, 1, "id-ce"                  },  /*  27 */
  {    0x0E,                  29, 0, "subjectKeyIdentifier"   },  /*  28 */
  {    0x0F,                  30, 0, "keyUsage"               },  /*  29 */
  {    0x10,                  31, 0, "privateKeyUsagePeriod"  },  /*  30 */
  {    0x11,                  32, 0, "subjectAltName"         },  /*  31 */
  {    0x12,                  33, 0, "issuerAltName"          },  /*  32 */
  {    0x13,                  34, 0, "basicConstraints"       },  /*  33 */
  {    0x15,                  35, 0, "crlReason"              },  /*  34 */
  {    0x1F,                  36, 0, "crlDistributionPoints"  },  /*  35 */
  {    0x20,                  37, 0, "certificatePolicies"    },  /*  36 */
  {    0x23,                  38, 0, "authorityKeyIdentifier" },  /*  37 */
  {    0x25,                   0, 0, "extendedKeyUsage"       },  /*  38 */
  {0x2A,                      67, 1, ""                       },  /*  39 */
  {  0x86,                     0, 1, ""                       },  /*  40 */
  {    0x48,                   0, 1, ""                       },  /*  41 */
  {      0x86,                 0, 1, ""                       },  /*  42 */
  {        0xF7,               0, 1, ""                       },  /*  43 */
  {          0x0D,             0, 1, "RSADSI"                 },  /*  44 */
  {            0x01,          64, 1, "PKCS"                   },  /*  45 */
  {              0x01,        54, 1, "PKCS-1"                 },  /*  46 */
  {                0x01,      48, 0, "rsaEncryption"          },  /*  47 */
  {                0x02,      49, 0, "md2WithRSAEncryption"   },  /*  48 */
  {                0x04,      50, 0, "md5WithRSAEncryption"   },  /*  49 */
  {                0x05,      51, 0, "sha-1WithRSAEncryption" },  /*  50 */
  {                0x0B,      52, 0, "sha256WithRSAEncryption"},  /*  51 */
  {                0x0C,      53, 0, "sha384WithRSAEncryption"},  /*  52 */
  {                0x0D,       0, 0, "sha512WithRSAEncryption"},  /*  53 */
  {              0x07,        61, 1, "PKCS-7"                 },  /*  54 */
  {                0x01,      56, 0, "data"                   },  /*  55 */
  {                0x02,      57, 0, "signedData"             },  /*  56 */
  {                0x03,      58, 0, "envelopedData"          },  /*  57 */
  {                0x04,      59, 0, "signedAndEnvelopedData" },  /*  58 */
  {                0x05,      60, 0, "digestedData"           },  /*  59 */
  {                0x06,       0, 0, "encryptedData"          },  /*  60 */
  {              0x09,         0, 1, "PKCS-9"                 },  /*  61 */
  {                0x01,      63, 0, "E"                      },  /*  62 */
  {                0x02,       0, 0, "unstructuredName"       },  /*  63 */
  {            0x02,           0, 1, "digestAlgorithm"        },  /*  64 */
  {              0x02,        66, 0, "md2"                    },  /*  65 */
  {              0x05,         0, 0, "md5"                    },  /*  66 */
  {0x2B,                      83, 1, ""                       },  /*  67 */
  {  0x06,                    79, 1, "dod"                    },  /*  68 */
  {    0x01,                   0, 1, "internet"               },  /*  69 */
  {      0x04,                 0, 1, "private"                },  /*  70 */
  {        0x01,               0, 1, "enterprise"             },  /*  71 */
  {          0x89,             0, 1, ""                       },  /*  72 */
  {            0x31,           0, 1, ""                       },  /*  73 */
  {              0x01,         0, 1, ""                       },  /*  74 */
  {                0x01,       0, 1, ""                       },  /*  75 */
  {                  0x02,     0, 1, ""                       },  /*  76 */
  {                    0x02,  78, 0, ""                       },  /*  77 */
  {                    0x4B,   0, 0, "TCGID"                  },  /*  78 */
  {  0x0E,                     0, 1, "oiw"                    },  /*  79 */
  {    0x03,                   0, 1, "secsig"                 },  /*  80 */
  {      0x02,                 0, 1, "algorithms"             },  /*  81 */
  {        0x1A,               0, 0, "id-SHA-1"               },  /*  82 */
  {0x60,                       0, 1, ""                       },  /*  83 */
  {  0x86,                     0, 1, ""                       },  /*  84 */
  {    0x48,                   0, 1, ""                       },  /*  85 */
  {      0x01,                 0, 1, "organization"           },  /*  86 */
  {        0x65,              94, 1, "gov"                    },  /*  87 */
  {          0x03,             0, 1, "csor"                   },  /*  88 */
  {            0x04,           0, 1, "nistalgorithm"          },  /*  89 */
  {              0x02,         0, 1, "hashalgs"               },  /*  90 */
  {                0x01,      92, 0, "id-SHA-256"             },  /*  91 */
  {                0x02,      93, 0, "id-SHA-384"             },  /*  92 */
  {                0x03,       0, 0, "id-SHA-512"             },  /*  93 */
  {        0x86,               0, 1, ""                       },  /*  94 */
  {          0xf8,             0, 1, ""                       },  /*  95 */
  {            0x42,           0, 1, ""                       },  /*  96 */
  {              0x01,         0, 1, ""                       },  /*  97 */
  {                0x01,      99, 0, "nsCertType"             },  /*  98 */
  {                0x03,     100, 0, "nsRevocationUrl"        },  /*  99 */
  {                0x0d,       0, 0, "nsComment"              }   /* 100 */
};
