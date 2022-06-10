Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC27546959
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbiFJPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiFJPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:25:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1F635B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654874706; x=1686410706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HexiX6vJIxBQR6aWZ4kTANS3/5NQuXtxK/6IfH+nlMI=;
  b=FYIMpRH0NoDOUpgppgw6kQhgKcpGFJdMArEEEntRd5jjfuTzOoXlNeIh
   VeUYsq+v5YlDIOSsfX1y8HEZlQoNlqlMDReoipTwzCGGh48ZOjhc9iq7n
   vFobY1BxEFxP09gMj/0a930RIROPFiHiO4Clr7y0he6ymEI4Aup51Uqld
   7z82Z5MrRZtkcO+xU/8vYlRR+6EYsoeBSOD94rgYSeyDPMoFlybBKY/RL
   lnY+yKegwhZaJyz8Ih/JwOH4RRj4/y5D31KHETmJOF8Hb6Bexk9909PiY
   QwClGUpR31tZrXQMoCFSuo4XdqbHBxP2F3+DVu4mL5ExVGgTTR4DvSYo2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="341717438"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="341717438"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 08:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="908956664"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2022 08:25:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 08:25:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 08:25:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 08:25:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo6Ju+cBVn+AxAc5hDQHFkK0ayD5EsqUfGjWTeZvPSHVuIovK8Qv05n+QEMfBmN1OzdHF2B5nevSsVhSDr5M/urLUJcblBjVewoCWWpvRfhqHbSmqrW7Df8le7eP9whnZ1mAnlIv9KrOYgfBVz+4g1DC++c2HejA1zjW+hFqA0e4crRpeDMT1RC75JG4vh52FOKubZ2Bh8jfLsYFbKSezMmlbJBAl8gdFiEbvBqnz2lWzQo/IlrRLqE4+LGLWgC+xRiuZEjLQZfSNpvHXKX1b6sY9KvAQwfhpZrDlhZWOaiLqbUgn5kEOifEJuMLmVngfRknYXwAhUeXSuxfSydFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HexiX6vJIxBQR6aWZ4kTANS3/5NQuXtxK/6IfH+nlMI=;
 b=D3fyxpB5x68j4iKC0Dv5xJVEeX6CHn2+B4W68AdtYd3in7TZk8BvI44bk+EE77R4CZKJd7KmGE+2CI9cv+i8DaeeyKm7eES4uHZWKzWH2hVIEJiWROKGa3SoZcnJZNP3YzlHl65SdJ8yFWs8zDbnVryKOBHNi/g9WF7g9k4BlsqOdTA7snVRNeughmG6pE2pj0kBeZt/xPZWA5V0xLHXE93IEBY2pdqZlSJCBz+0d0sEUwZcji+paHgRIM6IQ3UN/Gdp1XkrOfPLoZX4zMTR726WyoKWfhbf7joS4zjzTVwHiL/LrGX9bYPyw9ac84oPnE7pKXmK5yA8ryfzkIM6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1328.namprd11.prod.outlook.com (2603:10b6:300:2b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 15:25:02 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 15:25:02 +0000
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
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Topic: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Index: AQHYfNjBqEEvHjFqM0aC2BTrZ5Vx5a1Iws6A
Date:   Fri, 10 Jun 2022 15:25:02 +0000
Message-ID: <eb22968d0691760f579b90cd4bf75bfc4be0edeb.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dad8961-f74e-49fd-cfec-08da4af5636f
x-ms-traffictypediagnostic: MWHPR11MB1328:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB1328A379C3D1271823BD8A4AC9A69@MWHPR11MB1328.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZf+GIq4rCbl7lJ0eESlSlbxuC0LZoAFRjtwd6xI16cAFSBtlJJPn2bkluJGjqmT0AoTzeEhk2BExefXn5nCgAc0u2l/PsFZMEzAqmS4dcueodM7Iq3/PJQXGr+g8X/DW1b/SRl0/MDVBUwDpM3Ref2K7aoPEYnlAGqefzk3iBrrYooZlr6+m0BKIP/WdjDFamRtfa72zUEynt2k5kwX17NZaZvJwHBkyYtQJOex6ZlODuSGA6glSqoP6okqqjwfYP8RnlbbduMRVhUjjaeny+k6ZkT2gHeO+Naax5+B3Issfr//VpwGULz2JX/cgDDbi+nKEgef92192YfcfG6u+iGFDg2o9mmEVmZK9GGS24T/H8pdhRvsXgACFumlXhsSCc98ZpXwItsPRO0cJjvV3hctRw8zyMnOSxnMavZ2YiacOq3oyQbqtJ2qks3yKAbGBsqJ5DQuIAFsMWZUA5aI/erpOY4p/Nd+rUhbOSHrd4OE4ALIPjQ2UCf6enOT6tRywHixPHO+/Efv0iXgpWIDXfi1mjpSEI0/5ymR1fPain5VSIZOsMMcNcGjw2kcY9ifHi6w45InoVI9RdTFJxwBQiiOnqh6PRzbr3GrzSRqdZTUPR2XHUVK5V1ccCLVnW5M3bzQfbiyYhQckUGYo5Tmckpo5+PYd9DDFAK5XJxFn4PdsvE5hl592PQzqy35RDgosyg6a0EUq3qHd9si/6aHaFFRlDwgRY5F7rv5YNwXcec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66446008)(38100700002)(186003)(38070700005)(110136005)(64756008)(66476007)(66556008)(36756003)(316002)(8676002)(4326008)(83380400001)(66946007)(54906003)(76116006)(71200400001)(8936002)(6486002)(7416002)(5660300002)(6512007)(26005)(508600001)(122000001)(82960400001)(6506007)(2906002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SURKTkxDZU9JczRGQWJsWSt1UDJjeTF4YkZqRFVONXpjRVV5U21WWjhCVnJv?=
 =?utf-8?B?S2Jtc2QyMUtQbTBJeXJNcFlRVndCU0QvcUpIQnYwazgrNkJzRXRneUhPNGxB?=
 =?utf-8?B?djV2K282b1k5L2xjdkhYd2hmT1l1RmlVbDBidmJ3bjhmN2dwT2l3SWF1S0hF?=
 =?utf-8?B?bVYzT2ZKR2d0WlBVbjU5UE1pZVBoMXRheExzQzBVdS93VnA5T2JXSjczd0cz?=
 =?utf-8?B?NzJQOTBzS2w0WnRUVEtoK0ZYYWdlNTY3YTBuNHZPbkdsZE85M05vdDFHMkt1?=
 =?utf-8?B?d3BxSzZEUnByekptcVhwaTZid3M4ZXRybmhuUE1zbHJhTEJlNitCVHAyQ1dF?=
 =?utf-8?B?LzJjMVdlaDBXK1RNekhrR0sybmRIZzhQOTRlaExiY2s0ZHk3TjNvWk1lMEpE?=
 =?utf-8?B?M08yY0l3MVpEc0pkWnhpUSt0dEFzeVlmVzh6QjZQbExUUDNFcDBmS3UwaG84?=
 =?utf-8?B?bGtVZTdvNEpmVDBWRk1wU3Rrb2FmUW54NTcxRkpuT2Q3V2ZVT0YvTlQ4emFm?=
 =?utf-8?B?b3ZxWjMxQnlSbG54Wklvbm1qeHFNbWY4VHMrRXlsRHhSM0dTYjAyR092NXNl?=
 =?utf-8?B?VFVCS29CN2FZTkdJZ1d1ZTFHY3dMbVU1MXVXR2dTeFFOWlo4QThPa3IvOFl0?=
 =?utf-8?B?emVEaDBTejhiaUJ6dTVONlJjaUFDWnRQRjlsejJMeWxWdFYxbldCemRuZTAx?=
 =?utf-8?B?d09JaWlVd0h1LzBRSnNSdnpvSUYrWE1pMmNOT29nUkRkcThubFRiZGZ3QVNJ?=
 =?utf-8?B?L0N5T2xKaVZwODFEMWJ5K1c0NENrbXlxZmM5aTIvTFEyQVJhb2VURzdiaDN4?=
 =?utf-8?B?aEdjL09YYVREV1k3NUtaRXBZcnA4TVJNRzMyMmhnVDhWYkZ2UG1Yb0hvK09Q?=
 =?utf-8?B?azJOekloL1lKNkdKVEUxbDJwb1VTeVd1TEx5N0pqZHBjTnlRTVRZMXhUTDhh?=
 =?utf-8?B?S0JFNDd1VXBLNUJaN1N2Nnl6VURuUHZzeDhKNlVtditLS2VlaEdHZCtqS1J4?=
 =?utf-8?B?cXphS1Rtb3Fnb1Z1Snc0bEFTblg3RWlRYk04MXU1dHZoalliR2kvZDE0Mmdq?=
 =?utf-8?B?R2hNZk9XUDBxU3NUWkhka08vR3I5UitRQjdvSE5pVTBrMGI2akNEemU1WE01?=
 =?utf-8?B?WTRYVmk3SU5KeHFhQ2J0clk3WGpoelRCWjJOOGE1b215OE9NdnQvK0ZZcHV3?=
 =?utf-8?B?cFNqWnR4bTdWNFZFNVJRTXlKSHVyaG1HZytyV05LdndTOCtiOUh1Y0hsemJ5?=
 =?utf-8?B?c1dZSzFvTVlOUmIreTBHY2x4MndZQy9pSDVhb0tEQ2tvVHBDc2krcEdGWjVH?=
 =?utf-8?B?eFpDcm5kRktjM2NmS0R2QU5tTUVobjdpWWw3RUMrY2d6QW00SXNLeHZHTjBK?=
 =?utf-8?B?VWFNck1WUlZmMzIxV09iOWhCWGlVaE53NFMyeXNmei9WNVBLQjd0b1RtTTcv?=
 =?utf-8?B?enF1K0VKbUlSeDVRbWJpZXRIWkxGTkxOMmhPaXdzeVBZd3EzVFZyOEU0cE9k?=
 =?utf-8?B?bFk3ZTBGZkV6OGpzWnFtd0NxdHVBVk5aTlp3bzk5YlBPejZ4eEdReE4rVDZ1?=
 =?utf-8?B?UGw3ejlDcU1Qc1B0VnovbE1DRnN2U001M3VmN0kwd3U1Q1BqU1lnOWxNS0U4?=
 =?utf-8?B?cS9LV2hqOVZoZ01YajA4eEM2cC9GUDdaUytWY1dMTzkvQXhUSzlSWmVSUGZS?=
 =?utf-8?B?alhXeTY1YnB5dHV0VWx6bVBvMWtXamRJQ2xYdUlVYWU3TTZZcjR1MTFQdms4?=
 =?utf-8?B?dm1mT2RDck81Z09DYUY1a2tPWDFoc25wci92bVh5R1Q4TVZCL3Y2VjJ4cFRE?=
 =?utf-8?B?dUpOWlFCQjVLQzQyZ2IyOEJyd3h3YzQ5MWVsZTFxcHN5RUdNbXpiR01TYzAw?=
 =?utf-8?B?b0ZtVEFaT3NPbFVFYkRGVFFDRWVtUWJ4YUozbk9SNnlRb0RiVlJBdmNJb0k2?=
 =?utf-8?B?T2FYYVNrdDEwYlVzQkpYTDAweVVQVkJDREptdUpjd3FWZ1l0MkEyRmhwY0du?=
 =?utf-8?B?cm81cEVkcWlNTFlWRVJLd2gzSUh0Qmk3dTFzRHFvdEZuMU4wT3B5K1lJNDNM?=
 =?utf-8?B?NmU5aTFoYjVoQ01DOGVEOFZWUzY5ZXhhMTBKdThTQVFMbndmMWNmeTNHNnJp?=
 =?utf-8?B?SUxtSjVJWlVSQjRzcmV2OE84OWlIQXhwR096Yk1CRzZDb3hxTGlmbHBQcVBp?=
 =?utf-8?B?QlF6dE1PU0V5bnVkL1duN3d4SWpFTWpydWh6aFhxa25VU0VkUU9JUVAxSDYr?=
 =?utf-8?B?YXI0cFZRU3ZnMDRKdW5OUmt5T21zaTRIajhoUlhJSlkveXE5bytZUG9wQ1NT?=
 =?utf-8?B?c1ZQNzBYcWJDQlhBU0syYXJWeUxjWldnMThjTmtCODduMEh0K1JmbFR3MWhR?=
 =?utf-8?Q?tPuAw5L4Gh7t9KBBW63fMluAYy/PBrKGzX2rJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <030A4945423EB64793C8C38E4B38F5FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad8961-f74e-49fd-cfec-08da4af5636f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 15:25:02.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n07tWD0VVBW808ALzdLhUbUh9BNe/Yjc5HSrFDKS4Ora+8bi3hU/Bq0GklUObSnYh4LqaVWeDP24EE2jWpos1C/wFjUwg2940AN6UyIntQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+ICtzdGF0aWMgaW50IHByY3RsX2VuYWJsZV90YWdnZWRfYWRkcih1bnNpZ25lZCBsb25n
IG5yX2JpdHMpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50
LT5tbTsNCg0KZG9fYXJjaF9wcmN0bF82NCgpIGNhbiBiZSBjYWxsZWQgdmlhIHB0cmFjZS4gSSB0
aGluayB5b3UgbmVlZCB0bw0Kb3BlcmF0ZSBvbiB0aGUgbW0gb2YgJ3Rhc2snLCBvciBqdXN0IGJs
b2NrIHRoZSBvcGVyYXRpb24gaWYgdGFzayAhPQ0KY3VycmVudC4NCg0KPiArDQo+ICsgICAgICAg
LyogQWxyZWFkeSBlbmFibGVkPyAqLw0KPiArICAgICAgIGlmIChtbS0+Y29udGV4dC5sYW1fY3Iz
X21hc2spDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiArDQo+ICsgICAgICAg
LyogTEFNIGhhcyB0byBiZSBlbmFibGVkIGJlZm9yZSBzcGF3bmluZyB0aHJlYWRzICovDQo+ICsg
ICAgICAgaWYgKGdldF9ucl90aHJlYWRzKGN1cnJlbnQpID4gMSkNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRUJVU1k7DQo+ICsNCj4gKyAgICAgICBpZiAoIW5yX2JpdHMpIHsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0gZWxzZSBpZiAobnJfYml0cyA8
PSA2KSB7DQo+ICsgICAgICAgICAgICAgICBtbS0+Y29udGV4dC5sYW1fY3IzX21hc2sgPSBYODZf
Q1IzX0xBTV9VNTc7DQo+ICsgICAgICAgICAgICAgICBtbS0+Y29udGV4dC51bnRhZ19tYXNrID0g
IH5HRU5NQVNLKDYyLCA1Nyk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIC8qIFVwZGF0ZSBD
UjMgdG8gZ2V0IExBTSBhY3RpdmUgKi8NCj4gKyAgICAgICBzd2l0Y2hfbW0oY3VycmVudC0+bW0s
IGN1cnJlbnQtPm1tLCBjdXJyZW50KTsNCj4gKyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiAgbG9uZyBkb19hcmNoX3ByY3RsXzY0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50IG9w
dGlvbiwgdW5zaWduZWQNCj4gbG9uZyBhcmcyKQ0KPiAgew0KPiAgICAgICAgIGludCByZXQgPSAw
Ow0KPiBAQCAtODI5LDcgKzg1NSwxMSBAQCBsb25nIGRvX2FyY2hfcHJjdGxfNjQoc3RydWN0IHRh
c2tfc3RydWN0ICp0YXNrLA0KPiBpbnQgb3B0aW9uLCB1bnNpZ25lZCBsb25nIGFyZzIpDQo+ICAg
ICAgICAgY2FzZSBBUkNIX01BUF9WRFNPXzY0Og0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIHBy
Y3RsX21hcF92ZHNvKCZ2ZHNvX2ltYWdlXzY0LCBhcmcyKTsNCj4gICNlbmRpZg0KPiAtDQo+ICsg
ICAgICAgY2FzZSBBUkNIX0dFVF9VTlRBR19NQVNLOg0KPiArICAgICAgICAgICAgICAgcmV0dXJu
IHB1dF91c2VyKGN1cnJlbnQtPm1tLT5jb250ZXh0LnVudGFnX21hc2ssDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgX191c2VyICopYXJnMik7DQo+ICsg
ICAgICAgY2FzZSBBUkNIX0VOQUJMRV9UQUdHRURfQUREUjoNCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBwcmN0bF9lbmFibGVfdGFnZ2VkX2FkZHIoYXJnMik7DQo+ICAgICAgICAgZGVmYXVsdDoN
Cj4gICAgICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ICAgICAgICAgICAgICAgICBicmVh
azsNCg==
