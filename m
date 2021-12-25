Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446D47F2AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 09:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhLYIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 03:39:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:26646 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLYIjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 03:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640421592; x=1671957592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E3/HdW5PezqT5xsCvaUZAHLcsd1Vg4u/HzOWYqkpdhg=;
  b=bE5uWGI52CsWwUGhvNh2bnJkov/RnrKCYT45jbfRILCE7ulFz5U3cI59
   ih4J8SQR2od1kZy0o8KtZe0azQxyRToUc8GkKEQJdlIupTSBzi+e+3x0D
   iVDaJDq2Chsn0jKNPfnKuMVdFFGg41ccDGuRmJdI2Hngm1Hr36KOW/pyc
   MnmKKLZEif2aUcUnY8vpc7PuyXvsEfD5ZFXfnC5oGDw+CH3+j0LHP+HBv
   k8igFRKGbhcOqZLwPZxhl3PPV0upJJIuRwH2gImjkxuHahd5T6CnJwQP1
   k0Vcy4p+49cP3BBsQDBRrsmAWH/gLH45a33SXZK3M/9OhRjZGZXp2wvKL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="327360500"
X-IronPort-AV: E=Sophos;i="5.88,234,1635231600"; 
   d="scan'208";a="327360500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 00:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,234,1635231600"; 
   d="scan'208";a="467419529"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 25 Dec 2021 00:39:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 00:39:51 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 00:39:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 25 Dec 2021 00:39:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 25 Dec 2021 00:39:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYdwqjWg061xuv+6ZWXXTeYOx9d0Q9vNujP168vtrX3dotunB1ANmo1Ajellg24ivkFnoxIMeFjfSzgVlCtMzwzbb++aPp04Sk84/KWNFjoB+3A6iyygdf0FQrzE6Qe7mR8hnAvu227T75I6uxkI9BZVE2DbosMHSm9bAwcBb87/ztmlOz48chf3yBqH7swer0H/dvf61q+HDXqt8mm1WAUtjz6sewxtSe7Mq+Ix0OJPf0zWE6R+6aoRfm941KmnnqvZT/Jyu0IqLK+4foA1Uv+qEw3LvPbAS+C0/ZfvjxGQopXSILKkO/YxT/V6pY1wCQMd3BhJxSpjbi0Z3RbQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3/HdW5PezqT5xsCvaUZAHLcsd1Vg4u/HzOWYqkpdhg=;
 b=GCbzQjb2U0+AWcJqCOfDTer7lF1Y6DSJtZPqmKmEDAR2vmKK2Gw650F1qWzZr53i2UvCMWYbapozc3ZQB9hde7gGSMn5EujrpJn9NcSVYLXs/wEVR46StQROQ6WuEB2/l2dhLQ6D+R/DF9k8ngxCQKBXP/QiYIZWjTXAT3kAPB49lFHhnPpyZRKgLSjLiz+7l9Sj8rHa59NaGaRLKWejhOhv6S/8PqSuRCm2xwUVmPNEGTOWuQduM/luaFUXN+9SxoMfG6NWsOz+tBFKYy0qU6/rv6p9YEmOdJJtWgvJpkRZ5c6kyGcnpq3vQCHrTLLZcPqJezygtlUxIrSQi5NSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Sat, 25 Dec
 2021 08:39:50 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f%3]) with mapi id 15.20.4823.021; Sat, 25 Dec 2021
 08:39:49 +0000
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
Thread-Index: AQHX9wklU1gLrruOXkWZebdL9hbjzaxAL9KAgADIffCAAIURgIABV2sA
Date:   Sat, 25 Dec 2021 08:39:49 +0000
Message-ID: <PH0PR11MB5880B73436ADB3B8216C045DDA409@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
 <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
 <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CANpmjNPU9Yw3RtsSrn0ZfdKQ7XUEp-Ecu9Wcx4HGhH3D+6-CrQ@mail.gmail.com>
