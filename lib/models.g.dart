// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStaffRecordCollection on Isar {
  IsarCollection<StaffRecord> get staffRecords => this.collection();
}

const StaffRecordSchema = CollectionSchema(
  name: r'StaffRecord',
  id: -239121408107232,
  properties: {
    r'balance': PropertySchema(
      id: 0,
      name: r'balance',
      type: IsarType.double,
    ),
    r'cuttingRate': PropertySchema(
      id: 1,
      name: r'cuttingRate',
      type: IsarType.double,
    ),
    r'doubleStitchRate': PropertySchema(
      id: 2,
      name: r'doubleStitchRate',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'ledger': PropertySchema(
      id: 4,
      name: r'ledger',
      type: IsarType.objectList,
      target: r'LedgerEntry',
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 6,
      name: r'phone',
      type: IsarType.string,
    ),
    r'role': PropertySchema(
      id: 7,
      name: r'role',
      type: IsarType.string,
    ),
    r'singleStitchRate': PropertySchema(
      id: 8,
      name: r'singleStitchRate',
      type: IsarType.double,
    )
  },
  estimateSize: _staffRecordEstimateSize,
  serialize: _staffRecordSerialize,
  deserialize: _staffRecordDeserialize,
  deserializeProp: _staffRecordDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'LedgerEntry': LedgerEntrySchema},
  getId: _staffRecordGetId,
  getLinks: _staffRecordGetLinks,
  attach: _staffRecordAttach,
  version: '3.1.0+1',
);

int _staffRecordEstimateSize(
  StaffRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.ledger.length * 3;
  {
    final offsets = allOffsets[LedgerEntry]!;
    for (var i = 0; i < object.ledger.length; i++) {
      final value = object.ledger[i];
      bytesCount += LedgerEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.phone.length * 3;
  bytesCount += 3 + object.role.length * 3;
  return bytesCount;
}

void _staffRecordSerialize(
  StaffRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.balance);
  writer.writeDouble(offsets[1], object.cuttingRate);
  writer.writeDouble(offsets[2], object.doubleStitchRate);
  writer.writeString(offsets[3], object.id);
  writer.writeObjectList<LedgerEntry>(
    offsets[4],
    allOffsets,
    LedgerEntrySchema.serialize,
    object.ledger,
  );
  writer.writeString(offsets[5], object.name);
  writer.writeString(offsets[6], object.phone);
  writer.writeString(offsets[7], object.role);
  writer.writeDouble(offsets[8], object.singleStitchRate);
}

StaffRecord _staffRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StaffRecord(
    balance: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    cuttingRate: reader.readDoubleOrNull(offsets[1]) ?? 0.0,
    doubleStitchRate: reader.readDoubleOrNull(offsets[2]) ?? 0.0,
    id: reader.readStringOrNull(offsets[3]) ?? '',
    ledger: reader.readObjectList<LedgerEntry>(
          offsets[4],
          LedgerEntrySchema.deserialize,
          allOffsets,
          LedgerEntry(),
        ) ??
        const [],
    name: reader.readStringOrNull(offsets[5]) ?? '',
    phone: reader.readStringOrNull(offsets[6]) ?? '',
    role: reader.readStringOrNull(offsets[7]) ?? 'Tailor',
    singleStitchRate: reader.readDoubleOrNull(offsets[8]) ?? 0.0,
  );
  object.isarId = id;
  return object;
}

P _staffRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readObjectList<LedgerEntry>(
            offset,
            LedgerEntrySchema.deserialize,
            allOffsets,
            LedgerEntry(),
          ) ??
          const []) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? 'Tailor') as P;
    case 8:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _staffRecordGetId(StaffRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _staffRecordGetLinks(StaffRecord object) {
  return [];
}

void _staffRecordAttach(
    IsarCollection<dynamic> col, Id id, StaffRecord object) {
  object.isarId = id;
}

extension StaffRecordQueryWhereSort
    on QueryBuilder<StaffRecord, StaffRecord, QWhere> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StaffRecordQueryWhere
    on QueryBuilder<StaffRecord, StaffRecord, QWhereClause> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StaffRecordQueryFilter
    on QueryBuilder<StaffRecord, StaffRecord, QFilterCondition> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> balanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      balanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> balanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> balanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      cuttingRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuttingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      cuttingRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuttingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      cuttingRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuttingRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      cuttingRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuttingRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      doubleStitchRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'doubleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      doubleStitchRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'doubleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      doubleStitchRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'doubleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      doubleStitchRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'doubleStitchRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      ledgerLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ledger',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      phoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'role',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      singleStitchRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'singleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      singleStitchRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'singleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      singleStitchRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'singleStitchRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition>
      singleStitchRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'singleStitchRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension StaffRecordQueryObject
    on QueryBuilder<StaffRecord, StaffRecord, QFilterCondition> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterFilterCondition> ledgerElement(
      FilterQuery<LedgerEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'ledger');
    });
  }
}

extension StaffRecordQueryLinks
    on QueryBuilder<StaffRecord, StaffRecord, QFilterCondition> {}

extension StaffRecordQuerySortBy
    on QueryBuilder<StaffRecord, StaffRecord, QSortBy> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByCuttingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuttingRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByCuttingRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuttingRate', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      sortByDoubleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleStitchRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      sortByDoubleStitchRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleStitchRate', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      sortBySingleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'singleStitchRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      sortBySingleStitchRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'singleStitchRate', Sort.desc);
    });
  }
}

extension StaffRecordQuerySortThenBy
    on QueryBuilder<StaffRecord, StaffRecord, QSortThenBy> {
  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balance', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByCuttingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuttingRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByCuttingRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cuttingRate', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      thenByDoubleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleStitchRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      thenByDoubleStitchRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'doubleStitchRate', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy> thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      thenBySingleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'singleStitchRate', Sort.asc);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QAfterSortBy>
      thenBySingleStitchRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'singleStitchRate', Sort.desc);
    });
  }
}

extension StaffRecordQueryWhereDistinct
    on QueryBuilder<StaffRecord, StaffRecord, QDistinct> {
  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctByBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balance');
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctByCuttingRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cuttingRate');
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct>
      distinctByDoubleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'doubleStitchRate');
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct> distinctByRole(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StaffRecord, StaffRecord, QDistinct>
      distinctBySingleStitchRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'singleStitchRate');
    });
  }
}

