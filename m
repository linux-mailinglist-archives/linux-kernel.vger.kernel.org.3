Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4233562B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGAGKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGAGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:09:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD613DED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656655794; x=1688191794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GYjCsU7pqRStUQVNQnL2WXfaZUcwk/PNNn8aHlRr7n8=;
  b=QOfooJIV9wzqbqTUKJ60L9ALWJjnJ9RSIUoGUnAclDHWqrrI2DAsY3s6
   4R0KAp/kJDGdg5k/Tp/p8xLKbvbHW/3RpEcB9wneQFKJUzPBoQIZxK+M9
   CJ2zssCDKUkdGEBXb0KJHxMZf1XE1JcKAjb3M4pu0BLMMfGHb0fKYM6Rd
   TFe4IA/DkC55kJILkpm9GGHC+fhxHWOaiFdytJ5WsZ09aaYW1McHXNleL
   wVgBd2BsSNyo2nAC81z14vP1Dyq1opUM4jmWU5URzk3afaOrF5WiTEBQT
   QEdSFtD/ey0MeQiSUWBYB+p2P3dk04lCiw1pHtLGQpIarcGIkn6ilDpVJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262362349"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262362349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 23:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="618292809"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2022 23:09:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 23:09:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 23:09:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 23:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT4hSroW9T5MII7Mi+FS9zkpYDQDlxhphdA7aSe6RL0SwvxY/SNjijerJ/sA4XczgmXinyvD1o7BFu3n3szh9ZrQc9U7MKCxvZqP2RVEptekZ22aLK9Efol61Pa0R1ppkFtV26eMMIxjK1VhH5Kunzob5Z1+ELwYdHlk+5sr90hJbcESEII/N+UU00IK36XbhA984f15laJs0ckQ2ty8lgfATZCoIydKYEYFASUV9duGlk6XekmnntEShu/9+An8alFFVKbIfKn5jUb6mKV6ncOvM7xk1GqcO3k91odcBMJCjFRMKTTggWqMCCGQJz7NjPJTUkoMAm2QT1Tq696S4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjCsU7pqRStUQVNQnL2WXfaZUcwk/PNNn8aHlRr7n8=;
 b=UWTCoYqcOBaSb0C+cgwso41RYLNXqFXIaInp67YRTFU2Q669khXxBQ8ENq/pGWLcdq7ez3muyIM7s74WhyB/CFbNFyVQN8QCubcnYtfmLHPwnKH+ZnxYcepy5RReE2TYhi7Zbs2U9kD1JYOhEvcIfMaqiDF4vKYfZ5a6Conso6HjE1/KKXAMCwh4o+AegLtNSkKkINjJc1jPGH2MwQ44KyLNzdwBp6/KuwdMO0UZ1hocl6pmIqpRJHScwdJDk9JHK3c1o3Y6A2nlg2NIA82hlzIdvVCHShgAbHmKWDB84GHZtF8+XVJ2s5o/z0byxzwulQWpd/Fnu9i82gS5WgWM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4626.namprd11.prod.outlook.com (2603:10b6:5:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 06:09:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 06:09:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Topic: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Index: AQHYiJMJkSfp+Ms7gkCsHugg52JWua1npWyggAE6ZoCAADE/gA==
Date:   Fri, 1 Jul 2022 06:09:52 +0000
Message-ID: <BN9PR11MB5276E263D89459506396A84A8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
In-Reply-To: <239cfd97-b381-f523-f149-e127f44a0780@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7f0a2f5-b170-4e98-7589-08da5b284ffb
x-ms-traffictypediagnostic: DM6PR11MB4626:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vazzCRR3atfjDjBmgilRnTr2e5cfs6LhTIi83Xvc4OOnjQm4h1mfpSdIS1a/zB0VHnTve+gFECQj3kvOgo/qkDtvmdLvI5t52ytQPszKQQEnh+dTna4w0Rz4v3C5XCyStKZ1WRV3XM1xedIGeSWPcjC0qH6c6mTWUbIDWs5TJKIH7Uo3E9gXITkT+H8QZv5GAPz0yLspEg64rYOiZGCjKFDgbn951Y7Jbnq4TOYPvDwgTilBIcZSU6mt5x6D+ksvp70oJaoI9JZH3h3tiSmtD0eb+nz+kYYa61MTV+4iiNFJrUdOOx5LYvlA36Rzj/WrDVo2UvhQynt78uI2ZkWVDXvCgKLYpjtZV6wcPyOmKQ0cVbv+Nlq+lvUoqH2CN0aAdY+x/s6jYcV9CuSfFERcNNrfRzWByEf6rL/0sL+S1KuRtNMvqBK6fuTkLzZLKMSza35qX4irBDh2S5QBcY2C2y4KpAbj0hJDf3YRx98mpp8lL2QhOL7Ul3OSpWPODinq9Hl8MsqGmxSAPQItlQV80/DBv5+aRHZnWIeCsJMPk9qeo4Z49JagMPm6ik6kqaNQjHbbEvejQNRieyqZzltlA40EpAU/sqxn9suEK4dAqrD9ZjdSEuoyJHKc+uoK30sFxTqRrcGGZWX3HjLaYG+Q39isHhmAAvNeJEzfx1nd+dbmXCmkRUEnWIRkoiRRUhNnvFvf2hMTuTxr41Q22QeKf2c3wbkxl+brkMtCFhThVtPi/hBRFF1fCc2XBaddDqYEA+ilT2J0wOhk3EQ7pIFL5lu8+0ggq29cbOaaTJe1bReWG73TGxs3ZTwagkwerKL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(366004)(136003)(376002)(54906003)(316002)(76116006)(38100700002)(86362001)(41300700001)(64756008)(66476007)(66556008)(66946007)(66446008)(478600001)(33656002)(38070700005)(82960400001)(122000001)(186003)(55016003)(9686003)(6506007)(53546011)(26005)(7696005)(83380400001)(4326008)(2906002)(8676002)(71200400001)(7416002)(110136005)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHJyVUJMbCtsRTBRUzcvcXV2RnVRVGxuZGdVUWpoTVpBQWFRbHBVTnRTTC9n?=
 =?utf-8?B?SXRVRlVlVjc2N0RBbkNzQzdXcDM0d3loUTNhdmp3QkhwQmxnUnVBKy80TXhn?=
 =?utf-8?B?czJWM0JtOGpndTl5OEhmRWNFVW9EcVBpTmpoQWgzZGFxelRISXVqc1NYNU1n?=
 =?utf-8?B?TUQ0UGlJNzBKRWRHMWZuN2RkY3lsQmV1MjV0am91cEhpQ0k0ZlRvdXc3R210?=
 =?utf-8?B?OVVNcUFjdDNsd3FUeFB0T0p1V29ELy9IOUVhWXpuVmVySENyOCtjeEVVN01s?=
 =?utf-8?B?a3ZhMnZWRTV0SXo2ZTNnUGo4RkFLYlFJcVBIbFRrNHBzbzdDWnk4TDJZSnkr?=
 =?utf-8?B?THVmR09GeU9FaHc5cmhYZ2tRWm50Vm1GblJCS050eUF3Q3UvRVlaTk43RWpX?=
 =?utf-8?B?RWEzQzFCYTdOTGJoVjZKejQ1aWh1UXMzaHlKbEo2dkFzTG5OSVhPYU04ZlNp?=
 =?utf-8?B?aUY1Y0tydVdpR3FBNDh0dnNaVHdDNEJQN3NIc2cxdnhOSTR0aHBMVXFDaER5?=
 =?utf-8?B?RTd4RWxwOWNoa05iRS9JMVpmeTJ1eVhWUGg1NDhwWFJZVnluN0lhSTlrM2NP?=
 =?utf-8?B?eUxRNzZOaDJMR0dQYlpFV3BWVjZjdWtud2NsL3lySjZRS0t5NHlEa3QxR0kw?=
 =?utf-8?B?cURCNysrbUREd3hwQThzRzhoYVgzSEJOUnZmQ3JZZU1xRXVvODBqVDlCNjIv?=
 =?utf-8?B?alBzdTUvSDM2dElVOFM3ektGT0htbzh5N0JQajdwRWl1ZDdCYVRiWDA3Unph?=
 =?utf-8?B?UkZVK3BTK3VqTDIzOExTVlhKMWxYc1AyM2I4UHVrYTEvMjhxa0RRamI2MWRS?=
 =?utf-8?B?M3F2Q1ExL29KSjF4alpud2J6anB2WlRMdlJjMnNtT2JuZVpmSWdzdzZRQWFS?=
 =?utf-8?B?cFdEbWNTVmhyZ0daUThqQ28xY3ZIeWxIandQeFludDVEWEszNmg1VG1LdGJH?=
 =?utf-8?B?VmV1R09BUnZJRFI0YzVJcGsxNVdPTzA1c3dsZnd0cTQ2Tk0zZEk5OEVDcFE4?=
 =?utf-8?B?WFNGWEJ3blh0bEE3TVFkN2dIV3p1a1FBM0RLcFFFaHY4dGk1aDdqZnJmMDRu?=
 =?utf-8?B?dXlZRjhKWTlIK2hreVlsdVl0VUZ6d3dGR3RaY1l3eDBpTjVUSWNTSUlGMGJx?=
 =?utf-8?B?YW0wTWFpVGQ5TnBYRzEraEpIbnZaYTU5d0RyUnl6OWdKalQyc2MxV0o1eUFZ?=
 =?utf-8?B?RUF2MkZyZ2FTeDM0cUEyay9EQmtHMEpnaS9sSVVMMjY5cXZXTVAvcy9kbzBl?=
 =?utf-8?B?bytsTzRTNERBRVViMmRCSlZhWTRqZUg5RXBDT0lYRTNXQmNFSFRKZEhpQWdR?=
 =?utf-8?B?SERWNm91YzFoRWRtbUdYL2hFaW9YUjJBV0dWOUIxeWlpcHRqYk4yU1ZhN3lN?=
 =?utf-8?B?MjVBM0pyblRoTWQ4THdqWHBuZ2FqY3YwWTJHVE9Qc1FvR3JtRnlXTWovMVd5?=
 =?utf-8?B?aWdmVEcvM09QRU5NZ2NWMVIvK2ZnN2lndVp2ZGM1MDlHQkpkZEQrdlczS05n?=
 =?utf-8?B?NUNvMWFaWVpBVXh6ak1tWm9vaVZhNVg1Uk1rWEFlMWV0S1hBbzdvbnlLUy9E?=
 =?utf-8?B?VUV4dU1rc0hTVHRuUjZRRUY4SFJkMGhZUTBtZXlXZ3JOSjdYc3JFbW5rRCtn?=
 =?utf-8?B?RjFpSi9iUk84OElXYml5bEVwU3BCNStvd0JKZWpVeE04K3FoNzNWd2IxQm56?=
 =?utf-8?B?Yis1YUMxVVU3a3FDN0pNd2M3SzdGYUlKblNBRHBaUnE1RFEvWFlZRnhVdjBV?=
 =?utf-8?B?OWU3RXVOQUdXZ3BnMW16cGdhdmY2Wk5aNjM4NWFMSkp2UjZhVmRYUStiRVpY?=
 =?utf-8?B?eW92cWJFeHZySkN5NDZGOUNudjNiNUxGZFpEbEdadkNCTGpvdmhZcUR4L0kr?=
 =?utf-8?B?b3E5ZWt4MkRhSHA4NStxaHJNM0FJcHl2RHJmZlErRnFuRFVUY3A0bVNRdDFE?=
 =?utf-8?B?dEhPVU02R0FpRmlGV3pFQ1F6UzRadS8xUjVsRkdhZEQxUjlVS3BQZjNmZ1da?=
 =?utf-8?B?UWJKREFnSDc5OW1Zckw0N2cwblF2cGhxNys5T2s2SFpkRlI0eHVKQlUzMTBJ?=
 =?utf-8?B?VXdiS2JweFk0MXBQY2Q3elI4bmRUS3VIYVVUWThiaC9BZEVOQmM3eTdBZ3FO?=
 =?utf-8?Q?FFKNOpacMCdjFYsesh9eFAYMs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f0a2f5-b170-4e98-7589-08da5b284ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 06:09:52.4576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6KinqvA6sPMRDFkg2n7lOGuMyfmKcyA1y0/xhyRJ4S1y/qfHVyvbyoW+AQdE8hqEGPQITZ7YPsBJCqHLhQtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEp1bHkgMSwgMjAyMiAxMToxMyBBTQ0KPiANCj4gT24gNi8zMC8yMiA0OjI5IFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjUsIDIwMjIgODo1MiBQTQ0KPiA+Pg0K
PiA+PiBJbiB0aGUgSU9NTVUgaG90LWFkZCBwYXRoLCB0aGVyZSdzIGEgbmVlZCB0byBjaGVjayB3
aGV0aGVyIGFuIElPTU1VDQo+ID4+IGhhcyBiZWVuIHByb2JlZC4gSW5zdGVhZCBvZiBjaGVja2lu
ZyB0aGUgSU9NTVUgcG9pbnRlciBpbiB0aGUgZ2xvYmFsDQo+ID4+IGxpc3QsIGl0J3MgYmV0dGVy
IHRvIGFsbG9jYXRlIGEgZmxhZyBiaXQgaW4gaW9tbXUtPmZsYWdzIGZvciB0aGlzDQo+ID4+IHB1
cnBvc2UuDQo+ID4NCj4gPiBTb3JyeSBJIGRpZG4ndCBnZXQgdGhlIHBvaW50IG9mIG9yaWdpbmFs
IGNoZWNrLiBUaGlzIGlzIHRoZSBob3RwbHVnIHBhdGgNCj4gPiBoZW5jZSB0aGUgY2FsbGVyIG9m
IHRoaXMgZnVuY3Rpb24gc2hvdWxkIGFscmVhZHkgZmlndXJlIG91dCBpdCdzIGEgbmV3DQo+ID4g
aW9tbXUgYmVmb3JlIHJlYWNoaW5nIHRoaXMgcG9pbnQ/DQo+ID4NCj4gDQo+IEVpdGhlciBkaWQg
SS4gSXQgd2FzIGFkZGVkIGJ5IGJlbG93IGNvbW1pdCB3aXRob3V0IGFueSBjb21tZW50cyBhYm91
dA0KPiB0aGlzIGNoZWNrLg0KPiANCj4gY29tbWl0IGZmZWJlYjQ2ZGQzNDczNmM5MGZmYmNhMWNj
YjBiZWY4ZjQ4MjdjNDQNCj4gQXV0aG9yOiBKaWFuZyBMaXUgPGppYW5nLmxpdUBsaW51eC5pbnRl
bC5jb20+DQo+IERhdGU6ICAgU3VuIE5vdiA5IDIyOjQ4OjAyIDIwMTQgKzA4MDANCj4gDQo+ICAg
ICAgaW9tbXUvdnQtZDogRW5oYW5jZSBpbnRlbC1pb21tdSBkcml2ZXIgdG8gc3VwcG9ydCBETUFS
IHVuaXQgaG90cGx1Zw0KPiANCj4gICAgICBJbXBsZW1lbnQgcmVxdWlyZWQgY2FsbGJhY2sgZnVu
Y3Rpb25zIGZvciBpbnRlbC1pb21tdSBkcml2ZXINCj4gICAgICB0byBzdXBwb3J0IERNQVIgdW5p
dCBob3RwbHVnLg0KPiANCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBKaWFuZyBMaXUgPGppYW5nLmxp
dUBsaW51eC5pbnRlbC5jb20+DQo+ICAgICAgUmV2aWV3ZWQtYnk6IFlpamluZyBXYW5nIDx3YW5n
eWlqaW5nQGh1YXdlaS5jb20+DQo+ICAgICAgU2lnbmVkLW9mZi1ieTogSm9lcmcgUm9lZGVsIDxq
cm9lZGVsQHN1c2UuZGU+DQo+IA0KPiBJIHdlbnQgdGhyb3VnaCB0aGUgd2hvbGUgaG90LWFkZCBw
cm9jZXNzIGFuZCBmb3VuZCB0aGlzIGNoZWNrIHNlZW1lZCB0bw0KPiBiZSBkdXBsaWNhdGUuDQo+
IA0KPiBIb3QtYWRkIHByb2Nlc3Mgc3RhcnRzIGZyb20gZG1hcl9kZXZpY2VfaG90cGx1ZygpLCBp
dCB1c2VzIGEgcndsb2NrIHRvDQo+IHN5bmNocm9uaXplIHRoZSBob3QtYWRkIHBhdGhzLg0KPiAN
Cj4gMjM4NiAgICAgICAgIGRvd25fd3JpdGUoJmRtYXJfZ2xvYmFsX2xvY2spOw0KPiAyMzg3ICAg
ICAgICAgaWYgKGluc2VydCkNCj4gMjM4OCAgICAgICAgICAgICAgICAgcmV0ID0gZG1hcl9ob3Rw
bHVnX2luc2VydCh0bXApOw0KPiAyMzg5ICAgICAgICAgZWxzZQ0KPiAyMzkwICAgICAgICAgICAg
ICAgICByZXQgPSBkbWFyX2hvdHBsdWdfcmVtb3ZlKHRtcCk7DQo+IDIzOTEgICAgICAgICB1cF93
cml0ZSgmZG1hcl9nbG9iYWxfbG9jayk7DQo+IA0KPiBkbWFyX2RldmljZV9ob3RwbHVnKCkNCj4g
LT5kbWFyX2hvdHBsdWdfaW5zZXJ0KCkNCj4gLS0+ZG1hcl9wYXJzZV9vbmVfZHJoZCgpICAgLyog
dGhlIGFkZGVkIGludGVsX2lvbW11IGlzIGFsbG9jYXRlZCBoZXJlKi8NCj4gLS0+ZG1hcl9ocF9h
ZGRfZHJoZCgpCSAgIC8qIHRoZSBpbnRlbF9pb21tdSBpcyBhYm91dCB0byBicmluZyB1cCAqLw0K
PiAtLS0+aW50ZWxfaW9tbXVfYWRkKCkNCj4gDQo+IFRoZSBkdXBsaWNhdGUgY2hlY2sgaGVyZToN
Cj4gDQo+ICAgICAgICAgIGlmIChnX2lvbW11c1tpb21tdS0+c2VxX2lkXSkNCj4gICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gDQo+IEFsbCB0aGUgaW9tbXUgdW5pdHMgYXJlIGFsbG9jYXRl
ZCBhbmQgdGhlbiBpbml0aWFsaXplZCBpbiB0aGUgc2FtZQ0KPiBzeW5jaHJvbml6ZWQgcGF0aC4g
VGhlcmUgaXMgbm8gbmVlZCB0byBjaGVjayBhIGR1cGxpY2F0ZSBpbml0aWFsaXphdGlvbi4NCj4g
DQo+IEkgd291bGQgbGlrZSB0byByZW1vdmUgdGhpcyBjaGVjayBpZiBubyBvYmplY3Rpb24uDQo+
IA0KDQpUaGlzIG1hdGNoZXMgbXkgaW1wcmVzc2lvbi4NCg==
