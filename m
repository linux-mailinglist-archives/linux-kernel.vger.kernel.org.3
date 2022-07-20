Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDC57B48C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiGTK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiGTK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:29:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D02D32D8F;
        Wed, 20 Jul 2022 03:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658312963; x=1689848963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EvcQtVIZHNiujRxAeX2XVBS8fWSn3pS6lRTAt6Hf8Cg=;
  b=eyeGWYpSovTuCzSxWN0+CdN3rZcgX2gOHA03nRqUsdurgc7+iAq3q4/U
   w4crHC0Hi5dQ0qKOgA4RlycYOw/d2JkBjFibqWO/lNyqDAVQB//Cfh5al
   wHzfnZX+qMF4kaN0lt9tMeJKGTxZ0jsTms8PonRsDpFvB4udsRKFg4VFa
   KEdC4Ll8nsny3kDBTm73BJusruNpSHrDpRceWWK53MX3Zw0kiHI2AtdcU
   94IZTBbTQpUNmIq1G8m3utvvG++8rRFteL5yC3HWxAbA6a8pBp5wY+vv2
   KLhFpEl9m6eIkEg+T9uPuY7L9OhZwwjeHCBkfD1d4Hz6YVr6UPcVeVWsA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273577509"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="273577509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 03:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="630720812"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2022 03:29:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 03:29:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Jul 2022 03:29:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Jul 2022 03:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcJvKHBBm3FG5BhZMnzHjpJM9EEZtyUi0yqikWjZl6ZdrfijE+VMgC1okNz4GTa1ffj2sVGlG/uAQKf/LMcehV55eiwqGHKWevmTtv68QEWk3HU55dEx3gppnB3DmWmdJIJNIJl7FmIne/Jp9LetB8873if7Xj5vs8VyAQXG4zzz27PLW9n2exRZBLwm0fExqzQqgeMbFteL+LQmCSCNTgyRFqfrDXpyRcm4gk4OBqWMT3BqCjAWAdbpC70YSFkTL+MjllvtB+xBvbzRWDAY4vabMUcdqaU0XZyL18okOuKSxIxJluapErmIsDer7dgTgmOiYTe0pyXc1FSgP7Yhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvcQtVIZHNiujRxAeX2XVBS8fWSn3pS6lRTAt6Hf8Cg=;
 b=KXHIADwXLnSfF4kJtZB0KuQ9y/eUj0MtqZrDikPUoUBRWuD3i2cavBCBu3840/300/0VakcfIGJfBA7BnAH8D6xYyhRlxZUE6CxRqQ6wWpZnsRFL51F0/bPVY/j5piQYDpFWlythUK6v6eIN2Zm7KvLvdy2mWMxUtbJpnVWFZA6uZS1NrGWxC4GYs/z+t5ksgejVWzLJbodDYMrXetlc/IRzWzzPGfR1OpMgGNABPb32h/3YPZV2JjybwfHoIBKfZuOSWPcY7UAp4RO3QeavAyNxThlasSi7F6nYt9Y21NOj0GDoaByjSAY12nkAjPnY/dShHSEAAk1mwbnzmKTBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 10:29:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 10:29:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu-tasks: Make RCU Tasks Trace checking for userspace
 execution
Thread-Topic: [PATCH v3] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Thread-Index: AQHYmylCIn1ItqslD0y8W93ueHB5W62GPr+AgADQRJA=
Date:   Wed, 20 Jul 2022 10:29:20 +0000
Message-ID: <PH0PR11MB5880838A695F1DAE8E9A98B0DA8E9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220719043900.437443-1-qiang1.zhang@intel.com>
 <20220719215727.GV1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220719215727.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5afb924-bf09-4882-99dc-08da6a3ab4f5