extension StaffRecordQueryProperty
    on QueryBuilder<StaffRecord, StaffRecord, QQueryProperty> {
  QueryBuilder<StaffRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<StaffRecord, double, QQueryOperations> balanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balance');
    });
  }

  QueryBuilder<StaffRecord, double, QQueryOperations> cuttingRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cuttingRate');
    });
  }

  QueryBuilder<StaffRecord, double, QQueryOperations>
      doubleStitchRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'doubleStitchRate');
    });
  }

  QueryBuilder<StaffRecord, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StaffRecord, List<LedgerEntry>, QQueryOperations>
      ledgerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ledger');
    });
  }

  QueryBuilder<StaffRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StaffRecord, String, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<StaffRecord, String, QQueryOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<StaffRecord, double, QQueryOperations>
      singleStitchRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'singleStitchRate');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCustomerRecordCollection on Isar {
  IsarCollection<CustomerRecord> get customerRecords => this.collection();
}

const CustomerRecordSchema = CollectionSchema(
  name: r'CustomerRecord',
  id: -484509065328458,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'advance': PropertySchema(
      id: 1,
      name: r'advance',
      type: IsarType.double,
    ),
    r'assignedTailorId': PropertySchema(
      id: 2,
      name: r'assignedTailorId',
      type: IsarType.string,
    ),
    r'garmentType': PropertySchema(
      id: 3,
      name: r'garmentType',
      type: IsarType.string,
    ),
    r'individualStatuses': PropertySchema(
      id: 4,
      name: r'individualStatuses',
      type: IsarType.stringList,
    ),
    r'mobile': PropertySchema(
      id: 5,
      name: r'mobile',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'orderId': PropertySchema(
      id: 7,
      name: r'orderId',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 8,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'remaining': PropertySchema(
      id: 9,
      name: r'remaining',
      type: IsarType.double,
    ),
    r'requirementGroups': PropertySchema(
      id: 10,
      name: r'requirementGroups',
      type: IsarType.objectList,
      target: r'RequirementGroup',
    ),
    r'status': PropertySchema(
      id: 11,
      name: r'status',
      type: IsarType.string,
    ),
    r'tailorWages': PropertySchema(
      id: 12,
      name: r'tailorWages',
      type: IsarType.double,
    ),
    r'tokenNumber': PropertySchema(
      id: 13,
      name: r'tokenNumber',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 14,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _customerRecordEstimateSize,
  serialize: _customerRecordSerialize,
  deserialize: _customerRecordDeserialize,
  deserializeProp: _customerRecordDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'RequirementGroup': RequirementGroupSchema},
  getId: _customerRecordGetId,
  getLinks: _customerRecordGetLinks,
  attach: _customerRecordAttach,
  version: '3.1.0+1',
);

int _customerRecordEstimateSize(
  CustomerRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.address.length * 3;
  bytesCount += 3 + object.assignedTailorId.length * 3;
  bytesCount += 3 + object.garmentType.length * 3;
  bytesCount += 3 + object.individualStatuses.length * 3;
  {
    for (var i = 0; i < object.individualStatuses.length; i++) {
      final value = object.individualStatuses[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.mobile.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.orderId.length * 3;
  bytesCount += 3 + object.requirementGroups.length * 3;
  {
    final offsets = allOffsets[RequirementGroup]!;
    for (var i = 0; i < object.requirementGroups.length; i++) {
      final value = object.requirementGroups[i];
      bytesCount +=
          RequirementGroupSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.tokenNumber.length * 3;
  return bytesCount;
}

void _customerRecordSerialize(
  CustomerRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeDouble(offsets[1], object.advance);
  writer.writeString(offsets[2], object.assignedTailorId);
  writer.writeString(offsets[3], object.garmentType);
  writer.writeStringList(offsets[4], object.individualStatuses);
  writer.writeString(offsets[5], object.mobile);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.orderId);
  writer.writeLong(offsets[8], object.quantity);
  writer.writeDouble(offsets[9], object.remaining);
  writer.writeObjectList<RequirementGroup>(
    offsets[10],
    allOffsets,
    RequirementGroupSchema.serialize,
    object.requirementGroups,
  );
  writer.writeString(offsets[11], object.status);
  writer.writeDouble(offsets[12], object.tailorWages);
  writer.writeString(offsets[13], object.tokenNumber);
  writer.writeDouble(offsets[14], object.totalAmount);
}

CustomerRecord _customerRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomerRecord(
    address: reader.readStringOrNull(offsets[0]) ?? '',
    advance: reader.readDoubleOrNull(offsets[1]) ?? 0.0,
    assignedTailorId: reader.readStringOrNull(offsets[2]) ?? '',
    garmentType: reader.readStringOrNull(offsets[3]) ?? '',
    individualStatuses: reader.readStringList(offsets[4]) ?? const [],
    mobile: reader.readStringOrNull(offsets[5]) ?? '',
    name: reader.readStringOrNull(offsets[6]) ?? '',
    orderId: reader.readStringOrNull(offsets[7]) ?? '',
    quantity: reader.readLongOrNull(offsets[8]) ?? 1,
    remaining: reader.readDoubleOrNull(offsets[9]) ?? 0.0,
    requirementGroups: reader.readObjectList<RequirementGroup>(
          offsets[10],
          RequirementGroupSchema.deserialize,
          allOffsets,
          RequirementGroup(),
        ) ??
        const [],
    status: reader.readStringOrNull(offsets[11]) ?? 'New Order',
    tailorWages: reader.readDoubleOrNull(offsets[12]) ?? 0.0,
    tokenNumber: reader.readStringOrNull(offsets[13]) ?? '',
    totalAmount: reader.readDoubleOrNull(offsets[14]) ?? 0.0,
  );
  object.isarId = id;
  return object;
}

P _customerRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringList(offset) ?? const []) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 9:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 10:
      return (reader.readObjectList<RequirementGroup>(
            offset,
            RequirementGroupSchema.deserialize,
            allOffsets,
            RequirementGroup(),
          ) ??
          const []) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? 'New Order') as P;
    case 12:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _customerRecordGetId(CustomerRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _customerRecordGetLinks(CustomerRecord object) {
  return [];
}

void _customerRecordAttach(
    IsarCollection<dynamic> col, Id id, CustomerRecord object) {
  object.isarId = id;
}

extension CustomerRecordQueryWhereSort
    on QueryBuilder<CustomerRecord, CustomerRecord, QWhere> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CustomerRecordQueryWhere
    on QueryBuilder<CustomerRecord, CustomerRecord, QWhereClause> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CustomerRecordQueryFilter
    on QueryBuilder<CustomerRecord, CustomerRecord, QFilterCondition> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      advanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'advance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      advanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'advance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      advanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'advance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      advanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'advance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignedTailorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignedTailorId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignedTailorId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignedTailorId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      assignedTailorIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignedTailorId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'garmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'garmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      garmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'garmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'individualStatuses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'individualStatuses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'individualStatuses',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'individualStatuses',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'individualStatuses',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      individualStatusesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'individualStatuses',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mobile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mobile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mobile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mobile',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      mobileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mobile',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'orderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'orderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      orderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'orderId',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      remainingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remaining',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      remainingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remaining',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      remainingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remaining',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      remainingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remaining',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirementGroups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tailorWagesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tailorWages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tailorWagesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tailorWages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tailorWagesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tailorWages',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tailorWagesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tailorWages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tokenNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tokenNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tokenNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokenNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      tokenNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tokenNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CustomerRecordQueryObject
    on QueryBuilder<CustomerRecord, CustomerRecord, QFilterCondition> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterFilterCondition>
      requirementGroupsElement(FilterQuery<RequirementGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'requirementGroups');
    });
  }
}

