Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0426947995E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhLRHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:24:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:61111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhLRHYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639812249; x=1671348249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UfRreMzab1925HUFD8Vvc5KKo0Rv09ng1/BnANMlajw=;
  b=RD0JcLkGDXHjk2CyOvf21Q7XOvJ72Z5Fp8BYJ/DrBEo+RXczNF56ajSC
   petx76XtnRaXnDrWQsXKVonoYVtrl1/rVjkMnnOZPApU6v+1PczdOXpq9
   SH+z7M+bzfW7O7BUzWvGp4nKa9Fq36Be5I2GIy4XB9rybFUycv7opPFrM
   7yBR2oxZf/aR/9kMYQYqngejqOf+XDzCAeeqKgCkK1y/nw+w+VKJmnLwd
   SclWIMQOSTxpiAQJoKC1WxhU6OPMA35YV5R4PlqRVoU/BBUf3lYreaZjf
   Mnorn39qCwtr81vZ5CELMnOtJlyTseTzAaL/66V5adJABNkAlLBIgaqEr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237436233"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="237436233"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 23:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="520870562"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2021 23:24:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 23:24:09 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 23:24:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 23:24:08 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 23:24:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNL8xqXN0Z8Cb+vemR7WZNVY/+g8lmAMCKkmIxl5T61XIt729CgibtL/kXPXmXPmBIsNDnXv7ZvBxrD3Vrx8iKMk5uhew73NvqNuubr6N3qvj20InThloPTibjPms3pv8vl8TpNL66XS3B/o0A5dLx1dPgKaanNioOK9vqXY7AmdG+J8A8XgDGUDWbw6/4z8DCUBtUqOZIa38slgKJvHl76hxL9dQCn5ec9MSLHS+1LadMomzv8ooZfhMsjwjqRs1txKkxQ7SigOfQEDG5rfYzxmMOUVxsi5NHorJYYtebodSOEMtGvn1o+ajatY6hXQQTxpxo8oGgcZAzbdkzEa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfRreMzab1925HUFD8Vvc5KKo0Rv09ng1/BnANMlajw=;
 b=k6qlafW5UDilLAKiUTt3xuRIWWgueCcV8Vtn1idSVPtVeozFDWuyXuiwdG9Z3GWIRb6cVPiT3NgdqsuUxmxL2KF8rsOpISMQ7jrmv8sUzNQ1zRumMRQPpVcp5DCpQdnDSz6Q01xIbbUi9Tc9a1V3I0rtnsWU7qXyvAoA/GuYJPjjygFgmEy7wdwiVy+ZD88QnXN/yPm/FHKVYYutkEx0I9hIAaRXLPQnJl5GIBFZEjxQRNkIzVUWRzccdx+DcF93ihmMd401dzH9f9qLiNr7HNkJpnfkPURYzE3TKdfvoMD3dOCafXkncUBBtjeNpCr6P7sVfuIdBg8Wtl9cC9Hntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5951.namprd11.prod.outlook.com (2603:10b6:510:145::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Sat, 18 Dec
 2021 07:24:07 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ac2c:e06e:121d:755e]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ac2c:e06e:121d:755e%6]) with mapi id 15.20.4755.014; Sat, 18 Dec 2021
 07:24:07 +0000
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
Thread-Index: AQHX8xmfto9cD4Z770uMSCbPYAz7oKw3KfgAgACwDaA=
Date:   Sat, 18 Dec 2021 07:24:07 +0000
Message-ID: <PH0PR11MB5880A552E7A3856D8F9165FBDA799@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
 <87k0g3ar7z.ffs@tglx>