In-Reply-To: <CANpmjNPU9Yw3RtsSrn0ZfdKQ7XUEp-Ecu9Wcx4HGhH3D+6-CrQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 8257209a-3300-468c-b91f-08d9c7821d33
x-ms-traffictypediagnostic: PH0PR11MB5783:EE_
x-microsoft-antispam-prvs: <PH0PR11MB57830EA1D328C3B7149270AADA409@PH0PR11MB5783.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwV1vtoHjRNwBZF0rgJhiUn1sKq5MFOFV04yprVXApyVI8YVFfMP9CradURi/KHFXeBJOo2WroLrBrRCngCQQuWM+9PLfsIVydI6mOAV4csfLUtuZDs/xDASgeotEgrYx/XXppBBqDheoIymZezH6+nSRqqCh0I0IRKHZGCTPcIuhFez+UVeZiDzFSRaceNZ8tHhT2alVDhrImlz8ZboI2VyRAXBaqu8vZickrBhQISz+pIRxyOHFJ+65wfW/95mVQy7ZR1ka/to7MUVsfoZswNTUbii/e05HEYT6ofF8maESB1bS6JCxCxOAYdYqL2iXwMX6kp+pAYihEiAEkdGYXe8ZdlZ9dNuvqBItT7EVccCdaydU1bnStKOHJxizKK7SnIIA7qHGHUj4UyAkj6V4jiWWgVLrLXusTRMUjUnSagYJ6M4Mx9MxSOGqJVkNNmJRZ7y9NKUtZj3nxvjw3GPl6+jgVsStiSGpPKE9IOaXIMg+xzF/KJ580ZhSaChIIOMwJIOW+jID+HCj5hMrU3foQ2/mdD9As+SvhqYNB33abD5kpLqnaQmwRU7md0+7EvoOyqHW7wJbPRdM1p3A+DoFIJjCFeNiNONq8+ZmA8UnqeRvWUO0w3nLTBnUEYHK24hjDfClVBG/ZVoYWKquIWP5mZ1zo6hLQXT3FuttJrYOdaJIao1Cy0BvBCF3Fn8BLNa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66446008)(66946007)(55016003)(64756008)(8676002)(66556008)(4326008)(316002)(86362001)(82960400001)(38070700005)(8936002)(33656002)(76116006)(5660300002)(54906003)(71200400001)(52536014)(186003)(7696005)(26005)(9686003)(508600001)(122000001)(38100700002)(83380400001)(66574015)(6916009)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVA0ZW52VzJGWVJTazkybEFlM2pnVUhXWlhqMjZZTGhURitoQVRSR1R0OVc4?=
 =?utf-8?B?bG1UcFpxQU5paGJGaVJydFlQUHJJRWNpMTZqWVBkNWw2KzhIVmFEYTlnWmRr?=
 =?utf-8?B?cWFHZHMvZmtiWFBSdTY3RXhWcFBKU2s2TTdGVmM2YVZidUYyN3cyMHhYcDVS?=
 =?utf-8?B?NmF5YVJmNklwQ05wb0xxWmxYTVFCNC9OL2N2YjRCL0ltNUlKRDcxYTUydnlB?=
 =?utf-8?B?YlJhUDQ0MGVMUGRlcHRLRGc2blNrcFBBb3FpNVJhVlpjKzI4TUc0ZjZFNXhu?=
 =?utf-8?B?SkQ5dzdGV1pITFZFbnd5eDczUzhyT0ljTU5mWU5CQU90S0czZHFDc2xxYjV5?=
 =?utf-8?B?RVZ4THJrbWY2RHZURHB5dHlCM3paTzI4V2pvWVRtTHhvTVhwajBKRjd2clh3?=
 =?utf-8?B?NDR4QmZqcVh0SWhyNjJqUjk1QnpEZ1pxemZnUndyeWVrUVdUNkVOR2VvMTF4?=
 =?utf-8?B?cHJBakJDRHpOVjBwNFhkaEs4WVBYUkVXR2xURmFvdEU5Z2pRT0U5dkVla2pL?=
 =?utf-8?B?dlBYcDFMbUVqTUxFVm42YTVVOVVRYzl1ZWxzTDhwemZQb0FzVXJkMTlrZjlK?=
 =?utf-8?B?VklmdllKODFGU21GMUgyN3BsclNDTnJMS2RxZG5IZU1lZXhEVnBZeEVFaXJW?=
 =?utf-8?B?M0FsRkxuNUJyc3pYTE42ZGYzVVg2eWkzNWhWYW9ieDVSbE56NktvUHFRN0k4?=
 =?utf-8?B?ZnduSHBtU0hvL2hqQ2dyZVVCMHBFK0xvVlZKNURCQ3JxOENvNis1ZHF6alJW?=
 =?utf-8?B?K3pFaXhqUXJhOHFsdFBneU9qQ1ozT3dRVXlYVFNjelRObEtmSExQWnA2NTU1?=
 =?utf-8?B?QzFDRThSNWs5SWJoNE1RN3d4bk5SOGNVVlBVVWZrQ0ZPVG1oaUxCWkZja3Ja?=
 =?utf-8?B?cmVyZncwbW1yUzVUUGNLMDRndTd0MEE4eXhUT00xYkczcGdrRmpRK29mbUdG?=
 =?utf-8?B?UDdhQ3l5bnpGVWR5UlkyMXpnbjUrbDk1cjJ1dW5vWElzVnZCSDhCd0xEaFl1?=
 =?utf-8?B?VVArUFF5ZTJHTFpOUkM1SklvejhUUExBT3ZFU1F2ZHVrVUxBOFpLWmNtYWlM?=
 =?utf-8?B?cFRkeU5ZeGVTdFZQV1lSOXIxWHllRU91TDd4Um9heFBVMGxFWUEwa3p4NHlQ?=
 =?utf-8?B?clhadnlDcWFDQi9nRkY0ZFRxcG5zakhCVnMvaHNwWHEzWlM1V2FYbndveGp1?=
 =?utf-8?B?d3BQTmk3WW1sb0greWdLVk5PVEZYZ21TWURIelBOVU5BL2RlVUVLTUcrOHl5?=
 =?utf-8?B?ZmcyaS94NUhvNFByUVIxcDBGVVVUR1luRnozdmRrdys1cW94cGN2TEVLUStv?=
 =?utf-8?B?RllTdjhTUWlRSHdudFREZHdRWFdTdkZuRElHNTZiVWw5UjNwTExSSWNSZEIy?=
 =?utf-8?B?QTdxOXNIaXRGMzRtV1FIN2JTTThwWDdrRkk0SzRmT2NjT3hxbnFwNXN3ZU9P?=
 =?utf-8?B?TzNRU2VIWmhPaDY2M3JtVXpWTlVjd1VIL3lDS25uVXltQ2h3Q0JqWFdmUEhW?=
 =?utf-8?B?QlM0L3NqQk9ubjFEZGJpWDg5VVQ0TVpRM2xvUzdIK0RoNFNrbWFIRGkrVEVh?=
 =?utf-8?B?V2g5S2c4YmszdThROWtaZExLcHdYaWVPbU96bzQ2RnNibS9UNHc5Y3JTT3Rw?=
 =?utf-8?B?VUxrN3RWNDA0Z08wTFd3WE9nTWFaa3VaaS9vQW4reU1rK0NYTk5OSlZzOGVj?=
 =?utf-8?B?NWEvSTBhSGlobmp4K0toOWhSYlJTbk11L01EYlRNZnJnYlBGZ08xbHp0L0tY?=
 =?utf-8?B?VTlBZFVuRHBZVVlxc214M2VwcXhPbmVUcEYwdUVrSFRrTkNjcDFjSHNCSVlo?=
 =?utf-8?B?MG0wUnYxckpBcnBycEJPWHJTRExTNmZxcGpBYjJ2VmlnYjI2RXBHcG9ZUE1h?=
 =?utf-8?B?V0VzaE9zTFN4N3JrZzlHN1RRbG5QWXBzWXRFZVkzWmN5ZGhNSjJvQUJ0RGgy?=
 =?utf-8?B?U1hyTnVYSndNQ3VVS0FFSlViYVAwREJVZWozc0IrUno2R2RTRjBnR3QwSnBP?=
 =?utf-8?B?M3gvR25aZ0Yvd0trRk5uZVhzSHVqTmdpalVDM0I4V09lK2l5NEQ4SmlpQjQ0?=
 =?utf-8?B?YkZ0MFFveitVZjRnSnNuQ3JwK1MyTUhDQ2lxaG9Eb2IvM2RZK0ZabGlvTk9Q?=
 =?utf-8?B?ajBWeHZ2TkNveVlOdUx4TmpZcmN1YlpYT1VJSHY2Uk14eGp5bkNvaDkzSGdI?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8257209a-3300-468c-b91f-08d9c7821d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2021 08:39:49.8303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEEFfojaPf4nEUhb6Es3Wo+aRFi3+84s+h/1Kh/KHDOWhbHM5uJkK9wd2RR/b/Hw03rDNCPj6c4BVFW1HlrBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiBPbiBXZWQsIDIyIERlYyAyMDIxIGF0IDA4OjU0LCBacWlhbmcgPHFpYW5nMS56aGFuZ0Bp
