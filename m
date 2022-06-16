Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1D54EE08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379317AbiFPXtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378998AbiFPXs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:48:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D662A34
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655423337; x=1686959337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hixme5EXo6kiVJggVg1Wdc/dqJ0SA67tFkQmq+bt+w8=;
  b=HaVyJYxo0STMvl0zGXdawDiIK3kUHZNikCFfxKh2q3d/xJjJXt8do4qm
   SB2N47djvAs5GtbDtzilzRkBMrh11pORVMKkyUYQWFb25eB/gWeeoHwiB
   ZtffEy6q1vaPN3UOhiJbkgjjsYzykK2mZvu594mg2LqFmPFbBTTHK1KOx
   8BX8TxjTdF89nfbZzFswecFCfyzTotTZC1xxgDSKZLIQjs6ommrIQyvJy
   izPOXYhhtpFtT96Wc0Twe3rV2kCdhRJ70smtZOSFDYEUMT8ZYjuE+sHGM
   zAVRFBfLWIgeJx7CpkVYW+SY7LQHKwuKJsNGREhgkDcwgqWVpEt5SlsKq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276954417"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276954417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 16:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675250357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2022 16:48:56 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 16 Jun 2022 16:48:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 16 Jun 2022 16:48:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 16 Jun 2022 16:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KItnXQOm7TuNelNplwJD92I8KRTEIkkwbt/DnlR1yAQvjaGrhUg0oiosY/hxxXUZyX4u8smXp0gxVKpFn1YNbTzOR6yKDZjH5tNgeYeS4m3drA9dRfhyOsZTgtQ95eU2qrnNu4LJ/G8ZUgZdNna2/cQI9B+TeWlGAVgxZyBz57aoozyMVs3bMJmamFD9XaDS0abyBECNZGc753qvuoIM9XkLCGtjhzLMKES5kqh9Gfv1anMr3G15Pj4utXW4f1sicLSRQttsn41Hu0MeoEeELx/nqF/d/dnGC4PNRwvwmlOpzoIvAElBN+ggqhrHaZnMI9NN4AgGFuQBPEIi/jabrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hixme5EXo6kiVJggVg1Wdc/dqJ0SA67tFkQmq+bt+w8=;
 b=USW9KPGP4RNQBMZR6xaUrj3GjoRAMsP2nQDr9d017k8kqtEwjOyBnY93WqXR3lZ3wp8TEmP1A6F/SkqIkvANwrHXIAW8ssw+vG9/RGUf5KBFQ4ZRCAhU1xO+qic8hb2BzrFiK4AClnEKvzNqpGoCFuCkQ+vI3a6/OIGcp2cDA1+CTAtT9x2cZWY5xljuD8yH5Ti/MfIxc1Uwgl7ON/8hqFcSGm+XE3CMXWi+ih1luTDMiA0RT024+sMsssFnBK7GWwkVsb8d1iq9Nf9oIDG2y6SNqZCXq8RSzu57qI3Moi9ZmELr9b9V8pXbJO0GzzINDln41QGuMrKqNTmDF1KAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 23:48:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%12]) with mapi id 15.20.5353.016; Thu, 16 Jun
 2022 23:48:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 0/8] Linear Address Masking enabling
Thread-Topic: [PATCHv3 0/8] Linear Address Masking enabling
Thread-Index: AQHYfNjFGdTdbAcQSUuXYNy1+ejGKq1Srb6AgAAObgCAAAFggA==
Date:   Thu, 16 Jun 2022 23:48:47 +0000
Message-ID: <9913f15de07c52ebc036d08b6e83d815db299b76.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <fdc44a96f0734682338930aec4884d9a2b39650d.camel@intel.com>
         <20220616234352.2h4f64a4fw46atrs@black.fi.intel.com>
