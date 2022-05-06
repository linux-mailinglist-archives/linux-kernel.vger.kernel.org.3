Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9845651D1A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386558AbiEFGxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386546AbiEFGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:53:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B591866C8F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651819787; x=1683355787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYE24qPED0HjtZVYA9KjE8bzePgNrPcN9TujawE5UZQ=;
  b=WSbhZzOFTrjCYN1ptcXXAw0xW/Xup3UaDBlcsSNjtcmScVZfGbJxvgKt
   K1T0TIthlCQGdzbdf2+m1zrPTG1ZZJ3T8ho7WUXPzc/fOw1UlW1Yfz8vD
   lArXs77PCACumk3y0pTNU5dpOj/ik2sSx6VskXBG/WH5OHiAHLWlZjiCd
   Sj7JUJtG1tBoV4rw3OIKRubqiRWH6G7nKoTcoks4Nhtzkcpi+kRXb5ek/
   TK6XEGnQr3BxDCR/4f9pZUc3JEhttYDfhxvOEi4PZasNtME5HSSqBvtTL
   3tC32HK++2K10uvTbTbOntu9emq51Lr/EeX+zBKSuo4yjGFgR6m6rsqqZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267211299"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267211299"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 23:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="654577929"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 05 May 2022 23:49:46 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 23:49:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 23:49:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 23:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYmQ+j0vx+07b48NIetF6DXYFT/EaYvnj+0Mb5jZEuS4H2q2WQEf1dyexs9Ra8xWfqsNwwb7xvwuMWxu6O3hWWu598f9gAi6Kq0Ju7SY5FSz+ZTy4obhZ+CEMsllWIHbdM2uT8iihWeuJQcqh1zdadAOvvyl1FlkaNK0XC2EDZHVBzQRrmRqy0M+72hREIDBKu9q+Yx2x1FQMPzJook4ZjyaoPDc2niA63GujXOr4IpwOYw4wDeJ/zlioc64DnRe6YE/AcCYZdnPoUtyZmkxJMv0OJx8HMpur3XmACaKGkqsAduvOE2K2oAHEfFKtNZfmq0aDHItwxbiJ5cA08cUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYE24qPED0HjtZVYA9KjE8bzePgNrPcN9TujawE5UZQ=;
 b=aX2C7UON5ZP5qFrz1tmGN4xQaxNRPpz+VCzJ8cZYBrPkA5unfXInxKP+dUvOqIiQX8dgBgyKeq119yc6C7KLEHSvKYoNjw0tw1NrY3sZEjdNNVUyeaBoPrWHoHwxMBraiBQJ9lgx4eQRUbNMnIhlhnyy4BD82/hBNX3d8o4EY6oHWr7EDYFPXASRVVJJm9wSS0TL6m2XrH0M8KCpXGozap8lEi5Zx6/GvvKu6eAxm87K5VgxBN7/MwYZLHwfpOQbi5Cj79iurjIMXlEbqwGmokJbBVA3ROGEq5W2Wx5guIRTYzjUoM4Y3aua7CmFcIYBKZtmlfdALo3eoyYjDbUTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 06:49:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 06:49:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "Rodel, Jorg" <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Topic: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Index: AQHYYLnAHmosHc2CfUSQkp312mWw2q0RWsAAgAAL7nA=