In-Reply-To: <87k0g3ar7z.ffs@tglx>
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
x-ms-office365-filtering-correlation-id: 96b92117-a135-434e-3dde-08d9c1f760a0
x-ms-traffictypediagnostic: PH0PR11MB5951:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5951264AFD3D6C1603AB49ADDA799@PH0PR11MB5951.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOF1PrVunb78/BUcu+t7kcf8Sl6gAgPCC8ilR7kyiYqP+AkTAoxjO73HhhW6A7HW4YC2T4/fidy0+uuEq57E1sCfFynDLCflpwk59CyPnc7hhgWmiRAn4ETVENTCIIqrDNtaadFfgeT+kLuLbPgvZuN9PXBHXKHS44OyPLfZaNIEqucrUE3n+9MmAFVH6hX01plpNMpz6qebMUsa3B9L1QweNy27u0p2Vqqg8zjxBkR0XCkxw8FamQjjM7UeqMDPbWyNmMskIC+GZi4ZU61UI3kgV5AqhHgb073TspL1hVZWPfk/G8hWbD+WMtSkwdS41PEsK9Li+iGUhBv/HrHtWhK8FBnnJWaQjER7hU3BFomHUWfHc8CPUz3U2l3lqYiNFFQuEWER3So06dhoHCpMfQjgVYLv257M2HAIsPT+yw1x8GUDsdAdsbOXqAmUOCfN9s1+TdDgtpaoRib+rdzZJQs52Yb5mK9n9r5+8uBwUyT//vgaXAGM+NZjwoE86NoxwgawDJ05Wr091ElqTvI6Dl09XerZ1SOjpIhKk9ipRJSaLgQdeHh0rdGz9VzJ8oRkjHYezfnJXEnDJuQ1oLs3gxrQtgNaZw+f3bRv0L8BZwHLwZKfW/nD8nEduW0yPK0q38yvRyxMnC2M/WgiartpWBe2YlxnvM8ssVuXsP5relUMh1W1+t4nfodRPzyzVD6ufXa9ZPtJl0az74iL4U2J2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(52536014)(5660300002)(38100700002)(8936002)(186003)(9686003)(82960400001)(316002)(122000001)(54906003)(4326008)(83380400001)(71200400001)(2906002)(55016003)(8676002)(26005)(107886003)(110136005)(6506007)(76116006)(508600001)(66476007)(66446008)(33656002)(7696005)(64756008)(66556008)(66946007)(86362001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OGUwQXNUZXRWaS9SOG9TR1JQT2MxQUI4YklGYnliTnltRnhRZ0dnOFU3QjVo?=
 =?gb2312?B?VTk0WXhRYStrb2dLWGxwNTNrZll1RTRERHlGa3RzYkZvcTcvMGF2OTFUaisx?=
 =?gb2312?B?bDBzNjlCaUNKVHVHdTFNekhlcSsyOWMrSUlNbjVJMnpGV0NUaS9YOGpjOVUx?=
 =?gb2312?B?UjBkaE9zZ1d0NUVHTHU0TXBKajZIU04xWDZtL1hGbXRrTmxvTHdUYWh4b1F4?=
 =?gb2312?B?OWZHRmprSUxvb3E5Y3NvVjhPeHhYTGdFSjlTekdYQlBSR3d4b2FOYkFQSjVa?=
 =?gb2312?B?cWkweUo4emliMmxVY1F6MGpYMmRVa2tEMUcwL2oxSUg4eXhnYWRwNStWT2oy?=
 =?gb2312?B?YnZHNUlpaktpZkNqWXhiak91Y1RkM0NnQm8wVVVaMng2NS9jcVFQQjFqMFZQ?=
 =?gb2312?B?MWlPRTFDYVQ3c1pIcllacENUNC9tSlcwck5yL2pHdXU5RCs2MTQzdHFvZFZ1?=
 =?gb2312?B?bFRjUWZDa1p4L1JwMElaMi9XbGFRcDNQOFh6Z0hna2NFeG9lT0NnTkJqY1ho?=
 =?gb2312?B?U29MRWdYVWFTNzdYS0NWWHVvak1yb1A0a2tmMktQU09kS3orRHR2d3NOV1RS?=
 =?gb2312?B?VS9senJFdVNMWmEwUnJtQzZ6S3BmSVFOK3l1Tmlvc3RtUmRaR3FjVEZseVQ4?=
 =?gb2312?B?N2RscGVFTGtiWU1GOS9pV0Z1bFI2em1WaDdCNTZpRmJ0Uk1aL3A1a1ZVMWpi?=
 =?gb2312?B?d3ZqRURQUFhoS3hUblp3MVVtM0FDTjVIQ3BMS2FBRlF6eWdJcGFmU0tnMnpp?=
 =?gb2312?B?bWFNTDViZkllcU0xdlVMdlNxOGRjUUdlYWVNZnlHM0phck5GQ0V0Ym4yUkR4?=
 =?gb2312?B?OUNRMHRMTUFCUm03Z2REN1RETktzSmZLWmk0UnRaQVFvV0poQnJSNlVRcm1x?=
 =?gb2312?B?VWJIQ01aWlEzSU1wNEozN1BDQ3hzRm1NSGt4WncvQ0NsYzRsU1BWRVlHdXFp?=
 =?gb2312?B?UUdMUGt0Z005RWVFVEEybUpQZ3RYZjBUdUd3VnBacUk3NzFEZnIybC9IN0p6?=
 =?gb2312?B?NCtSd0U0dlRnUWgwa3FtbnBBdEl2T01hMDIrbjgvRGZGbUp5WjVKMnFRWHpQ?=
 =?gb2312?B?SmJGcmJVVmRxaWxhRlVHbGpjQXBPdCtHVkNkekdVUzVTQ0UrSEY5N1BueTJ3?=
 =?gb2312?B?enBMWEhGTmhIMWEwdXJkUEZLSnBMZ3VwOXF0OW4rZXhkS3hZNS85QmppaklP?=
 =?gb2312?B?TnhnQUZFVC9kQ002UmVHdTFUVjFvbXRBV3NEYSs0S0xuTFFIaWgyZmE2VDE2?=
 =?gb2312?B?R3hvZGt1Vk5rcjdCVnh1SDR0NGQ0UXJCeEdhZjFCTzdLU1hDUlBmYlFobDBV?=
 =?gb2312?B?UlppcjJlWGhaaGt4RzR1eWM1bWw4UnRETEx1SDVEek1XVWtDLzl0UUpTV1JE?=
 =?gb2312?B?VXpiSDJyZ1FaNzZseFZLdElBS0VCcUhKQVQ1eHZrRXg3MjZWd2dFUXlLbktx?=
 =?gb2312?B?Q0d4U1RxZXJLd3RaZERZYzhsZXphZVFubUZnRmR3ZXlDYjN5UU92a1hNeEZY?=
 =?gb2312?B?UWxHUzY0WGZjYnptS3IvQ3ZuNGlJOVZVTnlTbm52anVpN3FoNnhaK0Q3di9X?=
 =?gb2312?B?RTBicXRydXNRK29yZTRMUzhUenRPYkUzZXIxTHJXNjlaT0QvQXJFWm5tTlRR?=
 =?gb2312?B?MWc0MEJpQTRjUDlWTTdtSmovVFFOOS92Vk9MdWJTSmZVbFVEZXMxUi96T1RV?=
 =?gb2312?B?SGMvK2lQdldjSVI3aDBSdjdPYjFyR21TVnk2dURleGcwTUVDWjcySnlFdkRI?=
 =?gb2312?B?ZTZyZXBNZ2JXdXBMRHdobzc5dHhKV1BMZjhTK0xDR1UyM2FQVldiamFtMzMz?=
 =?gb2312?B?Tkk1WnFkS1M1aHp1TzVkdDlYdDRIeXhnY1hSTEZPUXE0aWhCVFRyeFpxY3hN?=
 =?gb2312?B?eHkwU1JTRmpKWTdrazI5WEVtRkhmTlJTYk1LcmJRNzBEQ3E3Y3RCTDIxUEl2?=
 =?gb2312?B?dzNoSTZ4TWJsckFoc3ExRXh6QVNNRlFsL0NCeEhaeGtPMUswdWpSVjRYWDVB?=
 =?gb2312?B?VEpmQUsrMXlWbGt0TzFKMjJ1SUJLVWxoYkJzL0ZsTTdUYXhac0JjT25oVmRs?=
 =?gb2312?B?T242YnpVc3hkWjJvdEIyMElUb0lnUStxTWx0ZlIxRVd6SU1XaHJJaTQ2enpK?=
 =?gb2312?B?cWpoSWVRYnZQdyt6eDhnTTN3Skt5VDh5WjN3T1Fod0srbUQ0TGFlSU85TFoz?=
 =?gb2312?Q?zhnJ/MWHxtsrykXABFdKPPY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b92117-a135-434e-3dde-08d9c1f760a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 07:24:07.1196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUYwXbnLnC3xNPLtXs7HWivCDwUJ01osvYbq7YODJcUh5EX1QkpKuauZpHyls0zMmCNWnfqd1kNlzzmIQezyGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5951
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4gDQpTZW50OiAyMDIxxOoxMtTCMTjI1SA0OjUzDQpUbzogWmhhbmcs
IFFpYW5nMSA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT47IHBldGVyekBpbmZyYWRlYWQub3JnOyBt
aW5nb0ByZWRoYXQuY29tOyB3aWxsQGtlcm5lbC5vcmc7IGxvbmdtYW5AcmVkaGF0LmNvbQ0KQ2M6
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpoYW5nLCBRaWFuZzEgPHFpYW5nMS56aGFu
Z0BpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBsb2NraW5nL3J0bXV0ZXg6IEZp
eCBpbmNvcnJlY3Qgc3Bpbm5pbmcgY29uZGl0aW9uDQoNClpxaWFuZywNCg0KT24gRnJpLCBEZWMg
MTcgMjAyMSBhdCAxNTo0MiwgWnFpYW5nIHdyb3RlOg0KPiBXaGVuIHRoZSBsb2NrIG93bmVyIGlz
IG9uIENQVSBhbmQgbm90IG5lZWQgcmVzY2hlZCwgdGhlIGN1cnJlbnQgd2FpdGVyDQo+IG5lZWQg
dG8gYmUgY2hlY2tlZCwgaWYgaXQgbm90IGxvbmdlciB0b3AgdGhlIHdhaXRlciwgc3RvcCBzcGlu
bmluZy4NCj4NCj4gRml4ZXM6IGMzMTIzYzQzMTQ0NyAoImxvY2tpbmcvcnRtdXRleDogRG9udCBk
ZXJlZmVyZW5jZSB3YWl0ZXIgbG9ja2xlc3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFp
YW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgdjEtPnYyOg0KPiAgTW9kaWZ5IGRlc2Ny
aXB0aW9uIGluZm9ybWF0aW9uLg0KPg0KPiAga2VybmVsL2xvY2tpbmcvcnRtdXRleC5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9ydG11dGV4LmMgYi9rZXJuZWwvbG9ja2luZy9y
dG11dGV4LmMNCj4gaW5kZXggMGMxZjJlM2YwMTlhLi44NTU1YzRlZmU5N2MgMTAwNjQ0DQo+IC0t
LSBhL2tlcm5lbC9sb2NraW5nL3J0bXV0ZXguYw0KPiArKysgYi9rZXJuZWwvbG9ja2luZy9ydG11
dGV4LmMNCj4gQEAgLTEzODMsNyArMTM4Myw3IEBAIHN0YXRpYyBib29sIHJ0bXV0ZXhfc3Bpbl9v
bl9vd25lcihzdHJ1Y3QgcnRfbXV0ZXhfYmFzZSAqbG9jaywNCj4gIAkJICogIC0gdGhlIFZDUFUg
b24gd2hpY2ggb3duZXIgcnVucyBpcyBwcmVlbXB0ZWQNCj4gIAkJICovDQo+ICAJCWlmICghb3du
ZXJfb25fY3B1KG93bmVyKSB8fCBuZWVkX3Jlc2NoZWQoKSB8fA0KPiAtCQkgICAgcnRfbXV0ZXhf
d2FpdGVyX2lzX3RvcF93YWl0ZXIobG9jaywgd2FpdGVyKSkgew0KPiArCQkgICAgIXJ0X211dGV4
X3dhaXRlcl9pc190b3Bfd2FpdGVyKGxvY2ssIHdhaXRlcikpIHsNCj4gIAkJCXJlcyA9IGZhbHNl
Ow0KPiAgCQkJYnJlYWs7DQo+DQo+Z29vZCBjYXRjaCENCj4NCj5UaG91Z2ggdGhpcyBkb2VzIG5v
dCBhcHBseSBiZWNhdXNlIHRoZSBjb25kaXRpb24gaXMgaW5jb21wbGV0ZS4gWW91DQo+c29tZWhv
dyBkcm9wcGVkIHRoaXMgZnJvbSB0aGUgY29uZGl0aW9uOg0KPg0KPiAgICAgICAgICAgICAgICAg
ICB2Y3B1X2lzX3ByZWVtcHRlZCh0YXNrX2NwdShvd25lcikpKSANCj4NCj5QbGVhc2UgbWFrZSBh
bHdheXMgc3VyZSB0aGF0IHlvdXIgcGF0Y2hlcyBhcHBseSBhZ2FpbnN0IExpbnVzIHRyZWUNCj5i
ZWZvcmUgc2VuZGluZyB0aGVtIG91dC4NCg0KVGhpcyBjb21taXQgYzBiZWQ2OWRhZjRiICgibG9j
a2luZzogTWFrZSBvd25lcl9vbl9jcHUoKSBpbnRvIDxsaW51eC9zY2hlZC5oPiIpDQptYWtlIHRo
ZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9ucyBpbiBsYXRlc3QgbGludXgtbmV4dC4NCg0KK3N0YXRp
YyBpbmxpbmUgYm9vbCBvd25lcl9vbl9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpvd25lcikNCit7
DQorICAgICAgIC8qDQorICAgICAgICAqIEFzIGxvY2sgaG9sZGVyIHByZWVtcHRpb24gaXNzdWUs
IHdlIGJvdGggc2tpcCBzcGlubmluZyBpZg0KKyAgICAgICAgKiB0YXNrIGlzIG5vdCBvbiBjcHUg
b3IgaXRzIGNwdSBpcyBwcmVlbXB0ZWQNCisgICAgICAgICovDQorICAgICAgIHJldHVybiBvd25l
ci0+b25fY3B1ICYmICF2Y3B1X2lzX3ByZWVtcHRlZCh0YXNrX2NwdShvd25lcikpOw0KK30NCisN
Cg0KVGhhbmtzDQoNClpxaWFuZw0KDQo+DQo+VGhhbmtzLA0KPg0KPiAgICAgICAgdGdseA0K
