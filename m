Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924C04EFF46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiDBHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:14:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9E22504
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648883535; x=1680419535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kPn40qI6XEuoGMotG6CP7nz6+54VPm1S72KIf3Q+Ha4=;
  b=N6CcmvW/jazxixMXB6qInVGpQd9nziQlNwxq+kqslYNdbeyTLyC3vL6M
   KmJRnJD0Pjgns8zrTe0Gf0N6Z9ehA17nrglDvY4e+4vn3LQ24/ys1GWDN
   UlYT9Nx7d+0TRt/8ldDcP3x+ecBM6YFd7gikvpmKDFSP/Iqn7O1LHb0b7
   GlKnfRVHjd8WdrFPVKcD+YXsqDBxv7ayGAd6Fq/s7QdsiUJyc/E83PqbB
   t9cVkcZ8OS1zUDPYqe8fAxAWO5Clpu4HLwyElDSSBksjU2+OjHh0cYQ7C
   Lje+8hGITgjYkM5HIPs6JEBGXdlJkDsYWcm/woAdg+d1HIJPzNpn2mZWF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259111913"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259111913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 00:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="548080538"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 02 Apr 2022 00:12:15 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 2 Apr 2022 00:12:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 2 Apr 2022 00:12:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 2 Apr 2022 00:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANTUO3x4mL3T9jc/jB3VeN7SlavixTy2JzwT0pwEIeEz+lzN2s28nKG9iBqCp6j/swbrwJcZEWUQ9faC9QdJVfWBWtgQqQeEuN/UYirxJYcIQ5oQKTzbG69ElRzMoCHi9zW20bcYw6UVT7JCnWXsFJxV+3mKSAROJA5z7wLgGqIiWZCsP27RwYk2izZeCLsYtN+HW6WPcys7t1dbkZRA2ElJ54x+Nvx5xNXP/Yp08WJmP/lxE0/vFRFrz1PJWjP9/6jGWPuRBcnnai1ZjT451EGbnnD1aX/xM6bM7q4JRRhzcgMbzE60TuxK05VEH/2Pf2vlBbABuUQDFyiYihOn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPn40qI6XEuoGMotG6CP7nz6+54VPm1S72KIf3Q+Ha4=;
 b=GfFg3dh4Ylob2mTnPXoxYmIWjWqLrmA/VvKAf3i0s4cG2pCdMLy3I04fUdNVwUtoWpF10BsZw6UyscCkzE38JJBhxc1gxFquDipoTKkjceam24aQpBlnfzIDO1oShrbt/UtyVM0+0iQ8nD9bXgjabRrzDAfNfehIEa1/RQvab3Okd3reyQVslHCDFxbSmUolW1cIjHU2LAsr+0qxGKwO+fkqKIfeqUAkGmGmypnHlKsupAKzBRHV9+Iow/VPl0x+Qg5HRkogveth2FCnBf+0VpvHwkROo+ACoyb+U3is+gABh/Nw52fb7OfFRbX8adwd4r0CEjJs6JIYWzRAA8H5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM6PR11MB2716.namprd11.prod.outlook.com (2603:10b6:5:c7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Sat, 2 Apr
 2022 07:12:12 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3c5c:b7a7:ca9e:88f5]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::3c5c:b7a7:ca9e:88f5%9]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 07:12:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAbnAIAELxCg
