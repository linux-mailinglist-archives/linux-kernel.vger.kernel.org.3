Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68A44F82AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiDGPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiDGPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:23:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D71FC9EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649344853; x=1680880853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B0YYQN32iwbW2N7gipopXfCMx7uXw7//O9fKhkZ65Xc=;
  b=aujnl9KfhVPuovraxoBaKxRgmsA3bEGek2bfZh5wmk0j9aysmxZuy5ej
   Mzkvm8tca1L7qATXFqiSMbTKjyX5RFOPAVa7+3vC+rnhmNRBUAk5xMHLo
   L1d901EPfkU4PSEdaCx8xU2RaqDmswH0l9KQazobzKdp2WEjIjtyfedBm
   ZL4NPVsNrdmMYOgfwlUVkWgIDA4b3AB40w3dCzswRuKjU93A/xBmU1lcx
   tocv8M3XGLBTa4IT/OPTxWgsQt+cYhBpR8IxD02i/SmXjX+5TmTclRzvm
   VRdlgSbxeXUISPnJclZsOtSHKl+NzDh+f5CTo3X89Muj+CyAD7xbHrRVW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="286335628"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="286335628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 08:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="506185343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 07 Apr 2022 08:20:51 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 08:20:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Apr 2022 08:20:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Apr 2022 08:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEMiom6Et+ncrnoclxBPvYoyr/A12p7Lqk8iACeje7f+e2PNahpsIi+3gFKv7AZH9jzO4w+YNRGzuaTFUwOsZwNEwFWMGXd2k68JaT1ALhFdRQleuao3Bf3fl4y8oa4Q9BfmWHhbsEPFWlJiiU9hzUixMs6T4HV6oKCdCAOtnyuKJoMjbtBihFUJtp/LcsaGCJ8jimjG6x23y5IqcQW6I5JPszTdvugEJhJI3lrjzcRyKxoBGnbIc+qwX0rxJSo16zJrD51Albl4+yxQj8LbBQNHU1ZFJvyvwQ1av6IRR0th/Lo64tgx0tYBkxoRNJzfjZq4RarYKDpnRdcj26paJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0YYQN32iwbW2N7gipopXfCMx7uXw7//O9fKhkZ65Xc=;
 b=Rzkwxo6Mo2vM0tdcxoo1rX3DJ2Fp1lj4k2zYCZ2G71RSpJTZDnm+Sy1sHZulXPZTi0ss1GyvE1SZ3akIEd3FVHYBF3kCUSOJd0qPwxf7nYdZLkqzXRl27+Ma6UCmOQBlvWCc6hUWTdvFY7yMJd+zzAIDs0zqrMTnNlluCX01Q1/HFceIaAVBG8Y9PcumQYULMwg2AyXGdUjwOwNtfoQ2OtnVY3w2UO8HVJKwz0OpVRq1imel5pHZU/9pRdLXwvF2cVNDUdZn/EkLb2lzNewTUA9pY72ORVI/v8GFVATn/C1H7/e25KjmmZgPt+qyq5x9zOpScNy6EPfa18CZE+T3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.19; Thu, 7 Apr 2022 15:20:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 15:20:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: IBT related objtool warnings
Thread-Topic: IBT related objtool warnings
Thread-Index: AQHYSge+yAgGuYjLVESuJPg8GBiYNqzkA0CAgACOzYA=
Date:   Thu, 7 Apr 2022 15:20:48 +0000
Message-ID: <aef4052eb8c87860d71a2648fbfb1dbd894c1531.camel@intel.com>
References: <314eeced310b07b50b500384741378e59168c36c.camel@intel.com>
         <20220407064941.GH2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220407064941.GH2731@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bdb5e75-95ba-47af-43cf-08da18aa31e9
