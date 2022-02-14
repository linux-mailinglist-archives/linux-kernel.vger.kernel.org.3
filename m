Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E804B5358
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355143AbiBNO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:29:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355128AbiBNO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:29:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CE46668;
        Mon, 14 Feb 2022 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644848966; x=1676384966;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5NWlhQyNQ/br+qMk2QQrOj4n+pumeDXMw3RAlwIExE0=;
  b=RA3ckgWMH41YeFhp+H7/fQiqSPlIN0+lBD1OWPkbPZNqi4X9OV752OAV
   SjL1JFn4KjXkVQeJAhjXZVkinvVqGs19zeFbuxymO5XzQ8j/U+0VK+cQQ
   l5S/+yIohhpZzyzDON2VuchiJV0f2HsBA5/AH20m9WMYbBrWIT/Sh08gH
   kt1oARimtQt6HmgeD9xxRdS9WPqkmLCUOeKP5FEsCkS/5p+8aJZRXcTD/
   fOwVnnalC4gy/cVu0SiXm+r79Do6qDWo0txKC+NqyD5DLk8+XJvFBHZzr
   MwuMmJZ9c+KPqVh7jDeDzv1a4s+Y5gf2ED8qWjiy0Ht/Ju2qcTjvK2Wsq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="274670966"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274670966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:29:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="528205009"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2022 06:29:21 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 06:29:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 06:29:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 06:29:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpRzANnvPP8wWz8kPPR9V/InRM2+Pr+R0fSEeNtqL8poSxa7M4J5D7XWCbSXBldNHChU6ElmXMd0RoCBYmz0M94z64CnAl2mdtnsD5u3LGfCFnw2C+senctDhnBn8HKQvPHOjoj0FP9I3me5DM+b1hOx7PGzDmS8w4Vte/v/LbcgYOmvwcAit22moNHakdGp/TNoDIH2hunIGSZ9x5yOu/ysxcY4z0ScHUh3bL+eXoIYfwb1UZ1ATau3b5cJ1xYRoaRql1+xZk4V9xE5fQDdzhFe59soYYjNmD0l4YxnL6qkBjSCzmva+/xB8Mzeia+oQRfL0YGRgxB2XyxBNBzDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NWlhQyNQ/br+qMk2QQrOj4n+pumeDXMw3RAlwIExE0=;
 b=AjSyFbpLobsVsWrquNKo6TAuhVmJVTySqp2OcCIh9f3AJYH6G4XeHEwuJY1UFmfjSDD2bny1h12NDKWYEUAg+kKeMDMssH8mudlIo4eDon64OzhUzASAF784M7d9Lp8QXWrPauGjofk4fvGp0+l1cOTkgxnMfVCLNLZT0Ng0ynDGlGYwVE7USq53pmP9fJoe2wiJaGAhYkSyDyFqnOFDtFdOjBNgGGkSWMSe64ZzHBkvFNleTrcGMuanRPvNMOGUDAniGTivl64g1sDsu3M6PFBzp7RvKNyeccQFZ+eDjW5DcnlGfS+rpi7pfjh7niLjNgMWSuKpos/aEc+Fmy3L/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by BN6PR1101MB2225.namprd11.prod.outlook.com (2603:10b6:405:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 14:29:19 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::c2e:55c2:bbfc:b47b]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::c2e:55c2:bbfc:b47b%7]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 14:29:19 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: peci: Use devm_delayed_work_autocancel() to
 simplify code
Thread-Topic: [PATCH] hwmon: peci: Use devm_delayed_work_autocancel() to
 simplify code
