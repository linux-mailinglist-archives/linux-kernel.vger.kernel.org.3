Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6A47F304
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhLYKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:48:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:17992 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231440AbhLYKsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640429286; x=1671965286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWeggOznIiJvHsi97p/SRpp1ycPOYWrMZSkmx72uti8=;
  b=L+JhkY3iZefQmobqwLNJ7JX4pm3J/HdFQRLLU/DIpGMZRkxPxyKVzQTm
   mYzqkFyZeweVbsodMNwGLhdJach8lNe3A7nzFEEfz7nX0igoONzN+rLGF
   dQBHm/SACz1sUEZhxm4oigg/ZSB1APazCpyCe7CVB5+wPxNwtITshqtpw
   K1R4MOfcUEY1zib8oflDLy7brhDbB0VsNNmQ/Q6xZVHv9oXAErOqd7I2j
   9dDNkrSaaofc1mqHftI54HaErrMg3M5b5dnhUftw6jXPXwvOSz/wQYzN7
   88L7ip0NIUJx9MQEfW1eoIN8Xi2UCfy5LWI9A2HDFbkHtCpJoYkEQYaVQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="227881207"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="227881207"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 02:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="759927917"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 25 Dec 2021 02:48:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 02:48:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 02:48:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 25 Dec 2021 02:48:04 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 25 Dec 2021 02:48:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYAkZVSZSyiRStVZq7rF9C2Dm1Ucz91polXl1m0Ct2hCO0MWh3Kujmhm9ArNuv234tGQfqRlQYNhtx+709uP95ymRVblITLWkVP/fMpzR8EfH+W16avoyF/QmUAzjJj6U6sW0eg1YuvaOBx9FJ+LaY8iAAb5rAJG8vU2zKF+zOhHh9BJJCOMxm3NTGAETEu5MquihIjpWsYdDQWrsiHVLfx3oa+VvL7Y8mN7Tp8qZpL9hLFEfw30Cm7D1okNQ2GbJA6grQpiqxtC1m1eVbbAKtXmlkq3hiUn8c5RGk5PSFtPbtJutxvRtihQCQ2sRAZNaUXoIdhLn17F4fbKStG5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWeggOznIiJvHsi97p/SRpp1ycPOYWrMZSkmx72uti8=;
 b=bLQgXtSpdqfxyViWADZMxoYPNEnucz59xbHLZyHRjVuCOBl38PT6WzIKADMzOVJDBFaKeySsZ674uqHwJDbR8SbqsnuQI6LWrBCu6AMvJZaCgvVan4qYpRG0+XbHXA+hC807VeETgYN/xihVc56eF7wGZTnDTalsixWUQtwENgi+i1Y9U9ell1KNM0HyLX7C+tby5g3DgzIh5pUENgl0lxvqEnykKqHfBq1feqHthleCt9CuPVu7ZgcTDzx3tTGyYHw/TZdNbSFuW+dsCCRffl5dX8GF/MqF7psDxRAOs52ni5f0N5bOQbTAphk2yV1LIJruKEanpPk3OF/L7EeqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Sat, 25 Dec
 2021 10:48:02 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f%3]) with mapi id 15.20.4823.022; Sat, 25 Dec 2021
 10:48:02 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Marco Elver <elver@google.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "Miao, Jun" <jun.miao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: record kasan stack before enter
 local_irq_save()/restore() critical area
Thread-Topic: [PATCH] rcu: record kasan stack before enter
 local_irq_save()/restore() critical area
Thread-Index: AQHX9wklU1gLrruOXkWZebdL9hbjzaxAL9KAgADIffCAAIURgIABV2sAgAAizYCAABI5IA==
Date:   Sat, 25 Dec 2021 10:48:02 +0000
Message-ID: <PH0PR11MB5880465752E5D5F37C4FF1D0DA409@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
 <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
 <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CANpmjNPU9Yw3RtsSrn0ZfdKQ7XUEp-Ecu9Wcx4HGhH3D+6-CrQ@mail.gmail.com>
 <PH0PR11MB5880B73436ADB3B8216C045DDA409@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CANpmjNP2kz9eYY2V_A82fqWbvJuVt045e2Ni9NFrmuO-uAvGeg@mail.gmail.com>
