Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7F4BC486
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiBSBUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:20:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiBSBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:20:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36CF1451CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645233628; x=1676769628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ubwu+WwKP4GdDBieckOlXdDo+0xxGAbJ8eqfWqcrPPU=;
  b=JVXAKWonzS52mbPFVo+Uodhs2+59oPnQfF2lb6SAOoUeUUGXaJcplUqn
   P3J7mwAsUWsmIAcbXNlk8V7ADVjzcN5Dj0EnTAgePKhghZrZ/tVSGPaEJ
   Uj2PVKRoMGgJCcK0zaf9EsYAIE8JfWAm1SyMHQBexEG/nmg7N8rbw14QD
   gmuRyP8bYLP3jw7UsqjP81x7gMOltvfiraZUfNwrKke18QSl8qi09oJBp
   bK4m+ugiaLzqv024tLhI+riVySfCDyOae4c/nSF9mzmWfbpvR3F9eIUVA
   zHrw9m/2HvPPzmBVKdEVr+YI1c6jJAcn9uxjUCo0vZHd+H7h42Si0iRMc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="251012228"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="251012228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="636057002"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2022 17:20:26 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 17:20:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 17:20:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 17:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSD7iBVx5kxGE49BUkOdWK1+a/PZRooCuUwQkmm8ubY0hQOE2/3G1i5MrIUyRY+/x+1eLajHh+TcWnE2xNZiOhIv6xruMH44pF92WsY6/Tw/eAl3ecY4TaWCcmrJH8RhbCkRp8pqcQnnRyn6VboMBBx00K7AC6hT49bsDtjNbu0btR7+iyuhiDbdS06WABMshKhOCa74bFnsvaw4CfELbK3HXwV0HDqDv1FIXNkduD0ruRC6DfPcW25vHfL7/lf5z0Je+dRJcnTz9pnxV/LJTfLVG4QgRE36c8NcxISywirGUIndNkZQvjc64ON9/tnuOZJwGgUjLhAxGLN0Y0+O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubwu+WwKP4GdDBieckOlXdDo+0xxGAbJ8eqfWqcrPPU=;
 b=UwfyboKKKCbMQvZJJcWrDIx1ZJS6Twu8AGliss1mWIFu+ERMa3VJSMok28/gnKHDWGGMxnkXJQgpF60moHewQJC6uDO683JHyD1BQUMJRheKBza06eTdF98WYNtAaXGv25eWsyume9PVDrH81DZQvg6NsWsRwa7WPDip4imTdzquEy+k58TzX7+WAbUTxioSVi0u/cCzo2E6RaISV2Bl1McManmwzCViaNPW9Yem7ELkz9r1cnEUEbdMtGIv0tXH59b06HoZtIO0w80veKwfETVkpiGwyPPgaGnRfUbI2PLCsb0jpl/tI8y2PEC86qtaadZQcgGqyX9ZLXmWs2+Avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Sat, 19 Feb
 2022 01:20:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4975.024; Sat, 19 Feb 2022
 01:20:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Topic: [PATCH 14/29] x86/ibt: Add IBT feature, MSR and #CP handling
Thread-Index: AQHYJSo1enFjW+ybRU+dZ/yIhjqUVayaE2eA
Date:   Sat, 19 Feb 2022 01:20:24 +0000
Message-ID: <253cf49d0b1ba9957d155764ec31dd91e82643d1.camel@intel.com>
References: <20220218164902.008644515@infradead.org>
         <20220218171409.395399333@infradead.org>