extension CustomerRecordQueryLinks
    on QueryBuilder<CustomerRecord, CustomerRecord, QFilterCondition> {}

extension CustomerRecordQuerySortBy
    on QueryBuilder<CustomerRecord, CustomerRecord, QSortBy> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByAdvance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'advance', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByAdvanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'advance', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByAssignedTailorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTailorId', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByAssignedTailorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTailorId', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByGarmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garmentType', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByGarmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garmentType', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByMobile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobile', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByMobileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobile', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remaining', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remaining', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTailorWages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tailorWages', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTailorWagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tailorWages', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTokenNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTokenNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenNumber', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension CustomerRecordQuerySortThenBy
    on QueryBuilder<CustomerRecord, CustomerRecord, QSortThenBy> {
  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByAdvance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'advance', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByAdvanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'advance', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByAssignedTailorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTailorId', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByAssignedTailorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignedTailorId', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByGarmentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garmentType', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByGarmentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'garmentType', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByMobile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobile', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByMobileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mobile', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remaining', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByRemainingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remaining', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTailorWages() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tailorWages', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTailorWagesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tailorWages', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTokenNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenNumber', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTokenNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokenNumber', Sort.desc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension CustomerRecordQueryWhereDistinct
    on QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> {
  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByAdvance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'advance');
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct>
      distinctByAssignedTailorId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignedTailorId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByGarmentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'garmentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct>
      distinctByIndividualStatuses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'individualStatuses');
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByMobile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mobile', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByOrderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct>
      distinctByRemaining() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remaining');
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct>
      distinctByTailorWages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tailorWages');
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct> distinctByTokenNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokenNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomerRecord, CustomerRecord, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension CustomerRecordQueryProperty
    on QueryBuilder<CustomerRecord, CustomerRecord, QQueryProperty> {
  QueryBuilder<CustomerRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<CustomerRecord, double, QQueryOperations> advanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'advance');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations>
      assignedTailorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignedTailorId');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> garmentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'garmentType');
    });
  }

  QueryBuilder<CustomerRecord, List<String>, QQueryOperations>
      individualStatusesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'individualStatuses');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> mobileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mobile');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> orderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderId');
    });
  }

  QueryBuilder<CustomerRecord, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<CustomerRecord, double, QQueryOperations> remainingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remaining');
    });
  }

  QueryBuilder<CustomerRecord, List<RequirementGroup>, QQueryOperations>
      requirementGroupsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requirementGroups');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<CustomerRecord, double, QQueryOperations> tailorWagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tailorWages');
    });
  }

  QueryBuilder<CustomerRecord, String, QQueryOperations> tokenNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokenNumber');
    });
  }

  QueryBuilder<CustomerRecord, double, QQueryOperations> totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExpenseRecordCollection on Isar {
  IsarCollection<ExpenseRecord> get expenseRecords => this.collection();
}

const ExpenseRecordSchema = CollectionSchema(
  name: r'ExpenseRecord',
  id: 591528302691816,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 3,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _expenseRecordEstimateSize,
  serialize: _expenseRecordSerialize,
  deserialize: _expenseRecordDeserialize,
  deserializeProp: _expenseRecordDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _expenseRecordGetId,
  getLinks: _expenseRecordGetLinks,
  attach: _expenseRecordAttach,
  version: '3.1.0+1',
);

int _expenseRecordEstimateSize(
  ExpenseRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _expenseRecordSerialize(
  ExpenseRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.title);
  writer.writeString(offsets[3], object.type);
}

ExpenseRecord _expenseRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExpenseRecord(
    amount: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    id: reader.readStringOrNull(offsets[1]) ?? '',
    title: reader.readStringOrNull(offsets[2]) ?? '',
    type: reader.readStringOrNull(offsets[3]) ?? 'Daily',
  );
  object.isarId = id;
  return object;
}

