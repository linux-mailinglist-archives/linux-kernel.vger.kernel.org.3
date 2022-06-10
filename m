Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08747547059
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 02:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348268AbiFJXzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiFJXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:55:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A551FD9E7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654905310; x=1686441310;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ILHwzbuqoTavblOqVRrMWSnbrTMh/tnvOLDHhG8DbiI=;
  b=VIjYFhDqbFFKcj7zvAjmX9j81uXhE3ROsW+hbDuL/Nk/H7Ol/8I/FG4U
   q1QSmg/qDBF0HZmnYywrAhDkc2ydOThkdXPMDEQ9fKNXNg8QxtILFkNYH
   XH97aBGVLFdpJkG1twMExUuilUnjfC1ZS3TR+qNG71Jekp4Z5yhHt85TX
   sKrTKyDxT1tvGGNfKBNw2B+AOm9rSEVLY8izqAMLY2EeDRu17wm2GsSss
   LvKX5d0qNSsoM1OjgvEupwPWQbCnJU2RmQyLOUaT8lfcqp8VBNEosIGBE
   0xzaTjmCBe8yh+sqI+sc32vKJ6Q8SRWHsXfPJAvyEqsYhknSJMe3u1RCM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="257616542"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="257616542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="586460845"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 16:55:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 16:55:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 16:55:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 16:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSmxLJXspuXujQHBWreaIP5A9R1rv7FS0Hu5z3NrvnLWHCfi25l27tygpIZd5quW/JmQ21zinGzAigbCspW4Pd4ZeksGoFoENn3gMVOcg8ppJBd3gYQBYYtBE5sMiOZoxlqd+IAJSrzpjQjZm/3IW+bNYr8SkbE4fQEGZNQ7j/V6uDL42sfLUFzNcUyfvV/nS69MLTtkZVHH+yC47Z+4uldEVOM1AxG0RYhptAg5dpaq9Kr3e2M3lgJI+yAu9FiiOOWOlx9UxGcMZlMqECs5RPBgzWNkaJkJC+LRoZDfAB0l2tDm0cO28mDZWHbJX04+WyfM51td+WpisNIV09HfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILHwzbuqoTavblOqVRrMWSnbrTMh/tnvOLDHhG8DbiI=;
 b=dABAHhbxeuxM/ZJ78h0iR2t8zC7lE+mfUyHT6QQDyOaBV0r+n5tNzz+YEw2DGpF9wfeeXslUcxGJuLX34hE2TUxYCi2hpORTnb+Z7DS9lkywYDOH203343lVTyMYXtj6sJw2wl7PrGQHFKnWckt8Vfl+pizrJi+ni8xribKPrd+aBxc64ikK+y4ww/A0Y46GzEIURPll2MFZ56S3iRLUtSygfZQlrAcBAHijh/hAX1Ea/ki3BCf5fDyNlCMA8TDcYH90Qsy6XZXNVohYrbLPER0/uHiE6NL4+VD8dx43Vyfc3OsQ0v3P9d8q3xg555EqKEdcXI28NSiSVOyOM7CJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3759.namprd11.prod.outlook.com (2603:10b6:208:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Fri, 10 Jun
 2022 23:55:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 23:55:02 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Thread-Topic: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Thread-Index: AQHYfNdb1narbRcmgUCmzQaMVS98/K1JUVEA
Date:   Fri, 10 Jun 2022 23:55:02 +0000
Message-ID: <d1a5615633f5e0376d7a75c1d8d12bbd89a7a63e.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd649891-d299-4bd0-fbb9-08da4b3ca2c8
x-ms-traffictypediagnostic: MN2PR11MB3759:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB37599A74A8BB57E3B11FF8EFC9A69@MN2PR11MB3759.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5x5RMc3xaeL/zv5xaVTS4Vl/EyBpM+QrPYR/CipnKowGiNKV5oot1iSwUNax+mezt/r5AuEumi4lc3vTjLgt1qZQ5MAO4gk7P5KuepyGJq5qGPInKOJvQHH3Hk+7fHJhQDinvpCYvjaK+fYlXc8KhiNZVpALAzyzEPtR2LQ2XTDIf5PSeoNPmujIeKbxyF9TKtIB0DgotEBVTdSR88yzVQJNa7K2qljGse/cSHhoTSYEkRMIy9NvnHand8MzN2XqrrAIHrmRkJ2+wAQ4kNPrWwwbwyAMPNdSCQnJKCAPSETZmTarC5DGxzatIo9lN7/rdgITg8KgbP77sfGdvw52Yp1uNsNSYXfIGYceKSnJSUPV5KAi0VKfwLqd4XZl7RxpMhh3XSck6+Vvl3Ir9YqDeyMcgmG1SSMrLaTceQ63XquPZT0EdjrssN7wClYyR9HxIOoMslLs4NB/0y0i+Q4k/1ubQ+Z2te8+l4ROqhoLk1gCL0FF3Ff0KsXUPOHfqxbl4dKKmxycVtIQP4DteVfFWu5NvzBkKLx2xCIBgUZjgdBschVHU9fE6qbLZ+4CMHeo+LNKfJhU2dJB+XxnBYzov4ho5/d69/aRxtafScXuqecZDTtqArn8de8f+wELuQvTgqWQ9KNMpAG1i6vRS5pu7renj1LgN82EMd+sw9qZZSDc+ypxcp2DRSGsD+OB8U4ycZ0gzWmiimH+HvllEZwUN0yQgX62sPdMSy76n4JrR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(36756003)(82960400001)(8936002)(38070700005)(122000001)(38100700002)(71200400001)(5660300002)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(6486002)(8676002)(4744005)(7416002)(6506007)(86362001)(2906002)(54906003)(26005)(316002)(110136005)(186003)(6512007)(2616005)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEtOYXg0Mk1PemdWVEs3MFR6bDUwNVZmRVpQYjVrWWVvT0U4cHkydCt0MDB5?=
 =?utf-8?B?bTF3OENreHQxb29yUXBUbFM4cklXWDZmQ0dHUGVPL29WZ1NEcDJoelhpTndI?=
 =?utf-8?B?QzhlS3dJZ1E5d3ZBUitUZDJINUQwMlpaNTc0YS9ZQnovaW5temNLUHN3ZGs3?=
 =?utf-8?B?WVMzL1p5U08vY3lieUZjRGxRSDBTVjdjWFQrcXRoTnVtNm9PenpKUTZ0ak9L?=
 =?utf-8?B?Lzc5bWJ1ZFh4ZjJGbllSa3d1RTBHZHVjVkJYbGZ6L2JHVWN2YXVXMkRKVURX?=
 =?utf-8?B?ZFJ6d2UxM0pzanU2QlMwRFF5SnRCblR4ZGdycVZmVmJRVXFndTBZNENjU3VX?=
 =?utf-8?B?TFYyajYrQjhpaXJhOWFXT3hpdEFWY3lrZVEwcjJkUjlBS2ZFTVY0anA3SzZH?=
 =?utf-8?B?dE1qVVlHTHFnY1Q1dGJnTVpDa1gyZnJ5OXZGVW04WEdoZ0lBRTd4L0wwcFZ3?=
 =?utf-8?B?WUFnTWlYekx3ZmVJLzRPaGJqWkdJZkp3NkF2RjY0ZmdxZGlGV3MwaFFpcE8v?=
 =?utf-8?B?WGZmcU5aTzY3UFZWQklPRlgzQXlZTDNrQkVjbnd4MDhtNGloQ1IrNU4yQUdH?=
 =?utf-8?B?SVlqNVNSdUQ5c29zOUhwV3g0OWt2dVdVRmJucmxwNUMvalRIUTdVSitlZ0tk?=
 =?utf-8?B?Y0V0MEJYeVVQN2RIbjZDNk9OM2NmNzNUWi82VkU1ZVB3VjhnV05nK0VvZTNr?=
 =?utf-8?B?VWhTVXJyblhiOWlzN0M3WXR1MU1xbGFYc2FWTUZkTXZKZVUrbTVQNnh1S1ZK?=
 =?utf-8?B?bWNSUWU5ZHZoK2NmRjMvcjlnaExKMDYwTy9iaTlHcHJUUGtEM1FTVlBKcDdF?=
 =?utf-8?B?ZGU2RmE4bmJwWXBVSlJwUzIrZENsMzdKRmlzaXBwajdOMlBZTE5RU2RLY3Q5?=
 =?utf-8?B?azBrb3pwM0xlWUYwRi9PeUZuenRHM0lzUUZqeXFySWNuQkRuc2F6eVpSUTlz?=
 =?utf-8?B?eXJPMVBuSW5kYm1TMVM5YWU1ZnZvUU9GRmxDTHY1Uy9GSGVweVlsTXVseTNU?=
 =?utf-8?B?YkViSFh1aGt3ZEZsT2N1a1hlUkVUWUlnK1htWG1YRCt3Rno3Y0pFVWQwZ3d5?=
 =?utf-8?B?WWUyTHZpcEdXVjVqUGJaV3l6VG1pdDk5dmVzei9Fdnp3bjgzTW83dnZTR0tP?=
 =?utf-8?B?ODFTT2NKUi9aMDlwUFdRMGpxYnpxR2UvalhTRXkvb1VyaHdsMVd1c3VHTlBT?=
 =?utf-8?B?d2M0SU51cjFLcU85dUlZNWNxck1RVk5pdTdMdW0wa1dNR1NtTzVudmJZRFNM?=
 =?utf-8?B?WHZYWUlRWUhFZmZVQ21XVWh2WHVnWWFvTmNhNElpcUpQYmpFdndDSjJlQ2ll?=
 =?utf-8?B?a0xKTURxTDRTL1BuMkxPdldSbUplUHNZUnNDZzFpRldIQWJoK2hTaHJNbkt0?=
 =?utf-8?B?SmNGZDJoR3VGb0FMTXV2MCtON0p2V0syajBpT0thSFdKeUlkTTJaS3dra2ta?=
 =?utf-8?B?ZmtQTHhKSWI0MlRaVE9UeEY5ZkZxZzJhSkNnckJIUkdiMFV1OVZ0OUNQbkFt?=
 =?utf-8?B?VGNjUmc5M1ZhSFp5SXRxVEVBSXhYMDNnQVhoVGlSVTQwWTJBSno2ZDRkblhi?=
 =?utf-8?B?M0FhNTJpMHpRUWtXT0VPWmZBa0lwN1RKdVVENUdsV0R4KytGNXluWG5QbWxM?=
 =?utf-8?B?TjJPaWRVY2g3OUM2ZHk2QXNtT1lTcy95bTdXWWxaZU1na2dZZVg2MjlHdDlK?=
 =?utf-8?B?UitaUnVEbEVlcHBwZHQ5S0RKMzkwUmRFcmNINUdWb1ZrVWtoWm4xQlp4MzdP?=
 =?utf-8?B?MG02Mis4UE9GdnNGdFprcnY2VWlIWC9EVmkvcDBxQnJkc05EUlBRYXJPRTEy?=
 =?utf-8?B?Z28yb05ZSHhYR1ZXclh0M0N2eDhPMHRtc2xvQ3crK1ZGQzhZWFJ2VkZGTW9C?=
 =?utf-8?B?a3NFa2NlcXg0QmMvaVlqSm41NEVEUVhjMy9aSERtcmc4ZGo0R0dnMThBR2tp?=
 =?utf-8?B?aDJJUVJrYUp5LzZlcnNrMHZ1dGxaSkcvUUx2TE1NWGl6bzlaaVIvTHdkMXI4?=
 =?utf-8?B?MmRLWXpZd1ozNnZ0SnFTWGhYUUpKM3MvajNkMVFoREpybTFtOU1GN2dJMVVk?=
 =?utf-8?B?UUtDbEJhQWY5QmVTNWxIclRKWEIxbGpPTzJVVUdraURXd3NxMmdwSUd6TVNK?=
 =?utf-8?B?QTJnVUFvY2FvYUt5VHlvV2ltTmdMMm16Y2pLMXd3enRYa1kvam1sNjVXbG1C?=
 =?utf-8?B?Z0xrcHlaa00zZVNkcEdneThyVXhiQzAzd3hCOFRRR09OSTNRSE91NDlFaUhx?=
 =?utf-8?B?UndWWGpTZk1POHMxMFk3ZG5KNFl2VExjWmpVL0ZQeDh2MHE0Y29PM1RlNTkz?=
 =?utf-8?B?ZWRpdFNIVzJTVHEvL2hzNVhaVzdkQmR4aVA1aWpNLzE3VGwwN1VrT0sxSy9E?=
 =?utf-8?Q?OUDJOL4PdpO2yqWyj+0vKQ3ey/D4uzFnmC1ts?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <047BAF488DAAB947B5D7C7C642D655E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd649891-d299-4bd0-fbb9-08da4b3ca2c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 23:55:02.6923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8Zgj8bxbRU9DbpdiNZmVcD2lrLB3cS4CFMZyET3NyCuLeWDvcfJvhLbyq8ur+/d2mo28VJ++L/JVF7L1TbFZa93iXWedIJk1ezxDn8HVcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEBAIC02ODcsNiArNzE2LDcgQEAgdm9pZCBpbml0aWFsaXplX3RsYnN0YXRlX2FuZF9m
bHVzaCh2b2lkKQ0KPiAgICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gdGhpc19jcHVfcmVh
ZChjcHVfdGxic3RhdGUubG9hZGVkX21tKTsNCj4gICAgICAgICB1NjQgdGxiX2dlbiA9IGF0b21p
YzY0X3JlYWQoJmluaXRfbW0uY29udGV4dC50bGJfZ2VuKTsNCj4gICAgICAgICB1bnNpZ25lZCBs
b25nIGNyMyA9IF9fcmVhZF9jcjMoKTsNCj4gKyAgICAgICB1NjQgbGFtID0gY3IzICYgKFg4Nl9D
UjNfTEFNX1U0OCB8IFg4Nl9DUjNfTEFNX1U1Nyk7DQo+ICANCj4gICAgICAgICAvKiBBc3NlcnQg
dGhhdCBDUjMgYWxyZWFkeSByZWZlcmVuY2VzIHRoZSByaWdodCBtbS4gKi8NCj4gICAgICAgICBX
QVJOX09OKChjcjMgJiBDUjNfQUREUl9NQVNLKSAhPSBfX3BhKG1tLT5wZ2QpKTsNCj4gQEAgLTcw
MCw3ICs3MzAsNyBAQCB2b2lkIGluaXRpYWxpemVfdGxic3RhdGVfYW5kX2ZsdXNoKHZvaWQpDQo+
ICAgICAgICAgICAgICAgICAhKGNyNF9yZWFkX3NoYWRvdygpICYgWDg2X0NSNF9QQ0lERSkpOw0K
PiAgDQo+ICAgICAgICAgLyogRm9yY2UgQVNJRCAwIGFuZCBmb3JjZSBhIFRMQiBmbHVzaC4gKi8N
Cj4gLSAgICAgICB3cml0ZV9jcjMoYnVpbGRfY3IzKG1tLT5wZ2QsIDApKTsNCj4gKyAgICAgICB3
cml0ZV9jcjMoYnVpbGRfY3IzKG1tLT5wZ2QsIDAsIGxhbSkpOw0KPiAgDQoNCkNhbiB5b3UgZXhw
bGFpbiB3aHkgdG8ga2VlcCB0aGUgbGFtIGJpdHMgdGhhdCB3ZXJlIGluIENSMyBoZXJlPyBJdA0K
c2VlbXMgdG8gYmUgd29ycmllZCBzb21lIENSMyBiaXRzIGdvdCBjaGFuZ2VkIGFuZCBuZWVkIHRv
IGJlIHNldCB0byBhDQprbm93biBzdGF0ZS4gV2h5IG5vdCB0YWtlIHRoZW0gZnJvbSB0aGUgTU0/
DQoNCkFsc28sIGl0IHdhcm5zIGlmIHRoZSBjcjMgcGZuIGRvZXNuJ3QgbWF0Y2ggdGhlIG1tIHBn
ZCwgc2hvdWxkIGl0IHdhcm4NCmlmIGNyMyBsYW0gYml0cyBkb24ndCBtYXRjaCB0aGUgTU0ncyBj
b3B5Pw0K
