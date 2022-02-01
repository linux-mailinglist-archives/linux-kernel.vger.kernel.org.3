Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BD4A5BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiBAMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:35 -0500
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:55833 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237704AbiBAMEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1643717062; x=1675253062;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=WKNnpwLNu9HU1KKpLrYqwUOfOGp0tY0ctHCO+NOm358=;
  b=sXDjsbzjg0V4o+D0ykLDJVoOlfViAgAfKfOy8zVrLYL7rNv4z2pPknEN
   oJN7YvtTfegwBdh1saqX5HNo2VzehWkrcIF+RA2gdApGIg94P5uQlrTn0
   koxoRcjSn8sMXINigmWCot74Bxou6A2sZX7yE3qcYALK3rpTrl0quqEZN
   BVTfLy0iru7dVRgLdy+T1CQBpYTWYg4yXn8+U3tD/zfB7uV2WqKPmHCGM
   l2aJdHsNn6QzXDx10h/okTCWYGbrlGC9M2exHb0eH98MBdONJMzIR8QkH
   ZvCIzCErp9kBpQEcVPdvQSg8hQJZ6UAFCy1zHnWut9KzkjmGa3K6fYJbd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="48626574"
X-IronPort-AV: E=Sophos;i="5.88,333,1635174000"; 
   d="scan'208";a="48626574"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 21:04:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvS0qDazAlBYE1UihgyEJP8aDidwh7Ks+Z66MQAqaHNNJDd+RH6GUitBnU48tQ+SkQzW6as12uKiT+FMnBi13psMx04UlYnUdSKZTASS4tGGRTQDHhpRtarhawbd4G6lr8GUIEjpi4SKyHWRYCjzfrZRn7pLlyyVIGUFN63gn0Wg57NDGKUMq2KUc4iFpO5RVomsHzsqH0HaOUENDAofAMDjVZzUO7FO/P/UKV3H5cio1TW3qJo27KoHIV+lee4GpZGzHBg08luYys45aoMnxxE2Y1Cd7jNHzQfs6LwF4Gq84pg7i14BEA0cPYpjJFw/Z7CeyYCEEhZ1rMKpNghRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKNnpwLNu9HU1KKpLrYqwUOfOGp0tY0ctHCO+NOm358=;
 b=Uey8bjYO6Q/sZ740IFkUNEPV5svdiPZnHMliE+kq44cosVmO/Nx26a8QrLtnChi7Z0M1SbEUDaYFlXqY2fe5TJInXi7Axba2fNJMwNRIg/NWtBwltwew7PzQX4FMGElhgQjKJ1S/J2V2DUN3B45Nx92jchje4GW+4PKbUTyTF0WqSLrN8gU3CGCHKaO4qsmvuSxOyS509Geh8sHAr0lIVe+uQDzAe0JANjH8ckArm447sr+dmybyFr2h5/qMk8SNCgRVwRth8PZJBPpI/zIylZYSsXtEcwC/L8BpLD9t1QAtMdK/3LUztuFGMzn1nN883ngpYNh3VFxi5eiobMH0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKNnpwLNu9HU1KKpLrYqwUOfOGp0tY0ctHCO+NOm358=;
 b=EgZt3ebj/GrAKGcx8o9Ng43pKvVAcaqEf3M8izmtetuKuztcbmNoMw8GGXfR5vW1kxmi7Zp5ZR/ChQRFRFxLvZpQHk1JOllJ9r2gnaj6XC3Xr9wbnOvFRRnwLjzxgB0AsX7UUtRnr1lbZHJ8E0nwa5jwNIUtv6pwlpZbZuYqLr8=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by TYYPR01MB7855.jpnprd01.prod.outlook.com (2603:1096:400:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 12:04:13 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::b596:877c:caf1:e443%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 12:04:13 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Randy Dunlap' <rdunlap@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] arm64: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Topic: [PATCH 4/8] arm64: Add Kconfig/Makefile to build hardware
 prefetch control driver
Thread-Index: AQHYEbs083TZT8bOcUCd6Z/j5n6rrax6QMiAgARhhcA=
Date:   Tue, 1 Feb 2022 12:04:13 +0000
Message-ID: <OSBPR01MB2037EF5184AC7697A98EA15F80269@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
 <20220125071414.811344-5-tarumizu.kohei@fujitsu.com>
 <964539a8-334d-37d4-99e7-d2dd76887fa1@infradead.org>
In-Reply-To: <964539a8-334d-37d4-99e7-d2dd76887fa1@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a01639bf-38f3-47e9-e381-08d9e57af68a
x-ms-traffictypediagnostic: TYYPR01MB7855:EE_
x-microsoft-antispam-prvs: <TYYPR01MB7855BF0F3CB63B6BA552288F80269@TYYPR01MB7855.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1FDpSOBbVCPtnxjDKvLV8HRFtC68xNFs5heAn3RBYGSImVGBu71VTDN4+Oy/Ept8EwzJiMtLYgYpq0RpkCta2j/ghyJb0H567EPKktRuyosLtUX6lud2IF3FseOS8Ek7KfRrhtv79C2FDDUZ1zaWug67uRerCM1x0J4/jLUe6XvzhnkOSv8UKPRzDvHJNNArBhrDRodkmU8qGNDRMr+KeAGSRPaVVffokN+Irf1PUpXd+uH+Qw4oMpQfEfzi+4J0hVOZXCk+65EMV3NxtRXUCTB0aDY+5QnIDcln0qYVvwESChvHPKdwW9U3rP34PCYjB6wjoJgmxk8HS+wIeqM3bBw88ooJIqYm4ixraOGHVWIzh9h7xHR69T3XTvwN2YtWbi2nzejvmVB/EJDe+BsTLVPMCO8dnXvVhrshPoFj2w5Gs8wblZqYKlHQQbKQxv5MdNLrtvvlsTk0JRBV7lGvkFCo3wgmlz0SZUkIhFAMtLdB4lfcXkZcBJuTK7Vs2YRiezhJoN1n4x+9RQoE/q/Zdyb6xQHMZj5iF1ZnGKSO2JX2Q4OHCIPPeqbo3Uh6p9c+D/atrNWt+tku5J7uq8+ncd4MSOtnj/5eC1aen9tDwkJeEbBF8BYGsNyQ240sCqhuPXHZFiGPP2b2LxiVvh1clxdXzoMpZED/2zdc7oGpaARJaH4LFPYCNXr+fefDqmAhcdLMwbbQCgL8ekj3uZ+A2RvyGQrtlvBlyf3LDAcFzs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38100700002)(86362001)(33656002)(558084003)(38070700005)(921005)(122000001)(82960400001)(66946007)(66556008)(64756008)(66476007)(66446008)(8936002)(8676002)(76116006)(71200400001)(9686003)(5660300002)(52536014)(7696005)(6506007)(508600001)(316002)(85182001)(7416002)(2906002)(186003)(26005)(110136005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFoyZHhVQmpSR2FsUUJFRWZwMk9IWWdWYWFtZ2ZQWW1QR3U0SDQ4UVpxcU9t?=
 =?utf-8?B?WHFuWFhTek83enVva1NhLzhEYmp4SmZzR1NQQWk0dWN3dlR0czk2eXF5Y0lJ?=
 =?utf-8?B?WlZHZ0VtdThkN2NzOTl1U1IzNHIraUp1aHZPSURtdlVDQ3B0T1JSR21RcVRM?=
 =?utf-8?B?WTNuakRubkVFdEFiaStRTHkycTZsVGVtM2RuZTg1RCtFM3JkRHJ1M3c0VERn?=
 =?utf-8?B?anNuR0NTZmpoTHRZOHowaitvQndaZ2VtU003UllYYzZaVXk1Yit6OGg1d3ZZ?=
 =?utf-8?B?UzFvczRQNEpTZmpnSWhhQ0FuTGVnb2QxbHpYM1VqQS9kVXM4T2I5MnBMOTgr?=
 =?utf-8?B?NHNHOXdvcVJzMm5tSXc5cVU4eXRmY3lzYlFIdmtKdER2c3Z1TzJ1RVl4dklG?=
 =?utf-8?B?Mi8xU0ljQjhpODlyK1ZsdHNuNmQwY1VzT01VbXY5djZ5a2lGNW1nQ3pZeHV3?=
 =?utf-8?B?dmVITTV3dWpQWUljR3I3ZklBWnFNME4zOEErN0FmU2wvQnlqcXdOYktSSGda?=
 =?utf-8?B?Uk5JZy9CdGlHcXFmMEM1cnRGekV6cjRkRTgzd2U5TmFpakFrdlQ3QlFIUllK?=
 =?utf-8?B?bzdjSit5N0V4TGRyakNMN1FNWEZCWmNyZDBGakt0TEl0cytCU1ExRkt3R3du?=
 =?utf-8?B?SUp4TzJJUXl2S1dkMkE0Y1ZtMXRSaC9EOHFER01ja0JnZkdPNFlaZFBoM1F3?=
 =?utf-8?B?UnNwc1RvOStENHl2SHlqR3lMN0g2RGdyV0Y4WmNjR3l0VXNqTEIzQlRRQXc3?=
 =?utf-8?B?d1p2K0JxQzd1TUtIaUN4K2NMOE1ETlE1TjIxK2srRjZ0S0hLU2pORHVTOWVn?=
 =?utf-8?B?WGNucFNBWlpqdzFpQ1lubzRIMi9iVkNvdFR4cEs4TUw3ZHJQanlFaVJCSHpN?=
 =?utf-8?B?ME00R3pGeCtXSDVBYTd3SmMyVW9oKzJZUjJBS3h4K0NDaU5iNHlIMWFDVXFo?=
 =?utf-8?B?Rm5pMzM2cGhFMDM1MzJVbml0REtsTWdWUWgvako3UVlFS2xhR25jUmdyaHlZ?=
 =?utf-8?B?R3UrY2xBd252SWdsVDhXa3lzYnljejRPeTREVVRmZW45N3JTUEJPcVZSQUxk?=
 =?utf-8?B?MzVuajhvZ0IzcWRDbFhtYzVtQ0JhVm16cHNIMHZwTHpLakRGd3AvUElJalBE?=
 =?utf-8?B?eGhVNnRhZUVkc0FLWkJPTjJucFlBczRwVVM5bWtVNnEvQ2U0ZVJzOFNrU09w?=
 =?utf-8?B?b0tpRG5qSE91Nk52SEN4QlhmU1hxSU8yQzZIZVFwUzl6NWZnMTA5K0NMUWRx?=
 =?utf-8?B?dmtQckJNQVZjdUhKem9HRmtReVRKbTFTNTZxeFp6NU1rSE12SDBVR3I4a29K?=
 =?utf-8?B?RTRoSkN6Sm5seVpxRkc5K05Vdnk0a2ZSZXJ5aTFhaDZiUFY4RTNxbXNlSDJY?=
 =?utf-8?B?dkxIam9ObTIzeWV2MnptYWtJcXF1ZkVRT2s0Qk1RZFR5OXd5YTdUaVBwMU4y?=
 =?utf-8?B?UHkwa0RrandpN2hDNXBwVUFIeld6NkRvMERZRjREbnF3b0o1WkxJaU1tV0xz?=
 =?utf-8?B?dE9jaWFwRS9ScDc1V0R4MXB5Mjd2MkdHNHptR0ltNVBGY01sRk9TbTBtZ1U0?=
 =?utf-8?B?Qlg1M01vOThJcUFOREgwc2ppekpPRVM5L2lEOE5HSEFVaEk4ZnBTQWV6NHpM?=
 =?utf-8?B?c3U5d1JXSXZsWXZvOUJ4bTF4ekc3c1NFdmc3YmpoMVZIK291bFE4K3RZYy9l?=
 =?utf-8?B?Wk9YZklNZEozU0lhbFcza0xOVlh0UEJFZGtQTG5TemdkeWNRbmlHOFN6M1dY?=
 =?utf-8?B?d2lPSkJrMHUxMmIwZW41M2R2NUw3RjYrR0lmTTJxa3p3WnVTcVdxVno0Y3E2?=
 =?utf-8?B?V1hkV0szWVU3bkxSNEw1cEs1bVJ3bGl5YU5NN1JHbjd4MTdLdE5ydlRaZ3Fi?=
 =?utf-8?B?ZXZjNkh1d0E1dksrbzhSbkpKUHJld2NxWGpkUHJKa2lTNVZ0cWFBQS9Pdkwz?=
 =?utf-8?B?N2orKzdhSVYrUjNLNFBTVUcxWW4wWkVoQXNtQU91Vmg2TEo2M3RhMFphMlYx?=
 =?utf-8?B?bTUyeU5tMmRvYXdjUjFEM1IxS1oxUnlFcEpoV09aMVNpT2M0YU1IcWloa0Fk?=
 =?utf-8?B?YlVvMUhqSC9TcXpVTnNZTFBvejAra2dXaEdUYVlvcCtIQ3k5WmdnOXdXZFVT?=
 =?utf-8?B?Zzd2MTZuYmR4N1hPaDREbFRYdlFGTWN5RUpmUWMrUU5NQk1ScFVHRStpYW5I?=
 =?utf-8?B?YXBnckNrM3V3YlpZd3ZJYlZTQTgyTytXN2RpbENoSll3bHl4Zk9OMTVLRnBa?=
 =?utf-8?B?bDl4b1JlMTJldWRGbjk1ZWFoRUxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01639bf-38f3-47e9-e381-08d9e57af68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 12:04:13.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGIqkwAbsgjTheuRA+zZriXkTuEtTLZLs8D157fBbTa60gS+wAEl6kPtPsNsrT+tzDklWRgF3O8wQBbMPy4luUp57YXNcURZEIA7783MtgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7855
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBEb24ndCBlbmFibGUgcmFuZG9tIGRyaXZlcnMgdW5sZXNzIHRoZXkgYXJlIHJlcXVpcmVkIGZv
ciBib290aW5nIGV0Yy4NCj4gU28gY2FuIHlvdSBqdXN0aWZ5IGhhdmluZyB0aGlzIGRyaXZlciBl
bmFibGVkIGJ5IGRlZmF1bHQ/DQo+IA0KPiBJIHNlZSB0aGF0IHRoZSBYODYgZHJpdmVyIGlzIG5v
dCBlbmFibGVkIGJ5IGRlZmF1bHQuDQoNCkluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNo
LCBJIHJlbW92ZSB0aGUgZGVzY3JpcHRpb24gb2YNCiJkZWZhdWx0IG0iIGFzIGluIHg4NiBkcml2
ZXIuDQo=