P _expenseRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? 'Daily') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _expenseRecordGetId(ExpenseRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _expenseRecordGetLinks(ExpenseRecord object) {
  return [];
}

void _expenseRecordAttach(
    IsarCollection<dynamic> col, Id id, ExpenseRecord object) {
  object.isarId = id;
}

extension ExpenseRecordQueryWhereSort
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QWhere> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExpenseRecordQueryWhere
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QWhereClause> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExpenseRecordQueryFilter
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QFilterCondition> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ExpenseRecordQueryObject
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QFilterCondition> {}

extension ExpenseRecordQueryLinks
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QFilterCondition> {}

extension ExpenseRecordQuerySortBy
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QSortBy> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ExpenseRecordQuerySortThenBy
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QSortThenBy> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ExpenseRecordQueryWhereDistinct
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QDistinct> {
  QueryBuilder<ExpenseRecord, ExpenseRecord, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExpenseRecord, ExpenseRecord, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ExpenseRecordQueryProperty
    on QueryBuilder<ExpenseRecord, ExpenseRecord, QQueryProperty> {
  QueryBuilder<ExpenseRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<ExpenseRecord, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<ExpenseRecord, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExpenseRecord, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ExpenseRecord, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPosGroupCollection on Isar {
  IsarCollection<PosGroup> get posGroups => this.collection();
}

const PosGroupSchema = CollectionSchema(
  name: r'PosGroup',
  id: -139128436234920,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'subgroups': PropertySchema(
      id: 2,
      name: r'subgroups',
      type: IsarType.stringList,
    )
  },
  estimateSize: _posGroupEstimateSize,
  serialize: _posGroupSerialize,
  deserialize: _posGroupDeserialize,
  deserializeProp: _posGroupDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _posGroupGetId,
  getLinks: _posGroupGetLinks,
  attach: _posGroupAttach,
  version: '3.1.0+1',
);

int _posGroupEstimateSize(
  PosGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.subgroups.length * 3;
  {
    for (var i = 0; i < object.subgroups.length; i++) {
      final value = object.subgroups[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _posGroupSerialize(
  PosGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.id);
  writer.writeString(offsets[1], object.name);
  writer.writeStringList(offsets[2], object.subgroups);
}

PosGroup _posGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PosGroup(
    id: reader.readStringOrNull(offsets[0]) ?? '',
    name: reader.readStringOrNull(offsets[1]) ?? '',
    subgroups: reader.readStringList(offsets[2]) ?? const [],
  );
  object.isarId = id;
  return object;
}

P _posGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _posGroupGetId(PosGroup object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _posGroupGetLinks(PosGroup object) {
  return [];
}

void _posGroupAttach(IsarCollection<dynamic> col, Id id, PosGroup object) {
  object.isarId = id;
}

extension PosGroupQueryWhereSort on QueryBuilder<PosGroup, PosGroup, QWhere> {
  QueryBuilder<PosGroup, PosGroup, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PosGroupQueryWhere on QueryBuilder<PosGroup, PosGroup, QWhereClause> {
  QueryBuilder<PosGroup, PosGroup, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PosGroupQueryFilter
    on QueryBuilder<PosGroup, PosGroup, QFilterCondition> {
  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subgroups',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subgroups',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subgroups',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroups',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subgroups',
        value: '',
      ));
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition> subgroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterFilterCondition>
      subgroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subgroups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PosGroupQueryObject
    on QueryBuilder<PosGroup, PosGroup, QFilterCondition> {}

extension PosGroupQueryLinks
    on QueryBuilder<PosGroup, PosGroup, QFilterCondition> {}

extension PosGroupQuerySortBy on QueryBuilder<PosGroup, PosGroup, QSortBy> {
  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PosGroupQuerySortThenBy
    on QueryBuilder<PosGroup, PosGroup, QSortThenBy> {
  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension PosGroupQueryWhereDistinct
    on QueryBuilder<PosGroup, PosGroup, QDistinct> {
  QueryBuilder<PosGroup, PosGroup, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosGroup, PosGroup, QDistinct> distinctBySubgroups() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subgroups');
    });
  }
}

extension PosGroupQueryProperty
    on QueryBuilder<PosGroup, PosGroup, QQueryProperty> {
  QueryBuilder<PosGroup, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PosGroup, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PosGroup, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PosGroup, List<String>, QQueryOperations> subgroupsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subgroups');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPosProductCollection on Isar {
  IsarCollection<PosProduct> get posProducts => this.collection();
}

const PosProductSchema = CollectionSchema(
  name: r'PosProduct',
  id: 657018568918230,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.string,
    ),
    r'costPrice': PropertySchema(
      id: 1,
      name: r'costPrice',
      type: IsarType.double,
    ),
    r'defaultQty': PropertySchema(
      id: 2,
      name: r'defaultQty',
      type: IsarType.double,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'groupName': PropertySchema(
      id: 4,
      name: r'groupName',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'imagePath': PropertySchema(
      id: 6,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 7,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lowStockWarning': PropertySchema(
      id: 8,
      name: r'lowStockWarning',
      type: IsarType.bool,
    ),
    r'markup': PropertySchema(
      id: 9,
      name: r'markup',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'preferredQty': PropertySchema(
      id: 11,
      name: r'preferredQty',
      type: IsarType.double,
    ),
    r'priceChangeAllowed': PropertySchema(
      id: 12,
      name: r'priceChangeAllowed',
      type: IsarType.bool,
    ),
    r'purchasePrice': PropertySchema(
      id: 13,
      name: r'purchasePrice',
      type: IsarType.double,
    ),
    r'reorderPoint': PropertySchema(
      id: 14,
      name: r'reorderPoint',
      type: IsarType.double,
    ),
    r'sellingPrice': PropertySchema(
      id: 15,
      name: r'sellingPrice',
      type: IsarType.double,
    ),
    r'stockQuantity': PropertySchema(
      id: 16,
      name: r'stockQuantity',
      type: IsarType.double,
    ),
    r'subgroupName': PropertySchema(
      id: 17,
      name: r'subgroupName',
      type: IsarType.string,
    ),
    r'uom': PropertySchema(
      id: 18,
      name: r'uom',
      type: IsarType.string,
    )
  },
  estimateSize: _posProductEstimateSize,
  serialize: _posProductSerialize,
  deserialize: _posProductDeserialize,
  deserializeProp: _posProductDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _posProductGetId,
  getLinks: _posProductGetLinks,
  attach: _posProductAttach,
  version: '3.1.0+1',
);

int _posProductEstimateSize(
  PosProduct object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.color.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.groupName.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.subgroupName.length * 3;
  bytesCount += 3 + object.uom.length * 3;
  return bytesCount;
}

void _posProductSerialize(
  PosProduct object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeDouble(offsets[1], object.costPrice);
  writer.writeDouble(offsets[2], object.defaultQty);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.groupName);
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.imagePath);
  writer.writeBool(offsets[7], object.isActive);
  writer.writeBool(offsets[8], object.lowStockWarning);
  writer.writeDouble(offsets[9], object.markup);
  writer.writeString(offsets[10], object.name);
  writer.writeDouble(offsets[11], object.preferredQty);
  writer.writeBool(offsets[12], object.priceChangeAllowed);
  writer.writeDouble(offsets[13], object.purchasePrice);
  writer.writeDouble(offsets[14], object.reorderPoint);
  writer.writeDouble(offsets[15], object.sellingPrice);
  writer.writeDouble(offsets[16], object.stockQuantity);
  writer.writeString(offsets[17], object.subgroupName);
  writer.writeString(offsets[18], object.uom);
}

PosProduct _posProductDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PosProduct(
    color: reader.readStringOrNull(offsets[0]) ?? '',
    costPrice: reader.readDoubleOrNull(offsets[1]) ?? 0.0,
    defaultQty: reader.readDoubleOrNull(offsets[2]) ?? 1.0,
    description: reader.readStringOrNull(offsets[3]) ?? '',
    groupName: reader.readStringOrNull(offsets[4]) ?? '',
    id: reader.readStringOrNull(offsets[5]) ?? '',
    imagePath: reader.readStringOrNull(offsets[6]) ?? '',
    isActive: reader.readBoolOrNull(offsets[7]) ?? true,
    lowStockWarning: reader.readBoolOrNull(offsets[8]) ?? true,
    markup: reader.readDoubleOrNull(offsets[9]) ?? 0.0,
    name: reader.readStringOrNull(offsets[10]) ?? '',
    preferredQty: reader.readDoubleOrNull(offsets[11]) ?? 0.0,
    priceChangeAllowed: reader.readBoolOrNull(offsets[12]) ?? true,
    purchasePrice: reader.readDoubleOrNull(offsets[13]) ?? 0.0,
    reorderPoint: reader.readDoubleOrNull(offsets[14]) ?? 0.0,
    sellingPrice: reader.readDoubleOrNull(offsets[15]) ?? 0.0,
    stockQuantity: reader.readDoubleOrNull(offsets[16]) ?? 0.0,
    subgroupName: reader.readStringOrNull(offsets[17]) ?? '',
    uom: reader.readStringOrNull(offsets[18]) ?? 'Meter',
  );
  object.isarId = id;
  return object;
}

P _posProductDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 9:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 13:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 14:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 15:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 16:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 17:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 18:
      return (reader.readStringOrNull(offset) ?? 'Meter') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _posProductGetId(PosProduct object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _posProductGetLinks(PosProduct object) {
  return [];
}

void _posProductAttach(IsarCollection<dynamic> col, Id id, PosProduct object) {
  object.isarId = id;
}

extension PosProductQueryWhereSort
    on QueryBuilder<PosProduct, PosProduct, QWhere> {
  QueryBuilder<PosProduct, PosProduct, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PosProductQueryWhere
    on QueryBuilder<PosProduct, PosProduct, QWhereClause> {
  QueryBuilder<PosProduct, PosProduct, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PosProductQueryFilter
    on QueryBuilder<PosProduct, PosProduct, QFilterCondition> {
  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> costPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      costPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> costPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> costPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> defaultQtyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      defaultQtyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      defaultQtyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> defaultQtyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultQty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      groupNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      groupNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> groupNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      groupNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupName',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      groupNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupName',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> imagePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> isActiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      lowStockWarningEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lowStockWarning',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> markupEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'markup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> markupGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'markup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> markupLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'markup',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> markupBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'markup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      preferredQtyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preferredQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      preferredQtyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preferredQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      preferredQtyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preferredQty',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      preferredQtyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preferredQty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      priceChangeAllowedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceChangeAllowed',
        value: value,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      purchasePriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchasePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      purchasePriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchasePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      purchasePriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchasePrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      purchasePriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchasePrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      reorderPointEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reorderPoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      reorderPointGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reorderPoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      reorderPointLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reorderPoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      reorderPointBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reorderPoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      sellingPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      sellingPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      sellingPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      sellingPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellingPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      stockQuantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stockQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      stockQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stockQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      stockQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stockQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      stockQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stockQuantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subgroupName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subgroupName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subgroupName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subgroupName',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition>
      subgroupNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subgroupName',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uom',
        value: '',
      ));
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterFilterCondition> uomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uom',
        value: '',
      ));
    });
  }
}

