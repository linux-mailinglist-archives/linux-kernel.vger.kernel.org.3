Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A45A4165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiH2DOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiH2DOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:14:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB3BEA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661742887; x=1693278887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OU8e8xNB1m89hmpfBotH80kYiKGRdJe0GqdUmxAk6xw=;
  b=Uyeot3mUAGZCSjzaSYSN/xXnpKY9cY2jcBCWr2A7Omvo5hHuR2JAv9za
   SNinvq2UiYPqggK0Z9z4Iy7muDntQUpmQZ7Vuo7iPyR7nsVPx+yOctYpV
   NktEZuJpps7JWH2nlx4o0aYVBh0qbfyTSIkGYMygFPW4Ev/+XAuXSQ7PZ
   jD74XAExK+KJ3b42eTWxquZU2PIGOGNjk3PiNvqbdqThv/2l2MsXJxCEF
   iXkfMkWzpOlrtHisyO6FNv+OD8TTXQ5VOdvzNA+FodFpS5yOFhhYrJKzU
   7ETXfvNPkr4F1YLSWbKR+vXKVP7k6Z4jiBkp1xtnoE0LUB7gSrulOD1w4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292377974"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="292377974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="700429346"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2022 20:14:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 28 Aug 2022 20:14:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 28 Aug 2022 20:14:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 28 Aug 2022 20:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cq2nbijeTtVStgoRGrglZ5C0PtZuhB4+JVdZpUzAllRK6tn/0tErTSxZAQ91j2Eh2JXpic14t1lOvHo7Dq5JmvEmVqrVJOLofsssqCIeNo1vgWO7gj3PCtP3g65Z3rirCbWYSTJDSX0FYHiUi+Z6XmDzsNFDHDRJ1AIo+TQJWuwjBO9VixGHdY/txAQ1bULX3l0hdf35FH9QiuBxxVPkZK1jtMRe8Rt0LzdZdCE3JSHhH6VpS3vHkhdmtCU09f55p+QcOSttD354vHNX0529yVOixIpryuceCTNKPDSbHUBSLAj6HWksK3DDBAbGc1TBIeNdM1cDGYPhiYnBbMGpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU8e8xNB1m89hmpfBotH80kYiKGRdJe0GqdUmxAk6xw=;
 b=ei/xX4pnJmhKt+DyIzjFP6wIj9LRPW5TQTrlXYRMiIPQj+p+re2B3y6DpJyiHk9x0AJa6h9gPOXJbrhJSVttX7M7HDdbfygEQB2MB2uSfgdvgQN80GzhG74Qem/mQ7d+zkT/XKAPc9j2TODDd7uOqu6l11nT6VLwN4SsNXi0inhs8jpqMdpm62wQOmitk6VK1r8eHH5Xn14nHb4JmsCFUvD282j0fpSx34UprO/fpK/ZE/cVNN8y61Mkmu33yqa2vEYxcrI4zon9RUvKHVLdHa92oWbYJa65B08MIKFvO3Mvv2dYnmo+DSbH0/hqr1JadfOz+/LJHhXeBf66lrYvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 03:14:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 03:14:39 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "wander@redhat.com" <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Topic: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Index: AQHYojRY+En7hOPydEe7EqRHOAymzK201mCAgAa/AwCAAATBgIAAAh2AgAnKRQA=
Date:   Mon, 29 Aug 2022 03:14:39 +0000
Message-ID: <493a956374bb64bc5608db73452182b2c1177c6b.camel@intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <Yv5KNyX992ddvVtD@zn.tnic> <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
         <YwP27a6/9Yq8LBM3@zn.tnic> <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