bnRlbC5jb20+IHdyb3RlOg0KPiA+IFRoZSBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrX25vYWxsb2Mo
KSBvbmx5IHJlY29yZCBzdGFjaywgaXQgZG9lc24ndCANCj4gPiBuZWVkIHRvIGJlIGNhbGxlZCBp
biBsb2NhbF9pcnFfc2F2ZSgpL3Jlc3RvcmUoKSBjcml0aWNhbCBhcmVhLCBhbmQgDQo+ID4gdGhl
IGdsb2JhbCBzcGlubG9jayAoZGVwb3RfbG9jaykgd2lsbCBiZSBhY3F1aXJlZCBpbiB0aGlzIGZ1
bmN0aW9uLCANCj4gPiBXaGVuIGVuYWJsZSBrYXNhbiBzdGFjaywgbG9ja2luZyBjb250ZW50aW9u
IG1heSBpbmNyZWFzZSB0aGUgdGltZSBpbiB0aGUgY3JpdGljYWwgYXJlYS4NCj4gPg0KPiA+SSB0
aGluayB0aGUgY2hhbmdlIGl0c2VsZiBpcyBoYXJtbGVzcywgYmVjYXVzZQ0KPiA+a2FzYW5fcmVj
b3JkX2F1eF9zdGFja19ub2FsbG9jKCkgZG9lc24ndCBjYXJlIGlmIGludGVycnVwdHMgYXJlIGVu
YWJsZWQgb3Igbm90IHdoZW4gY2FsbGVkLCBidXQgdGhlIGp1c3RpZmljYXRpb24gaXNuJ3QgY2xl
YXIgdG8gbWUuDQo+ID4NCj4gPldoYXQgImxvY2tpbmcgY29udGVudGlvbiIgYXJlIHlvdSBzcGVh
a2luZyBhYm91dD8gWW91J3JlIG1vdmluZyBhDQo+ID5sb2NhbF9pcnFfc2F2ZSgpIHdoaWNoIGRp
c2FibGVzIGludGVycnVwdHMuIFllcywgaXQgbWlnaHQgYmUgbmljZSB0byByZWR1Y2UgdGhlIHRp
bWUgaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQsIGJ1dCBpbiB0aGlzIGNhc2UgdGhlIGJlbmVmaXQg
KGlmIGFueSkgaXNuJ3QgY2xlYXIgYXQgYWxsLCBhbHNvIGJlY2F1c2UgdGhpcyBvbmx5IGJlbmVm
aXRzIG5vbi1wcm9kdWN0aW9uIEtBU0FOIGtlcm5lbHMuDQo+ID4NCj4gPkNhbiB5b3UgcHJvdmlk
ZSBiZXR0ZXIganVzdGlmaWNhdGlvbj8gRGlkIHlvdSBlbmNvdW50ZXIgYSBzcGVjaWZpYyBwcm9i
bGVtLCBtYXliZSB0b2dldGhlciB3aXRoIGRhdGE/DQo+ID4NCj4NCj4gVGhhbmtzIGZvciByZXBs
eSwgWWVzLCB0aGlzIG9ubHkgYmVuZWZpdHMgbm9uLXByb2R1Y3Rpb24gS0FTQU4ga2VybmVsLiAg
DQo+IEluIEtBU0FOIGtlcm5lbCwgdGhlcmUgbWF5IGJlIGEgbG90IG9mIGNhbGwgc3RhY2sgcmVj
b3JkZWQsIGluIA0KPiBhZGRpdGlvbiB0byBsb2NraW5nIGNvbXBldGl0aW9uLCB0aGUgZmluZF9z
dGFjaygpICB3aWxsIGFsc28gdGFrZSBhIGxvbmcgdGltZS4NCj4NCj5CdXQgdGhlcmUncyBubyBs
b2NraW5nIGhlcmUsIGl0J3MgZGlzYWJsaW5nIGludGVycnVwdHMuIFllcywgYSBsb2NrIGlzIHRh
a2VuIGluc2lkZSBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrX25vYWxsb2MoKSwgYnV0IHRoYXQncyBu
b3Qgb25lIHlvdSBjYW4gZG8gbXVjaCBhYm91dC4NCg0KPkkgZG9uJ3QgbWluZCB0aGlzIHBhdGNo
LCBidXQgSSB0aGluayB0aGVyZSBtaWdodCBiZSBzb21lIGNvbmZ1c2lvbi4gQSBiZXR0ZXIgZXhw
bGFuYXRpb24gKGluIGNvbW1pdCBtZXNzYWdlIG9yIG90aGVyd2lzZSkgd291bGQgaGVscCBtYWtl
IHN1cmUgd2UncmUgbm90IHRhbGtpbmcgYWJvdXQgZGlmZmVyZW50IHRoaW5ncy4NCg0KSGkgTWFy
Y28sIEFyZSB0aGUgZm9sbG93aW5nIG1vZGlmaWNhdGlvbnMgY2xlYXIgdG8geW91Pw0KDQpTdWJq
ZWN0OiBbUEFUQ0hdIHJjdTogUmVkdWNlIHRoZSBjb25zdW1wdGlvbiB0aW1lIG9mDQogbG9jYWxf
aXJxX3NhdmUoKS9yZXN0b3JlKCkgY3JpdGljYWwgYXJlYQ0KDQpJbiBub24tcHJvZHVjdGlvbiBL
QVNBTiBrZXJuZWwsIGEgbGFyZ2UgbnVtYmVyIG9mIGNhbGwgc3RhY2tzIGFyZSByZWNvcmRlZCwN
Cml0IHRha2VzIHNvbWUgdGltZSB0byBhY3F1aXJlIHRoZSBnbG9iYWwgc3BpbmxvY2soZGVwb3Rf
bG9jaykgaW5zaWRlDQprYXNhbl9yZWNvcmRfYXV4X3N0YWNrX25vYWxsb2MoKSwgaW5jcmVhc2Vk
IGludGVycnVwdHMgZGlzYWJsZSB0aW1lLA0Ka2FzYW5fcmVjb3JkX2F1eF9zdGFja19ub2FsbG9j
KCkgZG9lc24ndCBjYXJlIGlmIGludGVycnVwdHMgYXJlIGVuYWJsZWQgb3INCm5vdCB3aGVuIGNh
bGxlZCwgc28gbW92ZSBpdCBvdXRzaWRlIHRoZSBjcml0aWNhbCBhcmVhLg0KDQpTaWduZWQtb2Zm
LWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQotLS0NCiBrZXJuZWwvcmN1L3Ry
ZWUuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMN
CmluZGV4IDliNThiYWUwNTI3YS4uMzZiZDNmOWU1N2IzIDEwMDY0NA0KLS0tIGEva2VybmVsL3Jj
dS90cmVlLmMNCisrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQpAQCAtMzA2OCw4ICszMDY4LDggQEAg
dm9pZCBjYWxsX3JjdShzdHJ1Y3QgcmN1X2hlYWQgKmhlYWQsIHJjdV9jYWxsYmFja190IGZ1bmMp
DQogICAgICAgIH0NCiAgICAgICAgaGVhZC0+ZnVuYyA9IGZ1bmM7DQogICAgICAgIGhlYWQtPm5l
eHQgPSBOVUxMOw0KLSAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQogICAgICAgIGthc2Fu
X3JlY29yZF9hdXhfc3RhY2tfbm9hbGxvYyhoZWFkKTsNCisgICAgICAgbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOw0KICAgICAgICByZHAgPSB0aGlzX2NwdV9wdHIoJnJjdV9kYXRhKTsNCg0KVGhhbmtz
LA0KWnFpYW5nDQo=