extension PosProductQueryObject
    on QueryBuilder<PosProduct, PosProduct, QFilterCondition> {}

extension PosProductQueryLinks
    on QueryBuilder<PosProduct, PosProduct, QFilterCondition> {}

extension PosProductQuerySortBy
    on QueryBuilder<PosProduct, PosProduct, QSortBy> {
  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByCostPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByCostPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByDefaultQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultQty', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByDefaultQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultQty', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByGroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByGroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByLowStockWarning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowStockWarning', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      sortByLowStockWarningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowStockWarning', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByMarkup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markup', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByMarkupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markup', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByPreferredQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredQty', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByPreferredQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredQty', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      sortByPriceChangeAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceChangeAllowed', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      sortByPriceChangeAllowedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceChangeAllowed', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByPurchasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasePrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByPurchasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasePrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByReorderPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reorderPoint', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByReorderPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reorderPoint', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortBySellingPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingPrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortBySellingPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingPrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByStockQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockQuantity', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByStockQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockQuantity', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortBySubgroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupName', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortBySubgroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupName', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByUom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uom', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> sortByUomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uom', Sort.desc);
    });
  }
}

extension PosProductQuerySortThenBy
    on QueryBuilder<PosProduct, PosProduct, QSortThenBy> {
  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByCostPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByCostPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costPrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByDefaultQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultQty', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByDefaultQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultQty', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByGroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByGroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupName', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByLowStockWarning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowStockWarning', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      thenByLowStockWarningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lowStockWarning', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByMarkup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markup', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByMarkupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'markup', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByPreferredQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredQty', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByPreferredQtyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preferredQty', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      thenByPriceChangeAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceChangeAllowed', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy>
      thenByPriceChangeAllowedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceChangeAllowed', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByPurchasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasePrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByPurchasePriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasePrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByReorderPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reorderPoint', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByReorderPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reorderPoint', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenBySellingPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingPrice', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenBySellingPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sellingPrice', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByStockQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockQuantity', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByStockQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockQuantity', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenBySubgroupName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupName', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenBySubgroupNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subgroupName', Sort.desc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByUom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uom', Sort.asc);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QAfterSortBy> thenByUomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uom', Sort.desc);
    });
  }
}

extension PosProductQueryWhereDistinct
    on QueryBuilder<PosProduct, PosProduct, QDistinct> {
  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByCostPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costPrice');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByDefaultQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultQty');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByGroupName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByLowStockWarning() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lowStockWarning');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByMarkup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'markup');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByPreferredQty() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preferredQty');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct>
      distinctByPriceChangeAllowed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priceChangeAllowed');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByPurchasePrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchasePrice');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByReorderPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reorderPoint');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctBySellingPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sellingPrice');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByStockQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stockQuantity');
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctBySubgroupName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subgroupName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PosProduct, PosProduct, QDistinct> distinctByUom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uom', caseSensitive: caseSensitive);
    });
  }
}

extension PosProductQueryProperty
    on QueryBuilder<PosProduct, PosProduct, QQueryProperty> {
  QueryBuilder<PosProduct, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> costPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costPrice');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> defaultQtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultQty');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> groupNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupName');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<PosProduct, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<PosProduct, bool, QQueryOperations> lowStockWarningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lowStockWarning');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> markupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'markup');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> preferredQtyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preferredQty');
    });
  }

  QueryBuilder<PosProduct, bool, QQueryOperations>
      priceChangeAllowedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priceChangeAllowed');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> purchasePriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchasePrice');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> reorderPointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reorderPoint');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> sellingPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sellingPrice');
    });
  }

  QueryBuilder<PosProduct, double, QQueryOperations> stockQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stockQuantity');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> subgroupNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subgroupName');
    });
  }

  QueryBuilder<PosProduct, String, QQueryOperations> uomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uom');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInvoiceRecordCollection on Isar {
  IsarCollection<InvoiceRecord> get invoiceRecords => this.collection();
}

