Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1832E4A4FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377809AbiAaT5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:57:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:34052 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377744AbiAaT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643659021; x=1675195021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PEh2GfGU6ba7NsS+IzPHT/tImFIkATqyNBBnMI+CxVc=;
  b=QfpZf9IZioCssuIXFEsc8LVFI8B5kRf31XPznHkMv9uW3dC6mVyoJnlP
   3EtHtm1PsVhByAa+iZtKwuW57fVv10d9SYg7J4rtEye10Cpk5uy5p6FvX
   fcoQIp8zHZzGMWdHlcWKCxZLrDem4fOPiOE9a148cKeqZ2OTQTL1efHBJ
   VRMZywt+hfILd9OGlHNu+901KjLFeT++yp7Rj6S7tfzS66w/1zfyoi0Yq
   tuUHWyJfIhDNkKAbWhQOOCxjDdPWf1ug3Vpsist1IWtEiK855AUybAGAF
   rZN0mrfFdepsjbX9Tt3U5m9pxanGY+VsGAK9AOtgMwVdVY6GJDGv6qPZg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="272012545"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="272012545"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 11:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="537461064"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2022 11:57:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:57:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 11:56:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 11:56:59 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 11:56:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrhaHUYlXV4jKEboFcdIi4nEe8jS2Hu6cT0b8w2JJSmszbuPiEFBzj3eHo5KrObkB9+J4KazgpbvdEl2XiumjKp0cVQuZmeUeamAyrKcc7baq6CBjlFc0c9EwfOgAXZWMpqpIshz1YkIxCxE8s5uu1KiRYWK8u38oLexDv1/k8PRosSlC7C8+/hK0jNve9SLMl+9x2qL1E+/b/uuKBTzj4rMl+xxyWa65rZLgqYMDeVrDhLxAY3hxW2ZYxRgPb/2dWH8f/5oV+QoifVUP9vuewfrfWp9y4Q+VJpHpV4mX752pK9FkpnvOY3e/dXGNvWrGq36EKMkMqkV7if6r+MDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEh2GfGU6ba7NsS+IzPHT/tImFIkATqyNBBnMI+CxVc=;
 b=NF9ayd8CqrR/RrdKrOec5bLfG1lZH8MAcCMxGYdC4BMydGe8s9TqryDVW6jnV9MlsFWzoiGAFXEWydwgYw9KQ11WoG/6VDDVgsezMbefohHBwLDkNukKSjqpFkYi0hcHuUOaKMUYwYYTLhptiMrWX9H8i4n7RFm1idGHziJGSUGtmH+cZEve9DDqj3FVIZaq2lc2529Ooz66VuBdqzGInRU831/4+Dfv88GicJcA1jeCtshqZdr8M1xZPutMxtpMwIFzxNePGCdzLF2g906zsf5S+sGopkFn4NfTFvz7c6aLP1nuBqMTqigWJZ8kJM0v2Vcai8CHX4K2/Dzi94UhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR1101MB2352.namprd11.prod.outlook.com (2603:10b6:300:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 19:56:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 19:56:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 18/44] x86/fault: Add a PKS test fault hook