x-ms-traffictypediagnostic: MN0PR11MB6086:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YDn82LjxXbL2RpUAGop+yqvKhzonpjdFc4GWZX3taAbuKzeXC/LpZXfuNeIk74gaRApU7TmEt7tTmRKqtdYcXExAydJSLbfRjKoERlsTI4X3G29uugcWjKCDBxZ0gY5o9/2VcJf6MDXvVLxVokkC6aBFPlpcki0aVOREyOqY2n7KcwpRKBo6J7yK7g1DxZRr7JW93TGz0pVfjVYTFP/JnXDymo30Qx8Ee11bWMHkNFwI3vbj+tzloz4DvputtZwRWee2L5O3CaWM3/Uzw73pa/Dcf8cwHSX2bRYyFU4oCS6A/cIFoKQthAI+NV2BBQZQHSo8qJ/lj/gwqr5OgfzPoBKqvMra6YkmV38/lMExgtR6PTWslCDyyezjsQfmC/9gE2tvtuKwfYA8FouHzxlWRi3vdUn+4b2GOjOv1+/vH65P2+plNfHpdBSqDUxLEzn079j7V/2Iw4CaJwh0UwWi16TSM1uwJo2uy+P4M4IOqxHITP+lIiy0PBMQKLCVeD/+DYJ2kEeuTQZNYyv1VdZMz6JpuOCi/FnewjRiZEi9Wgt0HXYA5MyWo/EsgnZCRWS4URbEhDTWXJUS2IqxWH1cu8JQtPyaoVXyTiXFL0mdr5LUY9ur1r38+vH5iQIPYv47hnu1HL9JelgLBK81XlUFALbpLBpxYc96ty4I3qoP02hhC49V5ObP2MzqgjRvY9bQXnTuTrBjc8SWJw4YrESXR1+B+ukl3UIWrqN5+QMQsu35F6tje4NXNPIfhuzIpS4Da7WDzQ95EOePaEXIKZo+fp3a0QacBrJQr6mF3/uV/NcCUHQRhdxTa8XYdMLTKzZm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(136003)(346002)(54906003)(83380400001)(2906002)(76116006)(6916009)(66476007)(186003)(64756008)(66946007)(66446008)(8676002)(4326008)(71200400001)(55016003)(26005)(66556008)(9686003)(6506007)(7696005)(478600001)(82960400001)(86362001)(41300700001)(316002)(33656002)(5660300002)(38100700002)(8936002)(122000001)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RER6dzZDTm1ZWUluSVZ0aG80OW91R2V4QjdGVmdyZEF6czFOdUtqUjIyblF1?=
 =?utf-8?B?N3VBZ2R2VDVRb1Zvam01cTFnd0RhS09KSXRtVjF5a0pNY0NzMnp5YUg2R2k5?=
 =?utf-8?B?R3o0OUFSSFNCVWpTR3N2VVUvdncxb3JNOGxUczRrTHM2d1BTd0xnMFg0V2ZK?=
 =?utf-8?B?MVo2bmJtelNLVCt1SDMvdFVVdXZ0ZFZzMG5lOEFtUjllMWZSSm9NZm9ybysz?=
 =?utf-8?B?Q3lWOHU1RGlCQ3BvZlB2UGxFWFRMSnRZQTVFaEhlcHhpY056VDZGQlkzZWRw?=
 =?utf-8?B?K3NWZld2Vjh5aXBNT0J1bGU3eEJlajh2WXpHcTNsQWRGMWhuY09zYmRUeDBw?=
 =?utf-8?B?VXRkU0Q5eE9aTVNHMlJYV3ZEclBpRU5obXVXRjVENDA0aVFWcnIxdytXeE11?=
 =?utf-8?B?Vy95YTR6QnFjc1RDTFEvRWkxNHQ2U2IxaXBJc0pJN0wydUxBWFBBUGNTWUtu?=
 =?utf-8?B?M1JpM1ZYNXZRNlNweWw3UEhuNDdpajJsS3JPUjZ5a2dDVkxiTnRMajM3Z20r?=
 =?utf-8?B?MjlhaEpzRnNraXRUZC9JR1hhNVRFMkFmcnBMRWJ3eW00WExHUzlXQURSTTJV?=
 =?utf-8?B?Y3hLeVVLZU5CNU5qazJGdEFDc2ZTWTFydVRzY1AzWWVRODE4c0lmZU95UFAw?=
 =?utf-8?B?OTdYOUlyS08vVlU1K1ZyOHVzRW5NSHM1OEVpRTh5WFNtZVRYaWMrTUJMeEJH?=
 =?utf-8?B?VnFOT3NLTXFKWG82clkyQ2t6MU1ZeVRteGgreHYxdEFLaDFHbzA3VmptUXVt?=
 =?utf-8?B?NXhBcVFtUEhoUkc1WU1WVExCdHJoNm9IUWk4aVAzUTVrUU5qdklmaklhZmM0?=
 =?utf-8?B?M3NMSGxvcG43cE9CcE5OcHZFQUZOUmtKaG5mcmhQeHBLSGEwSWdsRE9GRmhl?=
 =?utf-8?B?S21ncm5Ib3A2K0xpeTRVK0JQT09hQzlSWG9RN3pTOWxSaGQyY3JtS09OcElt?=
 =?utf-8?B?MkNlTjJEaDFQaC9mSC9Fc3QrSjB6WjkzVW05ckJzQmJNUm4xbGNueTZCbXEz?=
 =?utf-8?B?N01lWktDTSs0cHFDekpxTm8rbE1IS3dUVjhBZmdtb3d3RnNLOEZyM053OTZW?=
 =?utf-8?B?cmp3aFQ5Y2g1RkhXTFlNRHJ5SjhuQnBJUzU1V3hUTFRxYTJiMVFwZm01MXhJ?=
 =?utf-8?B?NXJ4MU8wRWlRSFpjMG9xK3M0R001Y1gyb1BaVkN5L2JnSEV5cklQZ3Nibmcv?=
 =?utf-8?B?VVpDSTBBUnFock9tK3ZCTU9uSFpZT1pEbllOK0hiYjBTVXBLenRBT1orbnB0?=
 =?utf-8?B?RjF3MnVGVlVDVFIzRTRzS1MrUlVWeUtFa1drSDh1dFRmdTlFMFVzeS9vcW56?=
 =?utf-8?B?STFySTBmaXR6UkVoSGZYcUFsK0JqS2tEd3U5cDQzcXpWREZ4WU95SjhTSG9q?=
 =?utf-8?B?SklkbTcrbUppQWdvT1VBekgzUm1xWW90MXU4Nm1nOVp1cTBwNDZXQXJWVDk0?=
 =?utf-8?B?eXppZzhOcjl1MUUwYUVkR0hhU1I3aVFmSGcwN3hkcytGMXFxSWNDUnRkdU9l?=
 =?utf-8?B?VnZkMTB4aWs1a2FHMi9BQzc3SGh5L1p4TnI2V0FGNlc0bGlWcW9iMFVsWWRC?=
 =?utf-8?B?dGRsVGNGVVpDVE1vWGdDTWJ1bUtZNHU2OEtXa0lLWFg2Ym1tU2NsYnVQTVIy?=
 =?utf-8?B?UlZVNHdPMDQxS0VURnlIQUNwMk5KKzVEUFVLckRmdFZOcVNjdVpEMGJXSU10?=
 =?utf-8?B?eVQwWi8wNmM2ODZ1aE1WYjdXL0F5M2d3am1uR0NMYUhTUkE2UStoM28rall0?=
 =?utf-8?B?WDJ3bHhvaHNtS2NlQ3YyTWIwWVVEcElpOXk0WGtzaTZ1cDg4MkRCTjl4MWJy?=
 =?utf-8?B?bTFRRVZNOXluNCtIMU9CL2poKzNrR3BkNWtIV29SZi82dEFCZjl3d3BJcFI3?=
 =?utf-8?B?TWRTNit2OXEwVTIvZm1mRXVldFlvaTIrN2daYkxZUkZFVDM3QURyQy9mb09a?=
 =?utf-8?B?UFRhc3RoeHI0OTFZTzVUeEJhQmhnWFh0amhBWW9UNHIyNTdwZjlLSFpHWTl2?=
 =?utf-8?B?WmNsdXNnUERnVEkyWFNMRDlIL2RDY0ZjR2lUUXZuektjUmtMb1ViQlJyNFFk?=
 =?utf-8?B?NXdCY3dUSHYwdzVBdy9hY0FGeXJCSE43S2I3anpoaGFDOFRzbmpubGw1ejZl?=
 =?utf-8?Q?tXNbjtGsl1JSpoSBBLmpdF+u1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5afb924-bf09-4882-99dc-08da6a3ab4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 10:29:20.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Wy7lRTXY49wISB+xI8/k2xsIpAO/9kh8mPFzSOewlpO6Hm4VSQpLQzvyXdznNRPz0HSTtpTyOaS1LPAtCdBRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMTksIDIwMjIgYXQgMTI6Mzk6MDBQTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBGb3IgUkNVIHRhc2tzIHRyYWNlLCB0aGUgdXNlcnNwYWNlIGV4ZWN1dGlvbiBpcyBhbHNvIGEg
