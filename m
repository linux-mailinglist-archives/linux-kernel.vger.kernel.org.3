Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B587547EAD3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351130AbhLXDXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:23:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:36655 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234131AbhLXDXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640316180; x=1671852180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ixhb9/FU51a53W4bLTW/58ZtHd5BGVJX18kNSRCKYjE=;
  b=X8/s/nIvUUpnstFJVty0Rd0nC3Yd3JKUbNe5EbtACq5Z7w60veqRWxyJ
   2kYQ3ndv/9W+yi05FhU/YjiSDvF4MtHcg/B3uj6MCSMWlh20gXA9qtGws
   tOrp3QGgXvc5n2+k6BlAWXHJzntdlILlrO0Mgi8Yo/R6n8w/XXzB4PSH0
   +MYMmP3GKN8SO25vle5qnlJnBd5zcaRcrTv4HuRKASSFyi9nAJdrFws+l
   LIMPeC4+lSNsxjkydoLhHX+Qbt5P/5hlUEMMtnbr71yQtmm2zUZlTWEVw
   D+V563e0BZqz7F2zA+BJiusDLxy05JDhxg1Y2Dqw9EKaanz8c5rtfWmYj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="304291275"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="304291275"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 19:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="468732428"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 23 Dec 2021 19:22:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 19:22:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 23 Dec 2021 19:22:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 23 Dec 2021 19:22:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkmHjWfiyNPEdxDjox64y7bBPZe2nX8Ivh5N9x3vEwh1/RpizfF71BZQC+ZmXscUKbC1q3xDGjFOsR//8a9IptxEgOcQR5hX47fPv7rCFK4/BfH9pCmUnXkU021GVqj+kaA+YHteovVCjCqQb9RevjHE+EGRHw+bXfg7tJm+YVvDrt/7K7MwtI89VKQDJiDQ4+oXMiZi4itOczeQzXeorlPz/ypP1OSCYDId+tHHnFYGn8uAy7J+yimwsiJ5IUfi+//esZGDRoCPRo0aFsvZFSedFTk0JLkrine4NGRpoMTbdJ1Lttz2+OVhTu3rhgFsovUKSRlSGGhOG5lqXJNSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixhb9/FU51a53W4bLTW/58ZtHd5BGVJX18kNSRCKYjE=;
 b=n/++Pil6VblWygu7EeIUyPDvS9STxoB9KW885/raMdXdpBrbE6ElnmwK/V7yznCV2BOZc2Xfrp+afF0I2doZvbLP7ooPurGDz2lzs17SM6sGN6RkBTZOlfXyboOBXYhleR9uXQzRYMblA5D0NmTUUsBKS1Ivi8oIvN6OelaQkIWrXC4Rp7nS2+Wuir6GslQofkwvmPSeDMAfbbjjUyXTIsu12NQm6A6jg7cK1TM+juDHvQEX3Y6jt+dhtocNkID7RYBW/nmY27cPKpPIGayXJcNW9Zq4i8lJWWL623nKAz/VRwL5UHeJr+eQYhoxRhdfGoWTkxwD2V4D/G6NUWQKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 03:22:58 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b821:aef0:2208:7d1f%3]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 03:22:58 +0000
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
Thread-Index: AQHX9wklU1gLrruOXkWZebdL9hbjzaxAL9KAgADIffA=
Date:   Fri, 24 Dec 2021 03:22:57 +0000
Message-ID: <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
 <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