const InvoiceRecordSchema = CollectionSchema(
  name: r'InvoiceRecord',
  id: 691329285822391,
  properties: {
    r'cashTendered': PropertySchema(
      id: 0,
      name: r'cashTendered',
      type: IsarType.double,
    ),
    r'customerName': PropertySchema(
      id: 1,
      name: r'customerName',
      type: IsarType.string,
    ),
    r'customerPhone': PropertySchema(
      id: 2,
      name: r'customerPhone',
      type: IsarType.string,
    ),
    r'discount': PropertySchema(
      id: 3,
      name: r'discount',
      type: IsarType.double,
    ),
    r'invoiceId': PropertySchema(
      id: 4,
      name: r'invoiceId',
      type: IsarType.string,
    ),
    r'items': PropertySchema(
      id: 5,
      name: r'items',
      type: IsarType.objectList,
      target: r'InvoiceItem',
    ),
    r'paymentType': PropertySchema(
      id: 6,
      name: r'paymentType',
      type: IsarType.string,
    ),
    r'totalAmount': PropertySchema(
      id: 7,
      name: r'totalAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _invoiceRecordEstimateSize,
  serialize: _invoiceRecordSerialize,
  deserialize: _invoiceRecordDeserialize,
  deserializeProp: _invoiceRecordDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {r'InvoiceItem': InvoiceItemSchema},
  getId: _invoiceRecordGetId,
  getLinks: _invoiceRecordGetLinks,
  attach: _invoiceRecordAttach,
  version: '3.1.0+1',
);

int _invoiceRecordEstimateSize(
  InvoiceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customerName.length * 3;
  bytesCount += 3 + object.customerPhone.length * 3;
  bytesCount += 3 + object.invoiceId.length * 3;
  bytesCount += 3 + object.items.length * 3;
  {
    final offsets = allOffsets[InvoiceItem]!;
    for (var i = 0; i < object.items.length; i++) {
      final value = object.items[i];
      bytesCount += InvoiceItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.paymentType.length * 3;
  return bytesCount;
}

void _invoiceRecordSerialize(
  InvoiceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cashTendered);
  writer.writeString(offsets[1], object.customerName);
  writer.writeString(offsets[2], object.customerPhone);
  writer.writeDouble(offsets[3], object.discount);
  writer.writeString(offsets[4], object.invoiceId);
  writer.writeObjectList<InvoiceItem>(
    offsets[5],
    allOffsets,
    InvoiceItemSchema.serialize,
    object.items,
  );
  writer.writeString(offsets[6], object.paymentType);
  writer.writeDouble(offsets[7], object.totalAmount);
}

InvoiceRecord _invoiceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InvoiceRecord(
    cashTendered: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    customerName: reader.readStringOrNull(offsets[1]) ?? '',
    customerPhone: reader.readStringOrNull(offsets[2]) ?? '',
    discount: reader.readDoubleOrNull(offsets[3]) ?? 0.0,
    invoiceId: reader.readStringOrNull(offsets[4]) ?? '',
    items: reader.readObjectList<InvoiceItem>(
          offsets[5],
          InvoiceItemSchema.deserialize,
          allOffsets,
          InvoiceItem(),
        ) ??
        const [],
    paymentType: reader.readStringOrNull(offsets[6]) ?? 'Cash',
    totalAmount: reader.readDoubleOrNull(offsets[7]) ?? 0.0,
  );
  object.isarId = id;
  return object;
}

P _invoiceRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readObjectList<InvoiceItem>(
            offset,
            InvoiceItemSchema.deserialize,
            allOffsets,
            InvoiceItem(),
          ) ??
          const []) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? 'Cash') as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _invoiceRecordGetId(InvoiceRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _invoiceRecordGetLinks(InvoiceRecord object) {
  return [];
}

void _invoiceRecordAttach(
    IsarCollection<dynamic> col, Id id, InvoiceRecord object) {
  object.isarId = id;
}

extension InvoiceRecordQueryWhereSort
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QWhere> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InvoiceRecordQueryWhere
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QWhereClause> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension InvoiceRecordQueryFilter
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QFilterCondition> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      cashTenderedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cashTendered',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      cashTenderedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cashTendered',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      cashTenderedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cashTendered',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      cashTenderedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cashTendered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      customerPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      discountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      discountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      discountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      discountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoiceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'invoiceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'invoiceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoiceId',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      invoiceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'invoiceId',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'items',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentType',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      paymentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentType',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      totalAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      totalAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      totalAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      totalAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension InvoiceRecordQueryObject
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QFilterCondition> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterFilterCondition>
      itemsElement(FilterQuery<InvoiceItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'items');
    });
  }
}

extension InvoiceRecordQueryLinks
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QFilterCondition> {}

extension InvoiceRecordQuerySortBy
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QSortBy> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCashTendered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashTendered', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCashTenderedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashTendered', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCustomerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByCustomerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> sortByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> sortByInvoiceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByInvoiceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> sortByPaymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByPaymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> sortByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      sortByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension InvoiceRecordQuerySortThenBy
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QSortThenBy> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCashTendered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashTendered', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCashTenderedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashTendered', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCustomerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByCustomerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByInvoiceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByInvoiceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoiceId', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByPaymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByPaymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentType', Sort.desc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy> thenByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.asc);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QAfterSortBy>
      thenByTotalAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalAmount', Sort.desc);
    });
  }
}

extension InvoiceRecordQueryWhereDistinct
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> {
  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct>
      distinctByCashTendered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cashTendered');
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> distinctByCustomerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> distinctByCustomerPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerPhone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> distinctByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discount');
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> distinctByInvoiceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoiceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct> distinctByPaymentType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InvoiceRecord, InvoiceRecord, QDistinct>
      distinctByTotalAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalAmount');
    });
  }
}

