Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0AC47A357
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhLTBqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:46:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:41294 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhLTBqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639964763; x=1671500763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wH6T5akZvb5ODPZY6ZJBKViK3dOfYlXRRkCjBUMidaQ=;
  b=DYLwVyghCBe4uSH+mz0qMgEYHzG8CvKuJXdGlMqMPxE4S/t9eWrOnQG4
   NI/petN+1hWsyHhFrZuOlnXwSo7gwgT3qltMW7BFErbW3jLnfdMSxZORQ
   5+uDBF3UgqFkRbK9fz5hRwJoE3KP2hxE89qpJZkSwxBSrd5Zx7J9INnjd
   ye5OZZ9ibclj3AQTA0ej3jqfZlXfwm1I3BD3UwbKqijZRh/HDKzvppt/U
   1xJH7mkE6Z2OAkqXK/2xBbBlQxAgHclfZ92rBewvNtPSb8pAlZx7ztyfp
   sQ0M7ENSWTTkuFe81Lt22btUo788dEEqE/2YClZX1Su5hrh3sYsecc62r
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240301027"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="240301027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 17:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="520601147"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2021 17:46:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 17:46:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 19 Dec 2021 17:46:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 19 Dec 2021 17:46:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 19 Dec 2021 17:46:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIteScKc4UC1PR38ZrxOctUgNf60p+X9ebrdLpEcxe8qr7bHBZQIgMwrBi3pjnfxfQQyFR2UT9IQzIg2uZ6s0mtEuJvxMoPB1y8m4ehDzQG22PmJjb+MuwqecjF87q/G86buCz3Lu6wk28sJ6wDqdrXWkiqdIqMxr0dPAFFjgfQsEsJEXRJfsqHYfxssYvxvkJ2PAYR3xWsjFy3PX52kuJwjBkVfzZCwPf2olj2bd1fKeCgCpDexpiPKPdQg7bKv0kXEli76c+FIT0HHAH7tsQY6G2FYbfncSDx3WAuEqpdJpEP3cW54pJ6SyhhBD+8mgzer30a7M5gaKYc5AMUVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH6T5akZvb5ODPZY6ZJBKViK3dOfYlXRRkCjBUMidaQ=;
 b=a1gRujBEXCy717RzoBjtzPYE680FgNJa6rWOSHKFa4SF5XdbRV9oQ9gR+ByaMB8woPO9JkB/DRC6fjz0FEu3YV34W8e/LK6cma3Zq61bx5le7a0IGeXJRoPBUKB+gpCnj2yWnJQgzz3tB8fR+dOWJH5bJb/jGP3Ew8O2pivPRzNv40OY+5VzTrOyZD/3SbUgugXtLbaM5NdtX2+b4Iujp/JSj5mNdMfSWisDpAh7JMNi1bWY3QV34eCSvhMGnNsUh1GNTRDYbCKAeCZaBR1f9nJLzhfMJpsmbibRUtzy8Mb5iCqFx3ZSLKeNElG5COsEMvoM1nu59oVCKI4udisbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 01:45:59 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f%3]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 01:45:59 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: RE: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Thread-Topic: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
Thread-Index: AQHX8xmfto9cD4Z770uMSCbPYAz7oKw3KfgAgACwDaCAACTQAIACoCTA
Date:   Mon, 20 Dec 2021 01:45:59 +0000
Message-ID: <PH0PR11MB5880B86D250D7D92C1E8DD92DA7B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
 <87k0g3ar7z.ffs@tglx>
 <PH0PR11MB5880A552E7A3856D8F9165FBDA799@PH0PR11MB5880.namprd11.prod.outlook.com>
 <87zgoy9ry7.ffs@tglx>
