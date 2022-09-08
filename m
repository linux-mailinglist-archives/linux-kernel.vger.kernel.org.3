Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033835B149F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIHGbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIHGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:31:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE983B4405
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662618705; x=1694154705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g/QfFdMR2v3bDHotWg0bFgFZmVK7wqs4tTUfrzwcB9Y=;
  b=IGnF6gmrxy5dYZTUExnkPJ6ejUV0bG5ZvvotHRt2FfKSpSlQF2r+iZGc
   gAUHos79jXlXKhFFXw8OTcHvWT4bL35KtOCTHYn2n77MGcUbFY8fqKnw4
   4NorisvTLM89f/35SQ6OKCA+wl3D1qCMgqWgxpYif0DALj/RJphLwx05B
   eIiLVHdbzLLprfvphuGDFNL9Ku7q8DGicyRzM/As/VX+AWM9USDUzNj1r
   0xlEW99yFFPb4cByP4ii1Q8UiN6jhe9UO7j8diBgRmSfwdfOmyVlGYBPT
   4L8egkCVWm8O5OhpgKywn4LAhOlfUg2iawY0qZ3sv6lJY8XNNVlBGW00+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="361044872"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="361044872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="644943723"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2022 23:31:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:31:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:31:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:31:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwlLlb2Aunfz57jhqueEJ4y14D0egKoNc9aLm3TAn4aGYLFbbtKNO49BGHO8aS+cUFoeCNjFjt+n5eEhfbM1eLye8wwQO8yNZmORVywUNLKsTQDWfBMxwCuULRlTa6ciZNkx59xoVSLDhenUwZoN5K8Z8f8el6SGRE2iGrBILr9a4Fs9owcCKC7dI1WtTNBDlPC9rKaDYcQQQ3+GFBFDS48jU12zGdW44H1WBZc8O+b/hSyS8Fi5Pluu1D8DWzjf+iyTpCBY0gbyBfaRfwxNlNHfx/iNM5mzV2VVOzNZgJ0lmnutMhRxvhSdpmzJnBDLc3wnn4A/XQaJspn0S47VsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/QfFdMR2v3bDHotWg0bFgFZmVK7wqs4tTUfrzwcB9Y=;
 b=hkxvOXEijdlQlsT16vV44685zOJqzpSCii1Vpe+84UpDJVsN51W7nDL3CxWdDSuNQ+4oICgcwPAhRaMXlSMnDZTKTVJFtyH+hTh9wAy4LiK9ZGpbVl4fn5YkHRr8q6AupN2U9QKgH2VYHjbC6Ancun9JxRWQiaYRvvcj4kBSU3bMtdXgm09xQBTzUi54CKSZdsG3AcUXG6+/VhSKuSNl7WcGzf4ybMQs4L+rKf0e6Taf+VLLU1gCcX/IJ+cdFGSwgWe2Dm/SfNT1mt4ty1dr+kUaTOq8GNYtldx+6meUIjFWDFaTI/nTACY/ZOLdht0Ws7V8mAndUuvA+QtKrPQujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB2711.namprd11.prod.outlook.com (2603:10b6:a02:c2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 06:31:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 06:31:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Index: AQHYmwJBYp2710JQ30Cl1E4c+WdJBq2Ic2JwgARpZwCAAeCH4IAAIXWAgEZ/ZICAAAT4cA==
Date:   Thu, 8 Sep 2022 06:31:41 +0000
Message-ID: <BN9PR11MB52762A7EBE5EDFF6219DE33B8C409@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
 <BN9PR11MB52765FEEC0ED0EAB5D691FA38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c24bd222-9356-0564-414d-d54ca1e2b79b@linux.intel.com>
 <7f105bae-5def-e125-9391-c774d82ff455@linux.intel.com>
In-Reply-To: <7f105bae-5def-e125-9391-c774d82ff455@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BYAPR11MB2711:EE_
x-ms-office365-filtering-correlation-id: 8d6cd8b2-a876-4e10-e02c-08da9163cafd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXxCwAE732+Dt1CtzyjhlwIGJnA+JZAbXvW50e58NfC0K3liPceF/h1zZizaf5i8t9sTTi6WLBF+JIxovBqKZz1OXZRbVpdcvQx9HJwqy5PT6EgqKdKsLlFX0/ni2J9A7RVzpmyzj6hFNkahYF2QWs2YFybNo7MPIUymSSZwZt2O8U2kvnqjvY9WmZPNG3YuegpxepQICj0KCoANNnJxKp10RS4Q+RX84NUx3zwM6U/G2FRjzAIuLPMOVATsaGbE2TlioPrFbXpCLVEgm95BTjIloafASVXyR55lFRuP53zKhtDRXW7Z2nLieDiavojyyiLDqcRtonUL80/GbRfzZVUyjkgmuUkP9JtIEFqeiqEBoNgaZmiFArMN7lJ+cjVEkWRssqV+4BSAKeyPY9djV79ncHYeUWCSjVjQoY4xXjUiRAzqEYdB2mCecPHLq7ATvF0NZvhyjJjDwW6gJ3UAoutCvV8hxLH8sfybse1v6LxtVcSqGlW3B8XiGUEBni35OaMMH4S5Ncb/tAT1FmhxJ8HgpxJNjTioVdxyPHKlFn1xWGekjpu4ssOJ7FPgBDf6Qes135gcgEtq1LjYSfA/aJoy9bQIicHdvFazyEoxJ3vmdDqwS79YbkFnV8eTULq76OwL4nw4GBCLv24jCdD2NIiS28ftOYmi1l80YqHct2GfTrPZsbG6VqWMyz1kF+aNgc9v4KdTd+txiAZId7mG6ZH5qpAsJpM0Jg5rv1AplIcU6GT4cQrXGCWI2qy7gVmodKz4mK16DsjX0Uu5t5rull10mZ7lni6s3fV7wBT+auA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(41300700001)(71200400001)(6506007)(9686003)(7696005)(38100700002)(53546011)(86362001)(66446008)(38070700005)(966005)(186003)(478600001)(83380400001)(55016003)(66556008)(26005)(8936002)(5660300002)(122000001)(52536014)(110136005)(33656002)(4326008)(66946007)(66476007)(2906002)(316002)(64756008)(76116006)(54906003)(82960400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk5JVWE5dGU3eHlZZVpsZUpGYlY3SU0rTmxvSlZlZ1JuRG5QQjV1Tm5lclM4?=
 =?utf-8?B?MkVDYzI3KzY5MmRSVGcvQ0lyYW9laTkvQUU0aThycUI2K2h4elRpWExoRzZz?=
 =?utf-8?B?c1hXa29rMDVhMCtIQm1icVoxSHlhRmJOZWdMeElIZ0IrbjE4L3dSalljTk0v?=
 =?utf-8?B?ZStIQnU0eXhTM3k1WDJ6Q1kyVEt0SGUvYUFyejcwQkxnR2FFM1laRGg2ZWhD?=
 =?utf-8?B?RlV0Vys2eGpOZkI1cm9JQUxlMUxuMEQzbzRDNVpkbnc0ck9KMnRsWFZSK1Zn?=
 =?utf-8?B?L2Jwd2ZjTGdkUGhRNytFY1I0cC9MSVhpUmFEbGNjdjRiSkJ5VlIxdS9jUHJq?=
 =?utf-8?B?dXBPdGhXSkx2VC8vUk4vdkJTZldvUy9VVlVYWVVvZjRNMDJaUm5TTzhWTlBB?=
 =?utf-8?B?VHBJZUtlK3hQeG1tVWVHUkhMWGd0amtFTG1Bd0VLaVFFME9KcHROa1VDSlN0?=
 =?utf-8?B?Tk1KRHBmK2NodHRseE5YdnV2UUhWeHhEbFhvY05PVmw0YnBDYTN3MDRHRmM3?=
 =?utf-8?B?THNPTzEvRmFiSDBhNWwxbDJrbHJBWGpVeGRLNlNaSU5mTlFOc09hdGJBQlB2?=
 =?utf-8?B?K2JEZnZXYnYwRnlYcGp0ci9ISlo1RkNiQVg0S3BTaXo0MEsvYWNYdlVQUmwr?=
 =?utf-8?B?eDNlclZWTk5ZL1dDTkN6aXhYUHBYTWkrOFhNenkrcm41MDE1c1VCbU9LbWVs?=
 =?utf-8?B?RXdsMFZQWEpBbzRyZlJRamZCWWJwMCtlK2wvQVJUY0w5ZkY1TkhTOXNGQlFP?=
 =?utf-8?B?S2pSNG5qdDVJMTlENnFPOVVkK3BmUFZtbURXL3NMS2hlbXZhc3B3VGdZWHE4?=
 =?utf-8?B?SGd1UUdKYmdLNUdOV09qMEI3RSs5SkFUM0kvWURxYUdFbFNpaWZ3a3U0Nmd4?=
 =?utf-8?B?TW55SkZuYTVTQzgxNENlN21YUWtySXFyeVhBRkI5eGJBNTlaK0VtaEZsR3Jo?=
 =?utf-8?B?dk05QWUybSt3UjBETVNhdkZEa0szWmp1V01SWCs1bkIwU3hGQW9oNG5Tb0Z2?=
 =?utf-8?B?dHJ3cFJYaERaL3h5MUVpUDZnUHVOeWF3L3k1Zkx3RFV6RTZmS011ZFp0b2Rv?=
 =?utf-8?B?eERQTE5jdnF4emVNbXdSSUZHNVhiVTN4OFUyT2ozY3c1c0lOdXVXWGh2SGpF?=
 =?utf-8?B?TkxPNDFIVGVuaklvS3BUN1ZlZ0xiNDd4UU1vV0pXSTkyYjBqV21NL0xBempV?=
 =?utf-8?B?aHVud0ZFdzVMeHNQb1BuQk5meTFhQ2VsaHZOU2RtSGhrdU44L0s4dGY4VkdW?=
 =?utf-8?B?Snc1azlHdG5INjFmRUNBMGJxZHd1blJQNUEvdFNFOXNvdFp5LzN1Ni9CMkJU?=
 =?utf-8?B?RnR5Q1dBSHN6WUdCQXlYOEVweVJuM2JnUzdKaE03NCtrZUFxWmZOMDB1N2Iw?=
 =?utf-8?B?K3NESmE3OHo5WTlhL2tLRTdmYXpFRjYrQ3VFMS9lVUE5eEhyVVV1RFFIZkpn?=
 =?utf-8?B?ckpIUitDSThiR0dpb1l6ZjQyeVROM0hvNWt2QnNpTDJmMjFaTDFpS1ZkK3lU?=
 =?utf-8?B?QytNOUNWeS9EVGg1NEY1WURlSytxM1hiWC9kdGN0bjBTODM5akxjS3FSdE4z?=
 =?utf-8?B?djdOKzBnWndrMzd6R0p2bURxQituTTNhTjZaZ2tLREtSZG56WC82dG8vUzBj?=
 =?utf-8?B?cmk4RHhWY0Z0aURMVmkxREJ3VDZQVEV0V0ZjRUFLcjlTNmxndUloQjgwRVY2?=
 =?utf-8?B?Skc3b3VDRklLaGMzUlpORXZaaGNXVDMyVzNvbXZEeVlDZCtuY2hOTWVTdk96?=
 =?utf-8?B?ZWtpZ2JlTHExZUp2VU1XWnVsY1d2SUJDRUhJc2dGMEwydnZOclowcnJqT3NG?=
 =?utf-8?B?QXVLU1R6VUZrSEFaQU94SnlUKzNvaUFVSDhkRmVCTVdIb1lnWTBPSC92enI5?=
 =?utf-8?B?cUhqbEtoenE2VktsaGdZdEJ1Wkc2SVlDZ1lWVXJldjlPVHJSWUNNdUFkZjJ6?=
 =?utf-8?B?TFJ6VWx0S2twdW5LbGZESmFBVHpkR1hhWXRETmROZHU5N1pLSmNFckh4QXNN?=
 =?utf-8?B?dkdhVnhHSmRCK1JWZHZxeTJvWEw5M2JrWHpEa2Zsckl3TEVKRXF1aGVjZGJo?=
 =?utf-8?B?c2NKRWNEcys4aEI1emxIRDFTQ0lVNHlLMjB4L3hnY3F5eXpUQWFOUjR1VGtH?=
 =?utf-8?Q?Z9NDmuS5cuXleG1C6nRe9/853?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6cd8b2-a876-4e10-e02c-08da9163cafd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 06:31:41.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isJnPrB0HdM/dKAyYMa9mNeLofrAkNR2M4z/kMpt3tUq7khKMveosbJSw25RumB8Gj+4iVwaJ16i7prUaCYJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgU2VwdGVtYmVyIDgsIDIwMjIgMjoxMyBQTQ0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBP
biAyMDIyLzcvMjUgMTc6MzksIEJhb2x1IEx1IHdyb3RlOg0KPiA+IE9uIDIwMjIvNy8yNSAxNTo0
MCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiA+Pj4gU2VudDogU3VuZGF5LCBKdWx5IDI0LCAyMDIyIDExOjAwIEFN
DQo+ID4+Pg0KPiA+Pj4gSGkgS2V2aW4sDQo+ID4+Pg0KPiA+Pj4gT24gMjAyMi83LzIxIDE1OjM5
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+Pj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4NCj4gPj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAxOSwgMjAyMiA3OjUz
IEFNDQo+ID4+Pj4+DQo+ID4+Pj4+IEBAIC04OCw3ICs4OSw4IEBAIGV4dGVybiBzdHJ1Y3QgbGlz
dF9oZWFkIGRtYXJfZHJoZF91bml0czsNCj4gPj4+Pj4gwqDCoCBzdGF0aWMgaW5saW5lIGJvb2wg
ZG1hcl9yY3VfY2hlY2sodm9pZCkNCj4gPj4+Pj4gwqDCoCB7DQo+ID4+Pj4+IMKgwqDCoMKgwqDC
oCByZXR1cm4gcndzZW1faXNfbG9ja2VkKCZkbWFyX2dsb2JhbF9sb2NrKSB8fA0KPiA+Pj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzdGVtX3N0YXRlID09IFNZU1RFTV9CT09USU5HOw0KPiA+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzdGVtX3N0YXRlID09IFNZU1RFTV9CT09USU5H
IHx8DQo+ID4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAoSVNfRU5BQkxFRChDT05GSUdfSU5U
RUxfSU9NTVUpDQo+ID4+Pj4+ICYmICFpbnRlbF9pb21tdV9lbmFibGVkKTsNCj4gPj4+Pj4gwqDC
oCB9DQo+ID4+Pj4NCj4gPj4+PiBpbnRlbF9pb21tdV9lbmFibGVkIGlzIDAgaWYgQ09ORklHX0lO
VEVMX0lPTU1VIGlzIG5vdCBzZXQuDQo+ID4+Pj4NCj4gPj4+PiBzYW1lIGZvciBvdGhlciBzaW1p
bGFyIGNoZWNrcy4NCj4gPj4+DQo+ID4+PiBTb3JyeSB0aGF0IEkgZGlkbid0IGdldCB5b3VyIHBv
aW50LiBJZiBDT05GSUdfSU5URUxfSU9NTVUgaXMgbm90IHNldCwNCj4gPj4+IElTX0VOQUJMRUQo
Q09ORklHX0lOVEVMX0lPTU1VKSBpcyAwLiBUaGUgYWRkaW5nIGNoZWNrIGhhcyBubw0KPiBlZmZl
Y3QuDQo+ID4+PiBEaWQNCj4gPj4+IEkgbWlzcyBhbnl0aGluZz8NCj4gPj4+DQo+ID4+DQo+ID4+
IE15IHBvaW50IHdhcyB0aGF0IHRoZSBjaGVjayBvbiBDT05GSUdfSU5URUxfSU9NTVUgaXMgdW5u
ZWNlc3NhcnkuDQo+ID4NCj4gPiBPaCwgaWYgSU5URUxfSU9NTVUgaXMgbm90IGNvbmZpZ3VyZWQs
IHRoZSBpbnRlcnJ1cHQgcmVtYXBwaW5nIGNvdWxkIGFsc28NCj4gPiBiZSBzdXBwb3J0ZWQsIHNv
IHdlIHN0aWxsIG5lZWQgdGhlIHJjdSBwcm90ZWN0aW9uLiBXZSBvbmx5IHJlbGF4IHRoZSByY3UN
Cj4gPiBjaGVjayB3aGVuIElOVEVMX0lPTU1VIGlzIGNvbmZpZ3VyZWQsIGJ1dCBub3QgZW5hYmxl
ZCB5ZXQuDQo+IA0KPiBUaGUgbmV4dCBzdGVwcGluZywgd2Ugd2lsbCB0aWUgSU5URUxfSU9NTVUg
YW5kIFZULWQgSVJRX1JFTUFQUElORw0KPiB0b2dldGhlciwgdGhhdCB3aWxsIG1ha2UgdGhlIFZU
LWQgc29mdHdhcmUgc2ltcGxlci4NCj4gDQo+IEpvZXJnIGFsc28gcHJvcG9zZWQgdGhpcyBpbiBh
bm90aGVyIGRpc2N1c3Npb24gdGhyZWFkOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL1lyVlBlbG5PaTlucWwlMkY4Q0A4Ynl0ZXMub3JnLw0KPiANCj4gQWZ0ZXIgdGhhdCwgd2Ug
aGF2ZSBubyBuZWVkIHRvIGFkZCBhYm92ZSBjaGVjayBhbnltb3JlLiBBcyB0aGlzIGlzIGENCj4g
cXVpY2sgZml4IGZvciBsb2NrZGVwIHNwbGF0LCB3ZSBkb24ndCBuZWVkIHRvIHdhaXQgdW50aWwg
dGhhdCBkb25lLg0KPiANCj4gRG9lcyB0aGlzIHdvcmsgZm9yIHlvdT8NCj4gDQoNClllcy4gV2l0
aCBhYm92ZSBJJ20gZmluZSB3aXRoIGl0IGdpdmVuIFJvYmluJ3Mgc2VyaWVzIGhhcyBiZWVuIG1l
cmdlZC4NCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