In-Reply-To: <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8c0dc92-698b-41f2-62d3-08da896c9bea
x-ms-traffictypediagnostic: BL3PR11MB6386:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEYxq+kV7a7W+D3H/Wzwo/LL8HXVCDBsM2wYfFYxKfY+/6ojhOzwZWjhGaloP6LCR3v1iEzbdScvRnpb2fHMK5REx89nXo2oZBs8nefEd1UN84+BqsnMgb79rwC/deygBw0ICXUQKPGpKz/84Y0wny8UbPhwIbIS58mXaqnJD4LZdLjK/kDTHp0TW4qdm+gu9odyqJV/AkXtUAdcJLPl8RX0FQBr4g1hhMcaTRyCzVcpPZyYyndHgIsOvO9objHMyGe3UJ1EeylMENSHh9TKuDCt6Ejc5RD1sQ1VTq69u+9r0ZxOnNAXFwanvm6I80VBcWskYYPih3dd62c/eR+YYJjlmq2qyogkDEGLYEmFQmm2QIaRHuw0FmtfXes59IWTHXTHzzwzdXZfGd0uDa04g6eZnQeuf4kH10GBzyYhr51Gb1R8hRJTPkWotV5qNnqIBpbvRiZ5ggLaORyJfMUjkAS98jRTxXNVlAm6DV7fV3mvGRDhEvFUj9D4Q+9v7WIApvgMwKT9nKwdtg9Hwn9tpikSxLKGQD1aojQPIhHNzgRrD8Dwjd8o8k6I8nW/rbfQFHlzzgy45PPJjN1ij+C4g0Lfl7tSIRbC2huI2B5MLMqepFQz8L48oZE0g0DDmDIOpZKi3jUIo9dRjxWBpOUD/qdZh2Aw4YPAPn7r0bSLzAZo1jQomdUGbkcrBGgHmh7zwitq0iGImvO3tbuL3kzJjuxC9nxHpW9xO5silqNH506hxD6+JLZeY/H4aGlvCCuOfIT+fisDdEsX79dhcszCrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(346002)(136003)(366004)(38070700005)(6512007)(26005)(122000001)(82960400001)(36756003)(110136005)(38100700002)(316002)(71200400001)(54906003)(8676002)(6486002)(6506007)(7416002)(4326008)(41300700001)(8936002)(66446008)(66946007)(64756008)(76116006)(4744005)(91956017)(66556008)(2906002)(66476007)(86362001)(478600001)(83380400001)(186003)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzZ3a2lVZmFQYmpKTHJGeUFLL0VsUkMyakdhK0pjZnprQlNGV3JKWUxCdUFl?=
 =?utf-8?B?R0dvOVFnYU0zclVrSlVLVHBCcUd2ZXRmR0RIaVlaazZkUGV4bkdsaTJzWDYx?=
 =?utf-8?B?ekpWZWtwQlg2SFJDNlozTlJldjU2NERoUzZsbTIzVzk4eUxDYUtEY0hvTVRS?=
 =?utf-8?B?Uk5uWFhXZFdyYnF1ZG1BNTdVYjUvSXBXN2lGdFJHTWViYml3MkU1ZHliaTB6?=
 =?utf-8?B?bnFmeUZrSURkSVJHdXI4WGJYR0cwS1dlVGdlV3MzakMvcjNQbEJqL0lXOXdo?=
 =?utf-8?B?ZTB5T0xwUnE5b3M2ZG9CckRZdEJiaFRSRGVsK2dLRmNUZWdyajFFc0k4R3RP?=
 =?utf-8?B?c1N0dzhKM2duUEd0TkJJbUMwNWZQaHI2aTVPSUhrS08zd0p3TWRPdjdwam5G?=
 =?utf-8?B?c2h3TWg1d2tQWU1IOGNSOEVudVNNYy9peXhVVUhIdWxuRElibXpaQ0dTbE9m?=
 =?utf-8?B?Z1MxdlJqdEZ5R2NaVEFtaU9BMlAvSmZsdytzYVIwQUtOelV1Q2RjajcvdEk3?=
 =?utf-8?B?dEhUZmVJakRpbU9nR1JHeTlITjBoYWV1Qm1TUFhDVHc4bVFmQTA5cFZtbUE0?=
 =?utf-8?B?VWZIc2FOai9HSHJnZTliUnZIcHpXL3pqanR4NHVPZ0cybjJHTnlwenNZSUU4?=
 =?utf-8?B?VE1rbXBWTW9GbGpyWU1Wb0NyVStZbU41NEdMS09BM0lvSVJ3YnFXTWwyYWFh?=
 =?utf-8?B?TlF4WTNmeGhSZlpPOFYwOHE4L3pNOVVFYy9hcTNCRXhhNHhKSTY2aFAvcXk0?=
 =?utf-8?B?YUZ0Uys3R29YTzd2UjRmSnJ6eWhPL2JJOUQxK1JvUXJZKzFGemRUL3RtcGc2?=
 =?utf-8?B?a0x2ZjhFcXdJL0prS3lSNUh1Znl2Ymt1Y043VjEyYURMQVYwc1ozRUoveVZv?=
 =?utf-8?B?OEFIQmc2QXQvUVhRYko1UmkvU0l6Y2hwV3NqaW5YbVlkUzJrbFRNdExES0Rn?=
 =?utf-8?B?dU91NzhHRUtkNE52cnJ5RnhsN01vQTVJbDhpc2VvN3hSZzRMeHRaUCtud3Fq?=
 =?utf-8?B?ckw0Q0lTY0dQQU5hcFZQaXNiK3VnL29UVTZVeGpWb2d6YUVtZzFLU21KNDZL?=
 =?utf-8?B?RW0vRUtMSFRocTVYZWMvT09pcW56L2loRW1kbUhFNUhEU3IxYmhZM0ZJa2lP?=
 =?utf-8?B?S1IwQ0hkSzEyeVVLU0xZcDF2QUxlSjAyNzdHV0I0aFpCbU0vc1B6Z3hoZUg5?=
 =?utf-8?B?VjNYWmVaWndaUGNJY0dSWjJPcjFJWUNOMjB4QmJ3WXVEalNJb2VoQlVabm9m?=
 =?utf-8?B?ckhnQ0YveWltcm1YMXNzdUtZR2VxQmtjRFh6LzFicTZrck40TC9zM0x4cG1I?=
 =?utf-8?B?b3h3TTI1NTVwYmRRNUxjUFNaemtFcStjbFMwbXptckx1VkU3T3pNM2hsY3Bl?=
 =?utf-8?B?ZmJzTkhHQWRMUUFGa0VUMUxRa2pBcmVCNG5rRkJ3S242cG8zM3pQUGJFcFU5?=
 =?utf-8?B?N2tCMkRaSmcwbmt0bFd3YXd1VDd0QTV3c3dlWUpVc2pPcElGZ04rT3MrNmQy?=
 =?utf-8?B?QjFDVnN4T2JBTHd2RHNSV0VIY2Y3UGtNZDVtd1R1RlhJZnlhNFZwYysxZ2Ew?=
 =?utf-8?B?dWg2U3pXbFJmMEx6dTNGOGk5Vmc3c2JIOUcwem00dDNESVcwSXB6MlFIeVRa?=
 =?utf-8?B?ZkN1bFRKRTRSTFJNNjZ6VVV6dXp1RVo4aURaaS9DWEd3RW41QkJsNU9mcWhY?=
 =?utf-8?B?NDJEMXdCdlV1NkRkODRLY1JYbnRkYlhtU3pTMlQwZ1ZGd0p3YXkxakVuSFpn?=
 =?utf-8?B?SksxZklUcW5sZFNsc1ozUmtWeVNLQUxjQU9zSDJoeVhDNzBhU3hPQXFBNVZ3?=
 =?utf-8?B?VEswMjEyZlBLQnpLNnYzMmtQUk9ZQXZvcm9LUTNMWTRFVkpFL21wem5HK25m?=
 =?utf-8?B?L3M3WjNvSDdJOFRGNk1RRU10MVNJZnJYN0RRVGs3NFkvZFFOUHRtY29RcXhj?=
 =?utf-8?B?bmZlSGxwbDBwa1BGdTZZTVU1NlFjcXZDM1UzTEo5d0dXOVplTkhlbW9vcDJB?=
 =?utf-8?B?ODhFaUc2aWt6YzJRUUdQcDJDTGUyTy9nR0wzaEN1NEcwdEVwYmhrRUM0QXB4?=
 =?utf-8?B?ZVMxQ2hIR3kwa0VTRzNuNE5SdVdFS0RRYzV0WEZ4MjdNMWRLM2ZVOW04RnEv?=
 =?utf-8?B?d29tUkpKMURGSjA2c2w2OHA1KzBJUFdaZk1FZzRSZEo5Q3g1RnlOZUJzb20z?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D283CEEC1E0B44193B5A72B01F4ABFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c0dc92-698b-41f2-62d3-08da896c9bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 03:14:39.1180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdboWSvnQEVQYNQWPii7RQRMnJ1OiHIExSXMmL8B2liB/+hc5LHRz/UJIDEXfg7nmdV0QQnzIyCJGwvwb6bURQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDE0OjQ0IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
