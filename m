Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467E46F848
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhLJBOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:14:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:36586 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233330AbhLJBOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639098641; x=1670634641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JKgElxJuzE4q7lptBVYs+2nHDtvi1gtw3rWybQekcRo=;
  b=KpaR79iNskhGbVIJMds7s4/OK6g5V+nEA7tXStvNdwREW8PRO5E99sTg
   csBxnCcw9HLjr3LHLxLPJSrGsB9SboraoMq2UEEdRfwShq4YSL9gQiPGb
   mfDiuYFny29qljp86TSzg+PV5YyTAkJyKQwQJ97g+nLjZVd5R2lU9edy0
   Xx8sG4w8Qdwb+2lnB0w02sjXlQBTig1zdu9+aJR+wtcPndYL2WOrUIGqT
   vhlsFg/iRcBBskz4pk4Q8FXbzvO4xk43T/FYZWQLBW3bse6Fb4Sf4IcQg
   USeLDmSHtPmhoD1x+98CWFwDBWsWF5d7uOasbPWj3hug29M4gl7C8J80C
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218266575"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218266575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="543799272"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2021 17:10:40 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 17:10:40 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 17:10:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 17:10:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 17:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuHkUsa6bRgPG/G+lSAPEvKkvAEPGzat1ditRp3IlPcAAZ2+0LtF+hr/BVSDC2sdHDkFbsZYStEKKSY+S01fMpeP+cXHJMPYfreGe+UiemO+KBFJsu5zo7YoucfwJFG8sm9fImkuzGSK0vY4hVa2ROgSWnM/cCxbRI6OBJfUfKvNeHTvHfKnGS94wmNknf/H6Rbn0JM3gllY+67ase0url8lwpVq2eZCj4LDzJOTYQG/BihV01y49OnyIzDmtLnp2DTAXsTJalSrZ9/US+joGT4y+OGaER92n95IF5o2qL7ktwTpmZNMMY1Rql6RbIU4/Aaa2ivnjELHLBX37/zdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKgElxJuzE4q7lptBVYs+2nHDtvi1gtw3rWybQekcRo=;
 b=G9jQ+CksRAlbbFcEcrQ6jewmXq1Q3lxkPZKYqqUMzLf3TNxSHt2ZZ4soLNZ0k/iv9G+LYcrwJVIw8u0Cni5t9DyQrDN0Z0wLmsjzt/n5/77lph6qRhJrsgEEjrs+xM+4EkofXkPgT8wncLTk79cMPfxgjAPqwmhCIChIIzCio5zegY8pnsZ/HeLzIQqum4659xs+I/Lkdz/FkV6eaXRSN3iPYIuxHA2HNOUlrVJX+TpiuPq83PF7aBfQR01bWxP+uDhoNE1Hpjl+QxKmG/qVZ/LueDTMD8aNFERjytJWTYbNWd03Nw/dgRFdJ8XiESr5uN6GIYb9BESeYBo5LSo87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKgElxJuzE4q7lptBVYs+2nHDtvi1gtw3rWybQekcRo=;
 b=Dhh1geBgm3+TsDQ3OfTS6Zqd9UZrzascTCOdUasBbuUD3tCI8NkJEnOEoFMlgXtrq+kq7odV0rpN7qHMUQCTFcnGRncg1m7UB6zEoWnyNyi0aPw4tKt+d9Z2ZSQqmPhsbYAe7yw3gw6ewHxrId6hI5v0b2fTQ8Fv6TXju7eXrgM=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 01:10:38 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::e1e5:acdf:cecb:8c3b]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::e1e5:acdf:cecb:8c3b%8]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 01:10:38 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "andypalmadi@gmail.com" <andypalmadi@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Bluetooth not working on 5.15+ since "Bluetooth:
 Move shutdown callback before flushing tx and rx queue"
Thread-Topic: [REGRESSION] Bluetooth not working on 5.15+ since "Bluetooth:
 Move shutdown callback before flushing tx and rx queue"
