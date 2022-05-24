Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A15326BA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiEXJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiEXJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:44:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35AE4474A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653385451; x=1684921451;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QW5M2Q9yY3Wth/aRLjaboMVvDU1OeuVsIcK6MN2NGBg=;
  b=DeOMKWXhmk1sC7NVBeKD5FRRHOOfe0p/r0fVqnJRZ5YyMxx6qoygM+pg
   dARagylKVXO4sODn+18Ss+yZdfJypo/6cpVrJ7v+lVuOkSQiWB32b556G
   4DMUgMHhHNAqbshgQxzb4wMMSSxZ9XvCG8JoEUTvJuncHeMdQonz2YT7f
   +buBhs+DjJ1/qxHv4TP9dQ8xIRtmsYKAmfCj+SD7/LIAGpHd1G8KrenEV
   1sND2TPoQzoHJDYEbYOkPGKTyUaRRHYu5mVIj3Md5hcDf8QAAquN8l0rN
   sJ8Xhjs8hB0ONYGEnx96Dy8wQIWJxriSE5nGfUg/nos5jpbBl5s4qbXDB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="271057693"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="271057693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 02:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="629809951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2022 02:44:11 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:44:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 02:44:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 02:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg4JZxCUkibsB4ShGpIX8+PH6V+FLpxdQqNUhlo8J9gcFocYSvQabC2IK7B6BUWPAP6nWP2KP88EJJ0GIVoow5jsRZqIYA+17J6u5IFmsG42AFgHaAMJnNL/ymBUjDhvcnIX7MER7j8iSsgGmFF+/umpqSRdQ5LkmgRgwH/mFQfhDmFV1XXzwiYSSoN5gmybCNso76HEjfPzrkAKMPe88ZusO5op9xNHHC6v8n+PGBMGdfoV5f93MuBpy2pzHDePAfxnUE7eEi5g8HQUuLX9RIY0GoyknDiokLuom1aUPQlWrqK4Jf30X9kgp0niVG/Zrk3UUaDBnGRZkQnIJ/jdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW5M2Q9yY3Wth/aRLjaboMVvDU1OeuVsIcK6MN2NGBg=;
 b=D6nWXe4bIqjEWYDLgl++T8cBsZqG5K17vo2aEOGfMs+csh+WfBb/QjIsJ+a1jwpUdNNSz8M3VRqIwsd2dQpbjgVkZMYNaicnPppncfO3N6YyCqmeuW9rkenR3UelFedHIQMi2/Buh4PHv6an9LA/Qg8MrPtwQJ5WKF7liaBaGJcR/xzu3YUw8Ha0TTFe6OnA6bwte7g/KoHj65HIgB0Q9hX0XdlqnmX1peoFAlrX02pnP7LedZ3EpIFqqpK/rbfcvLKWJLptPqkGPnslTwepfKpc5mLFGeh2zDpUpszHeyalId/vU1Ng8o5HKQFCvQBY4bKQHUKEBeyNP0AOO+rndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2555.namprd11.prod.outlook.com (2603:10b6:5:c5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 09:44:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 09:44:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Topic: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Thread-Index: AQHYa1GAWzo4qdZhTU6Id4ueE7eQ+K0sEmaAgAG7rbA=
Date:   Tue, 24 May 2022 09:44:08 +0000
Message-ID: <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
In-Reply-To: <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8568b34-309f-4aa8-9964-08da3d69f351
x-ms-traffictypediagnostic: DM6PR11MB2555:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB25554B31292F3454C28704118CD79@DM6PR11MB2555.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /K39QcdHmWiobHJCNw7qHIlEmXob6torMjQivUHZxtg1yIm8A/M880cKa6Ojv9jdTRSCsuDqA9mjCaqEadx9ii9dDbdKkO7JEn/oKNJQoBUXybjf9oSUf7Z2REB4vSNbtjwt/DujqhKq0onY5SbzroUE1Iu6F1r/4FEjNKGm0skdxL05stMOTxZSIAY8Toa0pkqdCcFzJHYG5tPScX+wXAhk6CFPAp/NQO+tO/UR8wYm55jjEsBlotC7KmqXhojIC2ZSZYh0fjjG8pKoJJpzJvPzi08KbljUm4S/wiRh9sJ+pLd5LuCq2BOl76NBB47+5B9LYdgb/+LzylLD3Zd3mVinEm7RvKw+CChxOIo4B3ihG/H5EXDbliPO3s0KrqluoW5vveBTkWw8Tsq/xEDcugSB84e+u46LOVkxyW2VaPCQFPagbR777KiJzMDtl3X4+gzkwmY8xXAySl26pmXaKr6d3Dv6xEYDaJG6X5ZRoEKSJbRrs/6b2c8vthYwIcAIcv1oJhtpPIISBNS9vA+PdzJ408TO5dDnoyQnz39RPZ7ACpi8ylzrBl/qrg8RTrZj3LqiXGMDF+4zn9HIgrI25YQYayoE/0v52pgCZfJFHUD+wxP7sO9gA1nqKEsSjwKSEWw0Tzwjb6frb9WaAVWj6nA/Ei2PnvINN5RAcrgnB96iVZGUAbr6o94aLp8qumYFRJhFxsiev8Ul9+M+yb0n5BO5qloVIJqfuqPFzb+JwB7SMo7qytIwKWtg7+l0BUOL/UDvXT8AcVbwPMEmbsChYlA1h7sFHtM+NOSFGymYqUUYSsD9Go1p+r3ivHSvcXMe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(52536014)(64756008)(66446008)(8676002)(4326008)(66476007)(66946007)(66556008)(86362001)(4744005)(2906002)(33656002)(7416002)(71200400001)(9686003)(966005)(5660300002)(186003)(8936002)(26005)(76116006)(54906003)(55016003)(38070700005)(82960400001)(122000001)(921005)(38100700002)(110136005)(7696005)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekpURVIxQVBrRVh3US94RGRobDlWenU5dld4MWxhOU5EU09ObU5kSU1jdVZY?=
 =?utf-8?B?MWxpQk5MZnNtcXhWOTZ2b21hTit1NlhRby9mQUhRRkJHdUQrRmZSVVpOREpY?=
 =?utf-8?B?RmNIWE1Yck0yM1BHTWJ6V3JLaGZDQ1dOQld6aFE2T3RXa1g4bFVabkFhdms2?=
 =?utf-8?B?MURVSWg2L3liTlVMYTR0MUNUOWxKVnluZHgzMFRmczNVZUxUa1loQStEdGNt?=
 =?utf-8?B?cEl4dkRqNldxQlJCVHZXNWZrRzhqbVNqell5emphd3ZwUXB0dUpUVnE0NDFn?=
 =?utf-8?B?L0FZVy9OdVptMndGRDZDbDNUaHBDSnZJajRCNlZZTGRSb1BOcTROUlU4dG03?=
 =?utf-8?B?TFlpanczWC9tQjllSWtxR0hyQytUV3FualZDZ3duaWdyRVdIM0FGblAxalpr?=
 =?utf-8?B?UXIrWW1UUlpZT2J6TVMrMGdFWEFiUC85NkxvUGwycU1JN3lYMGo3c3I0ckc4?=
 =?utf-8?B?K3hsZ21QYnBZVXBZV0FJRnNJanpzTjVuZ3lORzZUekl3RzVPUGo3d3Rjd254?=
 =?utf-8?B?bzZSeEZTaUxKR1V0YWhCaU9vMzRYaUhlK1JicG0vOGpDNGF1emNJVC94dHNj?=
 =?utf-8?B?bzM4cFZuMkZ4cGJsME9TdHNPVHhMZE5VVXBiaXhpTFFXSVBDejdPcmdPcXJY?=
 =?utf-8?B?VW8zWXl5Wm5hVk51UXFxcDkybHBuTDVpSlI4YWNFUUxuUlVxWnN0elhDR0lD?=
 =?utf-8?B?REJlR3JaL21SMVJFWE1qQlpzbnZ1QTdUalhSbDFTWHg5QW05a2pCSmFTS0Z3?=
 =?utf-8?B?SVNxQ0F1MUpHOTg3RkdsN0RRT3NaYzRPN0Z6OGl1WDdyc0cvVmZ6Ulo3YklH?=
 =?utf-8?B?amExekVEZzBnTGdYN1FvOFVMT3ROOUhrTjJqMkdWbmx1RndmaWFBM3daVFlk?=
 =?utf-8?B?WUhoWVpwUUd3ZklXL0dYWW4rMXZPUnlNNE4zakVrU1k0R1llSkxBTDFmY0Vs?=
 =?utf-8?B?Y2xIZzMvTUIwK0UzaUE0cG9PSGJnMm5pU043TW5zZ3ExTDlwM25nTk0vb0tB?=
 =?utf-8?B?WFpVai9BVkxnRTdZYjZKNHJUeHN0Qjkxd2pjbjRrUGM3VWwxSzJkVk1xczNC?=
 =?utf-8?B?dms4TmZpRkRBTzVjdmtwM1dLTGE2Zk5ENVVTekM2TmgvM21KTXRpYkVKQnNa?=
 =?utf-8?B?cExyVWFlMFQ3R25ZTlowSEoyRnBkZnVWMlBENlR2QXNDYzBHdElZWkNBL2lh?=
 =?utf-8?B?QWVPYzQ2dEJOV3JBbmQ5RFI1Qnp6aVRXemtQS2NIWVpaV2h3TmFkWERPNm5u?=
 =?utf-8?B?NklBOVVUQS9vVTBOQ3hUS0RpUHVxV1RRNllDc2xhNUJGV3h3QlFlbms1SnlB?=
 =?utf-8?B?ek5RS2h4Nno0MzhrN0MyelMyYUtiV0l5TUVSbTRIaUkzdUpzZjFNT1NxMVM3?=
 =?utf-8?B?TTNHWjhGVzFESnVGZis4QzgyUzJKUlNwRG81d1ZNWStwRXJnUnNvMi9uQWFK?=
 =?utf-8?B?Y3lmcmhIaWl5bnpsczFzK29DVHNsR2FjbzZlaXcvaytSUUJLZ2lFNzg3amhl?=
 =?utf-8?B?clJqd2taRjBhSnlxc1dlMjZQdURmek9HcFdQZUtuN2RKd09IUlN1VXFLVER5?=
 =?utf-8?B?MVVnRGhPcSttV2g4WFNLVFA5TFBJSzVSb2ZCZjFlZUxjLzdNL0RLOHdlVXNS?=
 =?utf-8?B?M1ROZC9mdlYyUmpjYitEdGhNODZwd3lYRDNjRk55QlNEV05JczJPZm1jbXBq?=
 =?utf-8?B?QitJeForcmNDMkEyMStyK3hySG1pV1pla3lLS0YyRmhKRjZwOHNMenlVLzFt?=
 =?utf-8?B?czVaQlhtNStUaGsyOUtqU2I4NnNsQlZyVEVRUWw4TGVURS9qSzhVVWsweU9P?=
 =?utf-8?B?Q3cyZWQxb0dDOFN0ejc1T2dOTWdQRWJhRHd2Q21HNW05d3hkdENYWkszQzd4?=
 =?utf-8?B?VUR0WEFEOXdtVEdUQlIxNmUxZUJjWDlDOU56R3VXNjFDeVJjTEJWWkZyWVV3?=
 =?utf-8?B?dXhSWUsyU3NnckVLb1dJeTlpVzY5anpiSzN5Z21BdlgrWlpXelJWUHdwUEly?=
 =?utf-8?B?NElaYm0zaTNReWN1SGRZNEJ0N3o1NkljM2pjckUweGhuOVdBL1BzT2QraHZj?=
 =?utf-8?B?SlduOFh0NHpRUFR3Ni9wWU9BQnRTUG9RRFo0RTFTa28yRG0yVWF4eG5qY0VI?=
 =?utf-8?B?QlR2QURDeHFXcEhVcDdDTkVXWVRnOHoyODNYeW51bkdJNll5NE9Sczk3bWxO?=
 =?utf-8?B?RUEzNmRNVGZ0Mk15dC9oWEVySHN3QU4zbjNMNyt1ZzBEWGZIZTNkZ3hsZ0Nr?=
 =?utf-8?B?SlAwVEZ6Zmt1aTB3OEp2VjNXUWxwTUNJTTc1YVBQNExCNjZhaVpSTTh5byt0?=
 =?utf-8?B?cGNhNmh2TGlTSjBFZ2hGN2p0Q1NoR0RuaS9RdWF4eDBlT3M3SitIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8568b34-309f-4aa8-9964-08da3d69f351
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 09:44:08.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BD4P7Ad1ezAolyi2H+Pe95TD3/jyXmhW+AmAfM6CSTpJkLPh0An1fRkwnHl77kST+RiR6n+12b17LfhVgV9LPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1heSAyMywgMjAyMiAzOjEzIFBNDQo+ID4gQEAgLTI1NCw2ICsyNTksNyBAQCBzdHJ1Y3Qg
aW9tbXVfb3BzIHsNCj4gPiAgIAlpbnQgKCpkZWZfZG9tYWluX3R5cGUpKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ID4NCj4gPiAgIAljb25zdCBzdHJ1Y3QgaW9tbXVfZG9tYWluX29wcyAqZGVmYXVs
dF9kb21haW5fb3BzOw0KPiA+ICsJY29uc3Qgc3RydWN0IGlvbW11X2RvbWFpbl9vcHMgKnN2YV9k
b21haW5fb3BzOw0KPiANCj4gUGVyIEpvZXJnJ3MgY29tbWVudCBpbiBhbnRoZXIgdGhyZWFkLA0K
PiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvWW9kVko3ZXJ2cElkV2Zn
K0A4Ynl0ZXMub3JnLw0KPiANCj4gYWRkaW5nIGEgc3ZhX2RvbWFpbl9vcHMgaGVyZSBpcyBub3Qg
dGhlIHJpZ2h0IHdheSB0byBnby4NCj4gDQo+IElmIG5vIG9iamVjdGlvbiwgSSB3aWxsIG1ha2Ug
dGhlIHN2YSBkb21haW4gZ28gdGhyb3VnaCB0aGUNCj4gZ2VuZXJpYyBkb21haW5fYWxsb2MvZnJl
ZSgpIGNhbGxiYWNrcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCg0Kc3VwcG9zZSBpdCdzIGp1
c3QgYmFjayB0byB3aGF0IHYxLXY2IGRpZCB3aGljaCBhbGwgcmVnaXN0ZXJlZCB0aGUgb3BzDQpp
biBkb21haW5fYWxsb2MoKSBjYWxsYmFjaz8NCg==
