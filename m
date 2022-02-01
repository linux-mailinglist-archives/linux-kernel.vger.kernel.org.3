Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6753E4A548D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiBABQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:16:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:31070 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbiBABQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643678191; x=1675214191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0oE+m8pZBoE8JvBOi1lmDojdWaYh6fIsTdpTH/MdX08=;
  b=j7ClEvkFbpnMBntNw2W3JWTgCG/Lp5DcIPw6cYbYBBu9SbCgx+ARHp+O
   q10ypANzQpPXyyGIzTeblXtlT1cbSO3cRE4E/av0ZFbF9Yw+9hBG0vAQb
   X0TSy3A+8BYED3ShD567lPLtjmoiSv0sSNEDxLYQb3L9OQ3q/IHpW/ua2
   5xjgg0JKQhtwiM05AicyWHEVcED3SNWq9F036YdMMr4svuwZICXeG42HR
   jw8mcoioHZm7z21allgO2GMpNvRX51BMCaeG7KkRHZco636cHbJvuHlY+
   1yFM1te68AwK6Qq9hYVrUNEs+pkh9vkAB+O8xcu+mJRG1McZnEbI9CNdN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308330714"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="308330714"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="675929922"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 17:16:29 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 17:16:29 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 17:16:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 17:16:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 17:16:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0Tg6iA8vPU2H8CS5BriLSD7fNUSQD+QLgHBHkXBfo6rT90jw6nwqPt2dEeU95HadrPM457sFoEo5sdSPtBK2T+tg7wsSaiLFnyE8CivsgIQpmse8JlHN/u6z/phegbSqa81N+3IbIOHRgMXiHYEbTOeiwSr64UwZeR2UmazP9tVff9As+DL3XOpQpBU2GuNAD/N7E+D25JDxP1cjIWI67KsCB5yI8edfnCTKYWOSEwwvSkHUC3W8uTdnbN8ALCD5jTHa9TRTdzT8fIpeQMHaHKqKTSMDX3v0RD3118Ya21+lWDKGVLBRnJuo+dOXAJCKqt7bVpSBVBmjZSPyv+bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oE+m8pZBoE8JvBOi1lmDojdWaYh6fIsTdpTH/MdX08=;
 b=FzPuLHNj3x5iUe4UDBt4/ZaoKQiqV8kUed2tt6DL/Pfg61xIHJAHzFbnxG3yUVkFhgieIC05YGJXj+bm96UP929URlIBQx++g14pVTrEJVIEev5h0gsbEj3UyukwDpM74sCuBklmDhejJULl4oC42ApYCBUwfqU6cu7vCVCujKZLGRiDGwcvs9cWheWYAjZCJLJ9NIquVktYqFV7RBk7O75MAkEtQoZWTzfnM04Cd7RaoX72nhgiiGVNRqlyUvmf/TG4bepgedoSM5kEmWd3d2Kja7/+WUtDUioIXgypJ0xiX7HA+YCV0wrluFkAdvibIsJuFhw8PYltV/nBzHfsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1870.namprd11.prod.outlook.com (2603:10b6:300:10f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 1 Feb
 2022 01:16:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 01:16:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
Thread-Topic: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
Thread-Index: AQHYE6cTHeDzx1PUykelKKnpuzt1BKx961uA
Date:   Tue, 1 Feb 2022 01:16:26 +0000
Message-ID: <15f8b55bdb85130a8036332f850a561447681203.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-40-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-40-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a8c4cdd-5c38-470c-b710-08d9e5207802
x-ms-traffictypediagnostic: MWHPR11MB1870:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR11MB1870B48153A789484ECFF37FC9269@MWHPR11MB1870.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQZHcWezjWm1JYV7Ox9PTgFQcd8rLgIrUcUwUJSWUecOWNCgO9hWXZ2n2/W+b6o87OxOgJlN1Na9dkeysYWO5QaNkTR5S7HBNefo2isPrwBl3Dq1eGlgfOx1npQZ2F7FHrGOCABg6KOK5mjRViX4HG+pg0K6jowVQWG536I0kUD+1fh0laKV2IP0NUe/Oo4b+ZoSEs7z4leIpTpyVDfRmvABSzDYRJG4euJ+XpaF0nK6GvDt76x12ac2h4+WdZYcOGKjQP6xwhcL4ieUw/m6jZL3oxavNuKVpBJcG6V45Ztl+qWCpso5myo0nyGgU5+AdcT7iaUvOqczUtHgbq4j22kfrNvg98jG9mSchbEUaEtUkwUXzktRMSnLlyTyRaA+mDxuJgSzsJzimCvXpfnti6HHQQHoaoVx464YtTPQvhkjYsKt2CH/iCq/e+czwmJRptK0pqfkPU7Cx4E0PrGHegMbnokRiXcwwyI+sVIP3uQdG+eGHBZ1MdNMOEngtlUOM2kSL/98pL+HuhFcTgCS54MuKA5taQtr4mYixBdgfKtLUDfooS/dfs5UotFvxAz5CVRNBivSSN0svGBknlLQ1vbk4/Nc6G2MUyKDND6SDGfTZLM6SInPLdPQ6DCTjU0cr0wBYp1hR0XpdjTWtGl7AZZYVGO/IneYeCiD69LOatemJzyDSeJrlONUgyPpe/G/lYeMKAUjNIGcrhfqkTWqU/N36NylLNBhdKkTcD4L6fA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(8936002)(8676002)(122000001)(82960400001)(54906003)(64756008)(66476007)(38070700005)(6486002)(76116006)(110136005)(66946007)(316002)(508600001)(2906002)(71200400001)(86362001)(36756003)(4326008)(5660300002)(66556008)(2616005)(6512007)(26005)(186003)(6506007)(4744005)(38100700002)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZ5Z0NYbEN6QjVxZ0ZEQ3RUemlERjh0UHJhWE9jMkJyaHJoOEx0c0dsaUpW?=
 =?utf-8?B?cmNHM1JMQlFqY3RKSE5FMytRblNuM1J4OStYdEhQczZFbW05RTdaOG53c2kv?=
 =?utf-8?B?bTZ0WUkxNnVYR3RIN0MybFRQYjNQU3FaZ2I5RmRrVU41R2kvUWRJbFZ4djZp?=
 =?utf-8?B?YkFBcTBqQ3A1TkpZZUJjZEk2NmVsWHNkQzdKTW15bGthUEpHZlFCOEhHamN4?=
 =?utf-8?B?eGlBaW9TZG12VzZhTFRTc2RZYlYzT1VobFJOZnYyUFRvNkpoK082ajlnbkFP?=
 =?utf-8?B?bUZ4VnB4eGNVbzZJOWREUm5PVHd0QzNmM0FjTGJValkxVW14d3MvV25IUzgv?=
 =?utf-8?B?dExiRSt5VFJiMzJBUzJqd2ZVbUFzdWJHZFROV0FNOGEzc3VQNHJoU3lOaFQv?=
 =?utf-8?B?bkF4cVZhamU1U1d2UnlRaU55NHA4Y2Z6NXY4c0Z0QTFIejF5MkJpMTVRakJ6?=
 =?utf-8?B?NndMSjRCUGt3RWkwTm5qMk1lSXQ3Vi81Sjl0SUwzSjd2M2xHRVVoRlZWT1Nl?=
 =?utf-8?B?QkdJcDU2eGE0c1lpSWYyM3Z2V1RuT3BBQU90UjluTXZNQ1U0Q3oxVnA2Nm4w?=
 =?utf-8?B?L3JSd0ttakFaS1RBakxGZVhwYi9rU1RpWjJlUDcvaGRzN1J3ME5ZRmVCVUtN?=
 =?utf-8?B?Y3VCMHZqaHdqMzhlZTFKMTN1cWZCV0lsZ21uei9XWmxhS3o5eGxQMnduWEV4?=
 =?utf-8?B?OGE1ajhtOE5JRXFJS0l3dUZWc05mSFp4K09TRU1HeVd0R1UzZGNCZ3dmNGcr?=
 =?utf-8?B?UXAybmRvSStDM2dKakF3MDF2MkN2TGtBZGtMYUtOTEdnY0RDRy9vYmxiSWRk?=
 =?utf-8?B?YVZLczJOZXA4YkNPZEJEcFhobVM1Q3NkWjUyL0daeGk2SHoxNlBMNGU4ems3?=
 =?utf-8?B?aTdwMEZqekVrQ1NRbnY3TUJ0bDBuU05kaDBZUU5yQXd3REVxMTZHRmhJUjBN?=
 =?utf-8?B?bkk2R1ExQjU4amV0ak52TnUralpHaHg0N1RRTlBVeHEydk1oTWdXVGxvSGlC?=
 =?utf-8?B?RXByOWlQZEdZbGhick1zUzFxZFlUMFpRVisrUjJpSk9zeGVuQmJHaWF3Ky9s?=
 =?utf-8?B?dUJYZWFYdG9mY2t0V2oxbTRHMFpEaVFxZjlpOEZDcW1qaHUycmRiNVUzaWFJ?=
 =?utf-8?B?c1pqWE5SUHFFSll0dG1kZHl3MW02OUxrU2xQNWg0TDVQR3VrbEt3Zzg4cVR2?=
 =?utf-8?B?OHdyMXd1aytZNjQ2UFpISFMraGJhWHg5VG9RNHh2dThISUlUa2JBSERGYTBz?=
 =?utf-8?B?SmlnUGIwcWJ2M2Y1R3NXakNOTVJFZ25QMDNrdGs2Qjk3bXpqbmtFeExNNmFN?=
 =?utf-8?B?VXFqVzFSMmtENXVpVVBhZ1JiT2JLdGI3UHUydVUxQ1ZmODFmVDRVTy82aXli?=
 =?utf-8?B?bjlzUXR6UVZEL3hHMHdxZENUajdnNlNKUEQ2Qm1nMHpiZ3Y3MXc4anNPNUww?=
 =?utf-8?B?d3d0dnV5Uk9lcU9Famg5Q1BiUHVQeGY2VDc0bUhXVWNaVUVIbnZ6b01jWjRv?=
 =?utf-8?B?Z0pER3BRWGNEdmsvM1Z3dzRLOTZOMnBDSlJSUFRmdXlZM2hqTVo2VWxyZzNp?=
 =?utf-8?B?ckZkNTR4Y3VTSE5LRTd4SUhUMURUL1NRR2h1K0k1VGZzNDl2dWFRWEFlMEZF?=
 =?utf-8?B?dTk1OW5yb01rU3dMUEdoYUIxT3QweVZhYmM3Rnl2MWRKMnJHTXlvanY0QnRF?=
 =?utf-8?B?VzZqVWJPU0VQbHAxdzI4dFlNSi95TE1KSU45SGN1a0ZZdXZqK0dEOUZYbUlS?=
 =?utf-8?B?M0czRkttMm5HU1MydGltak9qZUNzNENJS3lONHE0UlkwMEE5aloxK1B5cGNB?=
 =?utf-8?B?S3NuVk9ydVVYVCtkejhycVVqTk9VZE9vMjJOSWVYVUk1SFg1L3RDL3lXdWsr?=
 =?utf-8?B?K3FydXk2Q2FONlFuWVo2cnczcUppL0Z6NmVncDY1QzFpc1dCQ01ETFdocU14?=
 =?utf-8?B?TERnbGw3RDJOYU5mTWh4V01RY3NKb2ZZckJtUVlyanVHRnpNdkhJNkU1a2FS?=
 =?utf-8?B?cTJPY2xOS01STVJwa0RDdFpuUHBhT0hNQStIWUFlbGhuZnBzR2I2TG95RGwr?=
 =?utf-8?B?RndkcjRlbWlxVWcvWG95MEc2ZVVHdFZKdTdKVEhIVGRHVlhSb2ZCc2tKYmdV?=
 =?utf-8?B?MGVNQUo2NVIwQTZBWkpqMzhMTEhNWjhVN0VmR1RNVmhFdjgzaUpab1lQbWEv?=
 =?utf-8?B?akxxUy84QlhIUWFDVVdTd2FKWmJLZmhZK1ZwMklrSm9lWWYzL1RUbjJnNTJo?=
 =?utf-8?Q?Fk9QqLBiJzozsfgYY3gFLd8Qmv4BYjrSMc651oEA8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE031A5668B4D44BB05A75AECCDBF9BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8c4cdd-5c38-470c-b710-08d9e5207802
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 01:16:26.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcxveTbpXfGlEcSVMB/RhiIlPsNEtLFInpBloz2p9l4hkq1r6y1i5K24G8MNvcGgZ9FYPh2mZDsje3wix4meQDoHLtBH0MiGDzM5piz/Uc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1870
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU1IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArc3RhdGljIGludCBwYXJhbV9nZXRfcGtzX2ZhdWx0X21vZGUoY2hhciAqYnVmZmVy
LCBjb25zdCBzdHJ1Y3QNCj4ga2VybmVsX3BhcmFtICprcCkNCj4gK3sNCj4gKyAgICAgICBpbnQg
cmV0ID0gMDsNClRoaXMgZG9lc24ndCBuZWVkIHRvIGJlIGluaXRpYWxpemVkLg0KDQo+ICsNCj4g
KyAgICAgICBzd2l0Y2ggKHBrc19mYXVsdF9tb2RlKSB7DQo+ICsgICAgICAgY2FzZSBQS1NfTU9E
RV9TVFJJQ1Q6DQo+ICsgICAgICAgICAgICAgICByZXQgPSBzeXNmc19lbWl0KGJ1ZmZlciwgInN0
cmljdFxuIik7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBjYXNlIFBLU19N
T0RFX1JFTEFYRUQ6DQo+ICsgICAgICAgICAgICAgICByZXQgPSBzeXNmc19lbWl0KGJ1ZmZlciwg
InJlbGF4ZWRcbiIpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgZGVmYXVs
dDoNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHN5c2ZzX2VtaXQoYnVmZmVyLCAiPHVua25vd24+
XG4iKTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAg
ICAgIHJldHVybiByZXQ7DQo+ICt9DQo=
