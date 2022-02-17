Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738E4B9CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiBQKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:13:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiBQKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:13:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6661405E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645092767; x=1676628767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HhPsuWqlANJiF08cqnEU1PZl1QPSwNelZ6kgdCOy398=;
  b=hNpR1wgwGeWkxac7hpHnhPuXYoPPuptYVfzgjw9cjEBPIkkqMiAkO1O2
   jxBxMINbhPUXWTHsKcLj/KNfRADVZMvFwA0j4e9Jw7UL7JOfU5jRRKSk/
   rPfW394AE3VnRqOLnsz2m2yOdEDfTSaJvuzzpU6ZyXbi7NTTKUHozKN/p
   CzQtbDCktolWoNk/kXbotO74ONLiLHww/wus5tKYrNbiaUcl+olM/NHr2
   d/EonAxa4G9KJnQwBtzlWkKvM+RGj3oDudxmrAVBh4V2tY9roWv9kzxrg
   MAHBop1paOLNeNR7GPEdRrginbjtjWKZe0YvtMVECuc95u1FFYAcp5cmv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275430527"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="275430527"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503439418"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 02:12:42 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 02:12:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 02:12:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 02:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUx+VVwBoLBtFbeF0Jk6DutDwfTs5X3rI/HzdBQdOdOEdXE0Zl38J0p3S0J5sCGcnr/2lJCTcil1WXnOF6UsChdfuh25UJ09bXQ1ZmnTxYYpJ8EjjKzPrzcgGDQNbXFHDu8V/hbcprnqsUnPKdyh8KSccdPVfTONsK5niDpqp9KVStJmCH8MVnEzYADVrysQwgEjv+TCdLpRhMgb85fM1pftZ10P+1O6OFUOkdX9On5jAq4k2KLMBORGaJ5zD+i32Ag506nk/RQ33Jo66stREKH03RvRPOy0WGJosRESDAxQthzlUL/EzcguMX79MHH9cp8VnrsFGPyk+VLNgeBXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhPsuWqlANJiF08cqnEU1PZl1QPSwNelZ6kgdCOy398=;
 b=cByA7CZJ7klSabnRCf/gjFzbuib17JJJwoUvabl16nDd+R0ipfDk+TfrhVJZK0b1+cpeddIe9sRHvYlUtsRjohZo3FbdR/GxANujbvw5hbsX25L5hI5TRyq5RCxvr08PXm/pprCdIlhvklyOMiDgcuOJaV23zMGlMefLIPm1EiLtdvGP67pBmTrzrYbU2XfQi5zlZSTXQdjiMhg7S2bRymkNjMzchlUk1ihMTjvgI62oH4aZyVTreNj06n9JSaPZieix8gqDQ0wbqbnlWFxd4eEUII/jLb3ng10pTlo/aTSXiJl8D4dhHtFYkxZZs2K6n3NGN/iJ9GFuxmTr0n4ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by BL1PR11MB5512.namprd11.prod.outlook.com (2603:10b6:208:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Thu, 17 Feb
 2022 10:12:39 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::6498:650a:6a82:7644%6]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 10:12:39 +0000
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
Thread-Index: AQHYIMUInhr0TB55Mk2YRvfYqRv5XayUjgMAgAAtuxCAAV1HgIAAU5PwgAESswCAAAnUQA==
Date:   Thu, 17 Feb 2022 10:12:39 +0000
Message-ID: <MW3PR11MB465118BF5A9F56BFDE356684ED369@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220213103215.2440248-1-alexander.usyskin@intel.com>
 <20220213103215.2440248-2-alexander.usyskin@intel.com>
 <f88b7780-cf4f-d2f5-f2ba-cd3d7bf2a0d4@linux.intel.com>
 <MW3PR11MB465112EBAFF7BC9681EF2D03ED349@MW3PR11MB4651.namprd11.prod.outlook.com>
 <7ed77377-1e6e-4329-1fda-87854f9bb938@linux.intel.com>
 <MW3PR11MB46512DE0897242041BAE055EED359@MW3PR11MB4651.namprd11.prod.outlook.com>
 <9910e85e-334d-7ceb-f7f2-6fc25eaacf1e@linux.intel.com>