Thread-Index: AQHYIRLC7mu1GsLwrE28NNtYMSHF9ayTHFkA
Date:   Mon, 14 Feb 2022 14:29:19 +0000
Message-ID: <1696edf17cbab06c7e0ef453cd7bc3bed3ae9299.camel@intel.com>
References: <fd277a708ede3882d7df6831f02d2e3c0cb813b8.1644781718.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fd277a708ede3882d7df6831f02d2e3c0cb813b8.1644781718.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed94ec5c-c22f-4e89-0ab2-08d9efc66310
x-ms-traffictypediagnostic: BN6PR1101MB2225:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB22250F455A383FDD819E42A5EC339@BN6PR1101MB2225.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpxe81GvVhahOlNJcPeyLTABwX4q7pHigs3FAhqik1vBRk+wSxS5QR6NEA5ghguXPyPf6ISBUv3mm8C17m4oLBMToDWMKRKVw+caELl63kAYK3/4DNi+XdjsexdpQu6EaV7XJd3m0hwVsqjJr35xx/NudoPdxzVLkveLFDLPnKv2sM+xDlnf2hqxgIa7U9ss5XuNG4zAvc7UQ8xZf9thYToaU/swYgR/vLRjO63l9cCyrBaz8OpCfIETQ8GyFnfWUDRiXETPG9xpScnSp4VnrcNJSk3ZoDGZMyO38ze8jlXUfj5Yzdx7ArusU2gikFaMfsng1qos8CzJRhv9cnC3SYMkj7YQBadNXNqqt/kXfd4WZhZFMYjH37BsqW8U/Yo5pl9jngOzHzCIfhu8JGXBz69idBFQRvmC28Jl5xB7XceQOC/WTqGk97KbX1vaf6+KJOo63TxibOf+Dmn9Ss1hxheSnzBjkcrvf6kQ0cX91VnzZkbk8HrhUwoxWunItuYwndWq81vs/ff1FdUeVJLf9qrGkyZyR3TscYR94ZOriIb4JCrTvr2zQVSyHIAwZpapa05gW/O5TsS2DwabOT//VgmdZl1VIwUB/8xk1z6TR+u3OuJYQGE6NNwiLHjKzHDSjqv9cd7g8VxkySANsz6goT/VWwp+fO92Pp4DIjjUqAmI6g+LLEVsHExjs0EVhpeyK9pal+Zif0VdPUpqMA19jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(86362001)(8676002)(6486002)(91956017)(76116006)(66446008)(64756008)(66476007)(36756003)(4326008)(66556008)(66946007)(5660300002)(82960400001)(8936002)(316002)(186003)(26005)(110136005)(54906003)(38100700002)(122000001)(2906002)(2616005)(71200400001)(6512007)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2g4TWt6aEt1WHA1enhGQWsrUUZ0WjB1a0JUYzQ3TmFnN21NVHVrMHR5VzJP?=
 =?utf-8?B?WlZyeVN6RzhtbVBmMDJ2TlJKaVZSK2I3cWVNOTU4QTNXdDhzVUkzSXJYZlFC?=
 =?utf-8?B?dzdIVTVSU0hqc3ROYW9LazFNakpOYW1BTHIwSXNIVWdmYUEwVDhrTGxBYzlu?=
 =?utf-8?B?RWlxUW5DNldWd2NRMWc2QnhtUFIyb3YwT2VGNXJBMmVkUk0wSkhEWVZDSU5u?=
 =?utf-8?B?TzNGWi9IbmsvL1JvRVRsVklWaUtYVkZDbGlpaWI1QVBuVXk0L1U1VE9DMXJD?=
 =?utf-8?B?YzNwU0haSTRTc3dlcHdBMFQvaHZyYVRvaUoxV25nNER1bHNyZS9mN0s1RmNG?=
 =?utf-8?B?RHVTTWNqVjJnT3JFK0Q1OVdHTVhyd3lMYmlTakxvWWNSUmRPdVRSR2d5aVM2?=
 =?utf-8?B?Nmc0T2ZKV0lwR01HcVJJL2Q5NlRrbHEwMnpBZnQ4K0htT0VPTDBzK2dvK0xJ?=
 =?utf-8?B?NTIwMTA2dnZrYmIvRmpFSXNzV09zcHV4dzEwZXo3THJ2UGY3WWNQVjllOFZJ?=
 =?utf-8?B?aVpJTm1MOThlMVVnOGhVdUIrSU1jTnA2NDZBMGxIYUFLWmlLZzJidllKcWZM?=
 =?utf-8?B?VTBteHVPdkZkOG5FUGUyRnZ2OS82VDA5MjlteW10NVR6a3B0UnNaU0pzUEs1?=
 =?utf-8?B?WFpQbitURm15MllrRkhvOVBldTJxRmV3bjVMbHY2M3U2M2owVWx1cVlNNTZy?=
 =?utf-8?B?QjYwZmsyNm10b0JIY3FnVGZjZ2V5QXAwazVqRW9OQmNhRHdNVkkxU2x5ZDd0?=
 =?utf-8?B?Q1hsL0wzQkhGTlQvQ2drakg0T1FBcTdhaDZibHUwQ0s4d2JLUW9jTHUwZUVN?=
 =?utf-8?B?aVZXbGxPeHNKL0NLYjgxblM3SmJFbm05VDA2aGx0NzBQcUcxdnRXRG54L3lB?=
 =?utf-8?B?MXU0WTZxQkYrU0ZBSENkRW1SV0NLaG4yZGtJUWZZb2l0UmhwQUxFVGptSUFN?=
 =?utf-8?B?cUxhYmY1RVNJaHkxaFhEeTltR1gxbXl5K3JRbjVva2JPN3RHRGVMYVdMTXZj?=
 =?utf-8?B?b2pxNWw1WG5tQlFkbVFnVExFd0tOY3pIV3llTXhtd0NZdCtCUkpicWxkVVp3?=
 =?utf-8?B?d3FEYlJIcVNQa0xQaEEwZEtBNVlFekpoS1dpYTF4eDNNaDI3MnorVmhaeFBX?=
 =?utf-8?B?MHlsbUI3RHdLNTNVSjkzTFVZOHFkaC9ML0hKcFJpTkVCZ1ZNcjE5VVN5Q1JO?=
 =?utf-8?B?c3plSk5ST3VNbjg2aDJaOGZVcXZDM2MrTFQwVGl2WVZwMHhidWJpQUk0OTZi?=
 =?utf-8?B?MDFzTFBOVjlCa0JtOHhHNEZXU21YYWVaME9pZGErdFJyMWJWZG5MS3BZaks1?=
 =?utf-8?B?OGs3c3NuRTdxeHRYbEp4eVVId0FOQVNia1ZSdmdRNkE3Q0puTndFeXBqN0pw?=
 =?utf-8?B?NzVWcXh0eTU0MkNDZlNYbExtcGZtaUpQSDd1bG9lLzY3UmFBQyt2dWxySXJ6?=
 =?utf-8?B?TFhBdTdIUEcrcEZHSDkySWRNTE5BZlpidzIwWE1mRVJPamFUS2sxVk4rY3p0?=
 =?utf-8?B?WERNcDBUZ1U5OGpodTFwcGJyMll1VWcvR2lEY0RsNmtIckl3Y1Q2dlFyK05D?=
 =?utf-8?B?LzdVQk9zSjFnQmRNUzVPU3NYSEhMcFdFdmt5bFdYOTQrSEgxdVBuT2kyN1FI?=
 =?utf-8?B?cVZrazFVSXk0ZHkrQnNaSFFxclo1L0ppM1dibGljUDBHcFhtOVhneHpmZDdR?=
 =?utf-8?B?UzhlSEpoM2xsMHZkbFh5RGo0SitqOVdUUUZLVDFFc25iUi8xNVFVN1VaaVRI?=
 =?utf-8?B?NlBhMTRqYzdhMHRGZWpXUjJ0aG5oZ3I5ZEc2bmZGRWI5WlZVUS9ZWmFYeXlI?=
 =?utf-8?B?Sk00VzZaV2xuREhJWDNYSkkvS1c2OHRmR0hycEdGZlQvR2cyazFzSGlzT0FJ?=
 =?utf-8?B?d2wzZmg4QWdJYUZSaHZMczFqV2h1czcrOVI5d0c2ZkJteWl5OWprQjF1dS9i?=
 =?utf-8?B?aklFdEZUME16OTlNbkp3SmxLTE14bnU2MHFobUxveDE5elA0dXRiM2g2c3ZZ?=
 =?utf-8?B?R3ZHMVJxQTY5a29nclp0ZHc0UWp2OUErVVhDYjZmZjVxVU5jbEp4T29oU3NE?=
 =?utf-8?B?OEYySWR5QnBSSFR5bk1XU3JrVGc5dWZreTA1MEgxWUxkclBXVm80U1M0aGZN?=
 =?utf-8?B?dU9IbW9WemJYeFZXWlRZdXM2WVl1dFZUWkM2NmU2TkZxZS9yM0ZKTUR6eVlO?=
 =?utf-8?B?OGN1akh3QUhIV2xNRnFJakNwVmpLWmRNZTVXc2pYWXpxU2hHN2NPK0N2V0xj?=
 =?utf-8?Q?BL1G1q9cKCnVuSWG6tDmB2gfpC7t954/rJ7BjJh90s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <844E0BF9F78F3544A72776BBD70360F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed94ec5c-c22f-4e89-0ab2-08d9efc66310
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 14:29:19.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3361nf2SrydML5oMmlNzGgjv/wXhCsAL0TnMUgsjWwks+7TblOldf28S3GRLPxU5WBUI0JZOhwPysyEVnV1/xDtNL+beqJgsqkhu5ibHm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2225
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTAyLTEzIGF0IDIwOjQ4ICswMTAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3Jv
dGU6DQo+IFVzZSBkZXZtX2RlbGF5ZWRfd29ya19hdXRvY2FuY2VsKCkgaW5zdGVhZCBvZiBoYW5k
IHdyaXRpbmcgaXQuIFRoaXMgaXMNCj4gbGVzcyB2ZXJib3NlIGFuZCBzYXZlcyBhIGZldyBsaW5l
cyBvZiBjb2RlLg0KPiANCj4gZGV2bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNlbCgpIHVzZXMgZGV2
bV9hZGRfYWN0aW9uKCkgaW5zdGVhZCBvZg0KPiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKS4g
VGhpcyBpcyBmaW5lLCBiZWNhdXNlIGlmIHRoZSB1bmRlcmx5aW5nIG1lbW9yeQ0KPiBhbGxvY2F0
aW9uIGZhaWxzLCBubyB3b3JrIGhhcyBiZWVuIHNjaGVkdWxlZCB5ZXQuIFNvIHRoZXJlIGlzIG5v
dGhpbmcgdG8NCj4gdW5kby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExF
VCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQoNClJldmlld2VkLWJ5OiBJd29uYSBX
aW5pYXJza2EgPGl3b25hLndpbmlhcnNrYUBpbnRlbC5jb20+DQoNClRoYW5rcw0KLUl3b25hDQoN
Cj4gLS0tDQo+IMKgZHJpdmVycy9od21vbi9wZWNpL2RpbW10ZW1wLmMgfCAxMyArKystLS0tLS0t
LS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9wZWNpL2RpbW10ZW1wLmMgYi9kcml2
ZXJzL2h3bW9uL3BlY2kvZGltbXRlbXAuYw0KPiBpbmRleCBjODIyMjM1NGMwMDUuLjk2Yjk5MTlk
YjM1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9od21vbi9wZWNpL2RpbW10ZW1wLmMNCj4gKysr
IGIvZHJpdmVycy9od21vbi9wZWNpL2RpbW10ZW1wLmMNCj4gQEAgLTQsNiArNCw3IEBADQo+IMKg
I2luY2x1ZGUgPGxpbnV4L2F1eGlsaWFyeV9idXMuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvYml0
ZmllbGQuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvZGV2bS1oZWxwZXJzLmg+DQo+IMKgI2luY2x1ZGUgPGxpbnV4L2h3bW9uLmg+DQo+IMKgI2lu
Y2x1ZGUgPGxpbnV4L2ppZmZpZXMuaD4NCj4gwqAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
IEBAIC0zNzgsMTMgKzM3OSw2IEBAIHN0YXRpYyB2b2lkIGNyZWF0ZV9kaW1tX3RlbXBfaW5mb19k
ZWxheWVkKHN0cnVjdA0KPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBkZXZfZXJyKHByaXYtPmRldiwgIkZhaWxlZCB0byBwb3B1bGF0ZSBESU1N
IHRlbXAgaW5mb1xuIik7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIHZvaWQgcmVtb3ZlX2RlbGF5
ZWRfd29yayh2b2lkICpfcHJpdikNCj4gLXsNCj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHBlY2lf
ZGltbXRlbXAgKnByaXYgPSBfcHJpdjsNCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqBjYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoJnByaXYtPmRldGVjdF93b3JrKTsNCj4gLX0NCj4gLQ0KPiDCoHN0YXRp
YyBpbnQgcGVjaV9kaW1tdGVtcF9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiwg
Y29uc3Qgc3RydWN0DQo+IGF1eGlsaWFyeV9kZXZpY2VfaWQgKmlkKQ0KPiDCoHsNCj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgKmRldiA9ICZhZGV2LT5kZXY7DQo+IEBAIC00MTUsOSAr
NDA5LDggQEAgc3RhdGljIGludCBwZWNpX2RpbW10ZW1wX3Byb2JlKHN0cnVjdCBhdXhpbGlhcnlf
ZGV2aWNlDQo+ICphZGV2LCBjb25zdCBzdHJ1Y3QgYXV4aWwNCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmV4cGVjdGVkIFBFQ0kgcmV2aXNpb24g
JSN4LCBzb21lIGZlYXR1cmVzIG1heSBiZQ0KPiB1bmF2YWlsYWJsZVxuIiwNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBlY2lfZGV2LT5pbmZvLnBl
Y2lfcmV2aXNpb24pOw0KPiDCoA0KPiAtwqDCoMKgwqDCoMKgwqBJTklUX0RFTEFZRURfV09SSygm
cHJpdi0+ZGV0ZWN0X3dvcmssIGNyZWF0ZV9kaW1tX3RlbXBfaW5mb19kZWxheWVkKTsNCj4gLQ0K
PiAtwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQocHJpdi0+ZGV2
LCByZW1vdmVfZGVsYXllZF93b3JrLCBwcml2KTsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gZGV2
bV9kZWxheWVkX3dvcmtfYXV0b2NhbmNlbChwcml2LT5kZXYsICZwcml2LT5kZXRlY3Rfd29yaywN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3JlYXRlX2RpbW1fdGVtcF9pbmZvX2RlbGF5
ZWQpOw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPiDCoA0KDQo=