In-Reply-To: <CANpmjNP2kz9eYY2V_A82fqWbvJuVt045e2Ni9NFrmuO-uAvGeg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 7ac76952-b54a-4979-f55d-08d9c794067c
x-ms-traffictypediagnostic: PH0PR11MB5078:EE_
x-microsoft-antispam-prvs: <PH0PR11MB507802739982B7501B3AE53FDA409@PH0PR11MB5078.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YEgZxJ5UkoecBe6xuGFOV2mYyQ5Og/HAPXBp8EOtehNWMJedRcpBEKzNyYc2ytcx9G6MZV+M1ZQglvNYFIMuhQumhkmK12QfOHIQd682SPjvyCVXvv7dadqHmGzyAd/48pJD/rAM898ParRqNlx105rfpeaJhnXs3++UnMgccPsz/YoCpjfdol6ObyrJUnKzSBgxEcZAbCzZ0Ken+j658EDbQwDzaN1kD1WejMk6CmRr1sBJnyDkiomOjuga5+GSXcvyTvF8sRXolkws/kcUcUtCargNsgPN5g2OpzA2nYMXOVWStVOu0ysyREulaH8Ny6JtKxYI5zykpk5CeZrOH+xkE5cfENzufO4YCUvbCVq5Ar5YjUhja/A/Cuoa4y8JYUzaDkiFyX3f5TCyfPr2djGCz4NmJImTkNMvEZgCjsdHHwc6P9vtJPm8mwivW5SwyWsq5QRUB35FFSvnVz57slGmldAouh5PJaSCmAAUETNLvhiZJZd2JhKc/AmpgUIKYF+8rPTQomhpy4qNo8fEKSmrxuSygSXprSPU0SL11y0lQxcoyAI+CUoGe3HcgYBC3CSxuF4POj/N/y6eoeTVBUX/C6PGLxZQjqLfsBFdvmhC/y6y6f+9md+29ryuhpkDBwDrvIOFzc2TjbMXam8Xh4dFMsoXtxpGaGLHkGM80ZE91GjHsio7ZdzrGRmJCXf0ZXygRtMldwF9bNedVof+QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(66946007)(66446008)(4326008)(64756008)(76116006)(2906002)(122000001)(66476007)(66556008)(186003)(52536014)(38100700002)(38070700005)(55016003)(9686003)(5660300002)(316002)(508600001)(6506007)(83380400001)(7696005)(86362001)(6916009)(66574015)(71200400001)(82960400001)(8676002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmM3a3pjcXpWZGxZNmRkRlpmZktYTGlFUmxIYlBQNDBxOC9LSnpPRk50U2xq?=
 =?utf-8?B?Ym1NZFg3OFUrVkpuZTdMdlVnVUFsN1hnalUzUzR2MFVHbGI0SjVGeGpyWWxt?=
 =?utf-8?B?T3hFeStHY0RVN1pYQ0VjL3JrZVNIMWZ1MjR2WW13QXdoNW1YOU5UUEQzZitF?=
 =?utf-8?B?OWFUMVVsZUNrczFrVGE1WUdGMUNYWWNqVzRiTEs5MWFOVnBmeE5VM1Z0NUtQ?=
 =?utf-8?B?b2Q2VTVRVXlDUEVWc1hBR3p6TVFuT3kzVHhEM0lEcFRuK1hla3JlOEthb1Qx?=
 =?utf-8?B?K0hpVXcxcU5GRnAyKzRWbFhOSXZ1Q1NwcHVWTkc0ODhyemNKaCtJajMzS0ZR?=
 =?utf-8?B?dDdDMWw0MGFhZjBSM2RyN2VxV0E2VEZJZ0tnc3A4VkZDMU9QMnhTMlhMUHFt?=
 =?utf-8?B?dnkrcHBvZU91WTg2QXh4N1h3NUJ6QzhEbjYrMVdZY0s5OE15MmVqSmpVRmtU?=
 =?utf-8?B?VFlLMnJRVytaemUzbnJqdGlRZ0UwVzhlcHNSaWxodDJTUnE2cG5XOU4zMXVY?=
 =?utf-8?B?TzhWQUNGMUo0d2wxc1ZVeG9rcW5WUkthVXpNVHJsaTlIanF3bUc5d1EyVVVU?=
 =?utf-8?B?Z0RqTnl2UkRXQmtkaVAwckxjNk1QQnpXT3ZKdDFvNUg2bllHQ2FTWDRlbVJ3?=
 =?utf-8?B?NXJYUW9WUHZYeGJsTzMrRDY3NkZqemQvQVU3MkFucEwydmdxNWU1M01qU01a?=
 =?utf-8?B?ZERjQjFva2NoNkN1MDd2d2JnY000V3BBWVBrVUFJOUg5di9iWnFPSEdCYmhy?=
 =?utf-8?B?aFNZU0ZuWk9wSE9rQ1REckpWamRlSUhFVUF5YVNNL2RoQ1RkNTVDTWllVlRX?=
 =?utf-8?B?YlFkY3NpN3N6UVZ5ZDl5MVV6VjRJTHVId3FnQjRXbm5vcks3ckozUFdwNm92?=
 =?utf-8?B?TTZHNHlEQWdyc1FpL0NnOURqckVvOUUzR0VVbXhuQmQ2cmMvcFNYOVBFbVlp?=
 =?utf-8?B?WERsOWV0cWN0SDM5NEpOclU2ZEh5b3pmVUFGU1dUMm84L1Q1eG90TjRzZitL?=
 =?utf-8?B?d0djYmNXYjZZcEZZeXZxT3JSWC9RSHlBL0dFZVg5bU9FVVBFQ1ZSYUVjMnJu?=
 =?utf-8?B?TENJMUdlaXNwYmhXcnZ5bjY3SnJ1WHFnZldobUlHcTJyWlg1RWg5ZWY0SDZo?=
 =?utf-8?B?VGE5UDdIcnpBRWl3YUZvb3VUOWlld3ZsQVlMZ0hoT1N5YUFENUxUSHJ6Q2Vl?=
 =?utf-8?B?ZENmemJzaU5VblJCZlF6b1hmdWRKUVpMczBFR1llVy9IZnZYSlBIZGhVd2xn?=
 =?utf-8?B?Q3dFMytabmhaUGJXY1I3Snd5dXdsNHdHd1pLZlRnNVRVTFlVK1RDNlhCTmxs?=
 =?utf-8?B?eUQyOWxUb2VSUmc3Wmw4UmZaQWNQa1BiUm5vWHhkN3pZZ0dJR1kwSjdQMWZj?=
 =?utf-8?B?MERLRTlJWFlWOUVjV1VmMm1TMUxPcVNYSnFoaXJwcG1qNnVHMDF0WHpxYXZE?=
 =?utf-8?B?eXhvRnUvQVpkcFdXUkJ1NVc5K3J6WVJTa2F5SjRyclh4eHJmTm5KMWh3cDZW?=
 =?utf-8?B?bnZ4bHhUd3JTRHhrOGlIczlHdDBCc0RqaG5EMi9MT2lmR1JkeUJjTzBMTmxK?=
 =?utf-8?B?YjhYRnJ4T2dkUzlXYW1RTHBUS29GOEp2NS9BNmg5MEdrV1Y3Qnduc2VRQ2hF?=
 =?utf-8?B?S0I1YWVKVUFoK1lQamZFdkhJT3lWdzBoVlpJOFEvbUFObnZUcGFOV2JWSXZC?=
 =?utf-8?B?UDkydm12SUNEWHduT25vb3RoOE9Ga2lkK05Remh0K0ZaOUxxQlgxM3Q3R0JM?=
 =?utf-8?B?WnFXeUdKRi9HR0dEWFVYTTQwaHp3NkI1aFBydjlBTXJDV0dZUEVxZDkxUVYw?=
 =?utf-8?B?aHRFajVmNGdCRko0OVBNS0UydmhTTW1rekZPMWNZVEJ6cFBqeWhUaHdtaGtG?=
 =?utf-8?B?dW9reDFIOVcrNFRRenlvNm5LV2ZlbjJTL0tuUGs2TWlseXhnOWtTbXpMV0Mv?=
 =?utf-8?B?U0t3OVlIU3VZQVpDYlBxdjdFN09YUWplNnpFcExDQWJPV0xqWnRPY2RaSkIy?=
 =?utf-8?B?bjJDK09wRUNLR1BjdjludVl5d0l2OEZYNjB5bVRDWmtWSGpKZnBMbE8vbE5F?=
 =?utf-8?B?Z3FjK3ZCb080TEZJQVZsRXpqd2NTTFBGaG9VbDdFeEdpTG5JWWRZaURJSUVo?=
 =?utf-8?B?QXRtWnNvRW44SW04cWVSVHJDTmwzcXlMVTI2dHZIQWZQWW5EclZpdjNmMnpa?=
 =?utf-8?B?MnFiUC94ekNjUFZ2M2tqbVNrc3dNTDZWZCtackhvNnR0cmQzN3g0MUxJNnRj?=
 =?utf-8?Q?mp8UWenuY8t9WgDHYjvaCYnNvVTOWm+c/diXg1dYQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac76952-b54a-4979-f55d-08d9c794067c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2021 10:48:02.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 478xRp8+OByPRe8sYaiguTb+L+DP3T54kivogpg/9nSgB78T9NWwuH7FkB3KrcAsgz5bXouB3Gy07vgBi0Wz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBIaSBNYXJjbywgQXJlIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9ucyBjbGVhciB0byB5
b3U/DQoNCj4+SSB1bmRlcnN0b29kIG5vdyB0aGF0IHRoZSBjb250ZW50aW9uIHlvdSdyZSB0YWxr
aW5nIGFib3V0IGlzIGZyb20gZGVwb3RfbG9jaywgd2hpY2ggd2Fzbid0IGNsZWFyIGJlZm9yZSAo
SSB0aG91Z2h0IHlvdSA/aW50ZW5kZWQgdG8gcmVkdWNlIGNvbnRlbnRpb24gYnkgc2hvcnRlbmlu
ZyBzb21lIG90aGVyIGNyaXRpY2FsIHNlY3Rpb24pLg0KDQpTb3JyeSwgSSBkaWRuJ3QgZXhwbGFp
biBjbGVhcmx5IGJlZm9yZS4NCg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHJjdTogUmVkdWNlIHRoZSBj
b25zdW1wdGlvbiB0aW1lIG9mDQo+ICBsb2NhbF9pcnFfc2F2ZSgpL3Jlc3RvcmUoKSBjcml0aWNh
bCBhcmVhDQoNCj4+U3ViamVjdDogcmN1LCBrYXNhbjogUmVjb3JkIHdvcmsgY3JlYXRpb24gc3Rh
Y2sgdHJhY2Ugd2l0aCBpbnRlcnJ1cHRzIGVuYWJsZWQNCg0KPiBJbiBub24tcHJvZHVjdGlvbiBL
QVNBTiBrZXJuZWwsIGEgbGFyZ2UgbnVtYmVyIG9mIGNhbGwgc3RhY2tzIGFyZSANCj4gcmVjb3Jk
ZWQsIGl0IHRha2VzIHNvbWUgdGltZSB0byBhY3F1aXJlIHRoZSBnbG9iYWwgDQo+IHNwaW5sb2Nr
KGRlcG90X2xvY2spIGluc2lkZSBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrX25vYWxsb2MoKSwgDQo+
IGluY3JlYXNlZCBpbnRlcnJ1cHRzIGRpc2FibGUgdGltZSwNCj4ga2FzYW5fcmVjb3JkX2F1eF9z
dGFja19ub2FsbG9jKCkgZG9lc24ndCBjYXJlIGlmIGludGVycnVwdHMgYXJlIA0KPiBlbmFibGVk
IG9yIG5vdCB3aGVuIGNhbGxlZCwgc28gbW92ZSBpdCBvdXRzaWRlIHRoZSBjcml0aWNhbCBhcmVh
Lg0KDQo+PkkgdGhpbmsgdGhpcyBtaWdodCBiZSBjbGVhcmVyOg0KDQo+PiJSZWNvcmRpbmcgdGhl
IHdvcmsgY3JlYXRpb24gc3RhY2sgdHJhY2UgZm9yIEtBU0FOIHJlcG9ydHMgaW4NCj4+Y2FsbF9y
Y3UoKSBpcyBleHBlbnNpdmUsIGR1ZSB0byB1bndpbmRpbmcgdGhlIHN0YWNrLCBidXQgYWxzbyBk
dWUgdG8gYWNxdWlyaW5nIGRlcG90X2xvY2sgaW5zaWRlIHN0YWNrZGVwb3QgKHdoaWNoIG1heSBi
ZSBjb250ZW5kZWQpLg0KPj5CZWNhdXNlIGNhbGxpbmcga2FzYW5fcmVjb3JkX2F1eF9zdGFja19u
b2FsbG9jKCkgZG9lcyBub3QgcmVxdWlyZSBpbnRlcnJ1cHRzIHRvIGFscmVhZHkgYmUgZGlzYWJs
ZWQsIHRoaXMgbWF5IHVubmVjZXNzYXJpbHkgZXh0ZW5kIHRoZSB0aW1lIHdpdGggaW50ZXJydXB0
cyBkaXNhYmxlZC4NCj4+DQo+PiwgbW92ZSBjYWxsaW5nIGthc2FuX3JlY29yZF9hdXhfc3RhY2so
KSBiZWZvcmUgdGhlIHNlY3Rpb24gd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkLiINCg0KDQpUaGFu
a3MgTWFyY28sIHlvdXIgZGVzY3JpcHRpb24gaXMgY2xlYXJlciwgSSB3aWxsIHJlc2VuZCBpdC4N
Cg0KDQo+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCg0K
Pj5BY2tlZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQoNCj4gLS0tDQo+ICBr
ZXJuZWwvcmN1L3RyZWUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9r
ZXJuZWwvcmN1L3RyZWUuYyBpbmRleCANCj4gOWI1OGJhZTA1MjdhLi4zNmJkM2Y5ZTU3YjMgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5j
DQo+IEBAIC0zMDY4LDggKzMwNjgsOCBAQCB2b2lkIGNhbGxfcmN1KHN0cnVjdCByY3VfaGVhZCAq
aGVhZCwgcmN1X2NhbGxiYWNrX3QgZnVuYykNCj4gICAgICAgICB9DQo+ICAgICAgICAgaGVhZC0+
ZnVuYyA9IGZ1bmM7DQo+ICAgICAgICAgaGVhZC0+bmV4dCA9IE5VTEw7DQo+IC0gICAgICAgbG9j
YWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiAgICAgICAgIGthc2FuX3JlY29yZF9hdXhfc3RhY2tfbm9h
bGxvYyhoZWFkKTsNCj4gKyAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+ICAgICAgICAg
cmRwID0gdGhpc19jcHVfcHRyKCZyY3VfZGF0YSk7DQo+DQo+IFRoYW5rcywNCj4gWnFpYW5nDQo=