In-Reply-To: <9910e85e-334d-7ceb-f7f2-6fc25eaacf1e@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: c05fe6bc-c50c-443d-234a-08d9f1fe077f
x-ms-traffictypediagnostic: BL1PR11MB5512:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL1PR11MB5512E8C42BD89DDDC4952B9EED369@BL1PR11MB5512.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhVKpVV+bhhKQEwrbaXETHJIAz82ZQMAY8C3OOqhGRxzQTCj0iSzynwrdRlKqVhpW8VosqaCwUF/UA/L5jhq8hp4O88NIQSElymh4YPfgdshp4EIIstAxHbvVNaHDdQgqll8pWxrbTw2sGfM6rpjS+bOxNwrjg7mWQdCkSAr1zK6nifHvTQS/Zq2OGkHW9mPSJoUXphSc8XUtA3O5Fb0X/cLIIgUy4kL/fVguPSz+Ag2e6j1AzLf3uFDs3FujPRPPEZMAd28vJj7JCrQ3HageSf7q96CO8h62ghqsL+YROtRlEjw82j5aSpJVN9kdcUAo/PA3aDeWYBjnh1KOoQODCCXtsWWb+qwvL0VpKMOMVsIS9KNDKV/cfMZvQyTZycCLpnFV241B64/z+36kdOOgZtljEWRDZAK5xsOcTg2X3kU/aGab5pQ9KOG10Ob2GKorCjXsbUAXE6oe2dFACY14qItw54Clwozgm6yOoyz0IF3mk9cdta9W6dKPUeGp195u8UKR3lf41O7mKWB6aWyssvhd5BE9dL72BCgyBXBiVNRH1HOtgyx0/mJhouRoGNGoP8bFmpTyMctYM2MBtZlJnqkPcFNcIT+rGmc0dBkPw/X/VH9zbPw4oZNBx2emt93Ph0T9E97CDPlO30EYM7Ap/XThVBEf6KYi9XU0OrLLcNO/gOUoPpeVyPdv/W/e88iScLYjMEC3siuI/Ah4uljzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(66556008)(7696005)(8676002)(4326008)(66446008)(64756008)(6506007)(110136005)(66476007)(76116006)(8936002)(86362001)(9686003)(2906002)(71200400001)(66946007)(53546011)(83380400001)(186003)(26005)(5660300002)(33656002)(55016003)(38070700005)(82960400001)(316002)(38100700002)(122000001)(508600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVlGbUlkVEV1cTZvMFI3c3hXTDJmZHQwYVFab3haTEU5Wk0rLzdnR1lGRHA5?=
 =?utf-8?B?dlVZSlpQTHZBZ2RUQ1QzeldodC9FR0FwQ3dUODQ0RWVmZ3I3OG1DRU5Bajhv?=
 =?utf-8?B?WkUzWnlkMGhYTE1PcHRGVGVla1JoSEhxTFBmNng2dWxaZFl1ODBreTlWNEQx?=
 =?utf-8?B?cm9PbmluQ1oxRkZYZEh1YlpwSTk5c1ZjL2p5NmlHKzAvN2wwQUdoYWduOWMw?=
 =?utf-8?B?UnVKTXBZek9Sa0VqY3IvN0pPcFZBRlVWK3hzZXNPdE9sRlBlakFPbUxFL21m?=
 =?utf-8?B?T0lMOVQ2Qi9acDBUb3dNbU9tYTZMa29FSGkzNGRwMEQxdURQMnl5T0dVcVl4?=
 =?utf-8?B?WjIxcHVqdTR5dDdJa2krUzNiTXFmK3hOYXpKWUVlUHArb0xiNE8rRzlFVlJa?=
 =?utf-8?B?eW96V28yYjcvZTRpaVFxUUYrc2JWSXdCaURxM0VFVzdqNzlMNmd2RXJOak0z?=
 =?utf-8?B?RmpLc3czQ29XcStpenBlTXBrVlV6Y1VrbWhZK3NOeERzWDRqeWd1aE1KcGxY?=
 =?utf-8?B?ekFBSHB2SlY2SWlOUUxBSHJveEttTWxUNU9Nc2t4UTAvcHp3TS81RTJKc0Z0?=
 =?utf-8?B?U2U3dGdPd3RHamxWU3lJK3ZyTkpLRm1WMW51dGZjZnQrS2NIdGpzNHlOWm4w?=
 =?utf-8?B?NG9PbEpieitaWjV0RUkwQXllb1VCQkFLYmJUOFdVUng5ajZVNkV5RS9WWUw3?=
 =?utf-8?B?SzY3U1oxbnZDdW05bTBtY1BuaVVEMDRzN2l6WkdreFJ5NDRZeWNmK1p5eTAv?=
 =?utf-8?B?OFFUWmxWRVpRVTJYU2krZU9jRG95SkhQa3R0S2VMMTZUZVhYRExiTjJPc2VP?=
 =?utf-8?B?YVBGbEoreFNvTW1XZXF2Z2x5Vno0elRwSkhPZmtjMDJ2RVFqNGRWWUl0U0Zt?=
 =?utf-8?B?bEhyMEtTbC9QWHF1NVBXeHZLYTlFeFUrNzNhZ1NIV1FpTzZleGJBblBOazhr?=
 =?utf-8?B?b0NQZTRpQnIvbnZkWnB2L2QzOGFlaTg2VTdFQTdUMmdiV2xYNEV0Tk5kdE5M?=
 =?utf-8?B?bWd6OVYwZHRWaWR3cTZkajVTcmUzenA1QWlKMGVOVVMwMGlFY0E0OWRxTHJR?=
 =?utf-8?B?d0lwc1ZOWUJJOCtLUmRvUkxNWEs1M1VUSyszUGRFMmhlTE5keEM5K2xvb0dm?=
 =?utf-8?B?SERSZHdmcVlZYkVad29aN25RSkJxMHY5c0J2a0wwbktDenBDNTZjUXhZaE1w?=
 =?utf-8?B?WG5wR0JKVTdmOWg4ZFBEei83cDFhUklOd2NvTXhIQVlmWndrQU9TZkU3Z1RV?=
 =?utf-8?B?N0ExbzFMa1FxcEpGU2dYUTE1QUkvb05WaHlaLzhZM1pxZmpNcU0zRVZTMXVJ?=
 =?utf-8?B?dEZ2Ui9ZaGN6NTU1N0R4N2lLMTNLeEFPMFpENUVpSUowM1BHdklnUDNxZ1ZX?=
 =?utf-8?B?eDQ3NkpiYTlXaFNWWU12RHJvV3U0STdiek5BK1M3bnRSNnNoczV4MjdWQWMx?=
 =?utf-8?B?d0FJRGZwMThJYUFSNVdLOVd0UmZ1WFNKZkJiZ2NYVUZ1Q3ExUW1WRWZqSEpt?=
 =?utf-8?B?ekFwaEk4ajhoRGNuM0NqbVo4OWVxYVdEL0RTNnNycTlrOG9Gb3R5RmNxazgv?=
 =?utf-8?B?OUhSLy9ocWZiaHIvRkdHUHVyKzd0QWdBc1hoZkx1ZDZWejZKcmxaeWdQZU14?=
 =?utf-8?B?a1VSRXppb000QWVJa09GaFp0bldYdENWcW1YdncvcGF1R3hHOVVHbXVwWERI?=
 =?utf-8?B?TWNxd3ZGaVg0WlhGeUx5ekZMMWNYdTg2Q2lMZlpmQitiazJrbUlQM3J4NEFu?=
 =?utf-8?B?SUdSRHZHaEovdVRKUWFhZEFFM0JsRjJ0NmxBMGlzWk4weHVZZ3NPVVNlV3Y0?=
 =?utf-8?B?S0c5Tml6c0tFeE96RGVNWkFiWTdUNGhORW1wcUl1RmRHbXhkR2JIaHlwOEpi?=
 =?utf-8?B?ZFp5NkVaVFQ3V0phVzJObjA2T3RNSXhvSzI4aFJVQjg2cFk2Y1dEYlREZWR0?=
 =?utf-8?B?dmdENC9EUy9oZnNLWk5lNytwT1VPUkR1ZkJTdFB0czZkWWZKbjVQdm00ZVNx?=
 =?utf-8?B?NWgzYmVHVlQyYWZISWlWMGRjQ1JCV3VRakNadUdCTkRNS1M4M3VJb3lZM2Y0?=
 =?utf-8?B?ZWpNbm1mK0dZRW5hWm5xN0tDUlBMNkVncTJoMXJxSk5qdWR3aTRXUk8ya1Mx?=
 =?utf-8?B?Zm5rM3B2Szk3V3A1RnBFT3A3cUpiay85NEpsV2tWZkx2cFBQaXpvdTJ4YXRs?=
 =?utf-8?B?eGNaYUdwY1BLTWJrQXFZSUh2aVVQbnNxMVVpRGZHa3FQS3VnSDlsOTFyVXJM?=
 =?utf-8?B?UkVGWVQvOWNiSm9wenNXRUtFMk5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05fe6bc-c50c-443d-234a-08d9f1fe077f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 10:12:39.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GKH2as7WYiInXRc1XmYIRVZnTpxvJfyxD1iHOQ8E8X447sBGwzFThBjO/ff3ebhslEXlDPr3c2UNqfvpPlIvmfHQvw/AgtDCDJLjH7RXak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5512
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHZydGtvIFVyc3VsaW4g
PHR2cnRrby51cnN1bGluQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1
YXJ5IDE3LCAyMDIyIDExOjI2DQo+IFRvOiBVc3lza2luLCBBbGV4YW5kZXIgPGFsZXhhbmRlci51
c3lza2luQGludGVsLmNvbT47IEdyZWcgS3JvYWgtDQo+IEhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPjsgSmFuaSBOaWt1bGENCj4gPGphbmkubmlrdWxhQGxpbnV4LmludGVsLmNv
bT47IEpvb25hcyBMYWh0aW5lbg0KPiA8am9vbmFzLmxhaHRpbmVuQGxpbnV4LmludGVsLmNvbT47
IFZpdmksIFJvZHJpZ28gPHJvZHJpZ28udml2aUBpbnRlbC5jb20+Ow0KPiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+DQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBXaW5rbGVyLCBUb21hcw0KPiA8dG9tYXMu
d2lua2xlckBpbnRlbC5jb20+OyBMdWJhcnQsIFZpdGFseSA8dml0YWx5Lmx1YmFydEBpbnRlbC5j
b20+OyBpbnRlbC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTog
W0ludGVsLWdmeF0gW1BBVENIIHY3IDEvNV0gZHJtL2k5MTUvZ3NjOiBhZGQgZ3NjIGFzIGEgbWVp
DQo+IGF1eGlsaWFyeSBkZXZpY2UNCj4gDQo+IA0KPiANCj4gT24gMTYvMDIvMjAyMiAxNzoxNCwg
VXN5c2tpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVHZydGtvIFVyc3VsaW4gPHR2cnRrby51cnN1bGluQGxp
bnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxNiwgMjAyMiAx
NDowNA0KPiA+PiBUbzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRl
bC5jb20+OyBHcmVnIEtyb2FoLQ0KPiA+PiBIYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz47IEphbmkgTmlrdWxhDQo+ID4+IDxqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5jb20+OyBK
b29uYXMgTGFodGluZW4NCj4gPj4gPGpvb25hcy5sYWh0aW5lbkBsaW51eC5pbnRlbC5jb20+OyBW
aXZpLCBSb2RyaWdvDQo+IDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPjsNCj4gPj4gRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPjsgRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0K
PiA+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgV2lua2xlciwgVG9tYXMNCj4g
Pj4gPHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPjsgTHViYXJ0LCBWaXRhbHkgPHZpdGFseS5sdWJh
cnRAaW50ZWwuY29tPjsNCj4gaW50ZWwtDQo+ID4+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gPj4gU3ViamVjdDogUmU6IFtJbnRlbC1nZnhdIFtQQVRDSCB2NyAxLzVdIGRybS9pOTE1L2dz
YzogYWRkIGdzYyBhcyBhIG1laQ0KPiA+PiBhdXhpbGlhcnkgZGV2aWNlDQo+ID4+DQo+ID4+DQo+
ID4+DQo+ID4+IE9uIDE1LzAyLzIwMjIgMTU6MjIsIFVzeXNraW4sIEFsZXhhbmRlciB3cm90ZToN
Cj4gPj4NCj4gPj4+Pj4gK3sNCj4gPj4+Pj4gKwlpcnFfc2V0X2NoaXBfYW5kX2hhbmRsZXJfbmFt
ZShpcnEsICZnc2NfaXJxX2NoaXAsDQo+ID4+Pj4+ICsJCQkJICAgICAgaGFuZGxlX3NpbXBsZV9p
cnEsDQo+ICJnc2NfaXJxX2hhbmRsZXIiKTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCXJldHVybiBp
cnFfc2V0X2NoaXBfZGF0YShpcnEsIGRldl9wcml2KTsNCj4gPj4+Pg0KPiA+Pj4+IEkgYW0gbm90
IGZhbWlsaWFyIHdpdGggdGhpcyBpbnRlcnJ1cHQgc2NoZW1lIC0gZG9lcyBkZXZfcHJpdiBnZXQg
dXNlZCBhdA0KPiA+Pj4+IGFsbCBieSBoYW5kbGVfc2ltcGxlX2lycSwgb3IgYW55b25lLCBhZnRl
ciBiZWluZyBzZXQgaGVyZT8NCj4gPj4NCj4gPj4gV2hhdCBhYm91dCB0aGlzPyBJcyBkZXZfcHJp
diByZXF1aXJlZCBvciB5b3UgY291bGQgcGFzcyBpbiBOVUxMIGp1c3QgYXMNCj4gPj4gd2VsbD8N
Cj4gPj4NCj4gPg0KPiA+IEl0IGlzIG5vdCB1c2VkLCB3aWxsIHJlbW92ZQ0KPiA+DQo+ID4+Pj4N
Cj4gPj4+Pj4gK30NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArc3RydWN0IGludGVsX2dzY19kZWYgew0K
PiA+Pj4+PiArCWNvbnN0IGNoYXIgKm5hbWU7DQo+ID4+Pj4+ICsJY29uc3QgdW5zaWduZWQgbG9u
ZyBiYXI7DQo+ID4+Pj4NCj4gPj4+PiBVbnVzdWFsLCB3aHkgY29uc3Qgb3V0IG9mIGN1cmlvc2l0
eT8gQW5kIGlzIGl0ICJiYXIiIG9yICJiYXNlIiB3b3VsZCBiZQ0KPiA+Pj4+IG1vcmUgYWNjdXJh
dGU/DQo+ID4+Pj4NCj4gPj4+IFNvbWUgbGVmdG92ZXIsIHRoYW5rcyBmb3Igc3BvdHRpbmcgdGhp
cyENCj4gPj4+IEl0IGlzIGEgYmFzZSBvZiBiYXIuIEkgcHJlZmVyIGJhciBuYW1lIGhlcmUuIEJ1
dCBub3QgcmVhbGx5IG1hdHRlci4NCj4gPj4NCj4gPj4gSXMgaXQ/DQo+ID4+DQo+ID4+ICsJYWRl
di0+YmFyLnN0YXJ0ID0gZGVmLT5iYXIgKyBwZGV2LT5yZXNvdXJjZVswXS5zdGFydDsNCj4gPj4N
Cj4gPj4gTG9va3MgbGlrZSBvZmZzZXQgb24gdG9wIG9mIEJBUiwgbm8/DQo+ID4+DQo+ID4NCj4g
PiBPZmZzZXQgb24gdG9wIG9mIERHIGJhcjsgYnV0IHN0YXJ0IG9mIEhFQ0kxLzIgYmFyIHRvby4N
Cj4gDQo+IE9rLiA6KQ0KPiANCj4gPj4+Pj4gK3sNCj4gPj4+Pj4gKwlzdHJ1Y3QgcGNpX2RldiAq
cGRldiA9IHRvX3BjaV9kZXYoZGV2X3ByaXYtPmRybS5kZXYpOw0KPiA+Pj4+PiArCXN0cnVjdCBt
ZWlfYXV4X2RldmljZSAqYWRldjsNCj4gPj4+Pj4gKwlzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAq
YXV4X2RldjsNCj4gPj4+Pj4gKwljb25zdCBzdHJ1Y3QgaW50ZWxfZ3NjX2RlZiAqZGVmOw0KPiA+
Pj4+PiArCWludCByZXQ7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpbnRmLT5pcnEgPSAtMTsNCj4g
Pj4+Pj4gKwlpbnRmLT5pZCA9IGludGZfaWQ7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpZiAoaW50
Zl9pZCA9PSAwICYmICFIQVNfSEVDSV9QWFAoZGV2X3ByaXYpKQ0KPiA+Pj4+PiArCQlyZXR1cm47
DQo+ID4+Pj4NCj4gPj4+PiBJc24ndCBpbmZfaWQgPT0gMCBhbHdheXMgYSBidWcgd2l0aCB0aGlz
IHBhdGNoLCByZWdhcmRsZXNzIG9mDQo+ID4+Pj4gSEFTX0hFQ0lfUFhQLCBzaW5jZSB0aGUgc3Vw
cG9ydCBpcyBpbmNvbXBsZXRlIGluIHRoaXMgcGF0Y2g/IElmIHNvIEknZA0KPiA+Pj4+IGJlIG1v
cmUgY29tZm9ydGFibGUgd2l0aCBhIHBsYWluIGRybV9XQVJOX09OX09OQ0UoaW50Zl9pZCA9PSAw
KS4NCj4gPj4+Pg0KPiA+Pj4gVGhlcmUgd2lsbCBiZSBwYXRjaGVzIGZvciBvdGhlciBjYXJkcyB0
aGF0IGhhdmUgcHhwIGFzIHNvb24gYXMgdGhpcyBpcw0KPiA+PiByZXZpZXdlZC4NCj4gPj4+IEl0
IGlzIGJldHRlciB0byBoYXZlIGluZnJhIHByZXBhcmVkIGZvciB0d28gaGVhZHMuDQo+ID4+DQo+
ID4+IE15IHBvaW50IGlzIHRoaW5ncyBhcmUgaGFsZi1wcmVwYXJlZCBzaW5jZSB5b3UgZG9uJ3Qg
aGF2ZSB0aGUgaWQgMCBpbg0KPiA+PiB0aGUgYXJyYXksIHJlZ2FyZGxlc3Mgb2YgdGhlIEhBU19I
RUNJX1BYUC4gWWVzIGl0IGNhbid0IGJlIHRydWUgbm93LCBidXQNCj4gPj4gaWYgeW91IGFkZCBh
IHBhdGNoIHdoaWNoIGVuYWJsZXMgaXQgdG8gYmUgdHJ1ZSwgeW91IGhhdmUgdG8gbW9kaWZ5IHRo
ZQ0KPiA+PiBhcnJheSBhdCB0aGUgc2FtZSB0aW1lIG9yIHJpc2sgYSBicm9rZW4gcGF0Y2ggaW4g
dGhlIG1pZGRsZS4NCj4gPj4NCj4gPj4gSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIHRoZSBjb25k
aXRpb24gbWFraW5nIGl0IHNvdW5kIGxpa2UgdGhlcmUgYXJlDQo+ID4+IHR3byBjcml0ZXJpYSB0
byBlbnRlciBiZWxvdywgd2hpbGUgaW4gZmFjdCB0aGVyZSBpcyBvbmx5IG9uZSBpbiBjdXJyZW50
DQo+ID4+IGNvZGUsIGFuZCB0aGF0IGl0IHRoYXQgaXQgbXVzdCBub3QgYmUgZW50ZXJlZCBiZWNh
dXNlIGFycmF5IGlzIGluY29tcGxldGUhDQo+ID4+DQo+ID4NCj4gPiBXZSBpbml0aWFsaXplIGJv
dGggY2VsbHMgaW4gZ3NjLT5pbnRmIGFycmF5LCB0aGUgZmlyc3Qgb25lIHdpdGggZGVmYXVsdHMg
KHR3bw0KPiBsaW5lcyBiZWZvcmUgdGhpcyBsaW5lKQ0KPiA+IGZvciBzeXN0ZW1zIHdpdGhvdXQg
d29ya2luZyBQWFAsIGxpa2UgREcxLg0KPiA+IFRoZSBjb2RlIG9uIEdTQyBsZXZlbCBkb2VzIG5v
dCBrbm93IHRoYXQgd2UgZG9uJ3QgaGF2ZSBQWFAgYW5kIGRvbid0DQo+IHdhbnQgdG8ga25vdy4N
Cj4gDQo+IEJ5IGRlZmF1bHRzIHlvdSBtZWFuICItMSIgPw0KPiANCj4gTXkgcG9pbnQgaXMgaW50
ZWxfZ3NjX2RlZl9kZzFbXSBkb2VzIG5vdCBjb250YWluIGFueXRoaW5nIHZhbGlkIGZvcg0KPiBp
bnRlcmZhY2UgemVyby4gSWYgeW91IGNoYW5nZSBIQVNfSEVDSV9QWFAgdG8gcmV0dXJuIHRydWUs
IHRoZSBjb2RlDQo+IGJlbG93IGRvZXM6DQo+IA0KPiAgICBkZWYgPSAmaW50ZWxfZ3NjX2RlZl9k
ZzFbaW50Zl9pZF07DQo+IA0KPiBBbmQgcG9pbnRzIHRvIHRlbXBsYXRlIGRhdGEgbm90IHBvcHVs
YXRlZC4NCj4gDQo+IFNvIHlvdSBoYXZlIHRvIGNoYW5nZSB0d28gaW4gY29uanVjdGlvbi4gSGVu
Y2Ugc2FmZXN0IGNvZGUgZm9yIHRoaXMNCj4gcGF0Y2ggd291bGQgc2ltcGx5IGJlOg0KPiANCj4g
ICAgaWYgKGludGZfaWQgPT0gMCkgew0KPiAJZHJtX1dBUk5fT05fT05DRSgsICJDb2RlIG5vdCBp
bXBsZW1lbnRlZCB5ZXQhXG4iKTsNCj4gCXJldHVybjsNCj4gICAgIH0NCj4gDQo+IFdoZW4geW91
IGFkZCBlbnRyaWVzIHRvIGludGVsX2dzY19kZWZfZGcxW10gaW4gYSBsYXRlciBzZXJpZXMvcGF0
Y2gsDQo+IHRoZW4geW91IHNpbXBseSByZW1vdmUgdGhlIGFib3ZlIGxpbmVzIGFsdG9nZXRoZXIu
DQo+IA0KDQpNYXliZSBiZXR0ZXIgdG8gYWRkIGNoZWNrIGFmdGVyIGRlZiA9ICZpbnRlbF9nc2Nf
ZGVmX2RnMVtpbnRmX2lkXTsgZm9yIG5hbWUgcG9pbnRlcg0KdG8gY2F0Y2ggbWlzbWF0Y2ggYmV0
d2VlbiBzdXBwb3J0ZWQgYml0cyBhbmQgZmlsbGVkIHN0cnVjdHVyZXMgaW4gZGVmaW5pdGlvbiBh
cnJheSwgbGlrZToNCg0KICAgIGlmIChkZWYtPm5hbWUgPT0gTlVMTCkgew0KIAlkcm1fV0FSTl9P
Tl9PTkNFKCwgIkhFQ0klZCBpcyBub3QgaW1wbGVtZW50ZWQhXG4iLCBpbnRmX2lkICsgMSk7DQog
CXJldHVybjsNCiAgICAgfQ0KDQpUaGlzIHdheSB3ZSBjYW4gbGVhdmUgdGhpcyBsaW5lIGFzIHdl
J2xsIGhhdmUgbW9yZSBwbGF0Zm9ybXMgd2l0aG91dCBIRUNJMQ0KDQo+ID4+Pj4+ICsNCj4gPj4+
Pj4gKwlpZiAoIUhBU19IRUNJX0dTQyhndC0+aTkxNSkpDQo+ID4+Pj4+ICsJCXJldHVybjsNCj4g
Pj4+Pg0KPiA+Pj4+IExpa2V3aXNlPw0KPiA+Pj4+DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpZiAo
Z3QtPmdzYy5pbnRmW2ludGZfaWRdLmlycSA8PSAwKSB7DQo+ID4+Pj4+ICsJCURSTV9FUlJPUl9S
QVRFTElNSVRFRCgiZXJyb3IgaGFuZGxpbmcgR1NDIGlycToNCj4gaXJxIG5vdA0KPiA+Pj4+IHNl
dCIpOw0KPiA+Pj4+DQo+ID4+Pj4gTGlrZSB0aGlzLCBidXQgdXNlIGxvZ2dpbmcgZnVuY3Rpb25z
IHdoaWNoIHNheSB3aGljaCBkZXZpY2UgcGxlYXNlLg0KPiA+Pj4+DQo+ID4+PiBkcm1fZXJyX3Jh
dGVsaW1pdGVkIGZpdHMgaGVyZT8NCj4gPj4NCj4gPj4gQUZBSUNUIGl0IHdvdWxkIGJlIGEgcHJv
Z3JhbW1pbmcgYnVnIGFuZCBub3Qgc29tZXRoaW5nIHRoYXQgY2FuDQo+IGhhcHBlbg0KPiA+PiBh
dCBydW50aW1lIGhlbmNlIGRybV93YXJuX29uX29uY2Ugc291bmRzIGNvcnJlY3QgZm9yIGJvdGgu
DQo+ID4+DQo+ID4NCj4gPiBTdXJlLCB3aWxsIGRvDQo+ID4NCj4gPj4+Pj4gICAgIH0NCj4gPj4+
Pj4gQEAgLTE4Miw2ICsxODUsOCBAQCB2b2lkIGdlbjExX2d0X2lycV9yZXNldChzdHJ1Y3QgaW50
ZWxfZ3QgKmd0KQ0KPiA+Pj4+PiAgICAgCS8qIERpc2FibGUgUkNTLCBCQ1MsIFZDUyBhbmQgVkVD
UyBjbGFzcyBlbmdpbmVzLiAqLw0KPiA+Pj4+PiAgICAgCWludGVsX3VuY29yZV93cml0ZSh1bmNv
cmUsDQo+IEdFTjExX1JFTkRFUl9DT1BZX0lOVFJfRU5BQkxFLA0KPiA+Pj4+IDApOw0KPiA+Pj4+
PiAgICAgCWludGVsX3VuY29yZV93cml0ZSh1bmNvcmUsDQo+IEdFTjExX1ZDU19WRUNTX0lOVFJf
RU5BQkxFLAkgIDApOw0KPiA+Pj4+PiArCWlmIChIQVNfSEVDSV9HU0MoZ3QtPmk5MTUpKQ0KPiA+
Pj4+PiArCQlpbnRlbF91bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+Pj4+IEdFTjExX0dVTklUX0NT
TUVfSU5UUl9FTkFCTEUsIDApOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAgICAgCS8qIFJlc3RvcmUgbWFz
a3MgaXJxcyBvbiBSQ1MsIEJDUywgVkNTIGFuZCBWRUNTIGVuZ2luZXMuICovDQo+ID4+Pj4+ICAg
ICAJaW50ZWxfdW5jb3JlX3dyaXRlKHVuY29yZSwNCj4gR0VOMTFfUkNTMF9SU1ZEX0lOVFJfTUFT
SywJfjApOw0KPiA+Pj4+PiBAQCAtMTk1LDYgKzIwMCw4IEBAIHZvaWQgZ2VuMTFfZ3RfaXJxX3Jl
c2V0KHN0cnVjdCBpbnRlbF9ndCAqZ3QpDQo+ID4+Pj4+ICAgICAJaW50ZWxfdW5jb3JlX3dyaXRl
KHVuY29yZSwNCj4gR0VOMTFfVkVDUzBfVkVDUzFfSU5UUl9NQVNLLA0KPiA+Pj4+IAl+MCk7DQo+
ID4+Pj4+ICAgICAJaWYgKEhBU19FTkdJTkUoZ3QsIFZFQ1MyKSB8fCBIQVNfRU5HSU5FKGd0LCBW
RUNTMykpDQo+ID4+Pj4+ICAgICAJCWludGVsX3VuY29yZV93cml0ZSh1bmNvcmUsDQo+ID4+Pj4g
R0VOMTJfVkVDUzJfVkVDUzNfSU5UUl9NQVNLLCB+MCk7DQo+ID4+Pj4+ICsJaWYgKEhBU19IRUNJ
X0dTQyhndC0+aTkxNSkpDQo+ID4+Pj4+ICsJCWludGVsX3VuY29yZV93cml0ZSh1bmNvcmUsDQo+
ID4+Pj4gR0VOMTFfR1VOSVRfQ1NNRV9JTlRSX01BU0ssIH4wKTsNCj4gPj4+Pj4NCj4gPj4+Pj4g
ICAgIAlpbnRlbF91bmNvcmVfd3JpdGUodW5jb3JlLA0KPiA+Pj4+IEdFTjExX0dQTV9XR0JPWFBF
UkZfSU5UUl9FTkFCTEUsIDApOw0KPiA+Pj4+PiAgICAgCWludGVsX3VuY29yZV93cml0ZSh1bmNv
cmUsDQo+ID4+Pj4gR0VOMTFfR1BNX1dHQk9YUEVSRl9JTlRSX01BU0ssICB+MCk7DQo+ID4+Pj4+
IEBAIC0yMDksNiArMjE2LDcgQEAgdm9pZCBnZW4xMV9ndF9pcnFfcG9zdGluc3RhbGwoc3RydWN0
IGludGVsX2d0DQo+ICpndCkNCj4gPj4+Pj4gICAgIHsNCj4gPj4+Pj4gICAgIAlzdHJ1Y3QgaW50
ZWxfdW5jb3JlICp1bmNvcmUgPSBndC0+dW5jb3JlOw0KPiA+Pj4+PiAgICAgCXUzMiBpcnFzID0g
R1RfUkVOREVSX1VTRVJfSU5URVJSVVBUOw0KPiA+Pj4+PiArCWNvbnN0IHUzMiBnc2NfbWFzayA9
IEdTQ19JUlFfSU5URigwKSB8IEdTQ19JUlFfSU5URigxKTsNCj4gPj4+Pg0KPiA+Pj4+IFdoeSBl
bmFibGUgdGhlIG9uZSB3aGljaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBwYXRjaD8gTm8gaGFy
bQ0KPiBkb2luZw0KPiA+PiBpdD8NCj4gPj4+Pg0KPiA+Pj4gTm8gaGFybSBhbmQgdGhlIG5leHQg
cGF0Y2ggd2lsbCBiZSBzb29uLCB0aGlzIHBhdGNoIHVuZm9ydHVuYXRlbHkgaXMgbG9uZw0KPiA+
PiBvdmVyZHVlLg0KPiA+Pg0KPiA+PiBKdXN0IGZlZWxzIGEgYml0IGxhenkuIFlvdSBhcmUgYWRk
aW5nIHR3byBmZWF0dXJlIHRlc3QgbWFjcm9zIHRvDQo+ID4+IHByZXBhcmUsIHNvIHdoeSBub3Qg
dXNlIHRoZW0uDQo+ID4+DQo+ID4NCj4gPiBJJ3ZlIGJlZW4gdG9sZCB0aGF0IGJldHRlciB0byBl
bmFibGUgdGhlbSBib3RoIGZyb20gdGhlIEhXIHBlcnNwZWN0aXZlLA0KPiA+IHRoZSByZWFsIGlu
dGVycnVwdCBlbmFibGUgbWFnaWMgaGFwcGVucyBpbiBHU0MgRlcsIG5vdCBoZXJlLg0KPiANCj4g
V2VsbCB3aGF0ZXZlci4uIEFzIGxvbmcgYXMgbG9nZ2luZyBvZiBzcHVyaW91cy91bmV4cGVjdGVk
IGludGVycnVwdHMgaXMNCj4gaW4gcGxhY2UgSSBjYW4gbGl2ZSB3aXRoIHRoYXQuDQo+IA0KPiBS
ZWdhcmRzLA0KPiANCj4gVHZydGtvDQoNCi0tIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=
