Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB64FEACF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiDLXsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiDLXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A88BF08
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649806619; x=1681342619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EXyrL3hNm8eUjxMYHPQZ/wd9CT59/ddRrkeVwmaUwug=;
  b=WJ/LXRwsqs8uf2K2T953v13HaWClKupHPLmKpKh3jxviYYRSolKPegEL
   Qw2TV1vMRfOal2DdAVCPMPmYpe/pKGJ6gnkOG8H52KVWyb9o/A7XSEcs8
   Y7UNwWphxoxNtrB2XaNOQCtTnB2X47MSrpmriv1aX4c8fnbr/GwZpjq5y
   NRt0wQlB4/HJBf6oo10fjacD9TEPgsDBk8PybFjX9RPZ1WZ4FnXVxtc9c
   3douWAThMzgA/Eivk0eKUnPlLt53KCwK60YQJlWj5azhS3Unb4Gwixtls
   Tvy7TCWkSjHsw5UQpJSvpJKbrI34/oJt9P7PXLpbQ2PlKSUXEbqs9kvEI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262711137"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262711137"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 16:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="590542586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2022 16:36:58 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 16:36:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 16:36:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 16:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Upowtt5MxMmwxaRbnt+WbQdSBO7DFofHdPzelHDRUeoopiWc59B6HLGCJUK7NhQ9xRaQGE8aQ77cgLkA3RSXc0Dkfd1GDeyfNcIsRMuljkxXXWt/sCwgTakjZWEuomY7zzcyezhAKp7p8smERSH0lr6xJbP7GNWnjcsiQRsSGJREg/AXBuUrOacjyEAc8N7tdpoPnJmAdnPC1mZpS+2mZ9LpPI7j/afErEk0Z3JgX9AJ3mRsqc2UAHjfHQZGE5Ly8r7MU94EpUYIKpzXj9ZOSDuUXDYpOJ8OB0KLX1giYdnD31S0SRp0+FHxh1THWUea4ialcfmDhD1pDR9kIOqGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXyrL3hNm8eUjxMYHPQZ/wd9CT59/ddRrkeVwmaUwug=;
 b=Pe4jVS5LTCC/3VpydEUcHdcrLKG00ZnvmhRkFSPxyzSRfo5yxpF8MuiGRE1bhc3eWrKlb9zOWaHiHLDieuwvjJuQOTb4bw3hyGDKtL/KMZtCquJeIfkVtRxlJTdEhbcPWah7Ev7UM0Kdnhi+hiX+VeppDUyO8McbtKsUfonlD2gIvDpC+9IX7S2+gYy6p7+WYXIIbM1EjlUIYbgBoRHpHAEhmbH1d7iRnX67g/BtMuTcLTVDTaGOit41qNvQ6bmqZ9A74gYrB7HNc3RfmvDPGaEtq6/KGwS1gK1UupsDPlunhFDhxZbDcIflEkypgfN+HsQCLF3nUqGpg0ThkASB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3817.namprd11.prod.outlook.com (2603:10b6:5:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 23:36:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 23:36:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Topic: [PATCH RFC v3 08/12] iommu/sva: Use attach/detach_pasid_dev in
 SVA interfaces
Thread-Index: AQHYTMWeRZaN3+doq02z8waSkl9xz6zr2plggABkY4CAALKlsA==
Date:   Tue, 12 Apr 2022 23:36:55 +0000
Message-ID: <BN9PR11MB5276BE861CF22DDC11D9D8038CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-9-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCAA64597FE400DF15CF8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
In-Reply-To: <1289f780-143e-004c-41ac-d95b6f18d63c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb96ffd0-68e7-452a-9ec4-08da1cdd542e
x-ms-traffictypediagnostic: DM6PR11MB3817:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB38174E812E9F63A36645249C8CED9@DM6PR11MB3817.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5YMnKZU/038kMzAOG72Q/lBsT+LcrLn7j6xBmBvCDd5ZOl1f/Ir9TjFpKPFzEr/kzsPc2tsguhD9r+hyH+PyTEYKJFO4LzRW2TrLBXsRfJk2eunU10BK64zQ9DLQh4I4JgcMrLqpyiBnnWjKeKr6BbJvK6uu/yfUlAjO4b2by4li+9SE2TrT25wpF5HbzPU+4jOBJ9i4LnW2DjoqTEtO6Jppke2bg5L2Csrm2j+gxEKvJffXJXmhgxQrvhrphmwtcfvW8fj8oKnuM5L1wzuboHTfILXFUR7zBK/RuS+H9R+lNfSLjv53ypKUzURSglarMw/GjQimkMHFrJhErIu6/JiRjFCtIx158RrFM0aTlwNnWOLCy/MJ0VrLxU7rkD95ztdXwzzEhkiXjzGnLjjS8MjW1pUrmVhZbu5HMaWe5LhkyTMCCjUe1q98bIbRf7w9Rcxn+GlsVNuDbRpvt8Wq79atwlRpJcP5+0OmkKOimaLBOYr9Rl4qaGL60cmPeFJTEw6IXrEuJI8U+FO8ZtsJscAHVnMOgU1jRzKeJN2cn2oaBqyPsiDKr0pvmOWaJEKBPuufGPHksITWPjEaK9w1HXvWqsFfnso2zCWE0PY45Zkqnaln6qvWjth/0gWXciNZY//o7YExJN2vOL/FmBuJaN76UHuYSD76uXdw7jpV7zMkgmSX9Ix2dGJIOHlESA7NemQzDS8yS+ImzJcJn8/Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(316002)(64756008)(66946007)(86362001)(66476007)(52536014)(54906003)(66556008)(110136005)(66446008)(508600001)(122000001)(38100700002)(9686003)(82960400001)(7696005)(6506007)(71200400001)(4326008)(38070700005)(8676002)(33656002)(8936002)(2906002)(55016003)(26005)(5660300002)(7416002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHg4VXE1QUcwZ0FQTFZrL25UQmtNeEpBWGhoQlkvRGtUb3J0VFhka0J0V0s1?=
 =?utf-8?B?SGZHNDFKTDJscWFWVVpSRk5lQ21nWUdoMStlekhvbVBIeStia0JpTGREQUs5?=
 =?utf-8?B?MnlQbXdqbzB2RGt1Qk5YT002V1F4RGFUU2dpdThWN29raDFBVUpJZkxTTUJa?=
 =?utf-8?B?cXdyTGx3ai9LdnQzWUNuZW5acXVydU03bjRyc1ZkOEdyTU1ySEo5MnZsSkVa?=
 =?utf-8?B?dlFZeVNoeFloeGxhbmUwa084RDRPMXdpaDY1SkhMdkptMmF4Mmswd3ZaUGZ1?=
 =?utf-8?B?RitieFJlTFNhaG1sWW96K2RCd2hVcFFNdGJCbDh2VUpoMVNrVkhqa1BoVXE4?=
 =?utf-8?B?eEhDR1c0cEl4cWFrSXBiVzIwTVduZC9iRnVqYkcya0EraUNDVHpweUM3T2pk?=
 =?utf-8?B?eU1PSlRwcUJad3BreFNkNXpSVlFUZG05ek5hKzdtQzdEUFZwanhPRkd0MFBh?=
 =?utf-8?B?MkpLYUdobWg0Q25QcUpoRnoxREd5Vi9GMWdWWmZIckQvUnQwS3pvbExKK01K?=
 =?utf-8?B?YThGQjVKL3Jqa0xlc2VqcFFZQS9tcWhJU0xuQk81dzgzbVBZTWxDYVdMaHky?=
 =?utf-8?B?SkZ5YWhJWldtcWZqUVhGaW04OVlMZkRDb3FMNTMwdGdXUlhDTUI5Nk1mU3VR?=
 =?utf-8?B?OXUvaTI1akt5SDBhelVnRXBEaTJsTTZNUmpEK0UxZEhrZ2liYXBRZFdreTJu?=
 =?utf-8?B?dHBMNncyYUxKSXVaL1luVGd6L1hYVVFvZFk3RmJoSHo0UE1vT2FGTHFkVHph?=
 =?utf-8?B?K2V0dzlMMjVFSDJwUEowWFF4N2ZiYSthTHVFV3J3VWdXQllwTGZST0M4UW0z?=
 =?utf-8?B?SUl0TXE1dFJObkJES1JNRlA2MGRzaDlPK3FpRDBIMnF3QmJRTDl0bzNHTTdk?=
 =?utf-8?B?RkZwRzdiekNPeXBwWVZEUVoxSFowamxxbHFEaEE2eXJpeURmakZwNDQ1Rk5z?=
 =?utf-8?B?dExlRFdqcXQrUndIUTcxUmdBc0FwNFY4VnRJbDVmVXVzWFJFQVpBSzJLKzlj?=
 =?utf-8?B?S1VFTkFTR1J3T1lNQW9QblRmc0lwekhwSGhsdjBFSkJsRVpNY3JkWDI2azd2?=
 =?utf-8?B?bWMvMWZzeXpGR3lycXJ1VzdUMkk4UHMwUlNqc2xlTEdGWUhFc2VKTFlWOHp1?=
 =?utf-8?B?RjlFUXE5K0s1cjRXODhkelhHQm0xb1NadzlIekFrUFhkd2ZPcWpzTEhmSTNk?=
 =?utf-8?B?dEk1d1VNWWQ5Vm43dllmUnR2NEJSemNFUlhuRGV6WDFkalU4cHh4TDk4cFhR?=
 =?utf-8?B?cjlnMW4yRlU3cElMR2orZU1JS1BDaDlJR1Jyc0krU20xQkNhTlRacDhLY29w?=
 =?utf-8?B?bUpyS3NZWjBpUlV5SVhXcVVqWmVYUncrRWQ5ZVFmTVVydm1WWGlaN1h2SW9D?=
 =?utf-8?B?QjUyY3dGcmtjejRPVFVGVmRjNjluaUIrRmNaeGVZa09hYzJUY2tBVnBjOG9O?=
 =?utf-8?B?RStyRWN6ZStvbHY5QWJPMGVRanlNQktCOWV6UmdmRWpkSVllaFlwVE5qc1Ny?=
 =?utf-8?B?S1dZWUpGVkorNmVxemhEdm0zR0tGdzBsOTlkL1VsRnk4NUZVRkhqTnpyYzZv?=
 =?utf-8?B?WlByM0huenEvYWpWOHAxV0Z5bXJlSFFPckxBZFk0aHJ5SWRMNVVJd1NwVEVT?=
 =?utf-8?B?TUZYa2J3TVF2U1NNdzE5NGVjMFdnSW5HMDV5aUtNaE15TG9XdlNVcC9XZTVy?=
 =?utf-8?B?cndpSEVJMjBvWVJwOHdTNnUwbUZpU21pc0V6N1BtbzdmRG5MTTVFRkVYSTUy?=
 =?utf-8?B?THp0UVh1QlN1bzZ3SFJFQ2s0NGt1ajl2MEl3dm5xazZnQnlWaHVHYzA1ZXJs?=
 =?utf-8?B?Ym90dEVUYkRnVkEvSjVWUzg2aTFqQUlWVGdlT3oyVklnMmV5bWdPSFZ6U1F5?=
 =?utf-8?B?NGdDWkl6ajhOaDZKM1ZrL3lzZ0NGR0ZFUG5yOG5UKzFPdEFzdkJOdGM1SkJu?=
 =?utf-8?B?LzluRlk5K1Bkeng3YkEycHVUZ1o0ZS92VGtJUFd6dGkwMVVWRFFCbkdiWXZr?=
 =?utf-8?B?QUFhV2JndmVEakNEbnBDOXFicitrUWRHNEo1OWl4cGp0akM3NWJheDQ5ZGo5?=
 =?utf-8?B?bGJEcXJIaHlieEJ0VlRvNnFxdVVwVUJMRlZCNUY1Q0RvcnZSNlpmOTNRdE96?=
 =?utf-8?B?UFplQmpUS0pGSU1IaHhhalIzWFBLcXhWUGdHdW9MWHd3V0EzdHR4bUJjVnBX?=
 =?utf-8?B?bjh3MGYwMkhoTzFvbWdqUU15aDQwb0VBNzRyZm1CZXo5Wks4NjFzRzNqOHdw?=
 =?utf-8?B?ZHBTQ09JZWo5cmhaNEx2R0lXcUdSK1dNUklpK3NzUUtQM1ZoUVh6QUw4SkFv?=
 =?utf-8?B?RTdUVFYrR2lqRVNWT2U4N3hnNzBvTDA1dWV2MnY4NkVvZkUyd2pzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb96ffd0-68e7-452a-9ec4-08da1cdd542e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 23:36:55.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In7VCihm4o7YnP/OeB/CWIAG9gdNtOdpvlVB/svRvqFuSj6GtbAyW6zA8Y25sxWfkS732Njq+aW4OdRSt8R7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBcHJpbCAxMiwgMjAyMiA4OjUzIFBNDQo+IA0KPiA+DQo+ID4+ICsJaWYgKCFoYW5kbGUp
IHsNCj4gPj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gPj4gKwkJZ290byBvdXRfcHV0X2lvYXM7DQo+
ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJLyogVGhlIHJlZmVyZW5jZSB0byBpb2FzIHdpbGwgYmUg
a2VwdCB1bnRpbCBkb21haW4gZnJlZS4gKi8NCj4gPj4gKwlkb21haW4gPSBpb21tdV9zdmFfYWxs
b2NfZG9tYWluKGRldiwgaW9hcyk7DQo+ID4NCj4gPiBTaG91bGRuJ3Qgd2UgZmlyc3QgdHJ5IHdo
ZXRoZXIgZXhpc3RpbmcgZG9tYWlucyBhcmUgY29tcGF0aWJsZSB0byB0aGlzDQo+ID4gZGV2aWNl
Pw0KPiANCj4gSWYgd2UgdGhpbmsgdGhhdCBoZXJlIGRvbWFpbiByZXByZXNlbnRzIGEgaGFyZHdh
cmUgcGFnZXRhYmxlIGFjdHVhbGx5DQo+IHVzZWQgYnkgSU9NTVUgZm9yIGEge2RldmljZSwgcGFz
aWR9LCB3ZSBhcmUgYWJsZSB0byB1c2UgcGVyLXtkZXZpY2UsDQo+IHBhc2lkfSBkb21haW4gd2l0
aG91dCBjaGVja2luZyBjb21wYXRpYmlsaXR5LiBTaGFyaW5nIGEgZG9tYWluIGFtb25nDQo+IGRl
dmljZXMgdW5kZXIgdGhlIHNhbWUgSU9NTVUgbWF5IGJlIGFuIG9wdGltaXphdGlvbi4gVGhhdCBj
b3VsZCBiZSBkb25lDQo+IGluIHRoZSBJT01NVSBkcml2ZXIganVzdCBsaWtlIHdoYXQgdnQtZCBk
cml2ZXIgaXMgZG9pbmcgZm9yIHBhc3MtdGhyb3VnaA0KPiBETUEgZG9tYWlucy4NCj4gDQoNCnRo
ZXJlIGlzIG9ubHkgb25lIGhhcmR3YXJlIHBhZ2UgdGFibGUgcGVyIG1tIGluIHRoaXMgY2FzZS4g
TXVsdGlwbGUgZG9tYWlucw0KYXJlIHJlcXVpcmVkIG9ubHkgZHVlIHRvIGNvbXBhdGliaWxpdHkg
cmVhc29uIGFzIEphc29uL1JvYmluIHBvaW50ZWQgb3V0DQppbiBTTU1VIGNhc2UuIEdpdmVuIGFs
bCBvdGhlciBwbGFjZXMgY3JlYXRlIG11bHRpcGxlIGRvbWFpbnMgcGVyIGlvYXMgb25seQ0KdXBv
biBpbmNvbXBhdGliaWxpdHksIHByb2JhYmx5IGl0J3MgbW9yZSBjb25zaXN0ZW50IHRvIGRvaW5n
IHNvIGluIHRoaXMgcGF0aA0KdG9vLi4uDQo=
