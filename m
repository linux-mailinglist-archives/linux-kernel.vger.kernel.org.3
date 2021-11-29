Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3914461114
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbhK2JbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:31:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:25572 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242852AbhK2J3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:29:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="216628840"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="216628840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 01:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="539920227"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2021 01:25:51 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 01:25:51 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 01:25:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 01:25:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 01:25:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEzUyVz++hdYux5YFthaLf6WpeSf0rUSX6ERBVALdSyK023t/kLp3sYTtf131qbQSOdxhpFt96XyahrkBohXkKzsommJ4//AZB+LOV0ALA65UBBHjXCHELTbknZKyTml5S3F4kVtYwluO7fDZg9gVXe8vqChjjf05SCEHRf70NnTACZtDaw6yDIVO4DbXMdm4Nt7nvY/Im5LoGusFTiPjuaVxT8Au4IdR7tMxI9N5suxn4jEftep8jsKUCcDHHu0vuNnM4eaRSPqg99bJTSSj5VG+Lq5xPDYZAyozAAJ5/P7dYZ61W6y7WRhyZ/+kPUUeF5UZSUjPhh62yl0HVIgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9BrUGI5V2OVodxhPGcA0Q7S7Vyfzbr5FzEqWDyNdyk=;
 b=n6tkgUIRKjN4dBHif38EEdG9K78GaaPqsCgT7yH24DT89gL3WMJHr4zOtzLSfEcv3S1L5mfy5R2AfLBSamX6gVsgLgefPKiYt7f11gHw1kvTc/2BCt+qws/Dg0xuoplRMkhvF0XqVf9l4/l7chUM/Dvyn0PLBzwaRxws8I+TvsnJB6Q/UHGxcjT/jZAXy9r/kT5/ChM9JSCJQ3kqUhj65aGGat4zytap1KuwOq0CPvkJn2w8K3f4tAxvbLAxaG37SJZYhR83YMfuFLlEjVYBqVTarVYYoPQzhyBWDP2i6N0uJCx9NQF+iDr2Ln7eetIYOYvH5tbqmTrni1zPnsj54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9BrUGI5V2OVodxhPGcA0Q7S7Vyfzbr5FzEqWDyNdyk=;
 b=S3mWTjqqFX8p1OaIRtSlvoSXRxa0TR9/BH882Ax8ttZbxMyuBt1VCXc7WC0nMndMPCRq2vGDQrDNFqwKUSWyNCh75Yrbp/XKnuTRk3LXxUdnswM5sTH8cLihg0g4XQccWZKqQD6UYgHGzCde3AaKKeX9e6yYnahP2DE2JQgLDZA=
