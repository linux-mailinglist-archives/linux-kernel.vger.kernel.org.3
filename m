Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D44E35D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiCVBBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVBBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:01:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5AB335503
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647910815; x=1679446815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EZ2uxHqqkYEhVDUtUYaPwBKICbKEcQj4D6xOz3xFAz0=;
  b=EzztOsOcEVICIPqD6Gq0lwqrbsHktf48sM9HQM01QUtK25cxpBQFSw79
   bh9CsA6a+DnBjr+0kA92S3RzhQIhn+08n8nAqov4K8/XCkdjIf0sGv8wl
   mK1r6mDLtCmiIn1jdv66Qw7Sx5iD2uMse+Ps5P/bAmjOtN5V3Z+aALCTX
   i0TQBaaVc/KLVZL64MDmBG26MfU+WbhIHd5NAHpNx4KjH3+bfZV/9GO5X
   7g6WIOhf1nPHYYHxYzyKW4xde/BrNTEWm77YSSTVInTMpSRntUNs5pEZd
   20++wvaJJ7hxwvxxq7mX1pHUXp87RTv37xYeTxeqhRmv/kdmvfZvC4CIh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239846163"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="239846163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="636847939"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2022 18:00:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 18:00:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 18:00:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 18:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQxNTdAxeoJoeKt2Oh98IcsSzkGrGPYG8I6+weCNazgbMsz4Q/9oc9pqFd2i3Gz3Ad06Ch69jdkuG+Oe+2POER0ePzr/J5a/Ye+eEd2iNAeuK9DzbSXepgPAhurxPfKwSm4w7nVqIjYPgvr6qUYRPDLX2luqemHF1giNWiDUYzHZ19hT0Cg3PaMeTd/x6S8LGwJHVrHEGsP+HI5BHbDDMVlmBJ2xjnfFW1r31nvUhzMxsntgaH4nf/Gx5E8CrWcc+0LuhNP7eSDtO4dwIvbKtDRD5auVHFEoI5jOkPFD+6cH96SlERPFRcXVNcuyMvcfmhkiRkqmed5f+4UjZyw8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ2uxHqqkYEhVDUtUYaPwBKICbKEcQj4D6xOz3xFAz0=;
 b=hsLqctSnmLDW0wn9Q0to+jGNb0hGDb0b7eVP4gm2Ly5IaoKT6sWoEeitn4xUA8SgXVpRxHNkVgX/YN9Q9ZUfLHnZ36TtelUz4ipmbHp6dD1p5/X8uTLWfy5KKxPBZXepVqkd5iVTmhd1QFXkTugx2tnk6UPc7T0Oa+lrXQbOZ4xCx8HwrDu1DDIdb4fhGGF5GTTPlUtseEMOXHWFnmX/aumcDC1Yf/s4hr10UFSppX3oe8R2QmgWJ5ZAh19XGoqaf0lj5MBLTGgxYcVa5ylXWFRL1bNpLYK67ci3RPPUC5kD4GAc5hbqt+VXpfzU0EZHC8ouNEYX9BPmCuPIco0gKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4296.namprd11.prod.outlook.com (2603:10b6:610:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Tue, 22 Mar
 2022 01:00:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 01:00:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Topic: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Index: AQHYPCXJ2tlsQR7+N0uG4LpIf9YVg6zJfVAQgAA70QCAAN2a8A==
Date:   Tue, 22 Mar 2022 01:00:08 +0000
Message-ID: <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
In-Reply-To: <YjhkmDEGwF4EcM8R@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdeef294-f9e0-49d5-9c2b-08da0b9f4f4f
x-ms-traffictypediagnostic: CH2PR11MB4296:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4296BCC17C3E7CD6E519DB888C179@CH2PR11MB4296.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuL4wwNrwt9pt8Sge6c/n3tMczeIL5DjKN1tx1UXr93lOIr68Gf69R7MWPVC/uxmet97ZmSCYtH4zge4NthvutEr6VjcUt5vN+wnkPpv/rEoHY2sh9OHMAB+Y8YouwS1Ng/renfYoDQ9bIO7iVM8Pc4q/wJlUdDf87ug96AsrCVbDnsXECBYl7vcuft/cWT1CAPgQgkVELBZTEwBmHCJODA95A/MTq0oC8Awq6mBYsaMCgS6Ce7X9ei7Iv8QpQH6Bibn39GcDnuHLG+VUVQYRKOjhWg5Y/hqfLnqb1LA5TQ3DzXjMtzFfO4l+tTJzXbAOlMgzomMA9UzrvcJ3/hcBG3AbtHws0JdMU1DQQ/1ZZqiESQri0MLgmRZtinwk6BQxW1cvXv1h2KPnpi5WmaiHTGcP/Rd19tmZXtvdpvutupMDTQeLrtrdIrjbe/0l7liY1DaIf2Ig5/BR7bpn1fVg2Br+W9z9h33+V2chZvV20BWp5zffhgB1jSyacuPmc6+f/hKfg7XHoYTgoSVjWR35jtsxdW3q6OLXZNFWKDmwJpINAr45Iilbd923mA7XrNiFaELxYM4Kk0LDETIiir2KdWzQoP8oAsRMo3DzhEIAqgVjD/DGFuTgCCxqPwbwvol7vVotPCWAidC3Jvkb10E8zCFbSkO0JrVFKb9kJ4hGfhVuNs4l0lJeamc/r/smJo18e5rU33qHhlFeTyWM2C9RRpl4of2OeGbsYq1n0zBI2I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(33656002)(7416002)(52536014)(71200400001)(5660300002)(86362001)(8936002)(508600001)(64756008)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(55016003)(83380400001)(186003)(26005)(38100700002)(2906002)(9686003)(122000001)(82960400001)(6506007)(316002)(7696005)(38070700005)(6916009)(54906003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTIxMndMU2VPRjV5LzlaT0ExQWV6VjlzZHNBcGtWOWhsNUhTNUpienZLMDlY?=
 =?utf-8?B?UjlqSmFJVE9XaWNGck51cnRaUXhCRmZqZUpsS1FxVmxaRFVBa1NSSkRscGhR?=
 =?utf-8?B?aUdtZklyWWRNN1pWK3dUNmFNS1hFRWMreWtKVGVWVm9yM3d0ZE5oUFhoZnZy?=
 =?utf-8?B?SFJkRnI1SDZOaHBjMGRhS3B1TGh3SnJhaldGeVRoQUt0WmRsUFMxVXhWeEJU?=
 =?utf-8?B?Y3g4dHF1OHhMSlNJZVVRRnFWTWJYcTVYdEcyaGF2Q25uNS9uN2pETG5od2l6?=
 =?utf-8?B?c1dTRWU2bHpydWVpbkFaUVlEUkNLMWdrRzh3TVllaENuV2puN09HU3JmTkNQ?=
 =?utf-8?B?M1l5NCtMcjhLSDRHMjErUDJPYnMxUEJoREg5UTdaOGdtZmlvekNQQ3pvUFNq?=
 =?utf-8?B?TWJnK0FVU0RlKy9zU0I3QXJrb2IxWkQzZVRESXVGSXBGcGh3S3VUT3VVNWhS?=
 =?utf-8?B?NmxtNHdNVFl1SDhhWm5OcWc3OUVyNXhEWWFzM0VQY2VJZmVNYlVpZWEwamow?=
 =?utf-8?B?ejVPODdpT1ZnZm8wZ3VPblFBUkZFeTU0NlcySUp0RHp2YUxzUVN6c1h4MFpO?=
 =?utf-8?B?SVczMkV2Tm8wLzJQYUg2WmZqNFBIalFZOW1nazFkZ1U3ZGNHcnJLUU1vekFt?=
 =?utf-8?B?dGJyaEhmdFBEcGJUbHp6TktVYjVHd1lDeUtpREhMVVlqZ3JITm9CNUlNN2Vt?=
 =?utf-8?B?dHZhTUo3a1dKMUFFUGVGRU43emw4NFM3bjh4MlZUSldBTkpacXNsaWFvL043?=
 =?utf-8?B?YVVHeGRsSEo2NjdYTlZYOGlkeWRRTStZb2liZmVhY2lkQVVpNzlLUktBZG4w?=
 =?utf-8?B?WnFZZ0dYQjNiclRBcm9KU2pBV2hCUXJVNmV5Z3JIQlVnalVGMjgyQk52SGJn?=
 =?utf-8?B?VHdKUHFRWHdMTEVXTXp1Y25FRi9mMWpJdFpwdlNsKzlpSVR6blo3dFFUcnJo?=
 =?utf-8?B?NTNtdFpwWDczNmJrdFVLMm83bTUyQmtFblI1TXFtQzkwOUlUK2JBcTVWaE9R?=
 =?utf-8?B?SHJZYkpsR3A4aERpK251engrS0NpYmU3Slk3ZVplMEpzNUVCSjRydHpWRHRD?=
 =?utf-8?B?aklzdjRZczRYc3ppNTZWT0Z2WDlycEgwd3FnbHNWZU5IOGhnQ3I4THFTUFNt?=
 =?utf-8?B?SkYyUndleWpGaE55S0lSUDEvV01ONjNnS21tZUJidGg1MnNUTUdIMGY2TEEv?=
 =?utf-8?B?NHIvVFl2bW9aU3IrZ1NOUVZ2SkNKdGZwNERhcmVGYlRDZTlQc1h1RGdmRCtK?=
 =?utf-8?B?clFzb1ZCYXRRUmxzbkNlVVY4NmFYZXA2MWlEc3B1ZENQUzVjM3pVelh6cDhZ?=
 =?utf-8?B?TEg2U05VUDROWDJnRThIOHIwNWZ4YlpMYVNFWjJ3YnhCd3BSUm1sUElOWmF6?=
 =?utf-8?B?TVpUR2lsT1BJR2I2OEt2SnpzVzFqY0cwWUpReXhnNEt4emc2UHdwNVd1b0Zz?=
 =?utf-8?B?eWZZcVNMd0tvN3NxRHFSMFM3bm9wODRaS2IvNDgwSEpHQnVac2NYSGVBUVk0?=
 =?utf-8?B?a1VCbCtxVmpZbzlBVm0rNk11eFd2YkxobWFPaG53WWJjd2lvaHZwWE5EdnNK?=
 =?utf-8?B?ZVVhWThud3FwQURyOU0va2Fob3B2V3MvYlM2eCtVVEw2ditYZUhRRXdaaWpn?=
 =?utf-8?B?TTY5bGFMRnBOV3QrL2o1QU9Gck16WWJZTXl4OHo1VE8rWUFDSlNIS2k3cUVi?=
 =?utf-8?B?S215Tkk1M2NneUc4a21EbFM5dG5zMHFwUjA5QUFHNFExcmUyTlZJWEFzbXNJ?=
 =?utf-8?B?NVZIMFNLNG16TStjMHlvSDdLQytXWXVUWkhxdklsbU02UHA2dTJGZUZLa2xi?=
 =?utf-8?B?OU5sWVVoaVFnTmtHVTFwamVZRmZ1dTFQNTR2OS8yVC80OXlJUnlJQW8zK0pi?=
 =?utf-8?B?MHRJYm1HVjU0UkM4RlVodk5KNjg3eDZmZVRtNnk0c0N1aHhrVFpZVFpkanZB?=
 =?utf-8?Q?oHaKtJm7m6elkgQCvSEpN/I9iIiO4pl0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeef294-f9e0-49d5-9c2b-08da0b9f4f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 01:00:08.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+Fp3GAJXTautmZlgXBRVD7sqp2jIwGqDQxyJGe9dMOD9ZsDR56iApk3jYTiDFkVaKZToRs3FvR57r2/Db3eig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4N
Cj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMSwgMjAyMiA3OjQyIFBNDQo+IA0KPiBIaSBLZXZpbiwN
Cj4gDQo+IE9uIE1vbiwgTWFyIDIxLCAyMDIyIGF0IDA4OjA5OjM2QU0gKzAwMDAsIFRpYW4sIEtl
dmluIHdyb3RlOg0KPiA+ID4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4NCj4gPiA+IFNlbnQ6IFN1bmRheSwgTWFyY2ggMjAsIDIwMjIgMjo0MCBQTQ0KPiA+ID4NCj4g
PiA+IFRoZSBleGlzdGluZyBJT1BGIGhhbmRsaW5nIGZyYW1ld29yayBvbmx5IGhhbmRsZXMgdGhl
IEkvTyBwYWdlIGZhdWx0cyBmb3INCj4gPiA+IFNWQS4gR2ludmVuIHRoYXQgd2UgYXJlIGFibGUg
dG8gbGluayBpb21tdSBkb21haW4gd2l0aCBlYWNoIEkvTyBwYWdlDQo+IGZhdWx0LA0KPiA+ID4g
d2UgY2FuIG5vdyBtYWtlIHRoZSBJL08gcGFnZSBmYXVsdCBoYW5kbGluZyBmcmFtZXdvcmsgbW9y
ZSBnZW5lcmFsDQo+IGZvcg0KPiA+ID4gbW9yZSB0eXBlcyBvZiBwYWdlIGZhdWx0cy4NCj4gPg0K
PiA+ICJtYWtlIC4uLiBnZW5lcmljIiBpbiBzdWJqZWN0IGxpbmUgaXMga2luZCBvZiBjb25mdXNp
bmcuIFJlYWRpbmcgdGhpcyBwYXRjaCBJDQo+ID4gdGhpbmsgeW91IHJlYWxseSBtZWFudCBjaGFu
Z2luZyBmcm9tIHBlci1kZXZpY2UgZmF1bHQgaGFuZGxpbmcgdG8gcGVyLQ0KPiBkb21haW4NCj4g
PiBmYXVsdCBoYW5kbGluZy4gVGhpcyBpcyBtb3JlIGFjY3VyYXRlIGluIGNvbmNlcHQgc2luY2Ug
dGhlIGZhdWx0IGlzIGNhdXNlZCBieQ0KPiA+IHRoZSBkb21haW4gcGFnZSB0YWJsZS4g8J+Yig0K
PiANCj4gSSB0ZW5kIHRvIGRpc2FncmVlIHdpdGggdGhhdCBsYXN0IHBhcnQuIFRoZSBmYXVsdCBp
cyBjYXVzZWQgYnkgYSBzcGVjaWZpYw0KPiBkZXZpY2UgYWNjZXNzaW5nIHNoYXJlZCBwYWdlIHRh
Ymxlcy4gV2Ugc2hvdWxkIGtlZXAgdGhhdCBkZXZpY2UNCj4gaW5mb3JtYXRpb24gdGhyb3VnaG91
dCB0aGUgZmF1bHQgaGFuZGxpbmcsIHNvIHRoYXQgd2UgY2FuIHJlcG9ydCBpdCB0byB0aGUNCj4g
ZHJpdmVyIHdoZW4gdGhpbmdzIGdvIHdyb25nLiBBIHByb2Nlc3MgY2FuIGhhdmUgbXVsdGlwbGUg
dGhyZWFkcyBib3VuZCB0bw0KPiBkaWZmZXJlbnQgZGV2aWNlcywgdGhleSBzaGFyZSB0aGUgc2Ft
ZSBtbSBzbyBpZiB0aGUgZHJpdmVyIHdhbnRlZCB0bw0KPiBzaWduYWwgYSBtaXNiZWhhdmluZyB0
aHJlYWQsIHNpbWlsYXJseSB0byBhIFNFR1Ygb24gdGhlIENQVSBzaWRlLCBpdCB3b3VsZA0KPiBu
ZWVkIHRoZSBkZXZpY2UgaW5mb3JtYXRpb24gdG8gcHJlY2lzZWx5IHJlcG9ydCBpdCB0byB1c2Vy
c3BhY2UuDQo+IA0KDQppb21tdSBkcml2ZXIgY2FuIGluY2x1ZGUgdGhlIGRldmljZSBpbmZvcm1h
dGlvbiBpbiB0aGUgZmF1bHQgZGF0YS4gQnV0DQppbiBjb25jZXB0IHRoZSBJT1BGIHNob3VsZCBi
ZSByZXBvcnRlZCBwZXIgZG9tYWluLg0KDQphbmQgSSBhZ3JlZSB3aXRoIEphc29uIHRoYXQgYXQg
bW9zdCB3ZSBjYW4gc2VuZCBTRUdWIHRvIHRoZSBlbnRpcmUgdGhyZWFkDQpncm91cCBzaW5jZSB0
aGVyZSBpcyBubyB3YXkgdG8gYXNzb2NpYXRlIGEgRE1BIGJhY2sgdG8gYSB0aHJlYWQgd2hpY2gg
DQppbml0aWF0ZXMgdGhlIERNQS4NCg0KVGhhbmtzDQpLZXZpbg0KDQoNCg==