In-Reply-To: <87zgoy9ry7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6fb1f0a-2a1d-4d6c-838d-08d9c35a793c
x-ms-traffictypediagnostic: PH0PR11MB5927:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5927D27F6F1E77F7573BD927DA7B9@PH0PR11MB5927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbXCGD0iUrh514YkcRfqGin+lOGlHP7NswezML1DmAa7iAcXO7U1ule7l02gsiqZC9txYUkmAHwEe0sFs+s8hf8WvVtoR+Ri2xaIiBfUpmSPAfGp86t2/W4uzQwME5jrSUHiRQVedhFqHQhd+/o8EHCDLjLhiyoiR0O9imAM/kABovyg6WmHwWLuPs9H6pe2sQYnO3Zx13yv4qXr0QgW8izTLwZX+h3hFVGTxh+cOxfkXkZmau9GWWtI+DCtWXdYecUtb3V5Y8BK3rOGPyyTpe9fohtuQL2apbtOsUQsAOHORkuZhipu99fOuz4XCQA+cdn811blU9+LS4YVUmi0M8t6inF9yg8H013EGAKiZu615SlgYrq8qaiPhx/xc88JcGqcpAGAjXzdw6buqE8lqidX4++/I+0+Rd6iWgygRwqr0BhdBiB00ZX+o5LSAF+eDHsHPdon2SEmX0vWNK26atJ0BVlf2n8KPVmqZPB7YpZzJV4JGEf094I10vy2IludeTZcvZJg2jrnxTRrvfx4vjnnbhhFFWwuBiqn0KlAQV6j+DZoFubAQUvo286HrNp4yRahSCDKn20tr8GrHaMbNT0/CnAnDoePfYafrLlmxwrbqaSaNlde7eL2hl0v6QiqiVQL234RjVKEiEpSqwj4Qwv3dDEeOXY3eh68jFx8Zkc+CA2Wlkk8XU1W+4p3agcXtsIWngYLdToHQuE6d6eM9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(5660300002)(83380400001)(82960400001)(186003)(33656002)(7696005)(54906003)(110136005)(4744005)(2906002)(316002)(26005)(4326008)(6506007)(8936002)(66476007)(66946007)(8676002)(66556008)(66446008)(64756008)(107886003)(55016003)(76116006)(71200400001)(38100700002)(52536014)(86362001)(122000001)(38070700005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTdUbzZ3cEs1QnpLbG94SHJOTjNUYWNyRUh2WXlaRUVzVXFrR0ZjME4vWmln?=
 =?utf-8?B?MkU3Zjc1NGloL0U4UEJBdndsTS9yU3g0WmVaRTFCeXZ1ZlpuTjR3N3U2M2NT?=
 =?utf-8?B?TnRieDhZeit6Qk1lWW1icUlZNWU3dHVqK2UwZlRiODMveFBjS1kzMFY2YklE?=
 =?utf-8?B?UzVrYjlqbWtQaWV6VFZXQTRmMnJrb2draEVNY0VVV3NOV1kvZ21DeSt3Tk1P?=
 =?utf-8?B?a3RzYW9EQ0dabG93ZVBJUjExcC9yYkFDOUJ1bk51V2dLdnVaV2hJV1Y3c3ZJ?=
 =?utf-8?B?a2hOd1dGOGVEVGhQRlMvdkJidG96QmJ0RHh5UFhlcEMyK3hSRzB5WGVOQmZR?=
 =?utf-8?B?a3FzNHhaOGZvYkVCQ2l2OEdHcnlBS1hENVY1S3BNQnN0eUg0N21pU2RteUQr?=
 =?utf-8?B?TXUveU81MGlHcjVDV2ZEckhyNXhxbFV5bWtrMVExeWFjamVrbkpTUkxQUGFs?=
 =?utf-8?B?VWc0VDdKNFpXUVVOOG9pcWxTajNXNnNPOFRlM3pUTC9Nc0d6NVcxMFIwejJ2?=
 =?utf-8?B?YzZPSHZNLzhBVGJDRlJNdVdTTDhXVHFiZWtyR3pMbS9LNlVlMWpzbmYwR2Vm?=
 =?utf-8?B?cUc2U203Q1NIcUZ0Q1VhbDBWSkkzN1MxOXIrOE1wZTFkY3lwZWpUdW90d1dm?=
 =?utf-8?B?UklVbTl0MklGcFU2WjdqelE5dDFvNW14WGRkOHZqK0lVWXJjbkdOQnd2cW1q?=
 =?utf-8?B?b2JLcVhDd09GVitnQkFGNGFDNWw0VU5xaVBudEVpdGVpaFEzWHpXOXJQTXhI?=
 =?utf-8?B?NTN0dllObzZRKyt5SGJpYzlpYXFqK0FqZENoUkdTUTFyV0lXdVlObnVUcmNx?=
 =?utf-8?B?RTNyU2tFcEFhZTIvMUl6cGE1dUs2WHFReFJkT00wdlNyWDFZTFMyaWhmNEFr?=
 =?utf-8?B?REJna1J0b1RaTURnNjY4aE50Z1RLYVczS0JsVmRsOG9mZTNvSUREUTBFQmxZ?=
 =?utf-8?B?T3JFMk1HQmtYMlZ1eldoS3lEK0NPeGFEWXdaTjhSeTZkMlQyTnUyanRsSWRN?=
 =?utf-8?B?anhHSkprOWlITG84YndONlJqZTJyVVRIRHVCWDhzUERXT3RiWXRLNlloUWFV?=
 =?utf-8?B?Z3F1ZVp5WEJrRFk5bGNqY1JVaW91cllJWWc5cGE5aGljdXVUb1hjUXE4RjZB?=
 =?utf-8?B?K004M2ZKZlpTWmlyUEE1dWZUTnVSVEUwOU5zdGExVWlrSENNQnpKWFd6T1ZY?=
 =?utf-8?B?MndwWlVEN2ZJNDVnWkU3akhyUGlWNEZleXczcHZZWXZZNFJrQ25lNnFlUWJL?=
 =?utf-8?B?MWRxanMxekJBb3RXNlZDbjZMOENkUTNNc2MvY1Rqay92VHpkbjF1QkNCM0Vw?=
 =?utf-8?B?NjFIZ0dVaVY1QlFDQXhVZHAyd1pnSjFER1pkVlVXaVRzUEdCQ3Y0ZmIvWDlw?=
 =?utf-8?B?NzNDMTVBVWU5SVB5M0NpWkZTWDhEZ3U4cnhuMWVXQVdsNjcxR0l0VTZMbFdi?=
 =?utf-8?B?WnBOVVFWZ0hsNVRFWEFUbkhyZzFLeW5iZjdwaVVWUmVkUFdGdVA3ZGVxSWtB?=
 =?utf-8?B?dHpxc0QzL0RESFZNeHdBZk03TklCemFsbnJ1QVRmekpMa2k1QVBwQzZ3aDdR?=
 =?utf-8?B?cEFJOFVWMDNqRVg1SWhMS2Y2VUJNc25TRkV1aDBYdWhDRnI5VHZ4VS93d3BQ?=
 =?utf-8?B?VEFwRnduc0JFam95THpCTzd5MkQyZXZCWUYxQ0taZGpjOUdkTDhkNnhaZCtk?=
 =?utf-8?B?RStXTmozUnVheTlDbW4vUElVTisvZVVzZW5qNGZBSktZYkx0U3JWb3A3bjM4?=
 =?utf-8?B?QzFDWkQxRWl6MHhMZGQ3NGRXYklFNWNZMnM0ODBMMUhwM3EyejhQVXc0NW5C?=
 =?utf-8?B?bG8yTyt1ejNXSHFwc1NFeGVCejhRbVpTLzIycFZwcWJCeTNBTThySDBta1ZX?=
 =?utf-8?B?ZGxkR1lZeWdOT3FLWitaaTY5UURUaTdXcFArSEZqSDNCOXV1ZDBRMlpVRnhM?=
 =?utf-8?B?QW9veHNaOW8rQnF0Y3JqeW5KZjlYV0lEWk9sK2tjajRXaTlkVkxuNnI2V3Rn?=
 =?utf-8?B?Vi96NzNsanRna0FrYzFhK3ZCMlllY1NKVkJ0YTU3TmVuRFFLNU5GY3RtSjFC?=
 =?utf-8?B?eDhheiszRjhvaXd3T2hUTGdnZldvdmRXMDRES2ZWa0hsRk9hUmcyYTBPUDF0?=
 =?utf-8?B?YW1zbHphc3hKcHhWNnRyY3VvVFRnZEJFU3kzY3pCL0tFSWUrdnhKbTdrV1JP?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fb1f0a-2a1d-4d6c-838d-08d9c35a793c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 01:45:59.7023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLSuvPOYYmM3vT2J1fX7V53BIDg/2vUk6jXG2O8o4TmNr61FobPc6X3S/adwxeiiA66bFKgiCGkTxNTiG3CW3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+Q2FuIHlvdSBwbGVhc2UgZml4IHlvdXIgbWFpbCBjbGllbnQgdG8gZG8gcHJvcGVyIHJlcGxp
ZXMgd2l0aG91dCBjb3B5aW5nIHRoZSBtYWlsIGhlYWRlcnMgaW50byB0aGUgbWVzc2FnZT8NCg0K
SSBoYXZlIGJlZW4gZml4IGl0DQoNCj4+VGhvdWdoIHRoaXMgZG9lcyBub3QgYXBwbHkgYmVjYXVz
ZSB0aGUgY29uZGl0aW9uIGlzIGluY29tcGxldGUuIFlvdSANCj4+c29tZWhvdyBkcm9wcGVkIHRo
aXMgZnJvbSB0aGUgY29uZGl0aW9uOg0KPj4NCj4+ICAgICAgICAgICAgICAgICAgIHZjcHVfaXNf
cHJlZW1wdGVkKHRhc2tfY3B1KG93bmVyKSkpDQo+Pg0KPj5QbGVhc2UgbWFrZSBhbHdheXMgc3Vy
ZSB0aGF0IHlvdXIgcGF0Y2hlcyBhcHBseSBhZ2FpbnN0IExpbnVzIHRyZWUgDQo+PmJlZm9yZSBz
ZW5kaW5nIHRoZW0gb3V0Lg0KPg0KPiBUaGlzIGNvbW1pdCBjMGJlZDY5ZGFmNGIgKCJsb2NraW5n
OiBNYWtlIG93bmVyX29uX2NwdSgpIGludG8gDQo+IDxsaW51eC9zY2hlZC5oPiIpIG1ha2UgdGhl
IGZvbGxvd2luZyBtb2RpZmljYXRpb25zIGluIGxhdGVzdCBsaW51eC1uZXh0Lg0KPg0KPiArc3Rh
dGljIGlubGluZSBib29sIG93bmVyX29uX2NwdShzdHJ1Y3QgdGFza19zdHJ1Y3QgKm93bmVyKSB7
DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBBcyBsb2NrIGhvbGRlciBwcmVlbXB0aW9uIGlz
c3VlLCB3ZSBib3RoIHNraXAgc3Bpbm5pbmcgaWYNCj4gKyAgICAgICAgKiB0YXNrIGlzIG5vdCBv
biBjcHUgb3IgaXRzIGNwdSBpcyBwcmVlbXB0ZWQNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBy
ZXR1cm4gb3duZXItPm9uX2NwdSAmJiAhdmNwdV9pc19wcmVlbXB0ZWQodGFza19jcHUob3duZXIp
KTsNCj4gK30NCj4gKw0KPg0KPkZpbmUsIGJ1dCB0aGVuIHBsZWFzZSB0ZWxsIGFnYWluc3Qgd2hp
Y2ggdHJlZS9icmFuY2ggdGhlIHBhdGNoIGlzLg0KDQpsaW51eC1uZXh0L21hc3RlciwgbGludXgt
bmV4dC9ha3BtLCBsaW51eC1uZXh0L2FrcG0tYmFzZS4NCg0KVGhhbmtzLA0KDQpacWlhbmcNCg0K
Pg0KPlRoYW5rcywNCj4NCj4gICAgICAgIHRnbHgNCg==