In-Reply-To: <20220218171409.395399333@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c0c331a-6ea1-471d-e14b-08d9f3460132
x-ms-traffictypediagnostic: DM8PR11MB5623:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM8PR11MB56235BF8380B496D02064391C9389@DM8PR11MB5623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYiw/m1ghwdS7KKGZqUA+MSh6f5yS6uW3VGHDJC38RiPuvRts+qj3+IzQxlPdzqZ9I3u4cbLdGpx964bfM/Hla00YX9RkOTNKCtcMRRyc3Gql6dNG+wZl7rQCQYV5uaWiTU0SPwULblpR25YyPNToO6veFnseiiYHqxo9CbqLXeHwXh7KHGuVhHAy1UD1VJMkAlvvrWYPUbCsoQTFVnEwzkUubqf5chyUIErhf5PVRy7XNOtNOZ8RIe4TnoGapot5FRWOdoiWEuRHZSDURgT8L0DX4XrxRwPakN5MLt8n7Om6y3vXLk2mNqceQKeD2wD+LiglI9NgxQx3ChW/yo9pfenbDCpe8UBirt/B72yOUg566AOxAHKWC+zJCYpgkgaXb5R+lT8oPCNtfFtcAXcsdEQdoqi90sjVTFXfTSreSa2HuiUZoLODP7ONRYxLTrR0YCEHBgzKlBPbTd/6y16qZ41oX2ETtXQseTAEU+NWZVp1Y7jjkulMYhbKdx0LQiboeOUz3LFiFnNaH/R4WRtLhtxQFDY3Nspe9K5OfP56O0+cAj5vJAGVlxJ9lmxwi3Mbc126SbL7N9OMQnguVJlGUukrXWqxw4BmJK/7hTxIi5NyZ0AeSn/p/cu0GXw/0w9Oe+qH5yFB0f3qIbbcnG/5FWq1h1J++WdRFSstwcd8zLsYPPcY21tID76nr7roJKWDO0FX+lXu3Ho8hOEyiMdnaCp3yiBBsxEvSIOuQUAh80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(64756008)(316002)(66446008)(4326008)(110136005)(38100700002)(2906002)(82960400001)(6512007)(71200400001)(6506007)(76116006)(38070700005)(66556008)(54906003)(66476007)(86362001)(66946007)(508600001)(107886003)(5660300002)(36756003)(122000001)(2616005)(4744005)(6486002)(7416002)(26005)(186003)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SldtS3NpcG5KRTllR0lIUXpLdGdzQ0JVWVJjVEFXNW9YdjUyangwVkdleEd0?=
 =?utf-8?B?MzBZMWpZemc0ZFVrb2ZZYnJvSlJXU2Q4VUlUTEY0dkNJY1FHV1hvaXdvYkRM?=
 =?utf-8?B?UW9TRTFSZ1k0TldXbmlQR28yV2htV09yclRQRVdMRUN5d0dGbXZvUkYyczE3?=
 =?utf-8?B?N0l4VmdGOEwyVEpxaTZSaXBPeXFxekNlU3pDWXZ6KzhPbDFsMFZxN2lBd0Rs?=
 =?utf-8?B?OU4yV21zMG5ZSzM1WG00M21udkp4a3NnUk5raDlPWkdlYkJva3FVbjlaVUVW?=
 =?utf-8?B?cGFmZjhRcU5GUmQ4YXhDdTRnQkxqZTdKRkNxSUhDUHZMSlo3NnRsbU9DWnhz?=
 =?utf-8?B?K0RQZ0hyVGNPd2tuRWRwUWZWZm5iZXJaYjkwaGdrcVcxT3RNQktnalZWMzgr?=
 =?utf-8?B?ZlAwQWg2aldDb1NWdjdIcG9ZUHNKZlpwVkpCdDdQUW9zRXJ5NEQ5aktndWVp?=
 =?utf-8?B?bkxJd0tIbndvcVZYb0pBalBFeUhUQ2NMVFFxMGpmVGR3aDZzM1NadDJOUCtm?=
 =?utf-8?B?aGRjTXZOMmk2R29hdUN6S0Q2dyt0a0Y4eXJTWWZ1L1FPS1JEQnNuSXpsdEZj?=
 =?utf-8?B?VjI5R09mY1VneXRTSEMvV0haOVZjY1ZQZG5VcWdscjBsYkF0Y1VVYU5tNTVl?=
 =?utf-8?B?YVdoVHQyaEV2M3BFNEhwTTgzUnNDRGlQZlBKUGYzSkFVZ0Zsekg3bW5YL1JD?=
 =?utf-8?B?VkE0bU1md05QbmQ1Tm85WUQrYWg2KzBMKzFYakdQczErQWVZNzFHaGhSM2gz?=
 =?utf-8?B?a3ZreWowYlk0MEkwNWtFdExiY04wdjZCbklwM0lZTS9xS2tMVVpTUkMwVkNL?=
 =?utf-8?B?cy8zbG9hK2hRMmg3azZFMHM5SjNqY2hMYTZFMSt6YjQ5ZGk5alpxeG5rc0lu?=
 =?utf-8?B?QkdkWXJIeTZHWEl2NnNEV05GcVNHUmlTLzViU3o5OVFsUUJxYVRHTFAwK3ho?=
 =?utf-8?B?enZqaHNVSlVzdHBUMWJESmRJMUVzT1FBUG9ncEJELzY1T3VoU0E1YXRRdkY2?=
 =?utf-8?B?SVBlSTJBQWtIcFA5TENnTHkxUFNCVGdPYlJkS0wvaXAzTkxEVWVxdnB1VU9I?=
 =?utf-8?B?a1JQcGtZbVo4c3IreHNNODJxOVdDRVBma2hiVTh5U0lVZmYrYjdXZk5kQjUv?=
 =?utf-8?B?WGtoRW9nYzhTT284ZE5KNnlDbXFESnl5ckM0Z0lUOXhWQitDMUZGU2tWbURP?=
 =?utf-8?B?OEVkQWJyQ09Ka1pFQTFIVDBUNHdNcWlVK1A0UE5DUHhvaEpaSUJ1Q0R4U0xW?=
 =?utf-8?B?NitjTmlVUVFNYjhET3NUbms5YWtVckY0SFJmam5QVUU2Tk4zd2JXSllSUitW?=
 =?utf-8?B?aWdSeDQ2Mkt5RElJcURsRkZjOXlBRDQwOS9HcHlyZHhGOG42YllxbDRFcGkz?=
 =?utf-8?B?RWQ4TTlqVWFpU21LZnZFOTE1R1dFVWJhak9FOUZJV0gycktVckFjTGRmNS9w?=
 =?utf-8?B?YTBzaVdYUkp2VG5NQTVISXVEY0xzQjJVenlISTV6TWU3djRkWlpLZVNzclBv?=
 =?utf-8?B?UFd4dXkzOHB6Qng0NXRCZ2tNazJaQWdiVFBLdDlWbDd4NUdJSEgwdVFRY1JX?=
 =?utf-8?B?d0U0bEVPdTl2NkJDLzNWV3JIVUhKNVpNTFllNXpJY3JYMkMvTk91bnZRTFNO?=
 =?utf-8?B?V3hKL1Qra0YwMFJVWk9Tb2RQemFKRnE2MTBrUWkzcUh6M3o4ZzdTUzh1NGE2?=
 =?utf-8?B?NlNla1ZCR0Jsbjc4MytwYWNkQkFEQVZyRGJCSlBUSDlZODRHTmMyMy9DU1Rm?=
 =?utf-8?B?d3ZHR2lHZFI0eENTbnE2d0xkSkxUYXF6bytHeWIvT2Z3bmlOZHpvZTZPNllv?=
 =?utf-8?B?akZ1b1lVYk8xNFZGUStyVUxmOVRaY2VrSkNUS1VZUU1EU0dkZEhtWHg0RzBt?=
 =?utf-8?B?YWNyWjM3QTZXZzJYU0FOcDI3OTFGQllVTWlud0JTUW0weFA5RzVlZ0NGZVF4?=
 =?utf-8?B?QWRTS0pmUDVOWlBQTlkrQ05aeFN2Q2Q4V1ZQN1piUXhvTFhiZ3NQNlJtc0V5?=
 =?utf-8?B?Mm1FTko4VndnM255b0tPLzVkdVpDNFpZZW5LSzZrLzF4UUZKVlpUQmEwNjY5?=
 =?utf-8?B?WkhYSE1QSTRQZUo3dFVLYlNPbXFTNFJSMlVaUnI3OEl0L3lyM2NJMWJXbFZR?=
 =?utf-8?B?THM1cldzQnpnVVUvNkgrMWRENDR5N3dRMUdSRTAraDhaUFZGWnNBbmNkLzNk?=
 =?utf-8?B?ZTYrWEo1eUVFZC9jM2FxbEhvWDJxVCtOa3ZCdjlaQ0UxcGpHbklPVnpib0tl?=
 =?utf-8?Q?PedxeqPrMfjoowAUrBfzA000NrxXXr7pLObcx1esAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2B592FE3B73E4BBCA662CF06BF8811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c331a-6ea1-471d-e14b-08d9f3460132
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 01:20:24.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8yZiDvJmZw5NqMIezIGcq5tCzjePQyqkCJ8hcXR95VP+kM2uuBno5Pp2h/dsJyo1ZKiso5Uh9CiSn8kTU8B8fBVCUDFAs1ud6XOohGEbfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTE4IGF0IDE3OjQ5ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzZXR1cF9jZXQoc3RydWN0IGNwdWluZm9f
eDg2ICpjKQ0KPiArew0KPiArICAgICAgIHU2NCBtc3I7DQo+ICsNCj4gKyAgICAgICBpZiAoIUlT
X0VOQUJMRUQoQ09ORklHX1g4Nl9JQlQpIHx8DQo+ICsgICAgICAgICAgICFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ICsN
Cj4gKyAgICAgICBjcjRfc2V0X2JpdHMoWDg2X0NSNF9DRVQpOw0KPiArDQo+ICsgICAgICAgcmRt
c3JsKE1TUl9JQTMyX1NfQ0VULCBtc3IpOw0KPiArICAgICAgIGlmIChjcHVfZmVhdHVyZV9lbmFi
bGVkKFg4Nl9GRUFUVVJFX0lCVCkpDQoNCkl0IG11c3QgYmUgdHJ1ZSBiZWNhdXNlIG9mIHRoZSBh
Ym92ZSBjaGVjay4NCg0KPiArICAgICAgICAgICAgICAgbXNyIHw9IENFVF9FTkRCUl9FTjsNCj4g
KyAgICAgICB3cm1zcmwoTVNSX0lBMzJfU19DRVQsIG1zcik7DQo+ICsNCj4gKyAgICAgICBpZiAo
IWlidF9zZWxmdGVzdCgpKSB7DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoIklCVCBzZWxmdGVz
dDogRmFpbGVkIVxuIik7DQo+ICsgICAgICAgICAgICAgICBzZXR1cF9jbGVhcl9jcHVfY2FwKFg4
Nl9GRUFUVVJFX0lCVCk7DQo+ICsgICAgICAgfQ0KPiArfQ0KPiArDQo=