Thread-Topic: [PATCH V8 18/44] x86/fault: Add a PKS test fault hook
Thread-Index: AQHYE6cROjXh+oF8jUWxTGWn2bpK1ax9khcA
Date:   Mon, 31 Jan 2022 19:56:57 +0000
Message-ID: <2a7b0a94ea52952927c29bfc32f0085cbdfe5747.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-19-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-19-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cb53690-e109-452d-bb90-08d9e4f3d660
x-ms-traffictypediagnostic: MWHPR1101MB2352:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <MWHPR1101MB235207F580F732FD4C9D408DC9259@MWHPR1101MB2352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1ztQebxviQMvmyEGNMn9e95wtdWy7Mk3PXq2GODYcHDvcEFGAkQPniAwd8fsa6W7ZSHD27ySvqwC9JEuyhsV6ZeQKu/BB79xO2/0vNopzYatzB0ck1SrN2j4GQ9EWkVFtdfl5pRLRsB9mgAR1L38isA+3o3IE2w6unRV+ABDcJ7WiQHm23m+gpOyul7cz5bFxOaAFiQbLIDKcBc6CieHhLfJT8TMwCRaPWsC+x6gC+w6RW1Ib74FgLJg48sol2RrlHLzmuQFuLWkF+0x3vBnE5mNFMXVkxb5sAl2vb0HS/EkPWeedGFIA4pZAWTElr8KSx0iDxEnqjbMYYx/HzsfaozjadJJbjPzKzgwxTadRIOIfNmJlESwytTTpOzGdBoXUZtmBePqBTbcPXY0agApZ/B0bFr59ybQFvmyciT7q82wEgjqjv6Xf36ygZS9lXa/ewchlN2gnXINd1YqmUvxmf5ZWs2yrMuqox3lSBBj80GfKOylBClLQXx8urOPWMUyg4Icp8C7tQZ7iRxgrEBaRkN1zjZ+WOuZYbflz8Q3kAYs/FBFNK7DZhIKBg9Y8HpAfyQuTz4OezylY/U3Cp3zbv+dJgun751/kC4vpcZmT6Q3IQFeCEjwIeG6ShQP0itfT9+BPZ1GAH3LJpeI0EEH0+Ezzh1B1tTFxGHzbWVlIt5po0WH8V9naFvQ9l98f2ZTTJa0XbqhS08ufSQ1vIg/9XDHxLprw7DPLnahi3X0pU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66946007)(26005)(76116006)(66446008)(66476007)(64756008)(38070700005)(38100700002)(36756003)(66556008)(6506007)(122000001)(71200400001)(82960400001)(5660300002)(86362001)(508600001)(54906003)(186003)(6486002)(316002)(4744005)(110136005)(2906002)(4326008)(6512007)(8936002)(8676002)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjIrTlNFdUxvbWw4M003UXNhRjdHMjA2cWZrYVpRUEtQRkJTWkc0VUJXVjRV?=
 =?utf-8?B?Z3N3VkZ2UnlDQ1VoME5lR1ZSaGtVVk9uOHllOHI4M0xqcHFvTGs1UXNIcG50?=
 =?utf-8?B?bWhYTFJwRXJJMm9CYTZ0RnFCTFFBZHc3cmFncW1yWEZUWFIvb0JSQUkzOExG?=
 =?utf-8?B?cHFpSXFyM05INC9paEdZanYrTVdrcVNZeWV3eWcvbEdRdW43ZmdxR3Z5ajZp?=
 =?utf-8?B?T2g3SGZyWnVmeThyMThSMUw2QlByTGJJRllsSUFMM0NEdlJqRlk3QXZ4RnVl?=
 =?utf-8?B?OTgvNFJ3SmxObXlnNkczZ3prZ0pXaExCMThoY2hkdFM1ditIajJvbEllL3A5?=
 =?utf-8?B?c0J6dlNBMGpCMEtKU251eWtseUJNTmlDQjhkU1pIR1JqWStRTW1QWmJ5Qk5J?=
 =?utf-8?B?UTJIcm8rNVNjL010bGZUOHNHelRaMHQ5OHFCVnJyUXhJU3hCaFR6ZWgyUEJo?=
 =?utf-8?B?NXB3YmhvR2QrTlF6NDIrY0ZIb2VGdkZPUy9UbndST0EydmhtMlRJSnYzZzFE?=
 =?utf-8?B?bENleGdBRVZSQ212Z1ViN1hWMjRIWFZieTMrb0l5ZDZSMXRsQjFVSGVRcFV3?=
 =?utf-8?B?QzY2bTVMTmIxU2JGSE1zZGE5bFlwTzJqQXl1OEFBOFhsQk41MzFMWTlSRlFT?=
 =?utf-8?B?RmE3ZlNWM2Yva3VoeEJIeTlqU1lnMlFPMHBmYVNNWWlXUUViNUx1NWpCVHB3?=
 =?utf-8?B?bkJQRDU1L3pDRlRTelZaM1VRNG1VdnNld2R6ZWc5NWRRbHR1OUVzRkRIeHRL?=
 =?utf-8?B?TzBrWjVNTWVsTjlIaHZCM1phTFpyS0tSQ1RsbUZiajJwSG5OR2xpQlJWTDdI?=
 =?utf-8?B?RDR6Y3I4TU11V1VubytJcG9nRGRuS2sweWVPclVOalRpR0RCWW5Ub3o2Y3c1?=
 =?utf-8?B?U05LZDZKZCtjWWtqbWttcEZhc3lzVUczZDJ6Q0haTXVscUtRVVpNb0RBQ0pv?=
 =?utf-8?B?M24wVW1jSHJ5Nm51OEJvTEFZMndFeGtKUGZ0NU1udkRVRXNwV3NIN0drNCtl?=
 =?utf-8?B?aCs5ZXpnenJuYTgrbHdCVVJPSUJpc2p2MG9jUExMNDljZVVlN1Z4Uldvazkx?=
 =?utf-8?B?b2NWVXB3U3JOeXZPZlBMdzhDeW85ZUxtTVZVODIxeEFucjR0SUR6ejJKcHlT?=
 =?utf-8?B?NW0xelZBVnltYzFYS0ZuZW9LQUFmS3BBRjZtQmRrb3ptdDBXN2tzZUo2SHVs?=
 =?utf-8?B?Z0lpWHBMazE2ZlRDcGxud05YUlF6L0lBMWVPQTJKQWxMYmVTdCtib0FvcHZm?=
 =?utf-8?B?ajQ3alkzT3RtQmxQUVlodTNhZGhnTzBvdEEvTmNCVTRpYjVOVzM2WTJqQU9G?=
 =?utf-8?B?WWM2WllaYzFQVFBYNlc5QmkxSHlKRFdvN2VTRnh1MkNIcThkTzVTWjNuVjB2?=
 =?utf-8?B?T01BemozWTEwbGtYZ0NhMHYyNGN0eFJrY3N4b24rL1RqK3pzSUxaSXRtZnVs?=
 =?utf-8?B?c2tLQTREMmRMRjFTTDU2ZUZhR21rQTZLeE1HWnJ6VlZ1cUZ2SXVKZ290T3d4?=
 =?utf-8?B?aHZ5U1FUQzc1S25qa3lYNVBwZVp3WDRDYzhIK1RGMmgxUlFzQ1Z0dW9obkNm?=
 =?utf-8?B?Z0pMNWd3ZlJKLzc1VzR4NTN0OEZZekVpek9aWDlMTDhXYUlPWXlnM1VIVzl4?=
 =?utf-8?B?WUJEUExwdU1ncmErblR0bDcvNytXMk1FeTg4WnI5YXkvekFzL3NESFYwamwx?=
 =?utf-8?B?R2lheG1nU1FGMGptTzNQY05lTzRTOW1hWExDbnBYa01vSEQza3Jxd0tKcVp0?=
 =?utf-8?B?MWYvNy9VWGkyYVZQZEI3Wk9sZGR3S0J4SHNjQ1JyU25XU2szSlE3TWdyOGlp?=
 =?utf-8?B?cFNOa2hhL1lSMlNvazhJc09Ya1hRcWhJclVka1d2aTdWRUs0cE4wYzd1SkVo?=
 =?utf-8?B?ZWV4UnlpRDZydDVpU2pGdXpvMmplNnhzUzl3N1V5R081eFd1WWIyejZ6MnZm?=
 =?utf-8?B?eXJBUmY0alFEVHorcUVTSlQyNXYzQUxuS2JOellYdXF1aU5ZeEFLMStjb1hw?=
 =?utf-8?B?NkhpTmZUVENUUVE2YnBSR255ZFhVbFU1R2tlRUdvMkRiODd3aUhiNVNNL2o0?=
 =?utf-8?B?L2RCSGxhdVhEa25nWktKQU85akttRWxuQnRYTkY3a0czak5PN2VsOGdMbHl2?=
 =?utf-8?B?OVRPMU9wYVpGWjErMlBTcHFZVkMwMmw5TnIrWnlJcmJNSXR6cktLbWYwM0l4?=
 =?utf-8?B?NDZ1ZHNWbitFakVYUm82TzNXeVk1d1NuVHhoNG9XOEtqTjhYdnpjRE03RzdT?=
 =?utf-8?Q?ZyLVIoYrEIB+Jn2fZSb1IFwy4V6pZd1e5FBsK0CHSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDCEDD88279BB4295A3CC562FFBC791@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb53690-e109-452d-bb90-08d9e4f3d660
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 19:56:57.3704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3KYJetEjeBnA2IUILNMJ42QuqLs6tR3oovZlwD6+cXv0rilWTp+xEOtA72OTaWAE1VtuC8N2bU9UIlIOBIsEZtgf8vfhARjHPqTLZmmh84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2352
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArICAgICAgICAgICAgICAgICogSWYgYSBwcm90ZWN0aW9uIGtleSBleGNlcHRpb24g
b2NjdXJzIGl0IGNvdWxkIGJlDQo+IGJlY2F1c2UgYSBQS1MgdGVzdA0KPiArICAgICAgICAgICAg
ICAgICogaXMgcnVubmluZy4gIElmIHNvLCBwa3NfdGVzdF9jYWxsYmFjaygpIHdpbGwgY2xlYXIN
Cj4gdGhlIHByb3RlY3Rpb24NCj4gKyAgICAgICAgICAgICAgICAqIG1lY2hhbmlzbSBhbmQgcmV0
dXJuIHRydWUgdG8gaW5kaWNhdGUgdGhlIGZhdWx0DQo+IHdhcyBoYW5kbGVkLg0KPiArICAgICAg
ICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICBpZiAocGtzX3Rlc3RfY2FsbGJhY2soKSkN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KDQpXaHkgZG8gd2UgbmVlZCBib3Ro
IHRoaXMgYW5kIHBrc19oYW5kbGVfa2V5X2ZhdWx0KCk/DQo=
