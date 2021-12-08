Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9846DAA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbhLHSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:04:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:35406 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238424AbhLHSEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:04:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="298686363"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="298686363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 10:00:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="462854106"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 10:00:21 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 10:00:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 10:00:21 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 10:00:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAT3Es5fW2LCXpr2R13A1ewE2pIAlxj0ndwBdZNAnblhanwqG/OxZnATvOBz4NKUUfzWbJY6yGOE6wRRL9FssUiL22smA0Cleu2LRO8rT45tLWZjTzi0hlYHB4oi04hO3sT1zMA+48SKdK/xa+LFbgdz9Y7OD+Pz3y5CnyQuac9avia5cD+OkFweNKYWBl3hBZmnNDMmKGiejuAdni4Y8hEAfmVDrPzvWNS2yJqmEBBjLzxPg7fL7VH7uHhP6qpm1o4KOtzUlyVVG1GH2qB8e7v6zRBGhkN+ayx2Jd1ss86QewoHLIOL5N/4BOxHlB/xpwJxgGjH3d5xIR9nqA5v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6tXOTaONhVINJEbiKSCDmHzI49UZiJe22NHrsMSvBM=;
 b=cnu9R+GUiLO8r4QnV8xGDzTN82/d+c+snrAHNNijTodNsgo+3KKRV9aGanOI5rWMeLHASoW0E9inCiLO9jPRUw7ofcI2TD330v+NimJQUe9TegFj4iIC4yR2Uzb+RL6KhjgVoaOc1U6PDiXXZ/SLgX9V03jyWJ86Mxlq6sk/dVcmvCUfvn04uGsmYXxyav6riTxuV2kQ1q1CCKVZzPfteuNZcjzKXr40XqfpvNF4kQG1CcD0IfSkOm89cU6r05/sb+FNOSdPiUTWYRlnBReA6MLbwo1q8qJ96BOwMLA6316BVqLJYp9EsnxrtElKss+yfdbL8achRFWztZCzGzo8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6tXOTaONhVINJEbiKSCDmHzI49UZiJe22NHrsMSvBM=;
 b=lEJvfUQx4siMMYafutp76bahTPIUDOqgcEcrrgNpgChZogvabx8o8OaubEJkB3b1UHerUmJSKDO9uHQ1gnWeA2EiQDwOhQrqZwVpL8z5kZTgrM9cwTmR/wix4B380zBfDM2E862dODTF4Vbnr5WSJobLvXuH5vB5WYnY3mxe35s=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 8 Dec
 2021 18:00:06 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 18:00:06 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [x86/signal] 3aac3ebea0: will-it-scale.per_thread_ops -11.9%
 regression
Thread-Topic: [x86/signal] 3aac3ebea0: will-it-scale.per_thread_ops -11.9%
 regression
Thread-Index: AQHX68BCPfwcXGFiOkq/teICNKl83awo41oA
Date:   Wed, 8 Dec 2021 18:00:06 +0000
Message-ID: <DF832BC5-AB0F-44AD-83C3-E0108176F945@intel.com>
References: <20211207012128.GA16074@xsang-OptiPlex-9020>
 <bbc24579-b6ee-37cb-4bbf-10e3476537e0@intel.com>