Thread-Index: AQHX7VWejAgZkHV2PUOgB+cWm9oKBKwq6tAA
Date:   Fri, 10 Dec 2021 01:10:38 +0000
Message-ID: <fbc36e8ebdd9222f84322d54d9114f58c225547e.camel@intel.com>
References: <CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com>
In-Reply-To: <CAJvGw+AJ5dHSb50RtJHnjbhMVQa+rJgYznFV4t-iaO0qx+W-jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e75f897-4515-492c-2fd5-08d9bb79e0d8
x-ms-traffictypediagnostic: MW5PR11MB5906:EE_
x-microsoft-antispam-prvs: <MW5PR11MB5906CBD8DD57BBB14E8409BFFF719@MW5PR11MB5906.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4V2BEkKWiIgWRAxs/l/cLaDBWNjjwj6j7eR64UZ/wHJFBbduYjC2uJBb6COlr9tDDyCn0YQKNSBYU65Gy7aL/2gbJubM5qsuhcdwTY25wfi+1hoMOKzF1UmDg9evA2ubKil+WfZPKSl/fUYOs99jZZIeZKwm+ja3zFnT4lEEMku09h1Nt/105s14I1fjd16aZkZ7yh3khRbJdL5MlnG4qtIQwVtmcKdf0R1YtQoqcqydt+dQGISkq7pKnCmAZLLykst1cmyK8fFVyXj3nk2xIo6eBkcEyKR7juz8FgsPyRcY/59qPaalYZguY9Oi7I30LpLZTToAd8A/7Cnw4O/PD9QWx6gcRyC72fmliwlBLM/8Yh7MmYGpvtDHtWRuU8sye2YDzIml7hW6eJAX5I7pjO/9o67LGjBHNGUaNVFjah8i8aYxGSNoFbUTBe2n2MIgCmhPrzcmdpfF83miN/NVHY1tz6YkPI130o/DZ0SDa1vow1doVnkuFOQ7+5Pv/QbvM4W6TqniqYDFYuA2DejmrhDbcyKzSQ5eAoeizG4ImkcSkjR8qBaAtEKPdOlXFIyqbhweV0wuWCgcHK8TwJaVwwxdUC6Thhguo4iZOM/VGgYyRdU8x9a1YMYIo8Cyr8IY8Wxh7BVu8cDgfQwJcXhKbmAk0CwzFkDnXrGgvYopnTSksat96QRjeIMwdWdt0s60DTQ0nuMf8cf4kUeWHqFm0yvMcdEb08dIrzctajU5WqiYjYyUXtei4AaYihrMKOq7J903kvJ3ivK/Fa7tpkp2QAlNastO1nYcfPqb+qurhTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(64756008)(66446008)(36756003)(2616005)(38070700005)(5660300002)(16799955002)(76116006)(71200400001)(66946007)(4326008)(6486002)(6512007)(2906002)(316002)(966005)(6506007)(508600001)(38100700002)(8676002)(54906003)(26005)(83380400001)(8936002)(82960400001)(186003)(4001150100001)(122000001)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlkvZC9oQ1grVHVVZUtxNncrOHNBeXR6TDQyQ2RTTS9ndURQNXo4Y0pGYUdS?=
 =?utf-8?B?K2ozOEd3ZlJlWmp3SVJNaHVhaUUzbEExbUY4Mzh4Z0FSZWV5Uk96N2JLbEdv?=
 =?utf-8?B?cmZXNG11MnJ1YURGNStnVzI5eG5Rc05PbnlYVFgvV1ZUa2U5Y1lNK1l2MHh5?=
 =?utf-8?B?a1lWNERWQjEzbTZSY0MzL2VTUFlWSjNPTWxrUjdVeHd6OWI5azluVnRSU3hw?=
 =?utf-8?B?RjZuUkV0b1Jway9oVS9VMnZRNDlPelpGSlNBUzNTSVVicVZBdEwzekErb2to?=
 =?utf-8?B?QWRyVDBCbUNTWkRrT3N5M0lhM2M2b0NFQXA3QWpDcGJnekordWhVQWhSQi9w?=
 =?utf-8?B?NGk4NXF0R015eE5xanhOV2FtOFlrOUx3djVKYXVBUDVnNlBZdFBCZ2JkOW1W?=
 =?utf-8?B?bkErWDZ4cnRmamQ4SC84UlRmUzNDbzZmVnpUVmZVVzdWbUJscG5YK0hsMDI2?=
 =?utf-8?B?QzBWZUtHYlNaSlYrR0w4eFdXcGlHQW5DeHRwUm9Kb2l5dUVJTzBZcVVFalNi?=
 =?utf-8?B?clN2QVVOYlJCNmhiSllpTmI1YUd5cHVZaU5jakxob0lYTE5kQjhFZ3MyYjQ4?=
 =?utf-8?B?bTJQcThOT2p4SHh3YUVUcWdYZHBzZzJMZDJGYlorZFFERUwvYVAxcHp3bldU?=
 =?utf-8?B?YlRsSHIzaElRK1ZXTDZ1azJJRG9EcVhrbUtvWVRVek1xczBmNSs5U0dxRXBx?=
 =?utf-8?B?MlB4ZFVsQTh4cFNIYWlSak1sdG82S0d1U0JQNENwZ05hbGtkMTFGQU9SNVoy?=
 =?utf-8?B?SWlSL3hTZXk4b2JHWkM0UlphT1hXWG9HdFNYNWVjSGNKNnp3T3QyekdMMmZh?=
 =?utf-8?B?bU9jN3FoamVYNkFXeTNVWm80K0hVaTJvUGVtWEVxVjhVdVFjY0RaV3NkaHla?=
 =?utf-8?B?eXE0QW8vV3dhdldRQkpMNGsxRll0MlZqbUZkTmJIM0hHbW5sYUhoY1hwN1Bw?=
 =?utf-8?B?eUtLNWttVmh5VXdKbTNBSXpVakxtWHVDNzFQUHIxME8yRjNzSHlIYXJlY1Zt?=
 =?utf-8?B?VmRibklxL3pEb2ErZEd0ekZmQXN6Y0Vnb1JLYU1kUHhhc3VucFpNMytuV3VT?=
 =?utf-8?B?bG5BN0liRm1jamdaanY4cjVaMDR3eE5oYzFBcmpUTGFXWGFUUG8wbGxyamJL?=
 =?utf-8?B?dTlrWkpzeFdsVy9GUk5OaGlNTnczSCtMdXFUUG5DNWxwUncvNE54NGUxVWJG?=
 =?utf-8?B?ZUpwVlZNU3lmWXN3eXdVS0ZKcWxpVmhlT1VsNXFYaW9kMDVVWUk3QXRteStl?=
 =?utf-8?B?WkkySHhjakZMMjhLb25wM0ZqZ2R5ZmpFSUxGZkZ2b05EdzFPSTNPdFY3aHhE?=
 =?utf-8?B?NFJacThkVVl6dUYwdyt2UDhlbTdaRVF3N0E0VlB2L2NvUjRRYkJHcWNmdlo5?=
 =?utf-8?B?K2tqdWFkRU1YM3JKYnlDZG95OFZjcDNMK2tEeDFQTU1yZC84N1FTTmdWbnVi?=
 =?utf-8?B?Q05Ca3ZLOU4wKytkcFQ3ajg3YVN4cHV4cndHVkl5SzVrSXIreW1ld29udFJa?=
 =?utf-8?B?U1RLVHBUZnZoMkV4RllaaWJYN3JDLzljUkpqSWQxWnhjOHEreTRtVkxxVmRK?=
 =?utf-8?B?V2Y5UXFlL3Nmcjd1WFJHaW1OVWNSSm5xbkl0cXByZ3k0ZHV3Z3hDV3Q2Mjhk?=
 =?utf-8?B?THlMRTJOSEZ2L290QzE0MTBZaUJHU0w2bXFsTGxUOUtESXB3SUdGS3FXWWZW?=
 =?utf-8?B?d04xZ3FOaENHSEo0bENtWWd0bXU2WG14enMyQVE1azZuamFzMWNEbGZQWSt1?=
 =?utf-8?B?UFZGa0puVm1vQkNCQkxBdUNqbmpwcUIzM0lZejNzT1VucXI4MkJkUDNZWGdO?=
 =?utf-8?B?WjV5UWZjYnZRakZ3RGxZQ1VWNW0rbkFFZElVOEtYZ1U0bUVlWmM4NVB5cVp2?=
 =?utf-8?B?ZFBSa0dzZEZnSGVHOVNkSzBUb0xOWDNNYjhRd25ldFF5VUtqS01DNHl2U0lB?=
 =?utf-8?B?bGFVQXRTdzBBVndacDJOazZpaTFLQmY4ZFZnTFV2dFhDNGFCN0x4SkZ2WHZm?=
 =?utf-8?B?MTlBaFA3L2pxVHFROWFkM2VQOCtnM2hwell3bUJpNnphazNlVjBqb29oZjlS?=
 =?utf-8?B?Q0QxUUp4WjJoQ0MrQXZIL2dNbnkrREVNWUJZWXNZVnh6NFJDMFA4U2VYaW5y?=
 =?utf-8?B?Q1ZHampqYjBpMHc1K3lCcnF5eG8yUElEb1FVVmEvLzdVT3crSDRLZitaY1ZO?=
 =?utf-8?Q?fJEPZeObzM4w6kGH1XJrJBGPqtvSuzoEVNn2XsXPaYwJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1D6F8DCCBC24442B7449EDA80F8C83B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e75f897-4515-492c-2fd5-08d9bb79e0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 01:10:38.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHhckYf9uPpdxypn4/ql1Uafaq4aOJh1IYLuITthXqcVodoWqDfQFaigRYwHcoOKNZLMjPs7UYc08xwL6hofgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgMjAyMS0xMi0xMCBhdCAwMTozNiArMDIwMCwgY29sZG9sdCB3cm90ZToN