Date:   Fri, 6 May 2022 06:49:43 +0000
Message-ID: <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
In-Reply-To: <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 457d8204-2289-473d-2689-08da2f2c9a4b
x-ms-traffictypediagnostic: BN9PR11MB5548:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB55489965C8418BD11E0F753E8CC59@BN9PR11MB5548.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4XKtnUhe2+st2rv2TiXUf4IXYScMGN+hIcgNZM7UVSpYON/slbqbCR/+GJ2wjuAerI1ADWqbxy53wfj1NmKwDeaM4xQNfJK5RusC0pzPyQPYWKtfZBbB7AkHq26/ceblKiogg+ypwSuhmiMIvfkgQDLZPv6W9U2njpDJwa+j3oeHcFXDVsJP0+g4MoUUsXrDVUli6yWfhLCAUYd36+PnfctfZTGOiU8WKeJ3r5/0PXAOgZN4yaSdCoNrmcVgM2mz0PoWePqwlAYWhXemI2lfOwh9RqRFivJy8Qyz9gTOvmm69134vdyDaKXhT6vLxPX2K09hNeLu27tm04jJW1woeLlZoKkB++koiE29O9AmKtYTVeEY6HOfemqvtoMUsCy/roP4zNu/S/je8kj3N3YXgEYze8ZbZAI9PF5H1lugV1GIDvTpxDOtdurAbxPseXSkrZbJm9SR0Gkh22rlOAg328FWWgKzN5LMtDGtLsNBSz2Dg7mLjn9FzlrrwfvkxdWcPWYh7A1m6BC4mzDpXFfZRDP3xX/zENW/R7/CmMQWfKQLdsHQfFK29PGNvACt77uPR0CUTxg2av8d03kYY1ZnT3r3BC52FuHMOt1kEInxizx1+RwarSbbLfLlJDJrD9xkGiy/i5VEGmVFMODGTH+0+Y1f3bM3TaNxOqxQ3Lxkw+fCXGGhEDMNflQeBq9SAh3gAVACveAY5FHjCHxJKr2tOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(122000001)(4326008)(33656002)(64756008)(2906002)(52536014)(66446008)(66476007)(7696005)(8676002)(76116006)(8936002)(38070700005)(55016003)(71200400001)(38100700002)(82960400001)(7416002)(5660300002)(508600001)(316002)(83380400001)(186003)(54906003)(110136005)(26005)(9686003)(6506007)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTgxK1lvZHZqcDlnSDA2RnVRVFZ1L0RQZ3JTeG1hK3F1NDhtb2drbWxHa0ZQ?=
 =?utf-8?B?NHYySWJkc2tPdXVnVlJLUGtiTzQzWUltMitrRXVzVktBdmg4UGJVbWJ2K3NP?=
 =?utf-8?B?WFJzMTJWVFNKNGlnYmJPL05OWDFxaVhzUmhOaVVwT1JjbE90K29ZNjNEdjI0?=
 =?utf-8?B?QVJHa08yZE9TbVplclR6c1ZlWXZaQnpNNEFkcDVJMzFpUzdkcW5xM0RPYVNj?=
 =?utf-8?B?SzBKR2E0WkxROVpFMGx3MzBzQ0pYdFI5NlUwMzNoQmRZakNjL2QxbTVmNGhr?=
 =?utf-8?B?TVZWLyt6YThhUk1Cb09VVmtaek95WkQ4Z0I1b0FZZ1dHWTVrSzgydklZcFI2?=
 =?utf-8?B?bHVxa0V5cWZ6QWNOdVYrUXNYUWV1OFJ0WVRmUERiUHoyaDJ1aFEwMGNOOEZW?=
 =?utf-8?B?OFA1NWNBb1d6Z2V2d1REK1Awc2xPMFArT2ZQOXpwTnRCWVNPbFV6TFFzK1F1?=
 =?utf-8?B?aDUzK1VPOVpXV0dJQ2V0cENlcHJwOEUzN1RKR01sZGo1TVM0ZVBseEFKNjFn?=
 =?utf-8?B?enVpN2ZkWlB2aHF2SzkrbjdQdTFzQ0VIVWVJcTZRd3dXNXlyb2dTcUw2ejM2?=
 =?utf-8?B?aGc2T1lSa2dqR3JJa2cwYkVEVTV2R1pxTUNwRzlkRTl1MFRZc093TFBlajMv?=
 =?utf-8?B?aytjeUJodTJmcjRIMDhTUHVELzZnN2ZtNStESTM4ZmwyMmdLc3FwUExmOElh?=
 =?utf-8?B?QWUxQlllL0VPRGo3MmZzejlBN2FraDBSWEFUNVZkMThQNjY4TFYyeWNKcnd2?=
 =?utf-8?B?aEFyWk50RE5abkQzRnFXbFZwcEU0NnM1ek1vMENUQnVHNXJ6YTBRZFV3ZlE0?=
 =?utf-8?B?Z1I0bDkwUXcyNy9vZHlEZHlIbkIyemQycmZGVStqamU3QzFnNG5jRTdqb3B4?=
 =?utf-8?B?cjNZNzdkNGphQnlQaHFqYUwvSzVHbVJQcDN0TFVhOWloekFlVEdkZy9USmMv?=
 =?utf-8?B?Y0UwdkdUc0JPcEc4WVRCLzQ1L2FPR3k3R2JyOGVWTVFZUGp1N1d0UUE4Nm9p?=
 =?utf-8?B?SG9oTHg4QUtWTmpyTlJCd1c1RXBBbjRqRWVnbDNBWDQzSGhLQld6Ni81Z2RV?=
 =?utf-8?B?Y21zV2ZBM1pTcE11bWI1bnFuMXZYd2lzSmhjeCtqSE9jQ2Q3TnMvdVVnYnNz?=
 =?utf-8?B?RGxVaGNnTEtTTnE4WmVjU0JQT0cvYlIwSTRaMkNVN0IyK2pydWNVczRFZ2sw?=
 =?utf-8?B?dUs0NEZMM0tZZ1pYOHBqeVVxcXhvNkNyUEN2SFlPUWYxcGFBQmVNWU1DaHZl?=
 =?utf-8?B?NnpJTUFGbUdOZnIxMEhQWkZrWFdwNlM2eEF1SVBLTkxFR2RweHlTMk9TUER1?=
 =?utf-8?B?OTVGVC94TjBVWURweW1UZ25OdlowUUZMc21xaVZabm9rczZnanZVUUEyVjZ2?=
 =?utf-8?B?M0dpbEwveXp6NFdqVldHcUd1dHo0RGk4V2g5M2c3MEFXR1NnK09FOHBMa21l?=
 =?utf-8?B?RldkeW10RUxxNXBiQVNMWlVyalhiRmJkSUZxdDdTQ0R2ejJxVldKdE5TOW5K?=
 =?utf-8?B?OFJKQmFLeVZNUlNDQTZWR1lacVZJWnRPQUNTUXhjU0RKT1ZmZ1A0c05pUU5o?=
 =?utf-8?B?K0l2N1JvQ1IvWHViTkhuZExNaDZLaTMxa1B4dHRDOTZzMDFvOTRPVS9ka3du?=
 =?utf-8?B?aCs2M3NWTlBDdHNvbm1oQjUxRUJ4QWZ6aW05TzFuTXBnZDZ2Z0NMc2FoMWho?=
 =?utf-8?B?aDFWTTRjckZ0SGtGb2tRUnNrRGJKaWQzenA0TkExbTBrSHFqL1ZKK25kUzBI?=
 =?utf-8?B?NEtZWjd4c3JDWUVQWURoeVcrZmYyYytNUUhNUzRyMWxLSVpmN1NWOC9DMW1H?=
 =?utf-8?B?MG1WdWJRUFVNbjJ6RzI4QmJ4bU9xUkUwL0NoWG1Rc3l5ay9qWkswSk9yWFE4?=
 =?utf-8?B?NFFJdERBYTFPR1VqZDIrd3ZuUEljUFA3NlVhbWc5bE1oRU1QK3d3SmR6ZXVa?=
 =?utf-8?B?RGYveWVnMTFxWk9tMnBpQjdnNlNack1oaVdTRXZkMHdBdER0OGpsK2U3dnVB?=
 =?utf-8?B?YW53djZWWXV2eVQyYzlwMUlGUWhrVy9JdmMrMjlaSHlER0VhRGk0THlDb3hX?=
 =?utf-8?B?ZklZci9qeURRTFMrTmg4d2MvQTdtWFJGWFRXZExlK2wreVltWUhEYkUyNTFl?=
 =?utf-8?B?ajdINmM3YVZqVnBYazlGblgwczdPL04vNkFOWjU1bkRNZW16ckxkdVJuVmJp?=
 =?utf-8?B?VXBDVFBRanNJM0JyU29pTWFWenp1TFlycHVXYkZiVnppQWtmQ3pMT0ZQQTdW?=
 =?utf-8?B?ay92QVZNRmdDQTArUTQyaCtwbWdJZTBuaGQyZnJLVGNBNlM4Njh1a3dhYTRl?=
 =?utf-8?B?SmNHSjU1RGhtVlpXRnlIZzB1M0ZoWFZsYytPT2l3TkM4RWF0bFV6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457d8204-2289-473d-2689-08da2f2c9a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 06:49:43.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNaP3jaIHBApyxAce9n12TacGOKiu0UcGW66S8Ez1YzBzdD691mRlkpFAot/mIzDD8Fu4CVfSHXx3F3pL24GVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSA2LCAyMDIyIDE6NTcgUE0NCj4gDQo+IE9uIDIwMjIvNS82IDAzOjQ2LCBTdGV2ZSBX
