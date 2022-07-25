Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201057FAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiGYICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiGYICJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:02:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9FACFA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658736129; x=1690272129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R/GBqKKGRZRuPBxl3dSxibgNxqQLQc+jEo21gwA9LoU=;
  b=OpKCMwclBMFRknL4kNAInYe8WoV0+Du7VTd3bttELoW2ofw+YcTPhXio
   l6n93cBQp7Fqx72kbng4A4FDWB9/9mNZeouVJLd2LLxwRBgULHpqr8hGN
   3X8XgHs+h5EiyP4CBHeem8M5cSSL2R2jGNnydLVfxkBiMS/A4GWpvKFe3
   rXNOGbCm7j3uCC1KMwzDbyDkAv9wPNqYWkhR6k6LTwDAuX9EJp6eWxVWh
   4sZ8s6hh5NwVXD6JDdEGKon+HBoR9rLC2SqhN8FbtQyoA1WPl3KAdDVZQ
   MHhiPPlBKTNndexjHDeC1gQnPoFIiqf3BUONAyXMnVRHKayCV7jexH2lK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="285188510"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="285188510"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="603296427"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jul 2022 01:02:08 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 01:02:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 01:02:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Jul 2022 01:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J76oHI4b0Rr3QjEIA15fZPlyvw08Cma81LLiYU1PplxDnoWGty2zzAZs9gJHq4O8IpZcX1QVbwoiVlpkG+YnK/Zc0Nt26RyfFzh7U9JWaLn8okzSdHMl7KdECxoz1VCIqouvLJUgzOSv5ODbniT/a5Tirmd9nbzAT+ubDIC8z3vuAMr8A2rPGZtSMQ8ElvE0HhpfVczSTT4SvazLn9H1xH0I/KcZXTV60h1BzWPTWwMqG+0iqqHrZqy9zdMJjUGJMd+h7RjHuWFvYEaM0szglRbA+4L2kugXgHQIZq1gUndamdRRfeqVnIYCo4JLYd4RJ+E2QkbaoJIBZU+oEtZ6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbXuwa+vtw3M0n9TIlKHNRxkx36t9evTyTQeXfr4ahM=;
 b=d2FWURHX8ta1/j6xWBgNXgEL4961gGntEOGt3EzY92jdlpqidv4y8dQoXv5oPFDdWwWElwNzv/eeRtcHBhnJEWTc58NsOy2gJNFZvT1fCIfXNsA1dv2YQ6fZ0gVmuevqM4Id3yogFLFa9h7q7RCCobMc+M1wDKKwjtUSpJYHktRP7urWqO7qL2GDwe4uslsDmrlqkzcBwNvIh7LHiWr4nki95dYHKgOj3DIX0Q3yFGj62K4pQW7EhuCHD7EF3z4kJV/vWehBETWWc0H/nzdFsUfwMJrBPxBSs5gHLvk9meTcyntXscaqJYoohuug9xuW+gN/pQHwmJ2WVtfqbnAoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3194.namprd11.prod.outlook.com (2603:10b6:5:5c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Mon, 25 Jul
 2022 08:02:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 08:02:05 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYkC3RawHjE5fI4kOPQdVz+DQ3s62MICIAgAGHjYCAAStGgIAAA18A
Date:   Mon, 25 Jul 2022 08:02:05 +0000
Message-ID: <BN9PR11MB52769B02DE62A229CCB4F2E38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <Yt5IqyZw/Sa6Ck5t@myrica>
In-Reply-To: <Yt5IqyZw/Sa6Ck5t@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e49ff08f-1bad-4771-334b-08da6e13f719
x-ms-traffictypediagnostic: DM6PR11MB3194:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXHHBJc1WXTVpeCm6Psef7Hh72v0PSycqAO0JD3Yp/Mdw5/jMHkyxId0z3nmIx0gzmbipfK2iGkPbG5SqzqATiLgeTQ/z3/heLprc0iRpmId4lurWZaiO/Sf/6uIpXVOHH8sapNpjsKVgLrlRnGCUFG3/Q7OMGHLBMNvDSwRltoqiDp8/yuPLssh1upXOZg46tIQIBH+QKvoEC792knNwbyEMUP6dDVX/HQVe+jf8tDBRyC1EwJnp8NNOA79/Fp79d2n6JPK+qU3+OroFD/yRtRyipsP/tmWv+t87Kw3Ac7VKJQiUPXPGfX+SPViqY4XIWv/oRLQtidpxWgTkQDkM6InU4cudt+WZ8LLOJmuiJVh9HjRfKIA9Is3giruuZeT59/sC7Ip4hO7KxKNROMzPsws49nojDvdFK7eWfs5UrEq69nnnPQYPPmC3N2jZs/9x2tmDg07FH+2XTlrQiv39gQ6CBwC+xIUvj4EMlZ/JLYOZHcGsl7O55/keIrt0QXvDZoS8bLaOjuv4mayXeWdx5Gyo3/7rKSCuK/Z8B2NkQ4YBP7OQoZPUirhssAkzAIkIjKf2Dy3IioNsAKcOBOFX9i0y0unW1aLhj6fyR8ty9+NBTM28fcBj7RT7d00hwoMcdDLeEk5wHgMmQ+shrx8wpLq3BAoGAbuaDWQnaGN2nDgiw6tNgFfyxKRqGyXzMMBR0KbK11EycrlqLW8SKg7V0ULk7z2tNmTn7OgyFPmqnleSYJBuhfGIP3ewgzO2OocDa3jmDhZO6jQlpSeyPc72PxN9gVesCSwO1uw3xvl+zXJbm/AEtVpk/bht+eFmUiKDJgsPgP6xc7ZMt/9NtzOT2EjBNvdvQA2RWRIfM14h6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(366004)(376002)(346002)(4326008)(38070700005)(7416002)(82960400001)(38100700002)(76116006)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(66946007)(33656002)(26005)(110136005)(54906003)(55016003)(9686003)(7696005)(6506007)(83380400001)(316002)(186003)(86362001)(52536014)(5660300002)(2906002)(8936002)(41300700001)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JAKwgVzxLnJ8QpQUglfIdldn/RkFteYGcS+ttMrhcH/oEEZitEa2QiExz+Tr?=
 =?us-ascii?Q?yUKzmKD4hTTyo83SrOp9eyalQKK3/3mCv7GHnHGlpRp8A1/HlLbwy8Q/eXAN?=
 =?us-ascii?Q?XZF3K1QrQgK8Sd+aX2ySNqQaIqk8aQSsLSHsHxc9UQhjabwuCKt8Yi2ml902?=
 =?us-ascii?Q?YFi/UZ6NG8paKNLgZI6brubJhkpCpyojuLfWNq6YLSCOsnOM89S8oY6Ap3yL?=
 =?us-ascii?Q?ziu7TEGXuB6UQiGOoGAOCb9F9LmCyLfAhvQCUhopjyb+8YD09bW1SSLuml/H?=
 =?us-ascii?Q?WbG5b41rjmADJavYadvR3tpsqZ6TNdmlwN6RyHRb1avpV+2OK2l+GH3eM7cz?=
 =?us-ascii?Q?Cg9h1+3bY8jxKrQ+86yP1Ow5o55sS6WBU+bwCp7RaCzprhSR1epEi/B1j22J?=
 =?us-ascii?Q?7GP7vnjS1H+jYL7C457sBXnW9cTebhnxS79tLeFYXzkRMzwSretBzdMe2xsQ?=
 =?us-ascii?Q?aC4eH7Gy7Cx2zKdiD2yue8SzirTtuDuGHP5NfoICppOKSiuokpnNYe8mGhLS?=
 =?us-ascii?Q?rsPqB7cYoChMq4qO30Apq/J2Q3f4WUnkJaF4c+Pjvcah8CZFtxS/fye3c1pE?=
 =?us-ascii?Q?F+YFnMFk20DyKwHsufCXo/DZm9BSf7Dn5lsxLzLgsOzjcsKKeYX8WOk2woIk?=
 =?us-ascii?Q?hWFESRkQ7BzOgzueCHGVslAq6kOTi1pGNl9feQyLAwqT4Zl3R2mub2uWnrdo?=
 =?us-ascii?Q?Lg2F5Si8qT4Au4bsgHaQPhGfGNOOYWyKqxXGKuOBh7W3XWM/wxRBChWTVcEB?=
 =?us-ascii?Q?OZLZ1Iq5ajqRmjwYT9JiSGzmPGZTEQNsgrU46DEK30YQpG51h9ObFwgFHGf3?=
 =?us-ascii?Q?D7ZHRblZoZb6Vw6uhuVJPFUE5phH4PVAAtEGXiEO6v/gOEvR9OERBFOvAKSn?=
 =?us-ascii?Q?scidDJc60e8h83rnYNkH6rrNu2O1oTeWlLTEinAyYqpaJ24GUVjWQiS/JEIX?=
 =?us-ascii?Q?uwOTIRYQAIp0UMXXFRDQaoKeH3XcAp5U9xl5ej/YiB0xq6aLD0iJ4/e9Y+ME?=
 =?us-ascii?Q?ERvQqiLxFCy1CrGTS8n6gfuD+K+dXy7pn3JYnMt0r5pvfPuGi1EIFi8eCTvu?=
 =?us-ascii?Q?R/uwJVnFY4SWJJhzcCCpClXKvPVx+8+kkTr29+wk/QK49LE7SYEitJt2VEbY?=
 =?us-ascii?Q?bJ0MX5S9BURdrSzEMW2WwgmufK7fG19o0HFoiUGUbB3cUB7NXVpjybbzbEFW?=
 =?us-ascii?Q?kJKogmEbzcyH8tzUOXlTQs9bPhgZmcDSeP6E6mM6RWnj419GQCTVPx8tM3iY?=
 =?us-ascii?Q?WQVSekN5nw0AKKVBA7PfISgCzTnc1GTaSbCfr/agzdNZs4Qnf6+CbZ6WWH3l?=
 =?us-ascii?Q?ntsc33khEFt9vs5fkcjck5XSu8RMDd6TJqtsbB4PMVLZTVnXctFhtdwZpaOL?=
 =?us-ascii?Q?ClFnjA6ilb8as8jIU+9wxk0brvJha/YX8F8INlfWEe+MJOu4vSLCFyftwAX7?=
 =?us-ascii?Q?ncbLhZDrRsjdWQI8r7OTM4MC77LmC3trXIdKLw4e9c/IbND2tutm9WB3Wbzk?=
 =?us-ascii?Q?xZKNVCdLrfQJQ7Cnqm8Fq1zXf48UZwnSQk2wb+bDmTvFex49usGB8qnINtXS?=
 =?us-ascii?Q?szUOEf4+/8uS9XtSN4FNtSCydolnA7tveVa7a+Tn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49ff08f-1bad-4771-334b-08da6e13f719
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 08:02:05.4779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0I6FGpjsnGBG9/NoCWEPMtJ3GZjmTEIaQGa+fmVqdQL1zLr8dI6QFX9wmbgo4M1RpeSPw9g9/ZqsRC64qzfsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3194
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, July 25, 2022 3:39 PM
>=20
> On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
> > /*
> >  * iommu_detach_device_pasid() - Detach the domain from pasid of device
> >  * @domain: the iommu domain.
> >  * @dev: the attached device.
> >  * @pasid: the pasid of the device.
> >  *
> >  * The @domain must have been attached to @pasid of the @dev with
> >  * iommu_detach_device_pasid().
> >  */
> > void iommu_detach_device_pasid(struct iommu_domain *domain, struct
> device
> > *dev,
> > 			       ioasid_t pasid)
> > {
> > 	struct iommu_group *group =3D iommu_group_get(dev);
> > 	struct group_pasid *param;
> >
> > 	mutex_lock(&group->mutex);
> > 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
>=20
> Please also pass the old domain to this detach() function, so that the
> IOMMU driver doesn't have to keep track of them internally.

The old domain is already tracked in group->pasid_xarray and can
be retrieved using [dev, pasid].

>=20
> In addition to clearing contexts, detach() also needs to invalidate TLBs,
> and for that the SMMU driver needs to know the old ASID (!=3D PASID) that
> was used by the context descriptor.
>=20

Presumably both ASID and context descriptor are SMMU internal
knowledge. What exact information is required from the core API
and how is it done today?