Received: from BYAPR11MB3207.namprd11.prod.outlook.com (2603:10b6:a03:7c::14)
 by BY5PR11MB4055.namprd11.prod.outlook.com (2603:10b6:a03:18b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 09:25:49 +0000
Received: from BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3]) by BYAPR11MB3207.namprd11.prod.outlook.com
 ([fe80::f0a6:e61:94db:53b3%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 09:25:49 +0000
From:   "Coelho, Luciano" <luciano.coelho@intel.com>
To:     "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>
Subject: Re: [Linux v5.15 final] Call-trace iwlwifi and/or mac80211 (was
 [Linux v5.15-rc6] mac80211 warnings with iwlwifi)
Thread-Topic: [Linux v5.15 final] Call-trace iwlwifi and/or mac80211 (was
 [Linux v5.15-rc6] mac80211 warnings with iwlwifi)
Thread-Index: AQHXzv1HdCkjW88YWkyWTtmG9YLVQKwYCVqAgAJbYgCAAAE0gIAAAkUA
Date:   Mon, 29 Nov 2021 09:25:49 +0000
Message-ID: <f62010887361ed46e190f896d8509de62941433e.camel@intel.com>
References: <CA+icZUXzoQ4Rkms6WbLnnY7WSbcgt9t4vNTu17qyTQTLr6d1sw@mail.gmail.com>
         <CA+icZUUqw-LSJOrGYbmjMv8tHEN_eoq4nbgr8BxspQRFxNjVrA@mail.gmail.com>
         <CA+icZUUWj_-jgiA=NCmSP5zgk_fcEFN5+vKn7jLOFpbdQepSyw@mail.gmail.com>
         <18efeb0222687d9886b2b83eb4090f08d0493d9f.camel@intel.com>
         <CA+icZUVT9YDReJDjggVOLkHGXf3zRZB=WZweSRQ1AzmZNW4-+w@mail.gmail.com>
In-Reply-To: <CA+icZUVT9YDReJDjggVOLkHGXf3zRZB=WZweSRQ1AzmZNW4-+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8434542f-e79a-46ff-31c5-08d9b31a3b5c
x-ms-traffictypediagnostic: BY5PR11MB4055:
x-microsoft-antispam-prvs: <BY5PR11MB4055E03D5106D3D98DC7B35290669@BY5PR11MB4055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Y+Xrs3ofbM78BLsT5O1GbntTNH3zSb09vLh/9WLSAissmUAL537JyJGwmJyn6Nwa7xcLNyBXjJ2PfwjuRE1cqJL4/SwFbgo9C7BDG3N4cgUmntq+33ZEZ+7LoOjVMF73jIG7FfyZ3fDwDLaYhmh5vMhncfQzYhEgYLt9edXNqQSr6QsqZvxjaR7ARPUacFn7AIHKyjHbDw0CGZb3fBEStx2H6OpXkatF81LtF7Sm1Uzr2t8XJGedIUbsz6UfT8AsyayDLmI9wJr0biQ3bbgpG0asJFXhBMFOG0uQvDBwO2AiCi8oXhVEQvvedlpekl7EDmBbn30ja4xGupXBWIDpCztBFRAtxR5j/DMu8JqNnRm9J3j8Ue6WXbDas6V05O4uveapIGnpJALQipryFTxsUNjWmBsEBou40w9ZRc2VUh3HKZsrr5d5g82RXGDcYaENCVV3BgBOAI6tr5+Xmw6RbPwfsrSwOPR2Yw/6b2hV9UmcsRUI1Q9R/62BECQWAGbTXc4vOeeTsjmAc71pXLrve4e3KvtCljyMgyQ3VYBI9Mb55O/LGIzQEiDPmRI81EFRobZ255VqfRxlZyIfOVXMbIVkGQf6weGNkVHSxe0Vns/ZRmgx1XK0BA9Q3HUV7Zg7QJ0jei6m/kb09KaLN8OmpQ4sCoIP2MhwGRztdvhm3fad2hfunEnCgwmAgRF3HiTtmfEDfF3WBg3Y3q2BNTex1hbImIaZ7N9JabmxBp6JG9Bz8+nWYcwgmNOBKcplEHiGuwSfvIdm9/4FI0UxzEHF3vasatcKjKoto4kKj2MEg4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3207.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(2906002)(122000001)(71200400001)(6916009)(82960400001)(26005)(6506007)(4001150100001)(8676002)(4326008)(2616005)(8936002)(36756003)(5660300002)(186003)(6486002)(38070700005)(91956017)(54906003)(966005)(76116006)(66556008)(64756008)(66446008)(66476007)(66946007)(6512007)(508600001)(316002)(83380400001)(53546011)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0NSZGVya2kxc2dwdjlFZ24zMWd0WnQwUEdBdjRWUFoyOThVVEw2VS9sUWJT?=
 =?utf-8?B?WWpLcEY2b3Fnb0g2eTVnU2FRNzVpZ0ZrZEw3cE42RFBCTktUV2hSYXdQNTNI?=
 =?utf-8?B?REZFaWJCQTZadzQ3dmNhNjdQYncrS0lySzFwcG54WXRwVno0KzhBN0didEJC?=
 =?utf-8?B?d2JQTzYrZW9rMThVMXVOTmJwN2tDNC8zVVM3WnJYOStWREt3OE9lRUllalhn?=
 =?utf-8?B?a1EzeTFFLzJuc3RIcm5BUzc3KzNYN3A2NWFSWEtHYytHSzZ5YVRxcEJBZVdN?=
 =?utf-8?B?MUI3YWdWei93d1dlRHlUTThWSDZIU1Q0UFB5bXQza0M0aUp1Mkw1UlpBTm5P?=
 =?utf-8?B?SW1xYjJpd1c2ZTRWc2pNUjY4amJFZEdVWDNOY1VNMEd1ZHNWSDdlRUo0Y3ho?=
 =?utf-8?B?UnJHUzQ3VFVXM2NuVEhSL3pBZ1p6UnAzRzNZcGxTdVZwU3hNY2k1ZEVQV3R2?=
 =?utf-8?B?bHA5RXBTRk9MNjhZRW03Ujd0ZHRWZTVxK2ZOSndJcm5oTi93RzB5dy9NVDFR?=
 =?utf-8?B?blNna2RBVER0bWFzdGtSYjlXYmdsTHE4ZzZiUTF5SmVKMkpWeGtQL20xeGJP?=
 =?utf-8?B?UUtQZFJDVFE3OXVFcEFJZXhUclVjUXZLbmNtUFBidlJyVzZlL1lkTHFLdkV1?=
 =?utf-8?B?eVJ3YitxdUN0UEJvT0NsemZTWU00VDF1clVPMTdoZ2RDZkw5T3I5QnVySFcx?=
 =?utf-8?B?ajI1YStJMVNvK2RDc0U5RXlIZ1JXc0FjejdYaEluUGNRRDNMQlhJTDJvcDhz?=
 =?utf-8?B?VnRDOEhDLzhmZjJhZ0c0NzBQNkdIcUxNc2Z3S2YrSWNkd3hoYS9raHlZcXdL?=
 =?utf-8?B?MEFEL1VOT21nSWZtanl5UG4yM1hwMUdoQitTMCtQRHk0UmxScG9CY0g3ZDBt?=
 =?utf-8?B?MXphV1dtVmM5TXg1QlNXckRoWjdWa0lEai84ekJXNkVtSzZ0Mm5hVllGbmtp?=
 =?utf-8?B?Z3N0OG1nK3c5S2RFclIxSTNBM1FBTVlaTnFUdzVCbkxXUHp5b2huU0NuTVpq?=
 =?utf-8?B?VFh0dzJpOUZQRXQvaTVRcWxRY2c3clhQdGEwS2o5T0xoT3IyS1p6NWkyM2ZD?=
 =?utf-8?B?cGtjK3o5N09ZOXQvbTlFT1RMemdKc1k3NEdNVlhVcC9mZkU5c3ZzNjNsNjdl?=
 =?utf-8?B?bWdlVG1TVjg4WFQ4L3loZy84VHFnNnpUbFJPc3ExeXNQUEpvQk5GdTBJSm1q?=
 =?utf-8?B?YUtWdlJWUTVpQWc3dHVpYlo0dDBSM0p2UWJtYVhWdGtWL1ZtcExCVUN0Q1hK?=
 =?utf-8?B?VWFqc25BaTdVQTFzS1Q5S0pWYnlqRzNHZHFuWDlJYVhxK2ZLbnMydGlKazRh?=
 =?utf-8?B?NC9tYWp6THBoNFpNNXdlUzA2NVp3Q2tBZlQreXU0WHowdGgxWWlwVlFBcU1p?=
 =?utf-8?B?d21IQXhaNExFTW4vN2V1eWUwVkg1SWNPdmxlbStocmVWWEtERmhMelVaUHlI?=
 =?utf-8?B?WGV2QkhZMTEzUEhnUCs1Q3d4U0ptUUZINDJseUlhQmRJRVRyb3pSRnd6aklO?=
 =?utf-8?B?di96dTRpbEM2ZXBXUTBxd3doNEo4WWlNei9HMTh0U1g2VGgremVjNjYyM3No?=
 =?utf-8?B?bEFIV0lvcnZPdTE3NmdPaEpVcE03N2lxRmJMVGVETHdXOEkrbEw4alpYeUtu?=
 =?utf-8?B?VzFsTGhHYkVXMFdvKzlXS3pDdlE3c2JTZWtoUUxzQVJiS21BQ0hBa0l1Qktr?=
 =?utf-8?B?Q0pUWGZPUTBlZGVaLytZejBEeXY5dTlxN0ZNV2xzSDhIT2d4aWg2aERRV2lm?=
 =?utf-8?B?Ymxnd0E0UXhwLzN5UDRQcndVK0h1bGFRSzdrcURHcml4c0VRUkdoa3c2cFRi?=
 =?utf-8?B?cFh3UDBxaWtFaVdFWGtyOVRCZ1ZKZUR1M0N2bHNzVGc5cm1TeVJ0Mzc1S2RF?=
 =?utf-8?B?L1NwdytnZ3FyaU5wTExxdGt0RGJVdFU1Q2JnS0xlNFNYNCtKZGZ5VXdmUzY0?=
 =?utf-8?B?b2FEcVlidGI2aGd6cEt5TDMvK1NsTjJuMU5pL0pUK2VibDQzV201Tk9LOGlN?=
 =?utf-8?B?Qm01MGh3T1ZnaW0vYkl2eXQrdmt1ZkxaMkhlUUtJY2MyVzNhelQ2MDFnUDRk?=
 =?utf-8?B?QnFKbWxHUWIwb0tEODJMREtBU3QwTzVzV1ZyS0Y5RUV5YXVsemJwTXBWZzRO?=
 =?utf-8?B?Rmdhb3NyOHhFMmVVTFRQZ1gydjd2dkVCMU4zb0ppRzlMOUQ4MWhZUGhlUkVy?=
 =?utf-8?B?VjlQWFpBVGdCQ1BwMmNySUJSMThqZ0VkYzQ2TEorMy9SU2ZvTUNyRmZmdG9R?=
 =?utf-8?Q?hXWUDEH1Itx2aadXie0KvPsWWGH268fgS/4+BPlYQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98E78E3E0AC41944BC1B897F81C735D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434542f-e79a-46ff-31c5-08d9b31a3b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 09:25:49.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7B8prc2hFVMlc+jPBSyjFcNhLUX/O3EC5RYVsUCXzO8x9GRL/DhBi+v/+n8v5mWz5TwJMpXIvpg/HKsXzssxY8Ma0e4bixy5xmMobn/HOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4055
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTI5IGF0IDEwOjE3ICswMTAwLCBTZWRhdCBEaWxlayB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMjksIDIwMjEgYXQgMTA6MTQgQU0gQ29lbGhvLCBMdWNpYW5vDQo+IDxsdWNp
YW5vLmNvZWxob0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFNhdCwgMjAyMS0xMS0y
NyBhdCAyMjoxMyArMDEwMCwgU2VkYXQgRGlsZWsgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0K
PiA+ID4gSnVzdCBqdW1wZWQgdG8gdGhlIGxhdGVzdCBEZWJpYW4ta2VybmVsLi4uDQo+ID4gPiAN
Cj4gPiA+ICQgY2F0IC9wcm9jL3ZlcnNpb24NCj4gPiA+IExpbnV4IHZlcnNpb24gNS4xNS4wLTIt
YW1kNjQgKGRlYmlhbi1rZXJuZWxAbGlzdHMuZGViaWFuLm9yZykgKGdjYy0xMQ0KPiA+ID4gKERl
YmlhbiAxMS4yLjAtMTIpIDExLjIuMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikg
Mi4zNykgIzENCj4gPiA+IFNNUCBEZWJpYW4gNS4xNS41LTEgKDIwMjEtMTENCj4gPiA+IC0yNikN
Cj4gPiA+IA0KPiA+ID4gLi4uYW5kIHN0aWxsIHNlZSB0aGVzZSBpc3N1ZXM6DQo+ID4gPiANCj4g
PiA+IFtTYXQgTm92IDI3IDIxOjU3OjIwIDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBSRl9L
SUxMIGJpdCB0b2dnbGVkDQo+ID4gPiB0byBlbmFibGUgcmFkaW8uDQo+ID4gPiBbU2F0IE5vdiAy
NyAyMTo1NzoyMCAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogcmVwb3J0aW5nIFJGX0tJTEwN
Cj4gPiA+IChyYWRpbyBlbmFibGVkKQ0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjAgMjAyMV0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9MHgxLTB4Mi0weDANCj4gPiA+IFtTYXQg
Tm92IDI3IDIxOjU3OjIwIDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBSYWRpbyB0eXBlPTB4
MS0weDItMHgwDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogRXJyb3Igc2VuZGluZw0KPiA+ID4gUkVQTFlfU0NBTl9BQk9SVF9DTUQ6IHRpbWUg
b3V0IGFmdGVyIDIwMDBtcy4NCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiBDdXJyZW50IENNRCBxdWV1ZQ0KPiA+ID4gcmVhZF9wdHIgMzUgd3Jp
dGVfcHRyIDM2DQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogTG9hZGVkIGZpcm13YXJlDQo+ID4gPiB2ZXJzaW9uOiAxOC4xNjguNi4xIDYwMDBn
MmItNi51Y29kZQ0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IEhDTURfQUNUSVZFIGFscmVhZHkNCj4gPiA+IGNsZWFyIGZvciBjb21tYW5kIFJF
UExZX1NDQU5fQUJPUlRfQ01EDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IE9LDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1
NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHVQYw0KPiA+ID4g
W1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAw
MDAgfCBicmFuY2hsaW5rMQ0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBicmFuY2hsaW5rMg0KPiA+ID4gW1NhdCBOb3Yg
MjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpbnRl
cnJ1cHRsaW5rMQ0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpbnRlcnJ1cHRsaW5rMg0KPiA+ID4gW1NhdCBOb3YgMjcg
MjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBkYXRhMQ0K
PiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDAwMDAwMDAgfCBkYXRhMg0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBsaW5lDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1
NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGJlYWNvbiB0aW1l
DQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHgwMDAwMDAwMCB8IHRzZiBsb3cNCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdHNmIGhpDQo+ID4gPiBbU2F0IE5vdiAy
NyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHRpbWUg
Z3AxDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDAwMDAwMCB8IHRpbWUgZ3AyDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIx
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHRpbWUgZ3AzDQo+ID4gPiBbU2F0
IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8
IHVDb2RlIHZlcnNpb24NCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaHcgdmVyc2lvbg0KPiA+ID4gW1NhdCBOb3YgMjcg
MjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBib2FyZCB2
ZXJzaW9uDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHgwMDAwMDAwMCB8IGhjbWQNCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaXNyMA0KPiA+ID4gW1NhdCBOb3Yg
MjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3Ix
DQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHgwMDAwMDAwMCB8IGlzcjINCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaXNyMw0KPiA+ID4gW1NhdCBOb3YgMjcgMjE6
NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3I0DQo+ID4g
PiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAw
MDAwMCB8IGlzcl9wcmVmDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHdhaXRfZXZlbnQNCj4gPiA+IFtTYXQgTm92IDI3
IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgbDJwX2Nv
bnRyb2wNCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDAwMDAwMDAwIHwgbDJwX2R1cmF0aW9uDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1Nzoy
NyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGwycF9taHZhbGlkDQo+
ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgw
MDAwMDAwMCB8IGwycF9hZGRyX21hdGNoDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIx
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGxtcG1fcG1nX3NlbA0KPiA+ID4g
W1NhdCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAw
MDAgfCB0aW1lc3RhbXANCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgZmxvd19oYW5kbGVyDQo+ID4gPiBbU2F0IE5vdiAy
NyAyMTo1NzoyNyAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogU3RhcnQgSVdMIEV2ZW50IExv
Zw0KPiA+ID4gRHVtcDogbm90aGluZyBpbiBsb2cNCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3
IDIwMjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBDb21tYW5kIFJFUExZX1JYT04NCj4gPiA+IGZh
aWxlZDogRlcgRXJyb3INCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiBFcnJvciBjbGVhcmluZw0KPiA+ID4gQVNTT0NfTVNLIG9uIEJTUyAoLTUp
DQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIxXSBpZWVlODAyMTEgcGh5MDogSGFyZHdh
cmUgcmVzdGFydCB3YXMgcmVxdWVzdGVkDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1NzoyNyAyMDIx
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogUmFkaW8gdHlwZT0weDEtMHgyLTB4MA0KPiA+ID4gW1Nh
dCBOb3YgMjcgMjE6NTc6MjcgMjAyMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFJhZGlvIHR5cGU9
MHgxLTB4Mi0weDANCj4gPiA+IFtTYXQgTm92IDI3IDIxOjU3OjI3IDIwMjFdIGl3bHdpZmkgMDAw
MDowMTowMC4wOiBSYWRpbyB0eXBlPTB4MS0weDItMHgwDQo+ID4gPiBbU2F0IE5vdiAyNyAyMTo1
NzozMiAyMDIxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogRmFpbGVkIHRvIGxvYWQgZmlybXdhcmUg
Y2h1bmshDQo+ID4gDQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+ID4gPiBDYW4geW91IG1hYzgwMjEx
IGFuZC9vciBpd2x3aWZpIG1haW50YWluZXJzIGxvb2sgYXQgdGhpcywgcGxlYXNlPw0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IEF0dGFjaGVkIGFyZSBteSBrZXJuZWwtY29uZmlnIGFuZCBmdWxsIGRt
ZXNnLWxvZy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiB5b3UgbmVlZCBmdXJ0aGVyIGluZm9y
bWF0aW9uLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+ID4gDQo+ID4gQ2FuIHlvdSBwbGVhc2UgZmls
ZSBhIGJ1ZyBpbiBidWd6aWxsYSBhYm91dCB0aGlzPyBUaGVuIGl0J3MgZWFzaWVyIGZvcg0KPiA+
IHVzIHRvIHRyYWNrIGFuZCBhc3NpZ24uDQo+ID4gDQo+ID4gVGhhbmtzIGZvciByZXBvcnRpbmch
IFdlJ2xsIHRyeSB0byBjb21lIHVwIHdpdGggYSBmaXggYXNhcC4NCj4gPiANCj4gDQo+IEhpIEx1
Y2EsDQo+IA0KPiBUaGFua3MgZm9yIHRha2luZyBjYXJlLg0KPiANCj4gRG8geW91IGhhdmUgbWUg
dGhlIGJ1Z3ppbGxhIFVSTCwgcGxlYXNlPw0KDQpodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcN
Cg0KUGxlYXNlIGFzc2lnbiB0aGUgY29tcG9uZW50IHRvIG5ldHdvcmstd2lyZWxlc3MtaW50ZWwu
DQoNCg0KPiBXaGF0IGluZm9ybWF0aW9uIHNoYWxsIEkgYXR0YWNoIGFuZC9vciBhcmUgcmVsZXZh
bnQ/DQoNClRoZSBrZXJuZWwgbG9ncyAoZG1lc2cpIHNob3VsZCBiZSBlbm91Z2ggdG8gZ2V0IHN0
YXJ0ZWQuDQoNCldlIGhhdmUgc29tZSBmdXJ0aGVyIGluc3RydWN0aW9ucyBvbiBob3cgdG8gcmVw
b3J0IGJ1Z3MgaGVyZToNCg0KaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vdXNl
cnMvZHJpdmVycy9pd2x3aWZpL2RlYnVnZ2luZw0KDQpQbGVhc2UgcGF5IGF0dGVudGlvbiBnbyB0
aGUgcHJpdmFjeSBhc3BlY3RzIG9mIHJlcG9ydGluZyBidWdzOg0KDQpodHRwczovL3dpcmVsZXNz
Lndpa2kua2VybmVsLm9yZy9lbi91c2Vycy9kcml2ZXJzL2l3bHdpZmkvZGVidWdnaW5nI3ByaXZh
Y3lfYXNwZWN0cw0KDQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIGFuZCBmb3IgeW91ciBoZWxwIQ0K
DQotLQ0KQ2hlZXJzLA0KTHVjYS4NCg==