x-ms-traffictypediagnostic: DM5PR11MB1435:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB14357D45A676EB21A17DE363C9E69@DM5PR11MB1435.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfpsOLiuiyjXDm8F1PHG/eyfx2pJ+lyx1nrBYZ0G2mUQwEEUqwmPCuemaCvfWUAtd9wZjSPmhaKMJkR6wenPRE9Dn5ECw8z5HGy2Syu33ebRZe0GN8+kkSw0uhZ+cEsWnIhSpl3942t00YAVstdxjzd11s4KJZGdgzocPb8yR6seucHd8zzGBLiiioDTNRCpRSl4rIShXfpCT0fTNUbovg0GsUN087MWydj2Zm0GfXkgI/Y/9kU0IVVucxlEg4YPa4RAh83cQ4TTRN5HQtuP5u9A6GytjkL3cxHckNP+G/to1ohLISDLmpUd40Xmnm9+E7d6TM/Ao0mbFu8pgJ864qy0gDeBBDmUBFLwYlFANG+xTPnmQBWrnJyre0ZryW41zvAEZC2qyxPzLhNhIsTHh4XepdUOT2+CPvngyG4bnI8b5in2Bv64kREFJ2F8uXDt+jxy/ajbwUgiqczlqMO+JI61IFqnb0yrXpBArqD5dtKfCXmete0jAclZewhzoAbeOQhAkSR0CGs4ZLAhWK2UJgHQ6errS4TQojZDate1C5NIAnE1Y60QIc8/9o5J9scG0Yj3HLlCdINJwzyhaddqrPgPtt30AEaZjRjjkWVwAi4tr3pESJEFnWiLHwY8JW+SR8zeCkOdmrgmgWxphBLdTobMznQMs4WPxEGRLSXw5q4gVSV7r25f/8uCNYtZ7groxAuUJxbc5BEkhH19L919YYsQ73M8d8s3lKVXeGaehzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(186003)(2906002)(71200400001)(6506007)(2616005)(5660300002)(26005)(6486002)(6512007)(86362001)(508600001)(38070700005)(122000001)(66946007)(54906003)(316002)(6916009)(38100700002)(4326008)(82960400001)(64756008)(8676002)(3480700007)(4744005)(36756003)(91956017)(66446008)(66476007)(83380400001)(76116006)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkpBY01aMlRwa3VoK0FaSU5JZDNyZkZBZ2xiYmVyZUp1VUdUMmZqOGF5Y1ZY?=
 =?utf-8?B?akFwNDkrQXplWDRDQ0ZLY3UrZ1ZKVzBVUnpTWDB0L1RLWktXMzExbzJHNjB2?=
 =?utf-8?B?amFzaG5JeXM2V1FYakZ3OVhqSXk3ME4xQVB1aEMyWU1ldVVmRGhzTjNPS3Vp?=
 =?utf-8?B?NjhiVjdrVG04emxqZjJ2b1RiM2RQOFdqVng5SUNhVkRJdjRhMlF0TlhwQVdr?=
 =?utf-8?B?ak9Pd04wNXkyL0hUNWtBQnQ0a29mdUZIZ1lEQmpnT1dCLzFkc3Zlalc3K3lW?=
 =?utf-8?B?eVJyUTBSNEg0RUxJSWFHY2hWbTJ5OHlkUzM3VEVvKys3QUlIbEl2MFQzY1Bu?=
 =?utf-8?B?ZDdmV0FkUXpldHk5dTFBQ0xEYjF5R1dvNmpDQ1Q3QThjajdkMGluL2RjRFBC?=
 =?utf-8?B?RDM3TjEyR204RWhaZ0JPWHFvb2lVOWxQejZHOEdxN0IwYlNsOHNYTmJKL0s3?=
 =?utf-8?B?ZWdRaXVKQ29MRzNLK253aHliZmluaWdqRVI1aTkrajBKakYrQmhPcSt2cmpV?=
 =?utf-8?B?bW56c2ZJS0o0ZWx6blNsaVFxbEtHQ2NKTi9jakdUaTdyc3M2UzN1SW5FcXAw?=
 =?utf-8?B?YkJqM1haVWJualNnaEp0Z0RHcWJnWW1pWXFiSkxoc1hlMmdSYlliS2d0RUdY?=
 =?utf-8?B?N0xMSWNjRG5saHBCdlpCVFpSUGR3YUs4SkJYaC8wU1Z0TFJwaitNbTJlcldr?=
 =?utf-8?B?MnU0WFpRcVJ2eVRjYnEwZ2E0bThxbDVVczBXYnBBVzU3ZmUvWW5pYjczSnNO?=
 =?utf-8?B?QW5BQTNTVHNyQTFrWi8yeHNVT2l3bUlYN3FFdjdjeThkSEdkNjFVTmE4NGRu?=
 =?utf-8?B?NGlTcHJKRGVJanN6QU05Zkh2Snk4SWhidWh3TThXRkxXeGk2VFZCRmt4d3Y0?=
 =?utf-8?B?WG5YMmJjZGdBVjJKc2dTdXlCbTRtUkxCMXRtRzRMM2NiUG9NUmlWak1sWGU1?=
 =?utf-8?B?SS9ROFRNc1VRZmtydTdTSXlZOUFLeDB4R3I0dCtPYzFBb1ZBQ1VmVVZWRWEx?=
 =?utf-8?B?WVNMOWQxWDhvTnJ3U1drUVZlVHJIS09UR1NRcVlDbVhOSTVxNmJFdzgzOUc0?=
 =?utf-8?B?SXRteFRacEtMU2pIR2V0bTA1WGJ0U1pMUEs1LzQvMkpvKzBHcFBFTVFOeFRT?=
 =?utf-8?B?QmVGaEZ2Z054b1hEWm50OGJZY1k4bk9yd00vYWRsQnFoT05wSk5oVU12UlYv?=
 =?utf-8?B?WEF1bWc4LzJ2WDZPRDU3bFhSSG0zcW9JMmd5VkM5ZnkyeHI5VnVlbXlKMnpP?=
 =?utf-8?B?aWZkK3d6ZUNyQnNJeGxTQTdBVXR3TW5KNXB1bVRUTC95ak5pWHVqRW14dEt5?=
 =?utf-8?B?SWpCaXU0U1JYQjVOUXY5Q1JJdHZnb20zMW55VjdDQUgweEtvdktFbjNGNWFJ?=
 =?utf-8?B?R1plRzVDQStUemRxb0hPWW9yblJab2dUM2ExSjY3Y2wvQy9DTERoZ21HRW5w?=
 =?utf-8?B?WTZsdmptYlB4UXVtNmtRUjBEcnNvUndudnJlVGdKUkZ0dkR3ekFqaVpFdGFz?=
 =?utf-8?B?WFVsVk9kUEwwWkNpZkU0SzEyYlZ0WXdCYXI1My9MSE1PakczWCs5QjZlRE0z?=
 =?utf-8?B?ZTB4NWtEaHB5TjkvL09XNnp3Vk9kZTZIQk5FcFdPbkdBNVNPYVhHelhLcWND?=
 =?utf-8?B?S0xjTVZpbFRZTGtENkQ5Zm9FVjJJSXRhRFhNYzMzMG1PNzNqMEFvejFyS2JY?=
 =?utf-8?B?cHpsSnJmdWZvQTFZeTIxdWtXQnJ1cjVmRkV4WnFJY3IzeWQ3anUwVDUxNWNq?=
 =?utf-8?B?Mmovbm42UlVpWDJPelNTSzhxWjB4UzU3T25yaDM2Y1h6OXE0NHZ6RnAyUXFa?=
 =?utf-8?B?dWdyNGdJZFA4VEdNM3l5UEtpcmJZenZmODREWmxFdjg3Y0swTHlxMEo3Q2cx?=
 =?utf-8?B?RjZFaFYwRVB4cnY0WHFPOUU5R3M3aXRxUlNxRkYvRC9VeStZNmMzMUVyTzVR?=
 =?utf-8?B?aDFVQkptWCs1M0x6MjlLT21SeTgzRnNJdXh4RSs2QjJIVFVoWnFFempSVVZD?=
 =?utf-8?B?amE3VnZORVA1M0FBL0daeE1paHFoVUNoTEpCQUd5bVh6RWwxRHh2QTFVR3Nz?=
 =?utf-8?B?eWJ3czl6VnAvb3liOVN1TWRuMUlhWWI4ZTIrQ1dvWWc0WlJmZ1l3TEhmak01?=
 =?utf-8?B?M3ArRXlMQW1GeGsvb3pxdW92OURKVGljZXlsS1NuenczNGhqQW1QS3loZTMx?=
 =?utf-8?B?b21oQnpIZ29iUlFvYVFGN1AwUUtjZDJyZWJQcWN3VEdSdEZlZ0hCNlFvK2tJ?=
 =?utf-8?B?YVpRb0VwYkN0S2pkWTlQSkJkcXAzYkxBVmxCaVR0SCtNQzFjNVlzL0dEM3NS?=
 =?utf-8?B?SUtSWWhCSGM4TDN5RnI1TUx0emluT2toWVpmSzZtd0pnaFdaemhBY2FRNTlE?=
 =?utf-8?Q?ySnGfxXKksMDkZq4HWBPconvrNPLorI7O78/x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31437B61BB14F64C85F32B0E433A956A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdb5e75-95ba-47af-43cf-08da18aa31e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 15:20:48.6130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFkZatiX20N3m7jr985dkwVnRqn2hPEreXge1GSVwauIgh0Sp1YQazQSkbm1iLo/t9lD6iEWCrEr4xWnUWhFkC7Iz1AZD36+X9BhCqAhvv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTA3IGF0IDA4OjQ5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMTA6NDM6MzNQTSArMDAwMCwgRWRnZWNvbWJlLCBS
