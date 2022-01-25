Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C159149A829
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316704AbiAYC61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:58:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:65236 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3415167AbiAYA6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643072289; x=1674608289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ja3FJbyZHNyl320LJq+VEZ/EmkVxxjYwEvgL9WRfS8o=;
  b=n0bQ89Txt2lnwLm13KebXqOa4uoNF0S/ne+gp/Kd2W+xATlClzAYA5gG
   EdrP9jrndKb7NLK6y9/rhtAHocCfNlCLKIglvgTcgwgptyf8gQGpsPmJO
   L6tHM5OPpZylPuPpEU3G1o4k8wW6CRcS0XUnWcdQpbrdBWXJGjyob/Y+X
   DhoTOglLhsb4frt8iuDGdmeEZFPX9Qh5qC3Ei/llliLzdaQxzbG1m/tzD
   vgvZhUbZKMxvVsZO+uMUumkcFiOnsPe62SwpRLepRIXn8LZP8aBlVF1o9
   kSsvXOlMShgp+BRQzQlfqa0cUMCyu0tCaUPD27Im0QGXp/8L11oSuEylU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243785884"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="243785884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 16:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617439424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 16:58:09 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 16:58:09 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 16:58:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 16:58:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 16:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBDSjUphoRuZ3G4FV2tHlenQ39S5JFqIiHtK00rpfk5R6J7BWtvOLTiaH67YTonJa3tomGXIJLjrwPLJ1AVKVJ5/XPGZAGd0EtebaMO/xlV3+wgWChXQJnBxwMiMShkTnbCkjT55gSAh3Ug1LiBmXH9XCwDPXcSRE4q56wVEwMKqNfsb+EroYoeVn9Yx5GliKpoO2lfXIh/d2o1fh5sKW3069x3k1lxLvCTMtEahp7m5MtrdQtJ9d+57sJK1gpOw+jAi2G1/z+Nf4pAwcOrC2BT2L+C7k98yzhyNZEyiPzwvcxKxVtxSnxMQ51tyvN0gTIE3Do51vjFtLvl+0rDyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YK9zPYN7SPW5DMtzYYlbhsSXJQmsioSvz+t6WYF2kc=;
 b=gOr4pf3yUJWoetrdstDCNm8VUAIpVGAeGARJ1IZ+fRUA8lTPvTTI/MI8vIfbSpw+woOtx3yMAGh1AYlt/TdVZNeXf8z1q0ATi8umhJ/3Y+UBSDZ79jALrtu1EjSxLJSPrJv++9doCJAHbeFN2pDkX1uBF/IeKFSpild1ryE9tnOs6Q5QPUJTsdSkFXx83fbYpYdt2IomQsCDTWLkkIhz8QU39JSvsdrCw4vWR5TzbcUSrJ5tmEaoP879FGW1dX9kYhRoAQmnGP47XgaLEISs1CuIYPl7tz37IRNbP1YzHlNNdyDW2W2TyVl6/E+VxBtq4PA/QSfjiIV/qBapSR4/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR11MB1952.namprd11.prod.outlook.com (2603:10b6:300:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 00:58:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 00:58:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        David Airlie <airlied@linux.ie>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Ben Skeggs" <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Thread-Topic: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Thread-Index: AQHYEPHVdqbh5j+v9U2GKt1N4SJ4Aqxx7UaggAB9gYCAAH5J0A==
Date:   Tue, 25 Jan 2022 00:58:04 +0000
Message-ID: <BN9PR11MB5276D1C4EA66F5B30D08124A8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124171759.GD966497@nvidia.com>
In-Reply-To: <20220124171759.GD966497@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 934f3ae5-8807-452a-7f97-08d9df9dbe5c
x-ms-traffictypediagnostic: MWHPR11MB1952:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB195201F0A7C1A42D193416688C5F9@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncbp9nzsF+wi87kIYuNb8GbMb+jiCWTxmo0NGxHrk3x+3HiMBdsO7RGE+cbVronn2rGq8U8anTow4gihSDoyeyrijbS3z1aUQiGJJ0DRkey3QjIhw4I/TOKCREmkkt5aiKt4YVXAD7ba5SR+uHd5wCnbCUVGyaHy0J/f0h4pghHFsU5/jI8GE+K0UVl7XUBCp7AyOfYAelVPvJKoKTc6x2m0nLM1IkeGrwB2pNLG7Vm+VoxB7PH2VXSiVEYDGji8UEiCnkMzpCkeLstiK+5jTGEBVPPXErqcIvUOw8kA8SsbN3CT+iaWEYBD9YYCNcpn8YYTPcKTJodwGU6TF6olbE5xY3txyCx9oNs5zRvIMLnY5BC97lgsR3mOM3b+eWpUOWOs3u1zLN8ppSb9fKKsiwtK5MEEnGbtS593fcgEvKPmLeBdJ5t22ozjgB57Av2jLf6eDpXmdOw2orR3jyJlrDfFCDf8qOUsvpzhLqLm1BLuIDkzuceqA1f+FPSIQR7bI91LhsZ6SIBPVC3FaWH0+p1aEt5wRcjdR7eiSu3jMajs+hyrFgOyM274AA81p13Nq/vUOMLO9WMDkmTAYSWnINP0QYDerFZlnFi12Niudl+U4t1R2E/+StYrlET5Bmjbs0neqE1BuhZLoncCwCKEAJnSdT9IKUZQyrPPsssJ7f80vdO5aLG+BzA4mADXYTqSn7Oqm4ftk4/olX4qf5NjgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(83380400001)(4326008)(5660300002)(52536014)(55016003)(33656002)(86362001)(82960400001)(508600001)(316002)(7416002)(54906003)(2906002)(9686003)(122000001)(6506007)(186003)(64756008)(66446008)(38100700002)(66556008)(66476007)(66946007)(71200400001)(38070700005)(7696005)(8936002)(26005)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rbfSVOA32lIHIJVCTtJ2KfkAc4c0MNKvb0sKFYGiIBk1rovLGV/0CV3YONHM?=
 =?us-ascii?Q?bdN/74LjtrdtU8Rm8ygWQEdG4qg1l/R/FREOHFm5PPNjsHymZG0LC/AasWYR?=
 =?us-ascii?Q?x9N5KSGUOFfDOidxOpwqzjDuSLOH8Jj9MwB663wFMLW4PbGqVTFyBdpqHh+h?=
 =?us-ascii?Q?EZ7BGivMsrdbIGj4JXwq4UhHfw/wxnea8cKYP+rg9SsczSaP3qk/XLM1kWgO?=
 =?us-ascii?Q?NphLbTMHkI9x8XaJ2VMUXwBdJXDuTZldF2ildi/nWEfMDxM+rE59n5RHbWo6?=
 =?us-ascii?Q?vlV1RhryKGVfWQPKQczuvrKtqdrQBY2kz92wOyVAwifzIMicpCwlQ5dTiHbQ?=
 =?us-ascii?Q?L1iGhOdJtmQJOdXpMqOaAVqHLPhFx2gVtX2sgDGePzLar1LSE3z9TrJPZGu+?=
 =?us-ascii?Q?u5cNtBOzlx2Cp2EG7asdFiy1o/7i6mb7AKDbIwgCcwIGt1szllHOqebttmr8?=
 =?us-ascii?Q?PiteBQVTVNfI6EP+0/eNymacKeFLGCN/+TkXLXGSTlig+mt5eDu6eVl8KEI6?=
 =?us-ascii?Q?UF9kUdCp+Ljcw1fQ1Me8dNSziC0CeFXvgtQCOTNwmfaLyDQVTxDJaZ1QVE9a?=
 =?us-ascii?Q?TNYQMzlSbOzV8a9M9+Y4oOS8rbP47xFKAlvoc9tk3gHxBbKeDFyK0E5rb46p?=
 =?us-ascii?Q?iG+zSEvaiSZDVjNmHyKSTOdg6jJUs6F3hSuMa3YUB+SmCmEoKpZ4BpXVR4sD?=
 =?us-ascii?Q?9/ZpFS7pq5khkwT7viO5MuHNjLFsPdzJrlsIFx1z61lEukAklSzx3D/r8TP9?=
 =?us-ascii?Q?S67yzk49KWOourdbO9g+nUk+0zxp2pO9qPCWeuyhsoddtU3IWpBAgyQ7z599?=
 =?us-ascii?Q?1CfNVScXkCGRGYqLlpN7NAHcNRkQRyx6EVAJ0n1XDm9/BIB2UoohlcAoaJtd?=
 =?us-ascii?Q?nTtx4ge5jul8CsLh9lw8iE/uaVxH1k853ZBPKmkBwkhZqSZZ9wELAwIbFz3a?=
 =?us-ascii?Q?4lJzDD+Jda/RGTxlrVC0jO45vZwJzlSnJPAPkODg2dLUQ4rQIJKb4QxYQcOJ?=
 =?us-ascii?Q?71Qrwhg+fMqrtDHulV/sdTHwhHQVgZ1oytIG6DMuYc/949HUk7XIo6HOzDtY?=
 =?us-ascii?Q?UUkOLhQD2vCgOE5w2wAdj8+JkAU9wcfaQTI/1JNttVExLf2nzOMgB8fQvjlU?=
 =?us-ascii?Q?BHcJMobUJ1aOdC0GLFVv4+KpTOy5mOA44i0skOUqe+tPZ7p8vpGgxr1nOH6J?=
 =?us-ascii?Q?WP6x6Pnd3IKs/xjifsm8NhMHNz6OhUOMRksOx9W+fPkIV7creyMPCW2w7vcw?=
 =?us-ascii?Q?Duw4vLCZvNAXbLLtWk5PX5gz7zGSk0h34kCf8ejD1zg01fLJy9+9bWjeMt78?=
 =?us-ascii?Q?v7OtdU7O796BlMHYjlNYf8gtrlfa1JbQxD+kxqrjy8lw6L8FvTPyZVV9kWAz?=
 =?us-ascii?Q?rBIHlBhT8t+Gnx+Y9bEKA8p+EsDIBfovsOfBAnhW7AI3T30poLPCe2vhqOtM?=
 =?us-ascii?Q?oipeiFGt2vhDXNlec6rNccMwFiSStLH6vtaUJXtSbGkHwv7oJc8LKfZNSeV2?=
 =?us-ascii?Q?c1fAZBoO1pJ8tSx6l6mE6tF2BcJmJbtVv34yZ//clQ4A1nzvQbswe8KkEgEI?=
 =?us-ascii?Q?0FqP7aCMYLb9uC8FF553UYZsrGHo4CWRfIRExYOcOE9yw5CEgrv8U2KgU5Z8?=
 =?us-ascii?Q?FFAF6tYc+K7zNfy37W24PJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934f3ae5-8807-452a-7f97-08d9df9dbe5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 00:58:04.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2VRQKvwonBxIycY/U9AdyzGLoryVAjg4uE55t5KqGqxKhRE0ixX1EioM+P8lGx8ego4eu00Z/nS6StdbRG0vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe via iommu
> Sent: Tuesday, January 25, 2022 1:18 AM
>=20
> On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Monday, January 24, 2022 3:11 PM
> > > +/**
> > > + * struct domain_ops - per-domain ops
> > > + * @attach_dev: attach an iommu domain to a device
> > > + * @detach_dev: detach an iommu domain from a device
> >
> > What is the criteria about whether an op should be iommu_ops or
> domain_ops
> > when it requires both domain and device pointers like above two (and
> future
> > PASID-based attach)?
> >
> > Other examples include:
> > 	@apply_resv_region
>=20
> For apply_resv_region the 'dev' argument is really selecting a device
> that is already attached to the domain, so it should be in the domain
> ops.

Looks this one can be just removed. No iommu driver implements today.

>=20
> > 	@is_attach_deferred
>=20
> Only two drivers implement this and neither use the domain
> argument. Remove the domain argument and keep it in the iommu_ops
>=20

Yes, especially when none of the two drivers actually uses domain.

Generally it makes sense to me by putting all attach related callbacks in
iommu_ops, since they are all for building connections between device
and domain while such connection is device specific (just like how a
vfio device is connected to iommufd).

This in concept also applies to @enable_nesting which you mentioned
in another thread. Nesting is a per-device configuration between multiple
domains attached by a same device.

Thanks
Kevin
