Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA0A4B8EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiBPRPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:15:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiBPRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:14:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C592A5980
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645031687; x=1676567687;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pwr8sp6voTwQon+og/xuxHjvDWiUhwT0qsidQrGzmzQ=;
  b=lu90S/+eqED11b8BvmwvnuYWGeaRlLUjJzQKvsIHyvLqrv2ibZp7kRxx
   qCUlXZNCeCPgWysjLwi6dNmyYv+DemgZxfLceE4fQrfsmPr2NVv/AoGyT
   bieehdnnIad9Io/GF+1PSLw1tQi7Z/l5UB7qr3U16tJwE3Ke9mMK6VXrz
   +4KRTr/FVbGqP1ah6gf9oE6dt+beO6/+2Ucjgovr7/Y2m8vVf7pMtncnV
   DYgrSjHZ+X/z7Z+8W/0JMJt1RyeExnxHwD/qZK6tlt/xrdLYjomuGtDUm
   tEtHYD08K+Z9w3t4KqPCeg0HO5xeuMBAWVgBdDhH3wb2TPyGyj/do5CQK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249507913"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249507913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 09:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="529598435"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 16 Feb 2022 09:14:46 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 09:14:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 16 Feb 2022 09:14:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 16 Feb 2022 09:14:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj2Trp1Scbb1fMKBeQbqMrWKM6CpPlJhuZspgrEFWOIKALSmkpRGqK5Sr1Sdeu5WAXtXPoQ45wn30mgXUaaJ6h7XWz9dE8G8WMzrMFnwQCCCrfeydG3EEKKBhE6/h1VdcqJjw7XscDJJUBeCvl0hskK9RBSXYdXLs6dvvxYqHHp+VeXaIVelx6shv8uhfrVgdLaf63EQiyAkHGa2dzz1pkYHa5IGzCbXPVv83gdeHYeWyJXMpXGIJUilfU8vJV3pPO6Bjr2l/Z/UIofR3k30SZJxxTPmfHz6WCruN0xPDJ8GcBrfeiD0PFlZAtN1xZLU9/Pz+JsBEQsXspsWnsZe7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwr8sp6voTwQon+og/xuxHjvDWiUhwT0qsidQrGzmzQ=;
 b=dVvLzxuQu6E7pXKDvyA9JjAu1QX5wSYt1ZEuCQHMus7PK8C+ClrHof+ee+TgyVTJRoUHYOrkSOcruJWddjKu7lqWNQ4t6kKmOC9i+ckMMBFq+ax1ssDzQWKGyXkFzlxefqiR2kTtLJfW87CVj06YHl9o5F7+wcjGkoCLU27JOW7TiI0tsyF7wXQBUrKRjKrgRiHvPEgUJlIGTcgDmRx2RPHQdtyugyZSLU6+nAKOnLh5iLKPT9BofvKhUWgGTY3hVyJ6oSxi+H4WLXNuJ+V9Ikl08U/ISdeYbMIkLFIuiGgzue/+wW/Z+Xas1HTPUX+SuBxDjzImxZ9DLy1vhloKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by DM6PR11MB3578.namprd11.prod.outlook.com (2603:10b6:5:143::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 17:14:43 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644%4]) with mapi id 15.20.4975.020; Wed, 16 Feb 2022
 17:14:43 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [Intel-gfx] [PATCH v7 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Thread-Topic: [Intel-gfx] [PATCH v7 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Thread-Index: AQHYIMUInhr0TB55Mk2YRvfYqRv5XayUjgMAgAAtuxCAAV1HgIAAU5Pw
Date:   Wed, 16 Feb 2022 17:14:43 +0000
Message-ID: <MW3PR11MB46512DE0897242041BAE055EED359@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220213103215.2440248-1-alexander.usyskin@intel.com>
 <20220213103215.2440248-2-alexander.usyskin@intel.com>
 <f88b7780-cf4f-d2f5-f2ba-cd3d7bf2a0d4@linux.intel.com>
 <MW3PR11MB465112EBAFF7BC9681EF2D03ED349@MW3PR11MB4651.namprd11.prod.outlook.com>
 <7ed77377-1e6e-4329-1fda-87854f9bb938@linux.intel.com>
In-Reply-To: <7ed77377-1e6e-4329-1fda-87854f9bb938@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d960236-a979-4cf8-6432-08d9f16fd2fe
x-ms-traffictypediagnostic: DM6PR11MB3578:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB35789C43CE592A1F4612CC6BED359@DM6PR11MB3578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNUSlStXwJmLR5e47NAeT3NC505WZGjJbQe+5Satv1uq4IovbyaLkD2/Ajz4Wjht3ULuWV0RvHCuMNTRSDv5A8UDcxYcNSQiLLDZDzXIRToWAkMgpiNvaLEvSNZEyplOp8AVlo1kJI/X4IBLAYIlMoWw2PyMovmrcrOfKbPQYZhZzMR+Bgp5/yzU088TBEpOO4VwP1A0p1EYG5rKLerFmP5YlTaZoTa3/GpZx5AKDUzzpM6+HmgvsH8hfwQiXmgmV5HOHk0fx2cTYEOz3loCArxArs5LVBMqWOOen2xKutPAvEP1D/yXcIWFFCAH62WeonWUA1gsnvRBLlEnHDCLBKapxinmGQghJ8QrpUtbuM/8ZLvKbjuAXyEIuMIENo5R6MWdF+XhBMSMLzdfLzuQmmWSGc2+mImCyEDdSmXV/yOlBYQUTJyi1BVyxGXENhnqgtIXw/JSGbuKnYWwCQu1A0dzo0oXKCokmmV6WS3pf25/Hc9xaQzdPzg4+muJTRRXdGg9Md6KwEuUr6qyZHjFh0VuTtMSigNUzDYtbX2N5k500bCaWOl6wMi1UjXYjxJLGSlJWYihfE/7suL09nm/GG1cjQZWq1i+5aC5x17wZACYIjei1h0/7Y2ZM/ZLjPkABuUmpgwsfa6ArtQMMfrxLGrWA0Ep0ks15em+HND1H54lPLN4ACsKIjewqRxeztAKaBZFI4YTH7DyNpN7v3Civw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(508600001)(2906002)(8676002)(316002)(38070700005)(82960400001)(38100700002)(9686003)(53546011)(76116006)(110136005)(52536014)(122000001)(54906003)(33656002)(71200400001)(5660300002)(6506007)(7696005)(4326008)(86362001)(66946007)(66476007)(66446008)(66556008)(64756008)(8936002)(186003)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2JaTEVVL2lkUGxzdm01NWh0NFJLVkdkSkEyclc5L0xEbExHMWI1Y1pKTmhB?=
 =?utf-8?B?NWtDNkFjTU1MZDZ6dXFCRkt2bER2TzM3MVlYVDNIaURJSEpYNHg0Y0VqREg3?=
 =?utf-8?B?bTlLeTJIWHFnRkF4a0pIdmVpNmFqWFVGcTAzNndRRm5SRCt1YmlCT3laUTZM?=
 =?utf-8?B?c0REd01WZ0M3Q0dpUzJMWVcrM1cvTkJRSUFqTG05RCtYTUtyRnkxbkp1RURi?=
 =?utf-8?B?K1ZTWmZPekJpbFE5S0ZTajlNaFlib0JEcTkxaFhyK3dkMnY4QjhZT1MwN2R3?=
 =?utf-8?B?M1ExRVZKOXFUQTl2Y3VaTmJqMGdrN3JEUG5SaHJWQXpWNGcrd2pQYlp0NTZr?=
 =?utf-8?B?UUJLNUpKKzR4ZmV2UXF1dXZ4VlJFVlprZVlBczRGbUtDVVBUaGRMaW5vOEdw?=
 =?utf-8?B?aW50Y2xtMUhrRDJLZjdkZC9vZkFNanpTOTJLbXZ0Rnl0M2s0MyttRGQ4U29H?=
 =?utf-8?B?Ym1FbmNMVGVaSkR4S3VCZnVzL3Z6Vnl3T0l4Z1JOVnBCczMzRjJNdU5iRFgy?=
 =?utf-8?B?MEh0LzZxNHNFZ09GOWpIVXB5T1pQVHQ4NmRPMEpPK0RrTFllZjBURUNNZjFV?=
 =?utf-8?B?WUV5MS9uczk1MTRGVStKaHZjYUplamdqSU5aQ3oxOTN0bXA2S2pVK1VNNGdB?=
 =?utf-8?B?WmhneTFpWUJHK1FVNFlHQTZhTTFFdEcvd0loaUF0Y2hHTE5oZmRhNTdJMTRm?=
 =?utf-8?B?Y1paenJCUjRiaTlWTlpodElYSDRER2pISEhOUTZTTDFDRVhGSWZRRHNEN3Vy?=
 =?utf-8?B?S3dqWEQyNk1taDY2Zk5VbXhocTJIWjhYOE1JclMyWUNUOEI4MmlGV015RERM?=
 =?utf-8?B?cUVxNXpKTGtLZU1pRkY4UmlSd0ZBL2gra2IwaS82T1FFQ2gyMTI1MjBkcHdt?=
 =?utf-8?B?RGZUSStJckhiQlNhU2txSzh1T3N1WUlHK0llYmF1OWJvai9Zb3lJdFNFSHlu?=
 =?utf-8?B?K1hKQUpXYjhwYkhBR1JzNzRQck5TenhCRG5rQXh2OXhqRUo1WWVIUTRWM1FR?=
 =?utf-8?B?cWgrcjlQZGNTTjBXWlp6bVlQS3EvZ2lYblVjUml5YmthWWlEa3pyblRFUXFT?=
 =?utf-8?B?a0xNQXc2ZnVBQ05XOTVtQ1g5S2JHWmtuMUF6bFJ3c2N0dEtKbUN1SkViMjd6?=
 =?utf-8?B?TlY0bGN3RUp0Nm1JdWticmkzU0NPOUlFRWcwRFpPbUJJZFpad21NREdUNCtt?=
 =?utf-8?B?b2NMRTMwOXp1TURjaXd3azZ4ZGVZRUhOY3YxbzVZWFc4OUZVMCtuOGVEMnRW?=
 =?utf-8?B?bmkwVWdzbE94SFIweHVuWjhPTExXcElQREFFdVdqNTNFRk9xd1A0Zkl5UTFZ?=
 =?utf-8?B?Y1VGdTJhVEowVGU1Slludk56amhDK0VNNGpTSWs0azZERmloWm56ODJFSCtj?=
 =?utf-8?B?ZmZoUlRQdk5jUVJ4bmtmVElNMndlQnZwSXBCQk4vb1pYL1pNMUMwTEJ1Vk5n?=
 =?utf-8?B?REd0VmFxQ2N3MThndjArNGtGRzZLMHU3KzFaUjd1cVYrNmQveXUxcVB3REdr?=
 =?utf-8?B?UUtTY1Y5OTlxMThaYi9yekFEdDZUNHRISmVrNUR6QW5xTFYzeWxpUGkwZkVh?=
 =?utf-8?B?YnN5R2F5WmNUd0FIamg3UFA4MEErbHYvRU9RWTI2Syt1dWI2MHNrd1V4SmpV?=
 =?utf-8?B?K1VSZDMzRHdOdlVDYllBSE9ndHNYMlZ5Y1FFVHV0eGpzbVllcVVyMlBWT3p1?=
 =?utf-8?B?clJDSmQrYTZSam05aXpZSndHcVE1TjB6UGhBVW5kOXkrVHV2T25QcjlkWG9J?=
 =?utf-8?B?NW8rVmFaczFhcFRxWWFuOTFLemZlcUVpMFQycG9rN2h6bTlQZUtZeWpQV0hG?=
 =?utf-8?B?eE0vOWFTSnc2TlJWdGNUd1FVZU9Sb0xrSGdVS0NuZlNpWlI4VkFSMUdvYndL?=
 =?utf-8?B?MGJuSkRCdXhFNlFoOFFOUmpSWEptaDBoenRQb2g4aVZ6YzZ2a3Rtd0VlZEhm?=
 =?utf-8?B?K3FvbjdjTW1CUS9vLyt4WUtQS25OUGdJZHUvSnYzbVVjN2tYYldud2t0a0pn?=
 =?utf-8?B?K2hTbmZhQWtoOEI4ckppRHU4RWtqY2RPRStHN050Z1FFNXgzeVAyRWY1dnE2?=
 =?utf-8?B?Vm9pQ2h3cUFDY3JRVkhpdXl2MnJMcXlxTlM4N21LUWE5WDVpb2xpd0d2d0t5?=
 =?utf-8?B?UUo0aU9Hc1IvM1pid2UwUUtEQ1F4UE9ObFZlc21oeWtzRTVyK1N5YU12SUo2?=
 =?utf-8?B?dkpYOW91WUVCRGd1UGovUHJ0NFdtcXBRVXU3RmFyWmFoVzN5Wk1HYTY1cGJY?=
 =?utf-8?B?ZDl3UDEvanhGaG9oZnliYm1QSHhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d960236-a979-4cf8-6432-08d9f16fd2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 17:14:43.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrSR0wQO0l9T7bGOM4ICJLPuX2SQugS87JEubtlgERTZBHPzlsRFxo/70p1o5sjnUI6lPeJ6a+V6ywh64vh6CcrqoEiWIwW8kIstSNhiu7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3578
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHZydGtvIFVyc3VsaW4g
PHR2cnRrby51cnN1bGluQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJy
dWFyeSAxNiwgMjAyMiAxNDowNA0KPiBUbzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIu
dXN5c2tpbkBpbnRlbC5jb20+OyBHcmVnIEtyb2FoLQ0KPiBIYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IEphbmkgTmlrdWxhDQo+IDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5j
b20+OyBKb29uYXMgTGFodGluZW4NCj4gPGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRlbC5jb20+
OyBWaXZpLCBSb2RyaWdvIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPjsNCj4gRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPiBD
YzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgV2lua2xlciwgVG9tYXMNCj4gPHRvbWFz
LndpbmtsZXJAaW50ZWwuY29tPjsgTHViYXJ0LCBWaXRhbHkgPHZpdGFseS5sdWJhcnRAaW50ZWwu
Y29tPjsgaW50ZWwtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6
IFtJbnRlbC1nZnhdIFtQQVRDSCB2NyAxLzVdIGRybS9pOTE1L2dzYzogYWRkIGdzYyBhcyBhIG1l
aQ0KPiBhdXhpbGlhcnkgZGV2aWNlDQo+IA0KPiANCj4gDQo+IE9uIDE1LzAyLzIwMjIgMTU6MjIs
IFVzeXNraW4sIEFsZXhhbmRlciB3cm90ZToNCj4gDQo+ID4+PiArew0KPiA+Pj4gKwlpcnFfc2V0
X2NoaXBfYW5kX2hhbmRsZXJfbmFtZShpcnEsICZnc2NfaXJxX2NoaXAsDQo+ID4+PiArCQkJCSAg
ICAgIGhhbmRsZV9zaW1wbGVfaXJxLCAiZ3NjX2lycV9oYW5kbGVyIik7DQo+ID4+PiArDQo+ID4+
PiArCXJldHVybiBpcnFfc2V0X2NoaXBfZGF0YShpcnEsIGRldl9wcml2KTsNCj4gPj4NCj4gPj4g
SSBhbSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzIGludGVycnVwdCBzY2hlbWUgLSBkb2VzIGRldl9w
cml2IGdldCB1c2VkIGF0DQo+ID4+IGFsbCBieSBoYW5kbGVfc2ltcGxlX2lycSwgb3IgYW55b25l
LCBhZnRlciBiZWluZyBzZXQgaGVyZT8NCj4gDQo+IFdoYXQgYWJvdXQgdGhpcz8gSXMgZGV2X3By
aXYgcmVxdWlyZWQgb3IgeW91IGNvdWxkIHBhc3MgaW4gTlVMTCBqdXN0IGFzDQo+IHdlbGw/DQo+
IA0KDQpJdCBpcyBub3QgdXNlZCwgd2lsbCByZW1vdmUNCg0KPiA+Pg0KPiA+Pj4gK30NCj4gPj4+
ICsNCj4gPj4+ICtzdHJ1Y3QgaW50ZWxfZ3NjX2RlZiB7DQo+ID4+PiArCWNvbnN0IGNoYXIgKm5h
bWU7DQo+ID4+PiArCWNvbnN0IHVuc2lnbmVkIGxvbmcgYmFyOw0KPiA+Pg0KPiA+PiBVbnVzdWFs
LCB3aHkgY29uc3Qgb3V0IG9mIGN1cmlvc2l0eT8gQW5kIGlzIGl0ICJiYXIiIG9yICJiYXNlIiB3
b3VsZCBiZQ0KPiA+PiBtb3JlIGFjY3VyYXRlPw0KPiA+Pg0KPiA+IFNvbWUgbGVmdG92ZXIsIHRo
YW5rcyBmb3Igc3BvdHRpbmcgdGhpcyENCj4gPiBJdCBpcyBhIGJhc2Ugb2YgYmFyLiBJIHByZWZl
ciBiYXIgbmFtZSBoZXJlLiBCdXQgbm90IHJlYWxseSBtYXR0ZXIuDQo+IA0KPiBJcyBpdD8NCj4g
DQo+ICsJYWRldi0+YmFyLnN0YXJ0ID0gZGVmLT5iYXIgKyBwZGV2LT5yZXNvdXJjZVswXS5zdGFy
dDsNCj4gDQo+IExvb2tzIGxpa2Ugb2Zmc2V0IG9uIHRvcCBvZiBCQVIsIG5vPw0KPiANCg0KT2Zm
c2V0IG9uIHRvcCBvZiBERyBiYXI7IGJ1dCBzdGFydCBvZiBIRUNJMS8yIGJhciB0b28uDQoNCj4g
Pj4+ICt7DQo+ID4+PiArCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXZfcHJp
di0+ZHJtLmRldik7DQo+ID4+PiArCXN0cnVjdCBtZWlfYXV4X2RldmljZSAqYWRldjsNCj4gPj4+
ICsJc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmF1eF9kZXY7DQo+ID4+PiArCWNvbnN0IHN0cnVj
dCBpbnRlbF9nc2NfZGVmICpkZWY7DQo+ID4+PiArCWludCByZXQ7DQo+ID4+PiArDQo+ID4+PiAr
CWludGYtPmlycSA9IC0xOw0KPiA+Pj4gKwlpbnRmLT5pZCA9IGludGZfaWQ7DQo+ID4+PiArDQo+
ID4+PiArCWlmIChpbnRmX2lkID09IDAgJiYgIUhBU19IRUNJX1BYUChkZXZfcHJpdikpDQo+ID4+
PiArCQlyZXR1cm47DQo+ID4+DQo+ID4+IElzbid0IGluZl9pZCA9PSAwIGFsd2F5cyBhIGJ1ZyB3
aXRoIHRoaXMgcGF0Y2gsIHJlZ2FyZGxlc3Mgb2YNCj4gPj4gSEFTX0hFQ0lfUFhQLCBzaW5jZSB0
aGUgc3VwcG9ydCBpcyBpbmNvbXBsZXRlIGluIHRoaXMgcGF0Y2g/IElmIHNvIEknZA0KPiA+PiBi
ZSBtb3JlIGNvbWZvcnRhYmxlIHdpdGggYSBwbGFpbiBkcm1fV0FSTl9PTl9PTkNFKGludGZfaWQg
PT0gMCkuDQo+ID4+DQo+ID4gVGhlcmUgd2lsbCBiZSBwYXRjaGVzIGZvciBvdGhlciBjYXJkcyB0
aGF0IGhhdmUgcHhwIGFzIHNvb24gYXMgdGhpcyBpcw0KPiByZXZpZXdlZC4NCj4gPiBJdCBpcyBi
ZXR0ZXIgdG8gaGF2ZSBpbmZyYSBwcmVwYXJlZCBmb3IgdHdvIGhlYWRzLg0KPiANCj4gTXkgcG9p
bnQgaXMgdGhpbmdzIGFyZSBoYWxmLXByZXBhcmVkIHNpbmNlIHlvdSBkb24ndCBoYXZlIHRoZSBp
ZCAwIGluDQo+IHRoZSBhcnJheSwgcmVnYXJkbGVzcyBvZiB0aGUgSEFTX0hFQ0lfUFhQLiBZZXMg
aXQgY2FuJ3QgYmUgdHJ1ZSBub3csIGJ1dA0KPiBpZiB5b3UgYWRkIGEgcGF0Y2ggd2hpY2ggZW5h
YmxlcyBpdCB0byBiZSB0cnVlLCB5b3UgaGF2ZSB0byBtb2RpZnkgdGhlDQo+IGFycmF5IGF0IHRo
ZSBzYW1lIHRpbWUgb3IgcmlzayBhIGJyb2tlbiBwYXRjaCBpbiB0aGUgbWlkZGxlLg0KPiANCj4g
SSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIHRoZSBjb25kaXRpb24gbWFraW5nIGl0IHNvdW5kIGxp
a2UgdGhlcmUgYXJlDQo+IHR3byBjcml0ZXJpYSB0byBlbnRlciBiZWxvdywgd2hpbGUgaW4gZmFj
dCB0aGVyZSBpcyBvbmx5IG9uZSBpbiBjdXJyZW50DQo+IGNvZGUsIGFuZCB0aGF0IGl0IHRoYXQg
aXQgbXVzdCBub3QgYmUgZW50ZXJlZCBiZWNhdXNlIGFycmF5IGlzIGluY29tcGxldGUhDQo+IA0K
DQpXZSBpbml0aWFsaXplIGJvdGggY2VsbHMgaW4gZ3NjLT5pbnRmIGFycmF5LCB0aGUgZmlyc3Qg
b25lIHdpdGggZGVmYXVsdHMgKHR3byBsaW5lcyBiZWZvcmUgdGhpcyBsaW5lKQ0KZm9yIHN5c3Rl
bXMgd2l0aG91dCB3b3JraW5nIFBYUCwgbGlrZSBERzEuDQpUaGUgY29kZSBvbiBHU0MgbGV2ZWwg
ZG9lcyBub3Qga25vdyB0aGF0IHdlIGRvbid0IGhhdmUgUFhQIGFuZCBkb24ndCB3YW50IHRvIGtu
b3cuDQoNCj4gPj4+ICsNCj4gPj4+ICsJaWYgKCFIQVNfSEVDSV9HU0MoZ3QtPmk5MTUpKQ0KPiA+
Pj4gKwkJcmV0dXJuOw0KPiA+Pg0KPiA+PiBMaWtld2lzZT8NCj4gPj4NCj4gPj4+ICsNCj4gPj4+
ICsJaWYgKGd0LT5nc2MuaW50ZltpbnRmX2lkXS5pcnEgPD0gMCkgew0KPiA+Pj4gKwkJRFJNX0VS
Uk9SX1JBVEVMSU1JVEVEKCJlcnJvciBoYW5kbGluZyBHU0MgaXJxOiBpcnEgbm90DQo+ID4+IHNl
dCIpOw0KPiA+Pg0KPiA+PiBMaWtlIHRoaXMsIGJ1dCB1c2UgbG9nZ2luZyBmdW5jdGlvbnMgd2hp
Y2ggc2F5IHdoaWNoIGRldmljZSBwbGVhc2UuDQo+ID4+DQo+ID4gZHJtX2Vycl9yYXRlbGltaXRl
ZCBmaXRzIGhlcmU/DQo+IA0KPiBBRkFJQ1QgaXQgd291bGQgYmUgYSBwcm9ncmFtbWluZyBidWcg
YW5kIG5vdCBzb21ldGhpbmcgdGhhdCBjYW4gaGFwcGVuDQo+IGF0IHJ1bnRpbWUgaGVuY2UgZHJt
X3dhcm5fb25fb25jZSBzb3VuZHMgY29ycmVjdCBmb3IgYm90aC4NCj4gDQoNClN1cmUsIHdpbGwg
ZG8NCg0KPiA+Pj4gICAgfQ0KPiA+Pj4gQEAgLTE4Miw2ICsxODUsOCBAQCB2b2lkIGdlbjExX2d0
X2lycV9yZXNldChzdHJ1Y3QgaW50ZWxfZ3QgKmd0KQ0KPiA+Pj4gICAgCS8qIERpc2FibGUgUkNT
LCBCQ1MsIFZDUyBhbmQgVkVDUyBjbGFzcyBlbmdpbmVzLiAqLw0KPiA+Pj4gICAgCWludGVsX3Vu
Y29yZV93cml0ZSh1bmNvcmUsIEdFTjExX1JFTkRFUl9DT1BZX0lOVFJfRU5BQkxFLA0KPiA+PiAw
KTsNCj4gPj4+ICAgIAlpbnRlbF91bmNvcmVfd3JpdGUodW5jb3JlLCBHRU4xMV9WQ1NfVkVDU19J
TlRSX0VOQUJMRSwJICAwKTsNCj4gPj4+ICsJaWYgKEhBU19IRUNJX0dTQyhndC0+aTkxNSkpDQo+
ID4+PiArCQlpbnRlbF91bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+PiBHRU4xMV9HVU5JVF9DU01F
X0lOVFJfRU5BQkxFLCAwKTsNCj4gPj4+DQo+ID4+PiAgICAJLyogUmVzdG9yZSBtYXNrcyBpcnFz
IG9uIFJDUywgQkNTLCBWQ1MgYW5kIFZFQ1MgZW5naW5lcy4gKi8NCj4gPj4+ICAgIAlpbnRlbF91
bmNvcmVfd3JpdGUodW5jb3JlLCBHRU4xMV9SQ1MwX1JTVkRfSU5UUl9NQVNLLAl+MCk7DQo+ID4+
PiBAQCAtMTk1LDYgKzIwMCw4IEBAIHZvaWQgZ2VuMTFfZ3RfaXJxX3Jlc2V0KHN0cnVjdCBpbnRl
bF9ndCAqZ3QpDQo+ID4+PiAgICAJaW50ZWxfdW5jb3JlX3dyaXRlKHVuY29yZSwgR0VOMTFfVkVD
UzBfVkVDUzFfSU5UUl9NQVNLLA0KPiA+PiAJfjApOw0KPiA+Pj4gICAgCWlmIChIQVNfRU5HSU5F
KGd0LCBWRUNTMikgfHwgSEFTX0VOR0lORShndCwgVkVDUzMpKQ0KPiA+Pj4gICAgCQlpbnRlbF91
bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+PiBHRU4xMl9WRUNTMl9WRUNTM19JTlRSX01BU0ssIH4w
KTsNCj4gPj4+ICsJaWYgKEhBU19IRUNJX0dTQyhndC0+aTkxNSkpDQo+ID4+PiArCQlpbnRlbF91
bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+PiBHRU4xMV9HVU5JVF9DU01FX0lOVFJfTUFTSywgfjAp
Ow0KPiA+Pj4NCj4gPj4+ICAgIAlpbnRlbF91bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+PiBHRU4x
MV9HUE1fV0dCT1hQRVJGX0lOVFJfRU5BQkxFLCAwKTsNCj4gPj4+ICAgIAlpbnRlbF91bmNvcmVf
d3JpdGUodW5jb3JlLA0KPiA+PiBHRU4xMV9HUE1fV0dCT1hQRVJGX0lOVFJfTUFTSywgIH4wKTsN
Cj4gPj4+IEBAIC0yMDksNiArMjE2LDcgQEAgdm9pZCBnZW4xMV9ndF9pcnFfcG9zdGluc3RhbGwo
c3RydWN0IGludGVsX2d0ICpndCkNCj4gPj4+ICAgIHsNCj4gPj4+ICAgIAlzdHJ1Y3QgaW50ZWxf
dW5jb3JlICp1bmNvcmUgPSBndC0+dW5jb3JlOw0KPiA+Pj4gICAgCXUzMiBpcnFzID0gR1RfUkVO
REVSX1VTRVJfSU5URVJSVVBUOw0KPiA+Pj4gKwljb25zdCB1MzIgZ3NjX21hc2sgPSBHU0NfSVJR
X0lOVEYoMCkgfCBHU0NfSVJRX0lOVEYoMSk7DQo+ID4+DQo+ID4+IFdoeSBlbmFibGUgdGhlIG9u
ZSB3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBwYXRjaD8gTm8gaGFybSBkb2luZw0KPiBp
dD8NCj4gPj4NCj4gPiBObyBoYXJtIGFuZCB0aGUgbmV4dCBwYXRjaCB3aWxsIGJlIHNvb24sIHRo
aXMgcGF0Y2ggdW5mb3J0dW5hdGVseSBpcyBsb25nDQo+IG92ZXJkdWUuDQo+IA0KPiBKdXN0IGZl
ZWxzIGEgYml0IGxhenkuIFlvdSBhcmUgYWRkaW5nIHR3byBmZWF0dXJlIHRlc3QgbWFjcm9zIHRv
DQo+IHByZXBhcmUsIHNvIHdoeSBub3QgdXNlIHRoZW0uDQo+IA0KDQpJJ3ZlIGJlZW4gdG9sZCB0
aGF0IGJldHRlciB0byBlbmFibGUgdGhlbSBib3RoIGZyb20gdGhlIEhXIHBlcnNwZWN0aXZlLA0K
dGhlIHJlYWwgaW50ZXJydXB0IGVuYWJsZSBtYWdpYyBoYXBwZW5zIGluIEdTQyBGVywgbm90IGhl
cmUuDQogDQo+IFJlZ2FyZHMsDQo+IA0KPiBUdnJ0a28NCg0KLS0gDQpUaGFua3MsDQpTYXNoYQ0K
DQoNCg==