aWNrIFAgd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gQWZ0ZXIgY29tbWl0Og0KPiA+IGVkNTNh
MGQ5NzE5MiB4ODYvYWx0ZXJuYXRpdmU6IFVzZSAuaWJ0X2VuZGJyX3NlYWwgdG8gc2VhbCBpbmRp
cmVjdA0KPiA+IGNhbGxzDQo+ID4gDQo+ID4gSSBhbSBnZXR0aW5nIG9ianRvb2wgInVucmVhY2hh
YmxlIGluc3RydWN0aW9uIiB3YXJuaW5ncy4NCj4gPiANCj4gPiBPbiBvbmUgc3lzdGVtIHdpdGgg
Z2NjIDguNC4wOg0KPiA+IHZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogc3RhcnRfc2Vjb25k
YXJ5KCkrMHgxMGU6IHVucmVhY2hhYmxlDQo+ID4gaW5zdHJ1Y3Rpb24NCj4gPiANCj4gPiBPbiBh
bm90aGVyIHdpdGggZ2NjIDExLjIuMToNCj4gPiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6
IHB2aF9zdGFydF94ZW4oKSsweDA6IHVucmVhY2hhYmxlDQo+ID4gaW5zdHJ1Y3Rpb24NCj4gDQo+
IENvdWxkIHlvdSB0cnkgd2l0aCB0aXAveDg2L3VyZ2VudCA/DQoNCkkgZ2V0Og0Kdm1saW51eC5v
OiB3YXJuaW5nOiBvYmp0b29sOiBzdGFydF9zZWNvbmRhcnkoKSsweDEwZDogdW5yZWFjaGFibGUN
Cmluc3RydWN0aW9uDQo=