Date:   Sat, 2 Apr 2022 07:12:12 +0000
Message-ID: <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
In-Reply-To: <20220330143008.GB2111031@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b47ff30f-85af-4c66-b06a-08da14781bf1
x-ms-traffictypediagnostic: DM6PR11MB2716:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2716E801710F364FF6B1DF728CE39@DM6PR11MB2716.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJPSRRtML7OywTlrDXiWq6BIaLZ/Re+0nq3HE9MkGk2mO+hgeJkVBbXo3i/XH1fFNVj1/yK0jlQupD9Z3nw0fAtiNb7wsSRz6DZfp6ZXrcGDjppeJHNFXMoxU6HauuidpvetFzHdaIRrSCdEEqmUAZfgU+3QITv46HsLrUnZ0pgejGKOG8bycRX1732D+W9sUEshrvIh2jiV9dtVpxmvIxSwftAKZhRBCZVgM6kTNJtqkBK3TcVlDHUSRME60Ev7PmmBa3W9twtMz4O3yTDJdiVkwl/SbtZYlRAa9b4N2J5UDhCp7g5o9AiC2QeDBmCKz0091oH7buzWWsG1t3ComSxoMCW34HwfoUmLFS15o1u4vVI/2dI5fIiW/a+F9yUO1rc9rlnKUmdFprDpS2YDVPcEkoM6usuFl57t4kWC1/3/PrwFB9vd8we8rNznuQOrlaj0p8tver9mBTmEKFLUSrjKSyxlK6iYX4JIR9yxL3U9vfOzpdeL7nYZzAM9FKAG+IQMNVQOJJX3yUjsN/RFfXg8uKLZbk4TAhkyiXAyF04ZPd2Lhp/5xGTd1KQZfqgfKOqL0i5V5KefiHM1PHQJctkepvHYisMPIobvJtEVn425Aw4+pXnAPvKUY/IT4a7cBLIWImnZmoOtr6Hrw6k0F4sLktMAG4pr4oViS+cJrjm/PPu9u9N3Uv/f7OMZcDvdZYfPPIZw9aMaTjjs/tx5Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(76116006)(66556008)(8676002)(66446008)(316002)(83380400001)(38100700002)(508600001)(66476007)(64756008)(66946007)(86362001)(6506007)(7696005)(8936002)(52536014)(55016003)(33656002)(82960400001)(54906003)(38070700005)(5660300002)(9686003)(6916009)(26005)(186003)(2906002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?haqfvKDsrEEVbCfGLTLsvwIdwRhIPX5wqn7L2YzCS4d9VhlKT03nnImvED9p?=
 =?us-ascii?Q?eDwjAev45sbW98cehMh6dhpmXlEFbEFFcV3YxoJ0TpAhkJEeUAdu1ZfKezux?=
 =?us-ascii?Q?numFWNgQZUV6IcLAnmibSS79WZ23APQ7OENxZcC15Mr/VDIsBNHN7596xjR1?=
 =?us-ascii?Q?qMBpBShTUwtbTOlpebZU7RBNaqThTZwQaAJG8SpT60K7dr2Vi4S2+mRuZw5r?=
 =?us-ascii?Q?DVA5u7MotrUC5EMreOzvzQHf6vIdrMOqkeHTKQGzaCS6R6TGONQTLC/8GAxp?=
 =?us-ascii?Q?gOeaFtOguKrhU8sa4sSTSIwe5Aa7wKHOlNMH6ZpWLBNhO9Jfqkdt1r9U7g1u?=
 =?us-ascii?Q?+4IYf2e3f68Grc/6QTZwMIzfwg/OXAyzdHI94SA81YzPAVHmeVPj6+pIpDcT?=
 =?us-ascii?Q?XaU5BLZgytdlZXNFI6W9fSe/Xrnj8+PhpoTgVmKrNJFjIk3PIK+N/B2dseSV?=
 =?us-ascii?Q?rGH8d54PV2Bl8+wQZjS9UR6V6Bp2IutcfxUO+QKBvTunGLLAWgclhusWN8H3?=
 =?us-ascii?Q?x7k6mTvAn6xlqGonmUEf51sJTc1Y6BQ3P2Qi/ERe8a3MdY2hMF5jIkZjkeKU?=
 =?us-ascii?Q?6Y0ecveIyt+69lGn/b63MaOxtvSzA6TFqVGIp8WkL7EEq9teTiD4WJweNaH1?=
 =?us-ascii?Q?HNKGtTZfXfLt+1vM6CNUfnl9oxEWhAopShHZoSwPXAxYhDV7GJ1BUvFVaDlt?=
 =?us-ascii?Q?xE3Q7HhVq0Nu1Nvymz1gEA4hVIoe60+iJNrcl++9M48fC4DYxbvIE0WHeIYE?=
 =?us-ascii?Q?5aKA8TFxGp2m7PvELsoXwsp9CWvfh00y0GX9eQjt1NI/s0hzzjGSryz6EqdP?=
 =?us-ascii?Q?EL8RhquVQl75vx8g5S1fnZZ4pIyLvIgiekEgalUVcD4w88aLheWcifqDwZY0?=
 =?us-ascii?Q?oLDjYmMqqwIgCQuK4X8Xa5NgDU0fMZ80vlxvNBIy5l+5y+5r1UW6CfrHL77m?=
 =?us-ascii?Q?T8MvhrSubxAw7wD7aX7KzBvoocAbIQy9u13EWmTT9PQGsGNIGz0cyDfbR6vG?=
 =?us-ascii?Q?Oa6JLoP6KtbgHw558qdoenAqP4675rVr+5Is2ocN/t0rfWmxLaIxiBq3hqFD?=
 =?us-ascii?Q?QbfcTkEFyCxWTWZwbuP9epxS/kMQxhRceS92GKg2BQEcCvUEKRb38n63BRu4?=
 =?us-ascii?Q?/2IL+7Rnn6sAUgL6wiHXl2GdVDv//lhVdNWPK2MuI9s2JOS+z0otY66iXx5Z?=
 =?us-ascii?Q?hSZFOplXe9D8Ls8b7ySCOOPI8EMHu9Qp9gLEFdEb5otl4+5nyV3ajzEkHGFE?=
 =?us-ascii?Q?A5KJlfHzjJDDsuI0rFDtK+YnFOHj7sQBtNCrDztzNHtOtYf5N/nhF1PWB6GW?=
 =?us-ascii?Q?IgZFXmXRdz0KH9ouGZaCCd7Q6toeoq+QKnON2y4YmpZN49f7S2GHC3l/JxsO?=
 =?us-ascii?Q?6SuyvzuSQ8WtZz1+nvsqL6onBLCvagMWKJ1vaoijb1jQVfLZh4X3++oP0ev+?=
 =?us-ascii?Q?eUVYhfYYITMPjIH9uZRbWhgWsatvxAlhCf710LbCHml3uo6CJK7RgALNC3Sc?=
 =?us-ascii?Q?k0+FzZMCLaIf3esMaZamV6Vm3LCj/cGURyCLOoGPERPacQqZTJfJgjEAUlh7?=
 =?us-ascii?Q?lsk/pZytW6Zyc338BaxXdbA9yIrGwluXV7T/jhsfqLtU3TkmfNWzWw1ZobOl?=
 =?us-ascii?Q?F7z+y1zZAWG6wkg37XN9luSuWSLonGuA+nkpEcHtwRBSB1xr8HtWHW441tS3?=
 =?us-ascii?Q?N0tF+G+YiGb1fKJi2d1wsF45sXtaJ1BHi+WT3Oe7R611C7uOMUZMWrMXxKVv?=
 =?us-ascii?Q?uZwH0II1Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47ff30f-85af-4c66-b06a-08da14781bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 07:12:12.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGEToSrjJQ7JJie8ZdlGE8PX/o+j3ods7IDamIDlSto2gQWml9fgk8OqsPY2FSd9vrAmC28SwSm1TdPLtlEABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2716
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

> From: Jason Gunthorpe
> Sent: Wednesday, March 30, 2022 10:30 PM
>=20
> On Wed, Mar 30, 2022 at 02:12:57PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe
> > > Sent: Wednesday, March 30, 2022 7:58 PM
> > >
> > > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> > >
> > > > One thing that I'm not very sure is about DMA alias. Even when
> physically
> > > > there is only a single device within the group the aliasing could l=
ead
> > > > to multiple RIDs in the group making it non-singleton. But probably=
 we
> > > > don't need support SVA on such device until a real demand comes?
> > >
> > > How can we have multiple RIDs in the same group and have only one
> > > device in the group?
> >
> > Alex may help throw some insight here. Per what I read from the code
> > looks like certain device can generate traffic with multiple RIDs.
>=20
> IIRC "dma alias" refers to things like legacy PCI to PCIe bridges that
> do still have multiple PCI ID's behind the bridge used in
> configuration cycles however the PCI to PCIe bridge will tag all PCIe
> TLPs with its own RID because classic PCI has no way for the requestor
> to convey a RID to the bridge.

That is one scenario of dma aliasing. Another is like Alex replied where
one device has an alias requestor ID due to PCI quirks. The alias RID
may or may not map to a real device but probably what we really care
here regarding to p2p are struct devices listed in the group.

>=20
> So, from a Linux perspective the group should have have multiple
> struct devices behind the bridge, the bridge itself, and the RID the
> IOMMU HW matches on is only the RID of the PCI bridge.
>=20
> But we know this because we know there is classic PCI stuff in the
> heigharchy, so we can just mark that group as incompatible.

Yes.

>=20
> > > Add a flag to the group that positively indicates the group can never
> > > have more than one member, even after hot plug. eg because it is
> > > impossible due to ACS, or lack of bridges, and so on.
> >
> > OK, I see your point. It essentially refers to a singleton group which
> > is immutable to hotplug.
>=20
> Yes, known at creation time, not retroactively enforced because
> someone used SVA
>=20

We may check following conditions to set the immutable flag when
a new group is created for a device in pci_device_group():

1) ACS is enabled in the upstream path of the device;
2) the device is single function or ACS is enabled on a multi-function devi=
ce;
3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
4) no 'dma aliasing' on this device;

The last one is a bit conservative as it also precludes a device which alia=
sing
dma due to quirks from being treated as a singleton group. But doing so=20
saves the effort on trying to separate different aliasing scenarios as defi=
ned
in pci_for_each_dma_alias(). Probably we can go this way as the first step.

Once the flag is set on a group no other event can change it. If a new
identified device hits an existing singleton group in pci_device_group()
then it's a bug.

Thanks
Kevin