In-Reply-To: <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 5012f3b4-b1a6-4b57-eb9d-08d9c68caeda
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_
x-microsoft-antispam-prvs: <PH0PR11MB482434FEC7933C9C950FA9E9DA7F9@PH0PR11MB4824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxmje8SEJBHfJkM2ZmWJCGqlyaT5wpnoLZrSPEqtQ2zmWWo+kRngYC9SuS5pmzxRd7ZKl8I4OgNgTv8JeX+71Z7d6crJBtL8iPuqlmMDmj8BwZt76OECm1hehnj3ZvmOCOAVI4bUg32WfCI+Ted+g5AZv3RkfEIvNLknfKylpy3o5TYC5Jf1CpKiJTdnM5nLAAbGVv4JWs8mS39y1XlIyvSjgmbjk3qliWEEtK/kO+ioc9jUjixCDn0wjP1GA7sOEgbrd7nI4EcNCicuHKM41urffElgpRtc8QAkqc9Tb30tR6dqxpKUO/BgC+VrLTbzJxJGfOr9g0dJIV02RlAHmyVPg5k7r1JzUExWLg+ayGQpeO6NlmKzdvr0H3HIgsKuje7OTvKenceT5jKFJzTtsQWJQK/LzDkDXzwTvQEshRByu8sjrAzQuONFYgFZQIap1/pNStoigiza2SqE8GlBljShbcRp2uiQPzppq6fF6U2aAjRuiul2IheGYrHW6K4XD2kZUraLNxb2uV/Y1I5ZtRPk8YoY1HB9XsUi2X3ojGy17Ad+v1CNMk/Wbh002ePWnrKe4oeBbtUK4CK0SgkZCWm0rB25EMlCRWicqLLpRYjrKjMgUMfG7D9oUX3TXL4joJHlSVv6zNalrVN/O5js0IKQiHEh4PuhT9sAxYDJez9tUZ3Ye4Io+/scihYKL/Qi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(38100700002)(316002)(82960400001)(4326008)(508600001)(7696005)(8676002)(55016003)(38070700005)(2906002)(8936002)(6506007)(52536014)(66574015)(186003)(83380400001)(66476007)(66556008)(66446008)(64756008)(33656002)(66946007)(26005)(54906003)(9686003)(76116006)(5660300002)(6916009)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkhXbVdTWWcwOHZ4VndnOW1VNDVUV21jaXpsWmN3NXJONmRmZThPbEtWU0t6?=
 =?utf-8?B?OWVVc2JhWDJMNjYzS0VzcktuZDc3aWdKNHB2Y3U0R1huK3BBK0VIbEJCd0Vq?=
 =?utf-8?B?c200ZHN3Unk0M2dTbm8xVDIxUEp6dDNWRnJDdVQ3a01ZV3ZTWmcramNJQ1FG?=
 =?utf-8?B?NmsxVVYvbmVSbUt4WVJ1V3k0M0h1K09OMGFVdStsbitMRHVJT2VJZ0ZYaXpP?=
 =?utf-8?B?TEl5cGlhSzhhVzMyTWF3SEltNG1xS2d4ckJ6cndnd1FPQjdzOEd5am10dUVF?=
 =?utf-8?B?RUFjd1lTK3p3VjRBRGM1cnVEMjZiMWlDd2s2YXorRWE5U2R4TjhTU0JDdzFV?=
 =?utf-8?B?L3cwcTlHYUFSV2JGb1U4bGRIcW1TUGRnaUtJcUwwa0lKRjFTRXd0aDUwTHNT?=
 =?utf-8?B?SUNzTzlKTlRBWmRWbmg2bjlZb1VSaXFHZ3loS2hUNDZqUlBYTkZ4d2JXVWxw?=
 =?utf-8?B?OHV3OFRQQ3RIcjhSNjYvZHJFVlpiaUh2cGhpSWFEbXprNGtHWTVReUJkUCtR?=
 =?utf-8?B?MlIxMk9sN2tuV0lnemphV3hkbHZUL3dIM25hR2k5QjlPakpIRXJET3JEc0xO?=
 =?utf-8?B?c3BQdUo0NVlFYjRJVDNaNHUyYVdlTG13Q2oyaWozcHVUOFRkQWt2K3BkVkZt?=
 =?utf-8?B?TUdMU0cwV3hkbHArR2J5WlB4RnoxYjE4NW5KbktRN0EvUThUdEZkbkVxWTZx?=
 =?utf-8?B?eTRPNWE3Q3NZTVlnbnM4RFA4RWw2eEdxY2VuU0ZPN1NQTmhISzVNOTcvdnVG?=
 =?utf-8?B?MHhva1NYeGFPbkp1OGNCcXV6RkZzdmkrSStYQ3lVU01Mb0ZWTStRNDByMTRl?=
 =?utf-8?B?YUozQ0ErbGxZRzNDRUZpRjVCSXpYOGNLRUVETUM4Tjl1VWphLzd2dS9YYWlD?=
 =?utf-8?B?aG04T1c0b2hFakhrZi83SDNQQmFwZGo3cnI3a3hzZURpcHMyRzRTMitOWk9x?=
 =?utf-8?B?MnRoMmFSUzJrQkVNV0RhZzVqRTk0TVU0Y09nNk01eWpIbGZwcEN0dG4vdmJR?=
 =?utf-8?B?cXBta3RnekUzWDJjU2dWb1hRMytFMWg5MS85ckhlc0ExeDJuTERGYllhdlNY?=
 =?utf-8?B?T0RyQVFUeHNxNFFUNnZGRWd3T1d2M3M4bzVLZ2ZBcjQzbjJ4cXZFTGVPR0hZ?=
 =?utf-8?B?SHVrTGJDckNkTUp1Wm9mRnl3dTNUSk51cS9Hdm1BWEw1VTdITGtFSHQ2K2Q5?=
 =?utf-8?B?MlFrSThRTmdwK0M4Rk1iSDFlMG51RzhhbWN3WHdRbzdJVEtvSE9Kejl3UVUx?=
 =?utf-8?B?VWxiVS9QbnNqU2ZXbjNmM2tialNqMllaYXZ1a3g2cDgydDlsd3RuRFJEZElZ?=
 =?utf-8?B?NW1heFJEN2poUGROWXFRTGxyaUw5TytCMjlRL0NRQk42TGJabTlpWTVhaDly?=
 =?utf-8?B?WlZReUFCL0pmZ2lubmRlc1FBUjJ5dTBKajd0Q3pRS2ZNVzdnVFdta0MzYTRm?=
 =?utf-8?B?MktFdHVFSlM3VHk4N05aRmpIR0plWDduN2ZtZnpjK29YZTNGMjFPRllnbDJ3?=
 =?utf-8?B?Z2NvbWV1RjlPUm1mbXN3UGRVYmF0aE1NaUVpMUhjUTByWm1Qc2dnTmFWY1NF?=
 =?utf-8?B?WW9yWnVhK29JOHhldjkrZHBXSUpGT2xyV0sxYnRMUS9PTUpSVUR5VU54U0RN?=
 =?utf-8?B?dlQ1QVlEcnVpbGJmNmowcWhBdVBrNUxhaXFlWDJZUTRaMHJ2K1F2YVh1ek5t?=
 =?utf-8?B?MWlMWlR4aXpIZEFXcmVoMW9QZHlDZElPd1QxYWZrb2duakZqTE80cThrckJW?=
 =?utf-8?B?aUJGKy9pakJia1JvT2pNVDhTR0RkSThlR0t3cUpuUkxObzc0aTlnNXR6VXU2?=
 =?utf-8?B?djhvSE1lS2t5MDNlYU9DckgwaG1YemxONUs0U1h0OUtiQW5BZ05Ka0FDKytU?=
 =?utf-8?B?YWkvV0Y3Z2RSV2M0aUk2YzBtcmhJL0Y2MmgwSnYzYnluM1hVZEZUS0J0WnVz?=
 =?utf-8?B?YytsRDI3ZWoraklhakVKWTlPK09naUNEdzdmOUlDOEdKV04yMFozS01zUWJC?=
 =?utf-8?B?TjgxQWlYcHYwWmpBK0QreFJOb2M0cXZnQko1d3hTTU5XR1B2aUtqK21yUkhJ?=
 =?utf-8?B?ZlNrY3dYYXBBbTFJbytJOTJ2bUdZSGl5dE9UVUhHVkgvU1dOSHhua05EZmpa?=
 =?utf-8?B?Nmxqcm0xQm1oUXFhS1ZKTzYvcTJJckVtZ25nY1QwWHViMVVVMGFjQnZUVWJK?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5012f3b4-b1a6-4b57-eb9d-08d9c68caeda
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 03:22:58.0002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGsy5JN5/WcSFnPQEJHi7DSevrzjk9dnLLyFb89cpTtmJr2Zl0CMUjSMM98LXMnvmpXEwEltwbEH1CAKkGy6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIyIERlYyAyMDIxIGF0IDA4OjU0LCBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRl
bC5jb20+IHdyb3RlOg0KPiBUaGUga2FzYW5fcmVjb3JkX2F1eF9zdGFja19ub2FsbG9jKCkgb25s
eSByZWNvcmQgc3RhY2ssIGl0IGRvZXNuJ3QgDQo+IG5lZWQgdG8gYmUgY2FsbGVkIGluIGxvY2Fs
X2lycV9zYXZlKCkvcmVzdG9yZSgpIGNyaXRpY2FsIGFyZWEsIGFuZCB0aGUgDQo+IGdsb2JhbCBz
cGlubG9jayAoZGVwb3RfbG9jaykgd2lsbCBiZSBhY3F1aXJlZCBpbiB0aGlzIGZ1bmN0aW9uLCBX
aGVuIA0KPiBlbmFibGUga2FzYW4gc3RhY2ssIGxvY2tpbmcgY29udGVudGlvbiBtYXkgaW5jcmVh
c2UgdGhlIHRpbWUgaW4gdGhlIGNyaXRpY2FsIGFyZWEuDQo+DQo+SSB0aGluayB0aGUgY2hhbmdl
IGl0c2VsZiBpcyBoYXJtbGVzcywgYmVjYXVzZQ0KPmthc2FuX3JlY29yZF9hdXhfc3RhY2tfbm9h
bGxvYygpIGRvZXNuJ3QgY2FyZSBpZiBpbnRlcnJ1cHRzIGFyZSBlbmFibGVkIG9yIG5vdCB3aGVu
IGNhbGxlZCwgYnV0IHRoZSBqdXN0aWZpY2F0aW9uIGlzbid0IGNsZWFyIHRvIG1lLg0KPg0KPldo
YXQgImxvY2tpbmcgY29udGVudGlvbiIgYXJlIHlvdSBzcGVha2luZyBhYm91dD8gWW91J3JlIG1v
dmluZyBhDQo+bG9jYWxfaXJxX3NhdmUoKSB3aGljaCBkaXNhYmxlcyBpbnRlcnJ1cHRzLiBZZXMs
IGl0IG1pZ2h0IGJlIG5pY2UgdG8gcmVkdWNlIHRoZSB0aW1lIGludGVycnVwdHMgYXJlIGRpc2Fi
bGVkLCBidXQgaW4gdGhpcyBjYXNlIHRoZSBiZW5lZml0IChpZiBhbnkpIGlzbid0IGNsZWFyIGF0
IGFsbCwgYWxzbyBiZWNhdXNlIHRoaXMgb25seSBiZW5lZml0cyBub24tcHJvZHVjdGlvbiBLQVNB
TiBrZXJuZWxzLg0KPg0KPkNhbiB5b3UgcHJvdmlkZSBiZXR0ZXIganVzdGlmaWNhdGlvbj8gRGlk
IHlvdSBlbmNvdW50ZXIgYSBzcGVjaWZpYyBwcm9ibGVtLCBtYXliZSB0b2dldGhlciB3aXRoIGRh
dGE/DQo+DQoNClRoYW5rcyBmb3IgcmVwbHksIFllcywgdGhpcyBvbmx5IGJlbmVmaXRzIG5vbi1w
cm9kdWN0aW9uIEtBU0FOIGtlcm5lbC4gIEluIEtBU0FOIGtlcm5lbCwgDQp0aGVyZSBtYXkgYmUg
YSBsb3Qgb2YgY2FsbCBzdGFjayByZWNvcmRlZCwgaW4gYWRkaXRpb24gdG8gbG9ja2luZyBjb21w
ZXRpdGlvbiwgdGhlIGZpbmRfc3RhY2soKSAgd2lsbA0KYWxzbyB0YWtlIGEgbG9uZyB0aW1lLg0K
DQoNClRoYW5rcywNClpxaWFuZw0KDQo+VGhhbmtzLA0KPi0tIE1hcmNvDQoNCj4gU2lnbmVkLW9m
Zi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9y
Y3UvdHJlZS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9y
Y3UvdHJlZS5jIGluZGV4IA0KPiAzNDdkYWUxODc2YTYuLjUxOThlNDRjYjEyNCAxMDA2NDQNCj4g
LS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gQEAg
LTMwMzAsOCArMzAzMCw4IEBAIF9fY2FsbF9yY3Uoc3RydWN0IHJjdV9oZWFkICpoZWFkLCByY3Vf
Y2FsbGJhY2tfdCBmdW5jKQ0KPiAgICAgICAgIH0NCj4gICAgICAgICBoZWFkLT5mdW5jID0gZnVu
YzsNCj4gICAgICAgICBoZWFkLT5uZXh0ID0gTlVMTDsNCj4gLSAgICAgICBsb2NhbF9pcnFfc2F2
ZShmbGFncyk7DQo+ICAgICAgICAga2FzYW5fcmVjb3JkX2F1eF9zdGFja19ub2FsbG9jKGhlYWQp
Ow0KPiArICAgICAgIGxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4gICAgICAgICByZHAgPSB0aGlz
X2NwdV9wdHIoJnJjdV9kYXRhKTsNCj4NCj4gICAgICAgICAvKiBBZGQgdGhlIGNhbGxiYWNrIHRv
IG91ciBsaXN0LiAqLw0KPiAtLQ0KPiAyLjI1LjENCj4NCg==