YWhsIHdyb3RlOg0KPiA+IEluY3JlYXNlIERNQVJfVU5JVFNfU1VQUE9SVEVEIHRvIHN1cHBvcnQg
NjQgc29ja2V0cyB3aXRoIDEwIERNQVINCj4gdW5pdHMNCj4gPiBlYWNoLCBmb3IgYSB0b3RhbCBv
ZiA2NDAuDQo+ID4NCj4gPiBJZiB0aGUgYXZhaWxhYmxlIGhhcmR3YXJlIGV4Y2VlZHMgRE1BUl9V
TklUU19TVVBQT1JURUQgKHByZXZpb3VzbHkNCj4gc2V0DQo+ID4gdG8gTUFYX0lPX0FQSUNTLCBv
ciAxMjgpLCBpdCBjYXVzZXMgdGhlc2UgbWVzc2FnZXM6ICJETUFSOiBGYWlsZWQgdG8NCj4gPiBh
bGxvY2F0ZSBzZXFfaWQiLCAiRE1BUjogUGFyc2UgRE1BUiB0YWJsZSBmYWlsdXJlLiIsIGFuZCAi
eDJhcGljOiBJUlENCj4gPiByZW1hcHBpbmcgZG9lc24ndCBzdXBwb3J0IFgyQVBJQyBtb2RlIHgy
YXBpYyBkaXNhYmxlZCI7IGFuZCB0aGUgc3lzdGVtDQo+ID4gZmFpbHMgdG8gYm9vdC4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFdhaGwgPHN0ZXZlLndhaGxAaHBlLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogTWlrZSBUcmF2aXMgPG1pa2UudHJhdmlzQGhwZS5jb20+DQo+ID4gLS0tDQo+
ID4NCj4gPiBOb3RlIHRoYXQgd2UgY291bGQgbm90IGZpbmQgYSByZWFzb24gZm9yIGNvbm5lY3Rp
bmcNCj4gPiBETUFSX1VOSVRTX1NVUFBPUlRFRCB0byBNQVhfSU9fQVBJQ1MgYXMgd2FzIGRvbmUg
cHJldmlvdXNseS4NCj4gUGVyaGFwcw0KPiA+IGl0IHNlZW1lZCBsaWtlIHRoZSB0d28gd291bGQg
Y29udGludWUgdG8gbWF0Y2ggb24gZWFybGllciBwcm9jZXNzb3JzLg0KPiA+IFRoZXJlIGRvZXNu
J3QgYXBwZWFyIHRvIGJlIGtlcm5lbCBjb2RlIHRoYXQgYXNzdW1lcyB0aGF0IHRoZSB2YWx1ZSBv
Zg0KPiA+IG9uZSBpcyByZWxhdGVkIHRvIHRoZSBvdGhlci4NCj4gDQo+ICtLZXZpbg0KPiANCj4g
VGhpcyBtYXhpbXVtIHZhbHVlIHdhcyBpbnRyb2R1Y2VkIGJ5IGJlbG93IGNvbW1pdC4gQW5kIEkg
ZG9uJ3Qgc2VlIGFueQ0KPiBoYXJkd2FyZS9zb2Z0d2FyZSByZXN0cmljdGlvbnMgdGhhdCB3ZSBj
YW4ndCBlbmxhcmdlIGl0IGFmdGVyIHRlbiB5ZWFycy4NCg0KSSBkb24ndCBzZWUgYSByYXRpb25h
bGUgZWl0aGVyLCBidXQuLi4NCg0KPiANCj4gY29tbWl0IDFiMTk4YmIwNGFkNzI2NjlkNGJkNjU3
NWZjOTk0NWVkNTk1YmZlZTANCj4gQXV0aG9yOiBNaWtlIFRyYXZpcyA8dHJhdmlzQHNnaS5jb20+
DQo+IERhdGU6ICAgTW9uIE1hciA1IDE1OjA1OjE2IDIwMTIgLTA4MDANCj4gDQo+ICAgICAgeDg2
L2lvbW11L2ludGVsOiBJbmNyZWFzZSB0aGUgbnVtYmVyIG9mIGlvbW11cyBzdXBwb3J0ZWQgdG8N
Cj4gTUFYX0lPX0FQSUNTDQo+IA0KPiAgICAgIFRoZSBudW1iZXIgb2YgSU9NTVVzIHN1cHBvcnRl
ZCBzaG91bGQgYmUgdGhlIHNhbWUgYXMgdGhlIG51bWJlcg0KPiAgICAgIG9mIElPIEFQSUNTLiAg
VGhpcyBsaW1pdCBjb21lcyBpbnRvIHBsYXkgd2hlbiB0aGUgSU9NTVVzIGFyZQ0KPiAgICAgIGlk
ZW50aXR5IG1hcHBlZCwgdGh1cyB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIElPTU1VcyBpbiB0aGUN
Cj4gICAgICAic3RhdGljIGlkZW50aXR5IiAoc2kpIGRvbWFpbiBzaG91bGQgYmUgdGhpcyBzYW1l
IG51bWJlci4NCj4gWy4uLl0NCj4gDQo+ID4NCj4gPiAgIGluY2x1ZGUvbGludXgvZG1hci5oIHwg
MiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWFyLmggYi9pbmNsdWRlL2xp
bnV4L2RtYXIuaA0KPiA+IGluZGV4IDQ1ZTkwM2Q4NDczMy4uOWQ0ODY3YjhmNDJlIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZG1hci5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9k
bWFyLmgNCj4gPiBAQCAtMTksNyArMTksNyBAQA0KPiA+ICAgc3RydWN0IGFjcGlfZG1hcl9oZWFk
ZXI7DQo+ID4NCj4gPiAgICNpZmRlZglDT05GSUdfWDg2DQo+ID4gLSMgZGVmaW5lCURNQVJfVU5J
VFNfU1VQUE9SVEVECU1BWF9JT19BUElDUw0KPiA+ICsjIGRlZmluZQlETUFSX1VOSVRTX1NVUFBP
UlRFRAk2NDANCj4gPiAgICNlbHNlDQo+ID4gICAjIGRlZmluZQlETUFSX1VOSVRTX1NVUFBPUlRF
RAk2NA0KPiA+ICAgI2VuZGlmDQo+IA0KDQouLi4gaXMgaXQgbmVjZXNzYXJ5IHRvIHBlcm1hbmVu
dGx5IGRvIDEweCBpbmNyZWFzZSB3aGljaCB3YXN0ZXMgbWVtb3J5DQpvbiBtb3N0IHBsYXRmb3Jt
cyB3aGljaCB3b24ndCBoYXZlIHN1Y2ggbmVlZC4NCg0KRG9lcyBpdCBtYWtlIG1vcmUgc2Vuc2Ug
dG8gaGF2ZSBhIGNvbmZpZ3VyYWJsZSBhcHByb2FjaCBzaW1pbGFyIHRvDQpDT05GSUdfTlJfQ1BV
Uz8gb3IgZXZlbiBiZXR0ZXIgY2FuIHdlIGp1c3QgcmVwbGFjZSB0aG9zZSBzdGF0aWMNCmFycmF5
cyB3aXRoIGR5bmFtaWMgYWxsb2NhdGlvbiBzbyByZW1vdmluZyB0aGlzIHJlc3RyaWN0aW9uDQpj
b21wbGV0ZWx5Pw0KDQphbm90aGVyIG5pdDogZG1hciBpcyBpbnRlbCBzcGVjaWZpYyB0aHVzIENP
TkZJR19YODYgaXMgYWx3YXlzIHRydWUuDQoNClRoYW5rcw0KS2V2aW4NCg==