extension InvoiceRecordQueryProperty
    on QueryBuilder<InvoiceRecord, InvoiceRecord, QQueryProperty> {
  QueryBuilder<InvoiceRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<InvoiceRecord, double, QQueryOperations> cashTenderedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cashTendered');
    });
  }

  QueryBuilder<InvoiceRecord, String, QQueryOperations> customerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerName');
    });
  }

  QueryBuilder<InvoiceRecord, String, QQueryOperations>
      customerPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerPhone');
    });
  }

  QueryBuilder<InvoiceRecord, double, QQueryOperations> discountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discount');
    });
  }

  QueryBuilder<InvoiceRecord, String, QQueryOperations> invoiceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoiceId');
    });
  }

  QueryBuilder<InvoiceRecord, List<InvoiceItem>, QQueryOperations>
      itemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'items');
    });
  }

  QueryBuilder<InvoiceRecord, String, QQueryOperations> paymentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentType');
    });
  }

  QueryBuilder<InvoiceRecord, double, QQueryOperations> totalAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalAmount');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RequirementGroupSchema = Schema(
  name: r'RequirementGroup',
  id: 571252317819701,
  properties: {
    r'bandStyle': PropertySchema(
      id: 0,
      name: r'bandStyle',
      type: IsarType.string,
    ),
    r'buttonPlacketSide': PropertySchema(
      id: 1,
      name: r'buttonPlacketSide',
      type: IsarType.string,
    ),
    r'buttonStyle': PropertySchema(
      id: 2,
      name: r'buttonStyle',
      type: IsarType.string,
    ),
    r'collarStyle': PropertySchema(
      id: 3,
      name: r'collarStyle',
      type: IsarType.string,
    ),
    r'cuffCornerStyle': PropertySchema(
      id: 4,
      name: r'cuffCornerStyle',
      type: IsarType.string,
    ),
    r'damanStyle': PropertySchema(
      id: 5,
      name: r'damanStyle',
      type: IsarType.string,
    ),
    r'frontPocket': PropertySchema(
      id: 6,
      name: r'frontPocket',
      type: IsarType.string,
    ),
    r'garmentType': PropertySchema(
      id: 7,
      name: r'garmentType',
      type: IsarType.string,
    ),
    r'interfacingWidth': PropertySchema(
      id: 8,
      name: r'interfacingWidth',
      type: IsarType.string,
    ),
    r'neckOption': PropertySchema(
      id: 9,
      name: r'neckOption',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 10,
      name: r'price',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 11,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'shalwarPocket': PropertySchema(
      id: 12,
      name: r'shalwarPocket',
      type: IsarType.string,
    ),
    r'shalwarStyle': PropertySchema(
      id: 13,
      name: r'shalwarStyle',
      type: IsarType.string,
    ),
    r'shalwarType': PropertySchema(
      id: 14,
      name: r'shalwarType',
      type: IsarType.string,
    ),
    r'sidePocket': PropertySchema(
      id: 15,
      name: r'sidePocket',
      type: IsarType.string,
    ),
    r'sleeveOption': PropertySchema(
      id: 16,
      name: r'sleeveOption',
      type: IsarType.string,
    ),
    r'stitchingOption': PropertySchema(
      id: 17,
      name: r'stitchingOption',
      type: IsarType.string,
    ),
    r'touchButtonStyle': PropertySchema(
      id: 18,
      name: r'touchButtonStyle',
      type: IsarType.string,
    ),
    r'waistOption': PropertySchema(
      id: 19,
      name: r'waistOption',
      type: IsarType.string,
    )
  },
  estimateSize: _requirementGroupEstimateSize,
  serialize: _requirementGroupSerialize,
  deserialize: _requirementGroupDeserialize,
  deserializeProp: _requirementGroupDeserializeProp,
);

int _requirementGroupEstimateSize(
  RequirementGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bandStyle.length * 3;
  bytesCount += 3 + object.buttonPlacketSide.length * 3;
  bytesCount += 3 + object.buttonStyle.length * 3;
  bytesCount += 3 + object.collarStyle.length * 3;
  bytesCount += 3 + object.cuffCornerStyle.length * 3;
  bytesCount += 3 + object.damanStyle.length * 3;
  bytesCount += 3 + object.frontPocket.length * 3;
  bytesCount += 3 + object.garmentType.length * 3;
  bytesCount += 3 + object.interfacingWidth.length * 3;
  bytesCount += 3 + object.neckOption.length * 3;
  bytesCount += 3 + object.shalwarPocket.length * 3;
  bytesCount += 3 + object.shalwarStyle.length * 3;
  bytesCount += 3 + object.shalwarType.length * 3;
  bytesCount += 3 + object.sidePocket.length * 3;
  bytesCount += 3 + object.sleeveOption.length * 3;
  bytesCount += 3 + object.stitchingOption.length * 3;
  bytesCount += 3 + object.touchButtonStyle.length * 3;
  bytesCount += 3 + object.waistOption.length * 3;
  return bytesCount;
}

void _requirementGroupSerialize(
  RequirementGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bandStyle);
  writer.writeString(offsets[1], object.buttonPlacketSide);
  writer.writeString(offsets[2], object.buttonStyle);
  writer.writeString(offsets[3], object.collarStyle);
  writer.writeString(offsets[4], object.cuffCornerStyle);
  writer.writeString(offsets[5], object.damanStyle);
  writer.writeString(offsets[6], object.frontPocket);
  writer.writeString(offsets[7], object.garmentType);
  writer.writeString(offsets[8], object.interfacingWidth);
  writer.writeString(offsets[9], object.neckOption);
  writer.writeDouble(offsets[10], object.price);
  writer.writeLong(offsets[11], object.quantity);
  writer.writeString(offsets[12], object.shalwarPocket);
  writer.writeString(offsets[13], object.shalwarStyle);
  writer.writeString(offsets[14], object.shalwarType);
  writer.writeString(offsets[15], object.sidePocket);
  writer.writeString(offsets[16], object.sleeveOption);
  writer.writeString(offsets[17], object.stitchingOption);
  writer.writeString(offsets[18], object.touchButtonStyle);
  writer.writeString(offsets[19], object.waistOption);
}

RequirementGroup _requirementGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RequirementGroup(
    bandStyle: reader.readStringOrNull(offsets[0]) ?? '',
    buttonPlacketSide: reader.readStringOrNull(offsets[1]) ?? '',
    buttonStyle: reader.readStringOrNull(offsets[2]) ?? '',
    collarStyle: reader.readStringOrNull(offsets[3]) ?? '',
    cuffCornerStyle: reader.readStringOrNull(offsets[4]) ?? '',
    damanStyle: reader.readStringOrNull(offsets[5]) ?? '',
    frontPocket: reader.readStringOrNull(offsets[6]) ?? '',
    garmentType: reader.readStringOrNull(offsets[7]) ?? 'Qameez Shalwar',
    interfacingWidth: reader.readStringOrNull(offsets[8]) ?? '',
    neckOption: reader.readStringOrNull(offsets[9]) ?? '',
    price: reader.readDoubleOrNull(offsets[10]) ?? 0.0,
    quantity: reader.readLongOrNull(offsets[11]) ?? 1,
    shalwarPocket: reader.readStringOrNull(offsets[12]) ?? '',
    shalwarStyle: reader.readStringOrNull(offsets[13]) ?? '',
    shalwarType: reader.readStringOrNull(offsets[14]) ?? '',
    sidePocket: reader.readStringOrNull(offsets[15]) ?? '',
    sleeveOption: reader.readStringOrNull(offsets[16]) ?? '',
    stitchingOption: reader.readStringOrNull(offsets[17]) ?? '',
    touchButtonStyle: reader.readStringOrNull(offsets[18]) ?? '',
    waistOption: reader.readStringOrNull(offsets[19]) ?? '',
  );
  return object;
}