In-Reply-To: <bbc24579-b6ee-37cb-4bbf-10e3476537e0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e988d760-1508-49a0-4830-08d9ba74914d
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5880439E590B8A9FF7E7CD1AD86F9@PH0PR11MB5880.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIK6WuBhrtMsAhgqtqdIuEiCPvpHGLkUoJ3IvtJMrmiudsKGF3Y9q/Th+PPkqOC2sVKJEtarH8BmSLbx6mJewWhUy5g7wtFzMyc1JvS3O9WYVBCShj+nsGqKZ3PmyZa562UKVsH4TsoFffyNcfbpl0AgT3waIkd5TVUlyJoFtk2SEbkno272njnn3C2dUlbUFqbjF9hupF5XJ6CUpikI97SogBPXrKy/U57vS4PS+xKYgsjgcFht69IvEUbpj14OJUJT17qvNT2bvEd0jDdVOtBPPHOloQIKmDPLofE0SRiNbB6tHBMhTwVvwQmmHhAtbpB7ybMIP7HRYLLMJ7JXFw8ceAdlenLLse1eDzArB/nQLIfJYRE7xuj5aMxWWv5Qg8d589rN0JlGAlq/TQvLTd8q3qFttL+cvbXt1zWwZ6IyUUn4D/+fkPmnLOoQD1aS95o4ljdcbexO6z9EypEKnYfCx5sTaAySqrIEqYK3PkeX+azqWE4LI37/W+aPyifU1VS/1JThzwHlb5LwOpqndufeLXH8Y2lcPbWzPusEBDbnvEsV4VhcY3rfAkXinDRraInH6DAi3X6wPkWmC8Wxuae3aJfyPNiY12bPdEeFivndKaUqMrl7TTWcYlZxFNmKSApTVuxvvZgjaYhwovCgOMRgAwfpmVGLwDOh25DqPdka6lWZILoCn3rlxAOR12eek5azQ24tFiFlZtwNpdnWHpgIi0T9t9lOSzT9/oAvTa+IIw3ZmXlPb+dx+FxZ7+0E9NOqbirvwQXoQ13eaQyG5UkglJAxEr1BS/k5j82tP0EK5wRhUX3EElSLhM+SwzOJi7fs/N9ljkTusi1euyrVWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(64756008)(38100700002)(82960400001)(122000001)(4326008)(71200400001)(6512007)(76116006)(86362001)(508600001)(54906003)(66946007)(66476007)(2906002)(316002)(38070700005)(66446008)(110136005)(36756003)(186003)(8936002)(53546011)(966005)(8676002)(5660300002)(33656002)(26005)(83380400001)(6486002)(2616005)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVkcGFPcEFxWEZSbTNzbXd4Mmk0SU51Wk9kSlhXUUMzSVVQWnR1R0tIak5V?=
 =?utf-8?B?b0YrSWtqOGdpYjcrc3lkdUtnajY2MDBHSUhDSkRnY0FJL1M3OFo4OHhmTytK?=
 =?utf-8?B?cGtEbUc3VWl2OEpMdnlOai9nakRnWHNRNk84dUZzOVpDNGtDVUZtaU9STUpD?=
 =?utf-8?B?em1pOHhGb1NYTmpMbUtaUUVkRzM5cnpZL0E2WnozM3lZRDNrc3ZOZW5mTW50?=
 =?utf-8?B?MTVKOTg2WjJrcWhjejE5TlhrUWtFTVQ3V1F0MVZPTEVDR25kNUE0OEV1U1RM?=
 =?utf-8?B?R0kySjlCLzg1WnYyT3RzM0RkdVFWcmE1L0srTDhxZS91Njlmdll6NEVVQ3Mx?=
 =?utf-8?B?R3g5d0EzenFLQ2FsWTJnNWdLS0pST1JJUnQ0WVc0OUluTTU1U0wxQkh4aUYy?=
 =?utf-8?B?SjBVT3BiK1NycWdHYnZ6L2YzRzJ0dkpsaUU1QW8yV2VTdEJNZ0oza1dCWW5v?=
 =?utf-8?B?dlplTXBHK0J3TlJ5aW1rTGFibkE5Z1hwTHpZazJLbWoyZDJKWEwvZ0laVnBS?=
 =?utf-8?B?M3ZSWnpVdjNlaVVPckFIbFo4ZTdVaEJycEpkSXV2MDFSLzMvSG13TW1OSmNE?=
 =?utf-8?B?a3NPV1gvcDAwMkRKdFZ5c2tsR1ZiN0VHUXRheEs0cGdqR2huVGFxaERFZFZJ?=
 =?utf-8?B?NmNaeURRck9Ma2lIR05iZ0crNHJTWkd3TkVVd2VJRFQvUmVHTVR1aHFMeW4x?=
 =?utf-8?B?UFIyaVB4d0pFNkljWWp6emZmMXF3QzVXcDh1L2c3emdsaXY1bHRiS3dZTmll?=
 =?utf-8?B?d05wU21jZzZacnhkMXVnRkdzQXRvQzliLzVWeEZ3TXFHWTNzTHpUQlRJZlF5?=
 =?utf-8?B?bllEbWM4aGpRWHZaZDNFY1BONktFeFRrcGZ3dGFxTmVlWHNLZ28zYVloUUVV?=
 =?utf-8?B?Y2ZoV2JUeFE3a0JySlJlcnl6YkcxZ3RxN2dNNDVzcUcwdGt0bzN6d2dYV3Fa?=
 =?utf-8?B?dXpQZlhoV1IzTDdIL2E0eWNRbllwejF4UG45SGh1anBMUS9KRFRvV3Z6ZVZZ?=
 =?utf-8?B?eFlHbGVpY1ZZemRNVGxZOEsyWTlBdVg3ZFFQR2daMkxaRmkwVkUzeXl6Smxv?=
 =?utf-8?B?NW9zNzRvWWkwenFTWERjVG9XUWlBMmhXYzNPZmRlVC9FbHBSSkRUYmRQR29t?=
 =?utf-8?B?eVEydW01Z2k5TnN1TmZwVEQrbTRoY0loODlXMVBkc2lsTWxzT0FXY0dRd2Y0?=
 =?utf-8?B?MnNzOFQzZTJpT04yWDQ4ZVZXc0pNbEtoVXhsWmc1Nk9hSXkyeXN4MHpzTHZk?=
 =?utf-8?B?Qlp6YTk1WUlFVEpBOXljZ1ZSNmtLWDF0VXdvbUdtWDU3em5BcWdwY0V0WXBK?=
 =?utf-8?B?NEdzVUVMV3NqT2dtVEQ0SnhoMkhGNUw0R0dNc205eHk3VlBXNXJMZ1Q3WFQx?=
 =?utf-8?B?ZFg0QmhpQzJXWTNIVDlWK0FHbUthWXNiUU1GSGZ6dzJKOVIzZVp0bG1YblVl?=
 =?utf-8?B?Zk8wU09HSzYzZGptS3FGb3lmNUtjaWcySXladHRpRDVQNzRudzNsYWFKaVF3?=
 =?utf-8?B?QjJZMFIrTFV4VzFUVE1PQzRDeDduYjlRWklETDhjNmxLZWlKSEtlLzM3ckVu?=
 =?utf-8?B?T0ZmQ2orakJMZUxOWllkcUkwdWRWWjVITC95c0RDbndXNkp4SWpGemwyeVkv?=
 =?utf-8?B?M0VLRUJuaFpINGZxN1NvbXhYRDRRZUxMM1BENHNGZC9OV0tvbW44MjFxSjVM?=
 =?utf-8?B?SmN0Y2F0NkJiUjBQb20xSkNIOXIxMDdCOENtYUNNanV6Rm9aSlJHYlJjNjAx?=
 =?utf-8?B?dExadFBObWl6VEs3K0R3VHRIS0ZjMXpuSy9SWmZkZDBYWEdGbmV2aDVVbU15?=
 =?utf-8?B?bmoxS05ocHlQSzFpV1NkcG83dUhaUDlhK2FraTFCV2prQzJoeUdaOHJVdFRm?=
 =?utf-8?B?NlVtT3RjMEJkRnlMZFB4Z2VvRWdQU1czVmJYTVFUZzN5MnFwNDJPdko5aHFP?=
 =?utf-8?B?T2hpdFdHblVWTzhLdUhtUmlTVEtXelZLN3g4dXNMUEl3ekVkK2FDZWNpVkJ0?=
 =?utf-8?B?QnBlYVZNRER5MEt1UTk0bVMwQkZvZGZqRXNMTnNXOVNZTDNiOVZvU3VLV1Ba?=
 =?utf-8?B?VzNCS3pseGI1YmdaZFNmWG8rOGRweVA0WE03V01LclI1SDlIdmV6Y3dpdThW?=
 =?utf-8?B?UndTTFc2azZ0TGw2UHQ2L3Z6dWI5OGhaYXhxeVJRdzdVZEIxcDdpbTBMWjZk?=
 =?utf-8?B?alcyN1M2M05JVENnR1p5bHJaNGVmbDN5R091UW9BdVhWZDgzckZDYUlJdTNq?=
 =?utf-8?Q?u8fnWBwZ7K3kkLtIw9aRlnbmCbUrbarxsNlSuEgUrI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E282A2DBD0AA1A4BB3D78BAA8E8B352E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e988d760-1508-49a0-4830-08d9ba74914d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 18:00:06.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bTKziALQ8GUbMlqK9q8I8EWn4NUVFDgdGmS8EYOcVPedLnWikJ/qY0IrR2pb2sSVE8yoemlE3USAd6iig4haS3cZcSBCz4vVuKJMUlklxN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5880
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGVjIDcsIDIwMjEsIGF0IDE1OjE0LCBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVs
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbGl2ZXIgb3IgQ2hhbmcsIGNvdWxkIHlvdSB0cnkgdG8gcmVw
cm9kdWNlIHRoaXMgYnkgaGFuZCBvbiBvbmUgb2YgdGhlDQo+IHN1c3BlY3Qgc3lzdGVtcz8gIEJ1
aWxkOg0KPiANCj4gIDFiZGRhMjRjNGEgKCJzaWduYWw6IEFkZCBhbiBvcHRpb25hbCBjaGVjayBm
b3IgYWx0c3RhY2sgc2l6ZSIpDQo+IA0KPiB0aGVuIHJ1biB3aWxsLWl0LXNjYWxlIGJ5IGhhbmQu
ICBUaGVuIGJ1aWxkOg0KPiANCj4gIDNhYWMzZWJlYTAgKCJ4ODYvc2lnbmFsOiBJbXBsZW1lbnQg
c2lnYWx0c3RhY2sgc2l6ZSB2YWxpZGF0aW9uIikNCj4gDQo+IGFuZCBydW4gaXQgYWdhaW4uICBB
bHNvLCBkbyB3ZSBzZWUgYW55IGhpZ2hlciBjb3JlLWNvdW50IHJlZ3Jlc3Npb25zPw0KPiBUaGVz
ZSBhbGwgc2VlbSB0byBoYXBwZW4gd2l0aDoNCj4gDQo+IAltb2RlPXRocmVhZA0KPiAJbnJfdGFz
az0xNg0KPiANCj4gVGhhdCdzIHJlYWxseSBvZGQgdG8gc2VlIHRoYXQgZm9yIHRoZXNlIHN5c3Rl
bXMgd2l0aCBwcm9iYWJseSB+NTAgY29yZXMNCj4gZWFjaC4gIEknZCBleHBlY3QgdG8gc2VlIGl0
IGdldCB3b3JzZSBhdCBoaWdoZXIgY29yZSBjb3VudHMuDQoNCnRnbHggYWxzbyBhc2tlZCBhIHNp
bWlsYXIgdGhpbmcgLS0gdGVzdCBpdCB3aXRob3V0IHRoZSBweXRob24gc2NyaXB0IGJldHdlZW4N
CjUuMTYtcmNYIHZzIDUuMTUuDQoNClNvLCByYW4gdGhpcyB3aXRoIHRob3NlIGtlcm5lbCB2ZXJz
aW9ucyBhbmQgc29tZSBwYXRjaGVzOg0KICAgICQgLi9zaWduYWwxX3RocmVhZHMgLXMgMTAgLXQg
MTYNCg0KVGhlIHRlc3QgYWNjb3VudHMgdG90YWwgbnVtYmVyIG9mIGRlbGl2ZXJlZCBzaWduYWxz
IGluIDE2IHRocmVhZHMgaW4gYSBzZWNvbmQuDQpSZXBlYXQgdGhpcyAxMCB0aW1lcyBhbmQgdGhl
biBhdmVyYWdlIG91dC4gVGhhdOKAmXMgd2hhdCAneyBhdmVyYWdlIH0nIHRlbGxzLiBTbywNCmhp
Z2hlciBpcyBiZXR0ZXIuDQoNCkluIHRoaXMgdGVzdCwgdGhlIGxvY2sgY29udGVudGlvbiBjYW1l
IGZyb20gdGhpcyBzaWduYWwgcmV0dXJuIHBhdGg6DQogICAgcnRfc2lncmV0dXJuKCkNCiAgICAg
ICAgLS0+IHJlc3RvcmVfYWx0c3RhY2soKQ0KICAgICAgICAgICAgLS0+IGRvX3NpZ2FsdHN0YWNr
KCkNCkJ1dCBkb19zaWdhbHRzdGFjaygpIGlzIG5vdCBuZWVkZWQgaGVyZSBhcyBubyBzaWdhbHRz
dGFjayBjaGFuZ2VzLiBTbywgcGVyaGFwcw0Kc2tpcCBpdCBsaWtlIFsyXS4NCg0KVGhlbiwgSSBn
b3QgdGhpczoNCg0KICB7IGtlcm5lbCB2ZXJzaW9uIH0JOiB7IGF2ZXJhZ2UgfSANCiAgNS4xNS4w
CQkJCTogNTg1NTc3DQogIDUuMTYuMC1yYzQJCQk6IDUxNDk1OQ0KICA1LjE2LjAtcmM0ICsgWzFd
CQk6IDU3NTA2Ng0KICA1LjE2LjAtcmM0ICsgWzJdCQk6IDU5NzIwMQ0KDQpJIHRoaW5rIGF0IGxl
YXN0IHRoZSBsYXN0IGNhc2Ugc2VydmVzIGFzIGEgcHJvb2Ygb2YgY29uY2VwdCBmb3IgdGhpcyBp
c3N1ZS4NCg0KVGhhbmtzLA0KQ2hhbmcNCg0KDQpbMV0gdGdseOKAmXMgZGlmZiBzaG93biBpbiBo
ZXJlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3YmwxczM1N3AuZmZzQHRnbHgvDQoN
ClsyXSANCmRpZmYgLS1naXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMNCmlu
ZGV4IGE2MjliMTFiZjNlMC4uODE5NGQyZjM4YmYxIDEwMDY0NA0KLS0tIGEva2VybmVsL3NpZ25h
bC5jDQorKysgYi9rZXJuZWwvc2lnbmFsLmMNCkBAIC00MjI0LDYgKzQyMjQsMTEgQEAgaW50IHJl
c3RvcmVfYWx0c3RhY2soY29uc3Qgc3RhY2tfdCBfX3VzZXIgKnVzcykNCiAgICAgICAgc3RhY2tf
dCBuZXc7DQogICAgICAgIGlmIChjb3B5X2Zyb21fdXNlcigmbmV3LCB1c3MsIHNpemVvZihzdGFj
a190KSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7DQorICAgICAgIGlmIChjdXJy
ZW50LT5zYXNfc3Nfc3AgPT0gKHVuc2lnbmVkIGxvbmcpIG5ldy5zc19zcCAmJg0KKyAgICAgICAg
ICAgY3VycmVudC0+c2FzX3NzX3NpemUgPT0gbmV3LnNzX3NpemUgJiYNCisgICAgICAgICAgIGN1
cnJlbnQtPnNhc19zc19mbGFncyA9PSBuZXcuc3NfZmxhZ3MpDQorICAgICAgICAgICAgICAgcmV0
dXJuIDA7DQorDQogICAgICAgICh2b2lkKWRvX3NpZ2FsdHN0YWNrKCZuZXcsIE5VTEwsIGN1cnJl
bnRfdXNlcl9zdGFja19wb2ludGVyKCksDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1J
TlNJR1NUS1NaKTsNCiAgICAgICAgLyogc3F1YXNoIGFsbCBidXQgRUZBVUxUIGZvciBub3cgKi8N
Cg0K