V2hhdCBpb2N0bCgpcyBhcmUgaW4gdGhlIHBpcGVsaW5lIGZvciB0aGUgaG9zdCBzaWRlP8KgIEFy
ZSB0aGV5IGFsbCBwYXJ0DQo+IG9mIC9kZXYva3ZtLCBvciBhcmUgdGhlcmUgYW55IFREWC1zcGVj
aWZpYyAiZHJpdmVycyIgZm9yIHRoZSBob3N0Pw0KDQpTb3JyeSBmb3IgbGF0ZSByZXBseS4gIFdh
cyBvbiB2YWNhdGlvbiBsYXN0IHdlZWsuDQoNCkFGQUlDVCBubyBpb2N0bCgpIGlzIGluIHRoZSBw
aXBlbGluZSBmb3IgdGhlIGhvc3Qgc2lkZSwgZXhjZXB0IHRob3NlIGJlbG9uZyB0bw0KL2Rldi9r
dm0uIMKgDQoNCkkgYW0gbm90IDEwMCUgc3VyZSBhYm91dCBURFggbGl2ZSBtaWdyYXRpb24gc3Vw
cG9ydCAoVERYIDEuNSksIHRob3VnaC4NClN1cHBvc2VkbHkgZXZlbiB0aGVyZSBhcmUgdGhleSBz
aG91bGQgYmVsb25nIHRvIC9kZXYva3ZtIHRvby4gICsgV2FuZywgd2VpIHRvDQpjb25maXJtLg0K
DQotLSANClRoYW5rcywNCi1LYWkNCg0KDQo=
