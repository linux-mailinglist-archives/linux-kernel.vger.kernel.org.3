Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0389D47CC60
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbhLVE6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:58:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:39714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238901AbhLVE6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640149123; x=1671685123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+KVJOcASLxRJ5arZ2nERyHkVyBiK1z7H9oLudXsQg64=;
  b=MDG37qw3ULDyC+7KpAKYn2MU/5dBltTPaw/IbgZRWHiJS0UQIWCaDFWX
   nk5aua+fvcnLcYRAuaploKSTD2Hj/V57TEGu+ti/hkFKOC/CfwUqWNP1S
   iZ4DXV+/FRGeSuDAB7t4a79vjLRadfvylPuohmuZ7kh3YF/opvpdSRj8Q
   GcSvxs7GEwqg7Moy52qhz3lserdLgcB+2nR0seZr1R/Mzt/Smka3AKPWO
   pYy6BYZMHZNDXqLPwLvX6t+0lvrGF4Rq0Sm8/uyF/1vF+i7ZDtyf2LvD9
   AVws0c3mGEj2k/tdZbnZCXOAscgI/wL52XEjF+8GdQ47HxUN+WFggqjWX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220556847"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="220556847"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 20:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="617009224"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2021 20:58:42 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 20:58:42 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 20:58:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 21 Dec 2021 20:58:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 21 Dec 2021 20:58:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxZrzSQjC+S212c+rnAwqDdz8RRF4sb3pb214dLk+wHnjzOIkqCtu55ZsIgfJ8jxboYe/uWyThIabXPUkO8I6iuL4l/DUp1u4uCBCVPpBoUtLZvqoiA8vkawLPbKOyF5qFyOUX/9FjEohZ/WqbjEKlhjtzBK9YyThZH9gylbQR0L9STk2wzTNUaXh1Y3MPiVHAVC9cJ/hWJzmzRDAykCQyR6QxIqMwPcaHmJurxgA8moVtRAO0Kvvp8z5+dRI3wPotiUT5wrUEtSK6cmjVgSEo4cORdHVNpNWDcHvvoYKNN1Kzlhq0ybIc5s++NztFXl0X2iqVXU3QuD/aps1t3HQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KVJOcASLxRJ5arZ2nERyHkVyBiK1z7H9oLudXsQg64=;
 b=QShJMR2LFRdWrFxpm/expjmjSzXy4BM6SfbgjgTXulAq1M7CaNApNjSRPynsMRZe3+cxGYewztKbM2Ys3HmZ7pQ8DdDoXXKO7kzj0b6kyAehaccF3Wl/B5oJnc+O333ENftd/Tvlppg9UBxISexKHS1Ec0A6kEKAYGv3gwdD8ZqlKRKy6vWc56NiNP2DXcrUJHmu+B2TWJjxDmJbu2WJ8um99sQKqVJRl7GfKVLxJVYMvmpYPx3ezaLro8J77yhBoJ1iTvIdeqotHhDHQKHBVGJW3EGriur0mg7TGQZ1UH1XZe6ej6z3fVNZP1Yide1Va7T7DA/3twrt0spCsdkp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 04:58:40 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%9]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 04:58:40 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 08/13] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
Thread-Topic: [PATCH v4 08/13] x86/power/keylocker: Restore internal wrapping
 key from the ACPI S3/4 sleep states
Thread-Index: AQHX8IXjRfFtZ/oANU+Q1COySZEY5Kw22G0AgAcnsAA=
Date:   Wed, 22 Dec 2021 04:58:40 +0000
Message-ID: <133514AD-0F75-4B54-8A74-E768B1E95CB1@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <20211214005212.20588-9-chang.seok.bae@intel.com>
 <CAJZ5v0gbePA+rR9gMRnaJrUGS1MwF6UQzxrFZChy5i=11tgz-A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gbePA+rR9gMRnaJrUGS1MwF6UQzxrFZChy5i=11tgz-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 296e1663-020b-44a0-2b29-08d9c507b8b8