Cj4gQWZ0ZXIgYSByZXN0YXJ0LCBibHVldG9vdGggZG9lc24ndCB3b3JrIHNpbmNlIGNvbW1pdCAw
ZWE1MzY3NGQwN2YNCj4gIkJsdWV0b290aDogTW92ZSBzaHV0ZG93biBjYWxsYmFjayBiZWZvcmUg
Zmx1c2hpbmcgdHggYW5kIHJ4IHF1ZXVlIg0KPiANCj4gYmx1ZXRvb3RoY3RsIGRvZXNuJ3QgbGlz
dCBhbnkgY29udHJvbGxlcnMgYW5kIEkgZ2V0IHRoZSBmb2xsb3dpbmcgaW4NCj4gZG1lc2cgfCBn
cmVwIC1pIGJsdWV0b290aA0KPiANCj4gW8KgwqDCoCAyLjYzNDgxMl0gQmx1ZXRvb3RoOiBDb3Jl
IHZlciAyLjIyDQo+IFvCoMKgwqAgMi42MzQ4NDNdIE5FVDogUmVnaXN0ZXJlZCBQRl9CTFVFVE9P
VEggcHJvdG9jb2wgZmFtaWx5DQo+IFvCoMKgwqAgMi42MzQ4NDVdIEJsdWV0b290aDogSENJIGRl
dmljZSBhbmQgY29ubmVjdGlvbiBtYW5hZ2VyIGluaXRpYWxpemVkDQo+IFvCoMKgwqAgMi42MzQ4
NTBdIEJsdWV0b290aDogSENJIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbwqDCoMKgIDIu
NjM0ODUzXSBCbHVldG9vdGg6IEwyQ0FQIHNvY2tldCBsYXllciBpbml0aWFsaXplZA0KPiBbwqDC
oMKgIDIuNjM0ODU4XSBCbHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4g
W8KgwqDCoCA0LjA3Nzc4OF0gQmx1ZXRvb3RoOiBCTkVQIChFdGhlcm5ldCBFbXVsYXRpb24pIHZl
ciAxLjMNCj4gW8KgwqDCoCA0LjA3Nzc5NF0gQmx1ZXRvb3RoOiBCTkVQIGZpbHRlcnM6IHByb3Rv
Y29sIG11bHRpY2FzdA0KPiBbwqDCoMKgIDQuMDc3Nzk5XSBCbHVldG9vdGg6IEJORVAgc29ja2V0
IGxheWVyIGluaXRpYWxpemVkDQo+IFvCoMKgwqAgNC4wNzgyMTldIHJhbmRvbTogYmx1ZXRvb3Ro
ZDogdW5pbml0aWFsaXplZCB1cmFuZG9tIHJlYWQgKDQgYnl0ZXMgcmVhZCkNCj4gW8KgwqDCoCA0
Ljg1MjgzNV0gQmx1ZXRvb3RoOiBoY2kwOiBSZWFkaW5nIEludGVsIHZlcnNpb24gY29tbWFuZCBm
YWlsZWQgKC0xMTApDQo+IFvCoMKgwqAgNC44NTI4MzhdIEJsdWV0b290aDogaGNpMDogY29tbWFu
ZCAweGZjMDUgdHggdGltZW91dA0KPiANCj4gSG93ZXZlciwgaXQgd29ya3MgYWZ0ZXIgYSBjb2xk
IHN0YXJ0IG9yIGFmdGVyIHB1dHRpbmcgdGhlIGNvbXB1dGVyIHRvIHNsZWVwLg0KPiANCj4gQmVm
b3JlIDgzZjJkYWZlMmE2MiAiQmx1ZXRvb3RoOiBidGludGVsOiBSZWZhY3RvcmluZyBzZXR1cCBy
b3V0aW5lIGZvcg0KPiBsZWdhY3kgUk9NIHNrdSIsIGl0IGFsd2F5cyB3b3JrcyBhZnRlciBhIHJl
c3RhcnQsIGJ1dCBmcm9tIHRoYXQgY29tbWl0DQo+IHVwIHVudGlsIGJlZm9yZSAwZWE1MzY3NGQw
N2YgaXQgZWl0aGVyIHdvcmtzIG9yIGRvZXNuJ3Qgd29yayBhZnRlciBhDQo+IHJlc3RhcnQgZGVw
ZW5kaW5nIG9uIGlmIGJlZm9yZSByZXN0YXJ0IGl0IHdhcyB3b3JraW5nIG9yIG5vdCwgbWVhbmlu
Zw0KPiBpdCBzdGF5cyB3b3JraW5nIG9yIHN0YXlzIG5vdCB3b3JraW5nLg0KPiANCj4gQWxzbyBv
biB0aGUgZmlyc3QgcmVzdGFydCBmcm9tIGJlZm9yZSA4M2YyZGFmZTJhNjIgaW50byAwZWE1MzY3
NGQwN2YNCj4gb3IgbGF0ZXIgaXQgd29ya3MsIGJ1dCB0aGVuIHJlc3RhcnRpbmcgYWdhaW4gaW50
byAwZWE1MzY3NGQwN2Ygb3INCj4gbGF0ZXIgaXQgbm8gbG9uZ2VyIHdvcmtzLiBTbyBpdCBzZWVt
cyB0aGF0IDBlYTUzNjc0ZDA3ZiBhbmQgbGF0ZXIgcHV0cw0KPiB0aGUgYmx1ZXRvb3RoIGluIGEg
bm9ud29ya2luZyBzdGF0ZSBpZiB5b3UgcmVzdGFydCBmcm9tIGl0LCBidXQgYmVmb3JlDQo+IDgz
ZjJkYWZlMmE2MiBpdCBwdXRzIGl0IGJhY2sgaW50byBhIHdvcmtpbmcgc3RhdGUgYXQgc3RhcnR1
cCwgYW5kIGluDQo+IGJldHdlZW4gaXQgZG9lc24ndCBkbyBlaXRoZXIsIGkuZS4gaXQgc3RheXMg
dGhlIHdheSBpdCB3YXMuDQo+IA0KPiBJIGhhdmUgYSBEZWxsIExhdGl0dWRlIEU1NTUwIGxhcHRv
cCB3aXRoIGFuIEludGVsIDcyNjUgd2lmaS9ibHVldG9vdGgNCj4gY2FyZCBSRVY9MHgyMTAgZmly
bXdhcmUgdmVyc2lvbiAyOS40MDYzODI0NTUyLjAgNzI2NUQtMjkuIEknbSBvbiBBcmNoDQo+IExp
bnV4LCB0aGUgcHJvYmxlbSBpcyBzdGlsbCB0aGVyZSBvbiA1LjE2LXJjNC4NCj4gDQo+IEhlcmUg
aXMgYSB0aHJlYWQgb24gdGhlIEFyY2ggTGludXggZm9ydW1zIHdpdGggc2V2ZXJhbCBwZW9wbGUg
d2l0aCB0aGUNCj4gc2FtZSBwcm9ibGVtLCBmb3Igc29tZSBvZiB0aGVtIGl0IGdvdCBmaXhlZCB3
aXRoIGEga2VybmVsIHVwZGF0ZSBvciBieQ0KPiByZWxvYWRpbmcgbW9kdWxlcywgYnV0IG5vdCBm
b3IgZXZlcnlib2R5LCBpbmNsdWRpbmcgbWUNCj4gaHR0cHM6Ly9iYnMuYXJjaGxpbnV4Lm9yZy92
aWV3dG9waWMucGhwP2lkPTI3MTQ1OQ0KPiANCj4gI3JlZ3pib3QgaW50cm9kdWNlZCAwZWE1MzY3
NGQwN2YNCg0KVGhpcyBpc3N1ZSBpcyB1bmRlciBpbnZlc3RpZ2F0aW9uIHRvIGZpbmQgdGhlIHJv
b3QgY2F1c2UgYW5kIHByb3BlciBzb2x1dGlvbi4NClRoZSBkb3dubG9hZGVkIGZpcm13YXJlIGJy
ZWFrcyB0aGUgYmVoYXZpb3IgdGhvdWdoLCB3ZSBuZWVkIHRvIGludmVzdGlnYXRlDQpmdXJ0aGVy
IHRvIHNlZSBpZiBpdCBjYW4gYmUgZml4ZWQgaW4gZmlybXdhcmUgb3IgZml4IGluIHRoZSBkcml2
ZXIuDQoNClJlZ2FyZHMsDQpUZWRkDQoNCg==