In-Reply-To: <20220616234352.2h4f64a4fw46atrs@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b29b50-c813-43c0-5f97-08da4ff2c1de
x-ms-traffictypediagnostic: DM4PR11MB6551:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB655167CE87D078C720CCFB8EC9AC9@DM4PR11MB6551.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpTGnJOwtdpmYzDzVHq4plknTp7mYDIdGr4/PSgm/tQb3dH/CqczQU0Qj1mRQS0DN5QjD8iYyezQVwW9FUJCm/IXvC1ASg0cFjylb7LFyeX3EeYfqAbxN4AMgkx3kPprWCDmiXA8cCNWtMnREZzHb7Y2YYczpV3TA3tFXUpQgnEzT27OuOSArAlatEbQCt0Ean3+30ck13p7tiK/7t190pO8KuqLG/hihmdOYarSUJ/Tm+uR+pLFkWpnhof7OBZOku0jamvOV4jm0Jls4H6vKZCWMT4iAC4XfHze49WmVMO5ANVuyLM4eD86YbynO+TXRKmRvGdBAA/p7QmIai+dfJ2SpDYUH5fCy7kZMwcyWI1z2sXh2CpXjjZZvTarPY7MO90lQojyp39Nw+tGn3viiIYRAIxtwh44k6+xsCU+2BsvnXys0EV9nuF7D9TZIIQjaa9wguLlbSdOqi9dNHzgMOrlQPUU/q+6GJ2mgJRxrjhQoiqiO3y2VCFjvz+v6TDm2VMYEU9BP0X4M+xcZ7Lvg0gZbhsMAg2mI0TAUIJPOfUGzGPcO1pEswoIu6F+aAjlJJ5Hc4hw65VsIfEEHt7c56yCpMsk033rST49BntTLudOAg6p/lNTYmYuEcI9iEP7oeIEmMFF6yI+0HJJqCYczEXBGQqwod8rmf8phXAmvxVyavlPxOgyCCMsJDSb82DdavviZvg8riXN1whH+dGxXSICApKC40n6x2Aq2Ggjtlx2GES7dea6+R681eJOjWlAFr+cYBmplPuQJ/nqzoYcH6XOIsc0K79OJbCt6hbXC1KLPOw1rzl1R6vcKRtlHUeE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(6486002)(966005)(122000001)(71200400001)(76116006)(82960400001)(66556008)(66946007)(66446008)(86362001)(8676002)(66476007)(64756008)(4326008)(6916009)(508600001)(316002)(2616005)(38100700002)(54906003)(6506007)(26005)(186003)(6512007)(7416002)(8936002)(5660300002)(2906002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blVQOXFVa1RFTVFxM2NiOFBscVNZWEwra3cxbC9Tc2NVQmUvVFUyajlzeUlo?=
 =?utf-8?B?WnRzZmsrMWZNWEJ5Z2tqN0FPZHRXR3cxeWE1bGpXMG5kTi9UaC9UbllJODFF?=
 =?utf-8?B?YnVBZ3B5L29hTGovb2VVUmtGYnhjblFET0FVRU5saGRGNnYxMm5JK2dCNXZS?=
 =?utf-8?B?aW1JZHZwQm0vbjYrdHRENUxBU2FKa2FaYlIwSUlxa085VzVaOFFvNnY4MFYx?=
 =?utf-8?B?M2dPUFFVbW1zQUozeXY2RExIVDdqUVc3bUxnOHN2bG9lWVRLYThKWWpYZzFP?=
 =?utf-8?B?YmJseWkycmhGaTdUL2JKRHdSUE8wd0dEaEdxVVhFSFNQM1luWUR1Nk5Oa2Vm?=
 =?utf-8?B?cWd0eHAwY1RwZmFaRzl0MStYblk4cWV5ZzdJbUt5TkJUNnRsTjlHVm42RnNQ?=
 =?utf-8?B?ekVKdGw2aVI4Wk9ZL3ZpR1VqajVvN3FhT3c1YTNsTENhdzZkQlY1clBQVmkx?=
 =?utf-8?B?SEtmcHJFRTNMSmZEQk1iQmNBRkVCQitKdmhNZ0pwSDc1dmVoMGRWUmhGcWFR?=
 =?utf-8?B?c1BucE9wSkQ5VGxUTlJDSXJ5VmQvSk9nZGIvS2p4ZEllcUd4ZlkyRzNEdGNX?=
 =?utf-8?B?L1dUQjlVaTRKbWsyTTZzUmgya055L2VtaEJDbkNZRG5iS1FZOEpZL2hhTSs3?=
 =?utf-8?B?UmdxWG5KVUlVMjdkajIxYVVIMS80SE1kajM0cHNZZkQ1QjhiNGFia0ZuNFdM?=
 =?utf-8?B?Ky9IMVFYemZzbTVoYWZIK1owbUtCU0hQd2RSMWxXSHhJb3NWT1MzcC9UbXVl?=
 =?utf-8?B?b3RxNzBDMmt2dXhhQWZTNzk0K05rSEU4V1U0LzdYSHpjN09nd0hzWE02aUQ1?=
 =?utf-8?B?SkVzTlF0YlVLaUE0VmJJeDhQU1FvcjdyZUtBRm9BdEhRZDVmZ3QvZ3NTR0c1?=
 =?utf-8?B?cHpMdGtyam4xWDhXbk90Z0dleUtlKzBvelk1TExRTDI5TmFzNHhxdUgzSm1n?=
 =?utf-8?B?eWJ6MnRmbVV1cDZlY2lNdTVBdmVuNkZZcHNwTUFBTCs0TnJ3cUZ6clp5aGVu?=
 =?utf-8?B?U1IzN0tZYUJsaWtNRTI3c1NwQnUyVHEvY3l6S1VxN2VOc0VFblhBT3Y1Vk1w?=
 =?utf-8?B?SzIzQmJReSs5dEFGRkRyRXRNcUVUb3dnV0dzVFlieXZ5L3JqSkdRZHEyZHRW?=
 =?utf-8?B?dUxDOXhDWUdLZ3NubW15aTNLNXZ5UitkZGZGUUdLVVFGeWIxd0t5Q1pEVXJD?=
 =?utf-8?B?RFJGdG50RUh3c0swMTZvUlE0Y1NrUXVLN3FDUDBuNFp0cmV5bmFhNXo3SWlY?=
 =?utf-8?B?WnQyTnFSMXpWN3dXK3lpYzNWTlkrekZjNE01RzFYcGVkNkhLTWxDTXhScERT?=
 =?utf-8?B?U3pma0tneHEreVV2NTFkMEU0ZXdvTkJ3ZkI5NTlKcTlzTUtyMkU2dTJVV2FW?=
 =?utf-8?B?bEZlTituRW1kQzhIUnN4L1FST3Iyay9pOE5jU3kwTjUrc29DRmN5STVXUW5X?=
 =?utf-8?B?RkRWdVJ2Ukg3czRCRFJHcmtlUDlCTUwwVGZETzRoMlNqSzlHUjdXWlNCell0?=
 =?utf-8?B?NnhibDkzd2xQK29ydUlqWWNsSWhLMEFnRFNGN2V0ZWtWZGJsdVBzakkvYmZt?=
 =?utf-8?B?cUJaMFkzZ01mTE9nMXJnQVBCdVF1eEVyeStudDdpZVJZSWV5L1hoS1JETDVQ?=
 =?utf-8?B?WTFEQmppczROUklmVmRrOVlOZzAxSjVsaU91NkMwMnl5SjdGT3dGNjJsektm?=
 =?utf-8?B?OCt3UHZWaVBmRGJ1bVc0dUdneVRjS0czL1ExcFRFOHErSTJ3aGVvcmJnZDhP?=
 =?utf-8?B?VTJ6VEpIb1JaSzVBaHppVjhyVzZzM3dqSzQxS2hOTVpHSmtCem9naHIxYlp1?=
 =?utf-8?B?OU9mU3VXd2srQlZ6ekpKVm1VRzFZZ2RucVJYQ1hBaTViTjhOL3ZPOEQ3cmlS?=
 =?utf-8?B?WksvS2tGWmJ6YlQ5VXdMR1JVekNmaEJkTTRuZW1FbmdYRTBGWk8xMXJmTHlk?=
 =?utf-8?B?N3IzdVJZUDRMTkJYME5sWkVGRjJlVUlBVXJ6QUp0d2VEY2FzYlZoMjhibHlD?=
 =?utf-8?B?a3pVMVFrejAxUFJ5ak5rVHpnUWRyd0JNclR1MGIwanFweEJEZmF4OHkxSTJ1?=
 =?utf-8?B?dTVXbGkzMzVnMys2MC96amE0VjZrd0VIVDhJck85MVB4eklGR0VUSE9zSklw?=
 =?utf-8?B?WEt3UC90cFkrS3B0NzhZZ0VKa2M5Z25WYjVQU3pMZGFaU2RvMVl2c3ptOFk3?=
 =?utf-8?B?RE5LVVFvd1BpUW04ZllkRGJoSTV2SmVpY1hJYTBLNWsvMVNZcDc2bHpNaUoz?=
 =?utf-8?B?ZUt4cUpxZ2szUHYvRUprQkRPaVVQSW91T1lIZlUrQkRTbWNXU0ZvWkFoOWFX?=
 =?utf-8?B?ZUlyb0pBamdOUTlHNG1qbkJVTk9xdWhuZmV1Q2xoR0VPYkgyNTNlVU5pQUlx?=
 =?utf-8?Q?B692qZAfngWTQjQhYaWUR4nRr1dD+lYA354Q+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A2174F0B35FEF41B9E15D7A84B8F997@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b29b50-c813-43c0-5f97-08da4ff2c1de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 23:48:47.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjAB+lY187xi73Rd+h/BU/g5rj8doofuE5SDdrtt32GRwnfGejXBXa53IzpXlu33ZADQUNIi9edjkSeEIMBTiqhi4ZHof4WCYpIgONzRTFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTE3IGF0IDAyOjQzICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFRodSwgSnVuIDE2LCAyMDIyIGF0IDEwOjUyOjE0UE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMi0wNi0xMCBhdCAxNzozNSArMDMwMCwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gTGluZWFyIEFkZHJlc3MgTWFza2luZ1sx
XSAoTEFNKSBtb2RpZmllcyB0aGUgY2hlY2tpbmcgdGhhdCBpcw0KPiA+ID4gYXBwbGllZA0KPiA+
ID4gdG8NCj4gPiA+IDY0LWJpdCBsaW5lYXIgYWRkcmVzc2VzLCBhbGxvd2luZyBzb2Z0d2FyZSB0
byB1c2Ugb2YgdGhlDQo+ID4gPiB1bnRyYW5zbGF0ZWQNCj4gPiA+IGFkZHJlc3MgYml0cyBmb3Ig
bWV0YWRhdGEuDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaHNldCBicmluZ3Mgc3VwcG9ydCBmb3Ig
TEFNIGZvciB1c2Vyc3BhY2UgYWRkcmVzc2VzLg0KPiA+IA0KPiA+IEFybSBoYXMgdGhpcyBkb2N1
bWVudGF0aW9uIGFib3V0IHdoaWNoIG1lbW9yeSBvcGVyYXRpb25zIHN1cHBvcnQNCj4gPiBiZWlu
Zw0KPiA+IHBhc3NlZCB0YWdnZWQgcG9pbnRlcnMsIGFuZCB3aGljaCBkbyBub3Q6DQo+ID4gRG9j
dW1lbnRhdGlvbi9hcm02NC90YWdnZWQtYWRkcmVzcy1hYmkucnN0DQo+ID4gDQo+ID4gSXMgdGhl
IGlkZWEgdGhhdCBMQU0gd291bGQgaGF2ZSBzb21ldGhpbmcgc2ltaWxhciwgb3IgZXhhY3RseQ0K
PiA+IG1pcnJvcg0KPiA+IHRoZSBhcm0gQUJJPyBJdCBzZWVtcyBsaWtlIGl0IGlzIHRoZSBzYW1l
IHJpZ2h0IG5vdy4gU2hvdWxkIHRoZQ0KPiA+IGRvY3MgYmUNCj4gPiBnZW5lcmFsaXplZD8NCj4g
DQo+IEl0IGlzIHNvbWV3aGF0IHNpbWlsYXIsIGJ1dCBub3QgZXhhY3QuIEFSTSBUQkkgaW50ZXJm
YWNlIGltcGxpZXMgdGFnDQo+IHNpemUNCj4gYW5kIHBsYWNlbWVudC4gQVJNIFRCSSBpcyBwZXIt
dGhyZWFkIGFuZCBMQU0gaXMgcGVyLXByb2Nlc3MuDQoNCkFoIHJpZ2h0LiBJIHdhcyB0aGlua2lu
ZyBtb3JlIHRoZSBwYXJ0IGFib3V0IHdoaWNoIHN5c2NhbGxzIHN1cHBvcnQNCnRhZ2dlZCBhZGRy
ZXNzZXM6DQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FybTY0L3Rh
Z2dlZC1hZGRyZXNzLWFiaS5odG1sI2lkMQ0KDQpTb21lIG1lbnRpb24ga2VybmVsIHZlcnNpb25z
IHdoZXJlIHRoZXkgY2hhbmdlZC4gSnVzdCB0aGlua2luZyBpdCBjb3VsZA0KZ2V0IGNvbXBsZXgg
dG8gdHJhY2sgd2hpY2ggSFcgZmVhdHVyZXMgc3VwcG9ydCB3aGljaCBzeXNjYWxscyBmb3Igd2hp
Y2gNCmtlcm5lbCB2ZXJzaW9ucy4NCg==