dmFsaWQgcXVpZXNjZW50Lg0KPiB3aGVuIHRoZSBzY2hlZHVsaW5nIGNsb2NrIGludGVycnVwdCBo
YW5kbGVyIGludGVycnVwdHMgY3VycmVudCB0YXNrIGFuZA0KPiBjaGVjayBjdXJyZW50IHRhc2tz
IHJ1bm5pbmcgaW4gdXNlcnNwYWNlLCB0aGVuIGludm9rZSByY3VfdGFza3NfdHJhY2VfcXMoKQ0K
PiB0byBjaGVjayBxdWllc2NlbnQgc3RhdGUsIHVzdWFsbHksIHRoZSBjdXJyZW50IHRhc2tzIC0+
dHJjX3JlYWRlcl9uZXN0aW5nDQo+IHNob3VsZCBiZSB6ZXJvLCBpZiB0aGUgY3VycmVudCB0YXNr
cyAtPnRyY19yZWFkZXJfc3BlY2lhbC5iLm5lZWRfcXMgaXMgbm90DQo+IHNldCwgc2V0IFRSQ19O
RUVEX1FTX0NIRUNLRUQgdG8gLT50cmNfcmVhZGVyX3NwZWNpYWwuYi5uZWVkX3FzLiB0aGlzIGNh
dXNlDQo+IGdyYWNlIHBlcmlvZCBrdGhyZWFkIHJlbW92ZSB0YXNrIGZyb20gaG9sZG91dCBsaXN0
IGlmIGN1cnJlbnQgdGFza3MgaXMgaW4NCj4gaG9sZG91dCBsaXN0Lg0KPiANCj4gQnV0IHNvbWV0
aW1lcywgYWx0aG91Z2ggdGhlIHNjaGVkdWxpbmcgY2xvY2sgaW50ZXJydXB0IGhhbmRsZXIgY2hl
Y2sNCj4gY3VycmVudCB0YXNrcyBydW5uaW5nIGluIHVzZXJzcGFjZSwgYnV0IHRoZSBjdXJyZW50
IHRhc2tzDQo+IC0+dHJjX3JlYWRlcl9uZXN0aW5nIG1heWJlIG5vdCB6ZXJvIChpZiBvbmUgb2Yg
dGhlIGZ1bmN0aW9ucyBpbiB0aGUNCj4gc2NoZWR1bGluZy1jbG9jayBpbnRlcnJ1cHQgaGFuZGxl
ciB3ZXJlIHRyYWNlZC9pbnN0cnVtZW50ZWQpLCBhbmQgdGhlbg0KPiBpbnZva2UgcmN1X3Rhc2tz
X3RyYWNlX3FzKCksIGlmIHRoZSBjdXJyZW50IHRhc2tzIC0+dHJjX3JlYWRlcl9uZXN0aW5nDQo+
IGlzIHN0aWxsIG5vdCB6ZXJvLCB0aGUgY3VycmVudCB0YXNrcyB3aWxsIGJlIGluc2VydCBsb2Nh
bCBDUFUgYmxvY2tlZCBsaXN0Lg0KPiBpZiBzdGFydHMgYSBuZXcgUkNVIHRhc2tzIHRyYWNlIGdy
YWNlIHBlcmlvZCBhbmQgdGhlIGdyYWNlIHBlcmlvZCBrdGhyZWFkDQo+IHNjYW4gcnVubmluZyB0
YXNrcyBvbiBlYWNoIENQVSwgZmluZCB0aGF0IGN1cnJlbnQgdGFza3MgaXMgcnVubmluZywgd2ls
bA0KPiBhbHNvIGluc2VydCBpdCB0byBob2xkIG91dCBsaXN0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPg0KPlRoYW5rIHlvdSEgIEkgcXVl
dWVkIHRoaXMgd2l0aCB3b3Jkc21pdGhpbmcgYW5kIGFsc28gd2l0aCBhIGJpdCBvZiBjb2RlDQo+
Y29uc29saWRhdGlvbi4gIFdpdGggdGhpcyBjb25zb2xpZGF0aW9uLCBpbnN0ZWFkIG9mIGFkZGlu
ZyBhIGxpbmUgb2YgY29kZSwNCj53ZSBhcmUgcmVtb3ZpbmcgdGhyZWUgb2YgdGhlbS4NCj4NCj5C
dXQgcGxlYXNlIGNoZWNrIHRvIHNlZSB3aGV0aGVyIEkgbWVzc2VkIGFueXRoaW5nIHVwIGFsb25n
IHRoZSB3YXkuDQoNClRoYW5rcyB3b3Jkc21pdGhpbmcg8J+Yig0KDQo+DQo+CQkJCQkJCVRoYW54
LCBQYXVsDQo+DQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCmNvbW1pdCBjM2U3ZmQwNDQ5NjQyZGY4YzQy
N2I0NDI3NTFmYmU1OTNlNDY3M2RmDQpBdXRob3I6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVs
LmNvbT4NCkRhdGU6ICAgVHVlIEp1bCAxOSAxMjozOTowMCAyMDIyICswODAwDQoNCiAgICByY3Ut
dGFza3M6IE1ha2UgUkNVIFRhc2tzIFRyYWNlIGNoZWNrIGZvciB1c2Vyc3BhY2UgZXhlY3V0aW9u
DQogICAgDQogICAgVXNlcnNwYWNlIGV4ZWN1dGlvbiBpcyBhIHZhbGlkIHF1aWVzY2VudCBzdGF0
ZSBmb3IgUkNVIFRhc2tzIFRyYWNlLA0KICAgIGJ1dCB0aGUgc2NoZWR1bGluZy1jbG9jayBpbnRl
cnJ1cHQgZG9lcyBub3QgY3VycmVudGx5IHJlcG9ydCBzdWNoDQogICAgcXVpZXNjZW50IHN0YXRl
cy4NCiAgICANCiAgICBPZiBjb3Vyc2UsIHRoZSBzY2hlZHVsaW5nLWNsb2NrIGludGVycnVwdCBp
cyBub3Qgc3RyaWN0bHkgc3BlYWtpbmcNCiAgICB1c2Vyc3BhY2UgZXhlY3V0aW9uLiAgSG93ZXZl
ciwgdGhlIG9ubHkgd2F5IHRoYXQgdGhpcyBjb2RlIGlzIG5vdA0KICAgIGluIGEgcXVpZXNjZW50
IHN0YXRlIGlzIGlmIHNvbWV0aGluZyBpbnZva2VkIHJjdV9yZWFkX2xvY2tfdHJhY2UoKSwNCiAg
ICBhbmQgdGhhdCB3b3VsZCBiZSByZWZsZWN0ZWQgaW4gdGhlIC0+dHJjX3JlYWRlcl9uZXN0aW5n
IGZpZWxkIGluDQogICAgdGhlIHRhc2tfc3RydWN0IHN0cnVjdHVyZS4gIEZ1cnRoZXJtb3JlLCB0
aGlzIGZpZWxkIGlzIGNoZWNrZWQgYnkNCiAgICByY3VfdGFza3NfdHJhY2VfcXMoKSwgd2hpY2gg
aXMgaW52b2tlZCBieSByY3VfdGFza3NfcXMoKSB3aGljaCBpcyBpbg0KICAgIHR1cm4gaW52b2tl
ZCBieSByY3Vfbm90ZV92b2x1bnRhcnlfY29udGV4dF9zd2l0Y2goKSBpbiBrZXJuZWxzIGJ1aWxk
aW5nDQogICAgYXQgbGVhc3Qgb25lIG9mIHRoZSBSQ1UgVGFza3MgZmxhdm9ycy4gIEl0IGlzIHRo
ZXJlZm9yZSBzYWZlIHRvIGludm9rZQ0KICAgIHJjdV90YXNrc190cmFjZV9xcygpIGZyb20gdGhl
IHJjdV9zY2hlZF9jbG9ja19pcnEoKS4NCiAgICANCiAgICBCdXQgcmN1X3Rhc2tzX3FzKCkgYWxz
byBpbnZva2VzIHJjdV90YXNrc19jbGFzc2ljX3FzKCkgZm9yIFJDVQ0KICAgIFRhc2tzLCB3aGlj
aCBsYWNrcyB0aGUgcmVhZC1zaWRlIG1hcmtlcnMgcHJvdmlkZWQgYnkgUkNVIFRhc2tzIFRyYWNl
Lg0KICAgIFRoaXMgcmFpc2VzIHRoZSBwb3NzaWJpbGl0eSB0aGF0IGFuIFJDVSBUYXNrcyBncmFj
ZSBwZXJpb2QgY291bGQgc3RhcnQNCiAgICBhZnRlciB0aGUgaW50ZXJydXB0IGZyb20gdXNlcnNw
YWNlIGV4ZWN1dGlvbiwgYnV0IGJlZm9yZSB0aGUgY2FsbCB0bw0KICAgIHJjdV9zY2hlZF9jbG9j
a19pcnEoKS4gIEhvd2V2ZXIsIGl0IHR1cm5zIG91dCB0aGF0IHRoaXMgaXMgc2FmZSBiZWNhdXNl
DQogICAgdGhlIFJDVSBUYXNrcyBncmFjZSBwZXJpb2Qgd2FpdHMgZm9yIGFuIFJDVSBncmFjZSBw
ZXJpb2QsIHdoaWNoIHdpbGwNCiAgICB3YWl0IGZvciB0aGUgZW50aXJlIHNjaGVkdWxpbmctY2xv
Y2sgaW50ZXJydXB0IGhhbmRsZXIsIGluY2x1ZGluZyBhbnkNCiAgICBSQ1UgVGFza3MgcmVhZC1z
aWRlIGNyaXRpY2FsIHNlY3Rpb24gdGhhdCB0aGlzIGhhbmRsZXIgbWlnaHQgY29udGFpbi4NCiAg
ICANCiAgICBUaGlzIGNvbW1pdCB0aGVyZWZvcmUgdXBkYXRlcyB0aGUgcmN1X3NjaGVkX2Nsb2Nr
X2lycSgpIGZ1bmN0aW9uJ3MNCiAgICBjaGVjayBmb3IgdXNlcm1vZGUgZXhlY3V0aW9uIGFuZCBp
dHMgY2FsbCB0byByY3VfdGFza3NfY2xhc3NpY19xcygpDQogICAgdG8gaW5zdGVhZCBjaGVjayBm
b3IgYm90aCB1c2VybW9kZSBleGVjdXRpb24gYW5kIGludGVycnVwdCBmcm9tIGlkbGUsDQogICAg
YW5kIHRvIGluc3RlYWQgY2FsbCByY3Vfbm90ZV92b2x1bnRhcnlfY29udGV4dF9zd2l0Y2goKS4g
IFRoaXMNCiAgICBjb25zb2xpZGF0ZXMgY29kZSBhbmQgcHJvdmlkZXMgbW9yZSBmYXN0ZXIgUkNV
IFRhc2tzIFRyYWNlDQogICAgcmVwb3J0aW5nIG9mIHF1aWVzY2VudCBzdGF0ZXMgaW4ga2VybmVs
cyB0aGF0IGRvIHNjaGVkdWxpbmctY2xvY2sNCiAgICBpbnRlcnJ1cHRzIGZvciB1c2Vyc3BhY2Ug
ZXhlY3V0aW9uLg0KICAgIA0KICAgIFsgcGF1bG1jazogQ29uc29saWRhdGUgY2hlY2tzIGludG8g
cmN1X3NjaGVkX2Nsb2NrX2lycSgpLiBdDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogWnFpYW5n
IDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNL
ZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJl
ZS5jIGIva2VybmVsL3JjdS90cmVlLmMNCmluZGV4IDg0ZDI4MTc3NjY4ODguLjIxMjIzNTlmMGM4
NjIgMTAwNjQ0DQotLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KKysrIGIva2VybmVsL3JjdS90cmVl
LmMNCkBAIC0yMzQxLDggKzIzNDEsOCBAQCB2b2lkIHJjdV9zY2hlZF9jbG9ja19pcnEoaW50IHVz
ZXIpDQogCXJjdV9mbGF2b3Jfc2NoZWRfY2xvY2tfaXJxKHVzZXIpOw0KIAlpZiAocmN1X3BlbmRp
bmcodXNlcikpDQogCQlpbnZva2VfcmN1X2NvcmUoKTsNCi0JaWYgKHVzZXIpDQotCQlyY3VfdGFz
a3NfY2xhc3NpY19xcyhjdXJyZW50LCBmYWxzZSk7DQorCWlmICh1c2VyIHx8IHJjdV9pc19jcHVf
cnJ1cHRfZnJvbV9pZGxlKCkpDQorCQlyY3Vfbm90ZV92b2x1bnRhcnlfY29udGV4dF9zd2l0Y2go
Y3VycmVudCk7DQogCWxvY2tkZXBfYXNzZXJ0X2lycXNfZGlzYWJsZWQoKTsNCiANCiAJdHJhY2Vf
cmN1X3V0aWxpemF0aW9uKFRQUygiRW5kIHNjaGVkdWxlci10aWNrIikpOw0KZGlmZiAtLWdpdCBh
L2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCBiL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaA0KaW5k
ZXggNDE1MjgxNmRkMjlmNi4uYjIyMTk1NzdmYmUyZCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9yY3Uv
dHJlZV9wbHVnaW4uaA0KKysrIGIva2VybmVsL3JjdS90cmVlX3BsdWdpbi5oDQpAQCAtNzE4LDkg
KzcxOCw2IEBAIHN0YXRpYyB2b2lkIHJjdV9mbGF2b3Jfc2NoZWRfY2xvY2tfaXJxKGludCB1c2Vy
KQ0KIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSBjdXJyZW50Ow0KIA0KIAlsb2NrZGVwX2Fzc2Vy
dF9pcnFzX2Rpc2FibGVkKCk7DQotCWlmICh1c2VyIHx8IHJjdV9pc19jcHVfcnJ1cHRfZnJvbV9p
ZGxlKCkpIHsNCi0JCXJjdV9ub3RlX3ZvbHVudGFyeV9jb250ZXh0X3N3aXRjaChjdXJyZW50KTsN
Ci0JfQ0KIAlpZiAocmN1X3ByZWVtcHRfZGVwdGgoKSA+IDAgfHwNCiAJICAgIChwcmVlbXB0X2Nv
dW50KCkgJiAoUFJFRU1QVF9NQVNLIHwgU09GVElSUV9NQVNLKSkpIHsNCiAJCS8qIE5vIFFTLCBm
b3JjZSBjb250ZXh0IHN3aXRjaCBpZiBkZWZlcnJlZC4gKi8NCkBAIC05NzYsNyArOTczLDYgQEAg
c3RhdGljIHZvaWQgcmN1X2ZsYXZvcl9zY2hlZF9jbG9ja19pcnEoaW50IHVzZXIpDQogCQkgKiBu
ZWl0aGVyIGFjY2VzcyBub3IgbW9kaWZ5LCBhdCBsZWFzdCBub3Qgd2hpbGUgdGhlDQogCQkgKiBj
b3JyZXNwb25kaW5nIENQVSBpcyBvbmxpbmUuDQogCQkgKi8NCi0NCiAJCXJjdV9xcygpOw0KIAl9
DQogfQ0K