x-ms-traffictypediagnostic: PH0PR11MB4981:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB498100C4EA936369E0FACA96D87D9@PH0PR11MB4981.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBgIluIEPXfAW7JrErN02oq96v05s+pEFklX68KtyKVdhf77v13vu/aMewj3C3hndgLPyfyIlgOlhWwOuab6LOZ3/zW/TOTiG9WQijCFcLGBfT8grZj99CTjK1SJ7cU1oTfPsp0oE3SAb+Z7JAQttWZCFrv/EKSjaSuG4N61yslkSZcb5dlDD43V7Cxx9qY9dy6D4GQK+rZKvggYsDgRtUtWGPIi1PFvqVBmYQRqmekzq+YeRlbeP7lvD0JR1BiCJz5zBP/tqW2nO82h//nPfHSTBz1OFz98b3RZLcpjKhndPJPiBfxgBJ3i4bOxdj3tT31SWmvFYukPWxA0a5ETNnD0MFBYLrW9ozCmzRABvwGT8t4HoMnzuC4hjDZY5lyuYcWQa5wSUeKdQFD6KY1R51luyEPUsuk/l7qSsmPgnt2ZIVpS0qymTsEFUsdC/O5XML16/M94zVEDQCRmM2wPC8UoP26pG62kzTAXFuR50ZA3xXy5XfKhw7GBC5tIKHawEpic7tOm1Lm5aicW4RDvP3RtLM4mS2arvUbkTEZHeeTMflo8L7LaWRuHHluQbbK3d3vYlF2Xk/xAS4wMx4q6/p5aIZiOf3NvJB60nCQVH0JRmyWHps216LT2HsUZgBtdNsVGc1/fU73k/gSGJNYjC8+PuACkw7mgSutEsuoz7jSVAvN2r8LFA1zwyvbIU65oyNQ2PH+urz4+YDp6zSFCixIwBa+9U4T2qtr+03D0gym6VGldp+Utzf/RjOTPcHpt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(6512007)(36756003)(4326008)(122000001)(38070700005)(6486002)(8936002)(38100700002)(508600001)(8676002)(71200400001)(66556008)(66476007)(82960400001)(64756008)(66946007)(66446008)(76116006)(86362001)(2616005)(2906002)(6916009)(33656002)(5660300002)(54906003)(316002)(26005)(186003)(83380400001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2ZFdlNBTzFTd0VhdHhkdjRXZEVKRmtidmZ4L1dIME90aUY4UkVFNzNiR2Nu?=
 =?utf-8?B?bVdyTXhwc2tValFCVXhzZVhBdTRqYzVLYWVjSUdkclFnVGt4c3ZsVG02Yjgy?=
 =?utf-8?B?SEpGKy9JSGNnRnZwVmdGWUNQd25ESithVmNKSmhYWk9rVUk5cFBXNDBqK1Jm?=
 =?utf-8?B?dEl6SzZUNnFBZE9mRFhvZUN4ZDhGc2xrc2FEdFVINDFZdDdIeEMyZU9lTUFq?=
 =?utf-8?B?TUFJNUZVallvZHVKTE1VMXU4VUlJSzljVmw2eHlVV2lrdmpwbzh0b1dEMmVS?=
 =?utf-8?B?RHZtNFpzUTNwZEtwYW9GODlYZVk2aGNObFh5NmhqbDBBR21ka0NVSTJpUm5W?=
 =?utf-8?B?MHVudWZkMGFXNnY0SXZIOVdBY01sdWZVcTI0bTYrdWFVWkFkUlFlL3lRVjds?=
 =?utf-8?B?Z2t1dW1JREZHZGJUSkRQZjRWRldyV2c0aEltOVpiMnJwbmpILzJaVU5ZMVE0?=
 =?utf-8?B?bVQ0UmU2czA1Yy9TbHR0MzhFOXNJNnZLTVA0a3VaQ01zc1NsNWxOaHh4dnll?=
 =?utf-8?B?Z3BWcUVOZ3dzOGNhZjNHZXllVkc4a2JwSUtvZHZIWDNZQWduTHJqNEZxL2RF?=
 =?utf-8?B?bjFMd1g5QUpPR2xIWHBZcytvMUNlbWVkZDMxcHRFRFFEaXBNWVBDQlZWSTJE?=
 =?utf-8?B?VngxM05KKzVuSFlDOFlNZS9Zc2xCQ281YlBBYzZYRmllVDFQa2YxU3B5T1Jz?=
 =?utf-8?B?WUw1azNGNXE3UVFrV2JtS2U4dmt4cGF1bWV1YWRxbUZyWW5FVUdqa3IvblNZ?=
 =?utf-8?B?N3J5b0R2bHlsbWZDRjZVSDBQYXVXUFRoNlM3NkdPR0FybDg4cHVSblJPd2FW?=
 =?utf-8?B?RzJqNk1yOGtka1NIVzJ1V2tHL0wyWXBOTjlOYmNMZ2s5NzE3SlpneW5zM3I4?=
 =?utf-8?B?VmpWTjdLTFZSTnRaZnVpSzdPM00xdVlkeER0aFA0bGhFa0MyYzkzaEdkLzI1?=
 =?utf-8?B?UWViVGFqbW05T0RoaHR2Znd0QnJDWDI5NDBHYVB5djJReEw3aG50QU5QWWFW?=
 =?utf-8?B?SFcxdjZ5WVlSdlNTQzhDOW5TYVhyRlFKdzAyc0hZTmthS1BtbVRUb1BqT3Iz?=
 =?utf-8?B?RG4rVStBeXZiaXdhR291ZTdzZ0pzNk9YblpQNG96WFl5aWx0VUx4RGNVeXRE?=
 =?utf-8?B?U2dGTjdOZ0IvNjQwYVRkbi9JOEdOZFdxa2IzQjRqYXJZNmgydlZJOC9IejVu?=
 =?utf-8?B?eVhQbUpocmN3NnVyZWVaQnN4RkxjOXQrZ2lkdm55SUtocGMrejFIOWh6b1pT?=
 =?utf-8?B?M3RqWldWZTdIa3dxUWdmZ1JUYlR2UmtLRDNCZzlIZXJySzRZZkxDTm1WelJx?=
 =?utf-8?B?dVZKNnBGL1orempLUzB5NkpvQURUZHNxc3ZHZW83MUpCYU8rNWtnNGYwY05t?=
 =?utf-8?B?dU5wUStxN2JhNHpOUEV5Q01UeGRYaGR1U0NQUTYxQ2RQZ05jQjdvMFRLZ29R?=
 =?utf-8?B?R2lWOWdXTmxseDQwR0RHdFdKdW5EeUVpVFBrdmNkQlJkZnl5dDQxcWd0YzR5?=
 =?utf-8?B?WWl5aXBPV21aMEQrdW1WdUpmaG8zcHdESDhEbGMzdmFjcU9vRVFpREFzYVQv?=
 =?utf-8?B?VjI4a1J6cVBoMUllOWZhdFcxWDRxR2hrNHI0YXp4UDIrUTBNQXM5allXZDAr?=
 =?utf-8?B?aVZ3QVJMTFpCbUxvUE1ZSG11STRlRzcvMkZYZUxZZXlHZmJGakJPSjR4WlpS?=
 =?utf-8?B?YTBRMC81aWVscmNXNVp0WUhOc3VmNUZaMHpucTQyV0twbUY5d2U4RGFHTk9r?=
 =?utf-8?B?c2xpVHlLTVMvb01OYVZjT2dTbGhsL3l0a29CYzA5ZFZpaDlLQkZibDEwREpr?=
 =?utf-8?B?Sll0RUFOL1JyYzI5NjlxNkUwSytUaVlXM0ZIa3BFUmdDSXdnVitod0FxRTdk?=
 =?utf-8?B?K3JDRENmN2hJSVBaTjJHaVl4WFRkS2FueVI0U2hHQkJtUGh5R1Urbk5SY2ts?=
 =?utf-8?B?NGVpVklnR21ObkFzVkNrVm0zcjZiTnFRRnVRazVidTc0U0J0WW1rQXlSdEgw?=
 =?utf-8?B?Ty9tWjhBaW5ROHFCTnpjaDNZenJDRFFibjF4RHEyT2JZdlNLRUdBN1lDRWVh?=
 =?utf-8?B?Qk9HbjdqdkVuaTllV3hPanhuZXBNbTFQOWZueE5Na1ZidndLL1YrZEcvM2lU?=
 =?utf-8?B?aFJacWpiVm9zOE9xYUhwQ3F6V1N6UGFQQ0lJWFJQL3FaYjZIWk5rQm9hTFBy?=
 =?utf-8?B?dWovUEJ0SjEweVdXSEFMRTZtSnBFYmVkTmNTN2xBMDNGcHJSdGEybHI5cFBq?=
 =?utf-8?Q?j1EzP/Z788aX13NE1R8f1KltCksVdI5oqYyBuJntdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE7D513E501C0449C5244AEE3DD5214@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296e1663-020b-44a0-2b29-08d9c507b8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 04:58:40.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWNUJrowfZqVp/NkIQ3zlBPsFpTX8wMht4MZF9CPt3pRHI7iuakRnosL/GVxN0FLohqHfP0ghq2QhwYJHJNeE1H/bJFoUnuVOC0al2o6oz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGVjIDE3LCAyMDIxLCBhdCAwNzo0MiwgUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IEZpcnN0LCBJIHdvdWxkIGNoYW5nZSB0aGUgc3ViamVjdCB0