P _requirementGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? 'Qameez Shalwar') as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 11:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 16:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 17:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 18:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 19:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RequirementGroupQueryFilter
    on QueryBuilder<RequirementGroup, RequirementGroup, QFilterCondition> {
  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bandStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bandStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bandStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bandStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      bandStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bandStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buttonPlacketSide',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buttonPlacketSide',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buttonPlacketSide',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonPlacketSide',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonPlacketSideIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buttonPlacketSide',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'buttonStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'buttonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'buttonStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'buttonStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      buttonStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'buttonStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collarStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collarStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collarStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      collarStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collarStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cuffCornerStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cuffCornerStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cuffCornerStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cuffCornerStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      cuffCornerStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cuffCornerStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'damanStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'damanStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'damanStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'damanStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      damanStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'damanStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frontPocket',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frontPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frontPocket',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frontPocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      frontPocketIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frontPocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'garmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'garmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'garmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'garmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      garmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'garmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interfacingWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interfacingWidth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interfacingWidth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interfacingWidth',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      interfacingWidthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interfacingWidth',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'neckOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'neckOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'neckOption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'neckOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      neckOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'neckOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shalwarPocket',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shalwarPocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shalwarPocket',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarPocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarPocketIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shalwarPocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shalwarStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shalwarStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shalwarStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shalwarStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shalwarType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shalwarType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shalwarType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shalwarType',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      shalwarTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shalwarType',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sidePocket',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sidePocket',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sidePocket',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sidePocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sidePocketIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sidePocket',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sleeveOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sleeveOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sleeveOption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sleeveOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      sleeveOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sleeveOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stitchingOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stitchingOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stitchingOption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stitchingOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      stitchingOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stitchingOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'touchButtonStyle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'touchButtonStyle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'touchButtonStyle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'touchButtonStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      touchButtonStyleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'touchButtonStyle',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waistOption',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'waistOption',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'waistOption',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waistOption',
        value: '',
      ));
    });
  }

  QueryBuilder<RequirementGroup, RequirementGroup, QAfterFilterCondition>
      waistOptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'waistOption',
        value: '',
      ));
    });
  }
}

extension RequirementGroupQueryObject
    on QueryBuilder<RequirementGroup, RequirementGroup, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LedgerEntrySchema = Schema(
  name: r'LedgerEntry',
  id: 367190837985873,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'gaveAmount': PropertySchema(
      id: 1,
      name: r'gaveAmount',
      type: IsarType.double,
    ),
    r'gotAmount': PropertySchema(
      id: 2,
      name: r'gotAmount',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'isAutoEntry': PropertySchema(
      id: 4,
      name: r'isAutoEntry',
      type: IsarType.bool,
    )
  },
  estimateSize: _ledgerEntryEstimateSize,
  serialize: _ledgerEntrySerialize,
  deserialize: _ledgerEntryDeserialize,
  deserializeProp: _ledgerEntryDeserializeProp,
);

int _ledgerEntryEstimateSize(
  LedgerEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.id.length * 3;
  return bytesCount;
}

void _ledgerEntrySerialize(
  LedgerEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeDouble(offsets[1], object.gaveAmount);
  writer.writeDouble(offsets[2], object.gotAmount);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isAutoEntry);
}

LedgerEntry _ledgerEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LedgerEntry(
    description: reader.readStringOrNull(offsets[0]) ?? '',
    gaveAmount: reader.readDoubleOrNull(offsets[1]) ?? 0.0,
    gotAmount: reader.readDoubleOrNull(offsets[2]) ?? 0.0,
    id: reader.readStringOrNull(offsets[3]) ?? '',
    isAutoEntry: reader.readBoolOrNull(offsets[4]) ?? false,
  );
  return object;
}

P _ledgerEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LedgerEntryQueryFilter
    on QueryBuilder<LedgerEntry, LedgerEntry, QFilterCondition> {
  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gaveAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gaveAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gaveAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gaveAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gaveAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gaveAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gaveAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gaveAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gotAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gotAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gotAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gotAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gotAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gotAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      gotAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gotAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<LedgerEntry, LedgerEntry, QAfterFilterCondition>
      isAutoEntryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAutoEntry',
        value: value,
      ));
    });
  }
}

extension LedgerEntryQueryObject
    on QueryBuilder<LedgerEntry, LedgerEntry, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const InvoiceItemSchema = Schema(
  name: r'InvoiceItem',
  id: 348979021325046,
  properties: {
    r'costPrice': PropertySchema(
      id: 0,
      name: r'costPrice',
      type: IsarType.double,
    ),
    r'productId': PropertySchema(
      id: 1,
      name: r'productId',
      type: IsarType.string,
    ),
    r'productName': PropertySchema(
      id: 2,
      name: r'productName',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 3,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'sellingPrice': PropertySchema(
      id: 4,
      name: r'sellingPrice',
      type: IsarType.double,
    )
  },
  estimateSize: _invoiceItemEstimateSize,
  serialize: _invoiceItemSerialize,
  deserialize: _invoiceItemDeserialize,
  deserializeProp: _invoiceItemDeserializeProp,
);

int _invoiceItemEstimateSize(
  InvoiceItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.productId.length * 3;
  bytesCount += 3 + object.productName.length * 3;
  return bytesCount;
}

void _invoiceItemSerialize(
  InvoiceItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.costPrice);
  writer.writeString(offsets[1], object.productId);
  writer.writeString(offsets[2], object.productName);
  writer.writeDouble(offsets[3], object.quantity);
  writer.writeDouble(offsets[4], object.sellingPrice);
}

InvoiceItem _invoiceItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InvoiceItem(
    costPrice: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    productId: reader.readStringOrNull(offsets[1]) ?? '',
    productName: reader.readStringOrNull(offsets[2]) ?? '',
    quantity: reader.readDoubleOrNull(offsets[3]) ?? 0.0,
    sellingPrice: reader.readDoubleOrNull(offsets[4]) ?? 0.0,
  );
  return object;
}

P _invoiceItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension InvoiceItemQueryFilter
    on QueryBuilder<InvoiceItem, InvoiceItem, QFilterCondition> {
  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      costPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      costPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      costPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      costPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      productNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productName',
        value: '',
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition> quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition> quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      sellingPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      sellingPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      sellingPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sellingPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InvoiceItem, InvoiceItem, QAfterFilterCondition>
      sellingPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sellingPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension InvoiceItemQueryObject
    on QueryBuilder<InvoiceItem, InvoiceItem, QFilterCondition> {}