byAieDg2L1BNL2tleWxvY2tlcjogUmVzdG9yZQ0KPiBpbnRlcm5hbCB3cmFwcGluZyBrZXkgb24g
cmVzdW1lIGZyb20gQUNQSSBTMy9TNCIuDQo+IA0KPiBPbiBUdWUsIERlYyAxNCwgMjAyMSBhdCAy
OjAwIEFNIENoYW5nIFMuIEJhZSA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+
IA0KPj4gV2hlbiB0aGUgc3lzdGVtIHN0YXRlIHN3aXRjaGVzIHRvIHRoZXNlIHNsZWVwIHN0YXRl
cywgdGhlIGludGVybmFsDQo+PiB3cmFwcGluZyBrZXkgZ2V0cyByZXNldCBpbiB0aGUgQ1BVIHN0
YXRlLg0KPiANCj4gQW5kIGhlcmUgSSB3b3VsZCBzYXkNCj4gDQo+ICJXaGVuIHRoZSBzeXN0ZW0g
ZW50ZXJzIHRoZSBBQ1BJIFMzIG9yIFM0IHNsZWVwIHN0YXRlLCB0aGUgaW50ZXJuYWwNCj4gd3Jh
cHBpbmcga2V5IGlzIGRpc2NhcmRlZC7igJ0NCj4gDQoNCjxzbmlwPg0KDQo+PiAvKioNCj4+ICAq
IHNldHVwX2tleWxvY2tlciAtIEVuYWJsZSB0aGUgZmVhdHVyZS4NCj4+ICAqIEBjOiAgICAgICAg
IEEgcG9pbnRlciB0byBzdHJ1Y3QgY3B1aW5mb194ODYNCj4+IEBAIC00OSw2ICs4Nyw3IEBAIHZv
aWQgX19yZWYgc2V0dXBfa2V5bG9ja2VyKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4+IA0KPj4g
ICAgICAgIGlmIChjID09ICZib290X2NwdV9kYXRhKSB7DQo+PiAgICAgICAgICAgICAgICB1MzIg
ZWF4LCBlYngsIGVjeCwgZWR4Ow0KPj4gKyAgICAgICAgICAgICAgIGJvb2wgYmFja3VwX2F2YWls
YWJsZTsNCj4+IA0KPj4gICAgICAgICAgICAgICAgY3B1aWRfY291bnQoS0VZTE9DS0VSX0NQVUlE
LCAwLCAmZWF4LCAmZWJ4LCAmZWN4LCAmZWR4KTsNCj4+ICAgICAgICAgICAgICAgIC8qDQo+PiBA
QCAtNjIsMTAgKzEwMSw0OSBAQCB2b2lkIF9fcmVmIHNldHVwX2tleWxvY2tlcihzdHJ1Y3QgY3B1
aW5mb194ODYgKmMpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZGlzYWJsZTsNCj4+
ICAgICAgICAgICAgICAgIH0NCj4+IA0KPj4gKyAgICAgICAgICAgICAgIGJhY2t1cF9hdmFpbGFi
bGUgPSAoZWJ4ICYgS0VZTE9DS0VSX0NQVUlEX0VCWF9CQUNLVVApID8gdHJ1ZSA6IGZhbHNlOw0K
PiANCj4gV2h5IG5vdA0KPiANCj4gYmFja3VwX2F2YWlsYWJsZSA9ICEhKGVieCAmIEtFWUxPQ0tF
Ul9DUFVJRF9FQlhfQkFDS1VQKTsNCj4gDQo+IEFwYXJ0IGZyb20gdGhpcyBpdCBsb29rcyBPSywg
c28gd2l0aCB0aGUgYWJvdmUgYWRkcmVzc2VkLCBwbGVhc2UgZmVlbA0KPiBmcmVlIHRvIGFkZA0K
PiANCj4gQWNrZWQtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbT4NCj4gDQo+IHRvIHRoaXMgcGF0Y2guDQoNClRoYW5rcyBSYWZhZWwhIFdpbGwgZG8uDQoN
CkNoYW5n
