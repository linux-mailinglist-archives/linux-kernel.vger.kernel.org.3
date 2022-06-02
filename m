Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94153B3D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiFBGqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiFBGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:46:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3128187B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654152373; x=1685688373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KOOuDwsk2TRPer1GlLHsf+dMRLfnWnoEjasdSi66eOI=;
  b=AgovehNG/ekGV3PwBb+P3IUtVfNqyoxFdCxAixdjE0s4KTwdrOOfR2ls
   6IZxOCEFnK2bPCrpm376oEhnbYu8+3ppZ1Gig40XE7Riy3bCCYLT58Ij0
   dh4UETNQQiSwtmiMeGvHFTpK7xTWzpcMq+8fS2uD3/KhFWHVVdUXCzXaU
   20fDyiSr93Gjog1kXEgt1HwduMxbTEi9bYpGQ7coBRyKlDaaaLtb7gZH4
   5MjnZ3LSS5VlKnS9qbz4lg3HKbmF0NdV6OYJ7rX5MFosH2YdOsqWLdtgc
   H78riqISyA/iHC3Iz9ZNDpc2YUpbJTrkYlkqJNNqNNZ4MklnDIKOBLbCL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273411476"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="273411476"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:46:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="756833260"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2022 23:46:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 23:46:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 23:46:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 23:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8zY0YvhcHe1QGfqO9HF2nghC1j4nBI7Xdx7DXlhp6XFloJWEGQ+DeFXmO0JnqIah3WTnl1tYRdCUk0DlvkfKwMALNoHPAPYWQp9t22NTpOpDHOG/257mHtxjnc8AAMyrcaDNVTo5GwKs03vM7F61KQfKNgVAxVcbF6/WhdlTVR7JDi8x/8fSuoTLJ56w4S5Ckq8ne5+M39SJeaKqbm8ZzPsxC5O0IffDCf6gR4jOgi7BOqA8/YLWkUWvSa5v3+2btX5Su+TBGX9qHuJqxsK2MIAabfA9cCQdF6FnKDc/Fb5sOMdqrUw3RzsdlenMVvorlaSLidbNbvT4OB5VG/Ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KciEVO57KZvJO0dZIhga7MZjdBMfO7jsl6cERQdM7UA=;
 b=bXpDNnjRF357PYNRmqwZk81nOumVs54Q6UrAsegcQmpqHDElAMG6ko27Y2mgs7OSLaQPkxLjlLUETMypX5WhAa+ZW9rgGZbsEP6+WQrnZYZlas8muX/P6DLKOgRuD/t0bhb4cIZT6G2Ie9LntIFaJmLADN/9mLWLBoWeM//L3qaliD8HYKNwjJDzfpd6AWjaJjGRvPz9dZ9pAf97apyZr2GdsHvCvKLIMwCTGanTvRQhKJxnVdAC72YvBjBM8RZqN0RnoiDjSyGQxJahx3qLhQb5ANS9f0sjc+IpQkUnQPOqEeoFoP7ZoajObzgt7QU/n8numVnifplTQifUp/f2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2907.namprd11.prod.outlook.com (2603:10b6:5:64::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 06:46:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 06:46:02 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Topic: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Thread-Index: AQHYa1GHkRXh3WJ3kEuCY8op0Mm4AK0t2DnwgAALZoCAAPxJwIAAW+OAgAyFD4A=
Date:   Thu, 2 Jun 2022 06:46:02 +0000
Message-ID: <BN9PR11MB52763F2C27F567A01003F1878CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276E462E3B32DDE54DD66418CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yoy6NxroLLZup0sE@myrica>
 <BN9PR11MB5276FF0D52CF82942CB84D608CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yo3a7U9kSaSzagkX@myrica>
In-Reply-To: <Yo3a7U9kSaSzagkX@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7556fa6-8963-471f-4610-08da44638f36
x-ms-traffictypediagnostic: DM6PR11MB2907:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2907E0CD83A4F7748B48160E8CDE9@DM6PR11MB2907.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aN5hsupckbBFnV4AlubKrS85IdrBtTjz13bfPIapr3w8tuzrkH2NdBhna4W3O0yBE3SdfbPXANz2KmGZihWrXRWplCFnFlPzzba1JEWjrsDHglbGkWU7mx9CgMgE7jT+WWaqP+8R5EhxZBdeK6ldObStb+N9yYtEMg5cxx+P1q2vbpW3lcztvJ3n9AEHymCJTgm4x2c9MIbTa2V4kgiYmYs4kwwl1J39zLquV0rLK/pSTfFu6RTnQmzPeQevBivxMBz5jqmQMLzh8idPROEbxWFfC8NK+d+Jbb5YFxm7wVLO9bbQwX2uy2ddKsF1AGe1t/+BZl8NZFiNusEaf2x2jCMAdP7WkZS0lD7t8rZNl2ApqUfNOxgpVBQrf18YwUEZAw1kPkWvQ2jKmWYOPvRQ8+h0EMdwr5PYXlWcGj/6VR4+ZH/bZUFNub0vNHZlc0NxnAhYfkCPLJkEO0La5ghHY51W3caI+/SvdpAJsqfXufvCGn/aoUOp1fRkPZLFMZxyuHG2WdbEKl2PLgKMrBqqvy4OfiF1gBSKm9wBvJLyVEl2Vjq5g4+ZycjtLytT4O0VTx/vFTcI5gykhB4PglVJfXIW8whG8gExkqANWnNSXYIC4/zqfIM6im50JSFhQmT0rVm/dHgKvKC/Z+/4w02Qmx+OYqCKrhJeMkQWY9VMFX/r6sIyIuSo2Dsj1J5IDXEDY34lN0Ma1RtaXU0NQMMBHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(6506007)(4326008)(66556008)(83380400001)(64756008)(66446008)(38070700005)(66946007)(8676002)(66476007)(52536014)(5660300002)(76116006)(498600001)(55016003)(7416002)(71200400001)(8936002)(6916009)(26005)(9686003)(86362001)(7696005)(54906003)(122000001)(186003)(82960400001)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CZ99JuRLZ+jQtXP/zYMoZIMvf+8fUwag+CELYXlPTF5/YzhhwrtPvjyZAvRw?=
 =?us-ascii?Q?2rUpgXIKKcUBW07Kc8j0oko7nWdT+MAMgGHRbGEs/PNgm82OF+weHhAo+/of?=
 =?us-ascii?Q?zNVTGEY+yX1wc7R/EIJnrqVPUUXQtAKX7EfBhjj+bzaUAZd4udAMpXpb3No2?=
 =?us-ascii?Q?Z8zWDOYQlsqjNw/xdURTSSZleSS8xCHD4jMpqpFUxj+fuu0TgcyAEgh8l6EB?=
 =?us-ascii?Q?pUNylwrkR278ItF21Xj5eq6QR02nSxFQLLfCd3fBo1yFvsLrq9YO8wNvtQ8G?=
 =?us-ascii?Q?dF8JUBRYDad2Qk6lxrSfbwkDgmLFC8Tn4aJcnC1Jh+Lt5D1N4jbPmQ/NJRvG?=
 =?us-ascii?Q?UAGGhK/k78abGXLII+LFiBFoBPcW3EQRpTmrBaAptPn4Jg/WmbVjOFEUx/Ag?=
 =?us-ascii?Q?LTW/+rx6Q9TAUclEE26ZrvOBE7yI62lgJLLKvJZCIXjnKqQKSGGy7CXZ58rH?=
 =?us-ascii?Q?2HByDX4U9IGclmc8EhFBEvF+CsYjkdwCLpqB5KW9Hl+dT82mDJAV/WfB4sWf?=
 =?us-ascii?Q?hgV6fHMtPG82HJnNC+Dzpw428iMkbJhZhOTy5r9UypHRRSReykvu+5MS6UQs?=
 =?us-ascii?Q?MXGlZYQndMgs0a2pzW4NYAQkyfEbfl+dsnzOwB+SMfWqRQqWVUe3oxlJiClo?=
 =?us-ascii?Q?/kDCYiemj5vUcc3jstiy1tMspDCjgqwopbswIqMFoAq54glSoh8nNuFOfiHv?=
 =?us-ascii?Q?SEylaFg8SFit6m8edAKQ0Sfnhi6nTjywcLbQvLcAwbvKe9Wnbn3q4ts3aNfp?=
 =?us-ascii?Q?cM62ml0fZgbulnVSv+/JshLW/lLBAcTh2o/AbJptL27DEwLdpFtMIf1No9eH?=
 =?us-ascii?Q?09+yzHmPPmHlxcCYLHL6ZMVKWpfxBWMsMBOgb/Yz5i0NG5QygcnBwYWE2fnY?=
 =?us-ascii?Q?xTC53fBpg9WZ5Xkqqp+8lygWYgiYPbVUvEoLSZ4m66AXQKsUpcRlQYLIvqxP?=
 =?us-ascii?Q?a0g96+Hphz8pc87307NGxmGa3NBSCc0+/Q6E0WpUUh55gOYiEtqDVNcPIZbH?=
 =?us-ascii?Q?Y7XxswU7kF80jTE9vUxwHFYYks7rwq76ivsump5ZjpktkgoMsJR3UdHZs8FR?=
 =?us-ascii?Q?JQTvh2GWRa1u6NvsFabXvpWTIJHapWllHCRVWckWuWN4IYaqp4rka5KDH+f1?=
 =?us-ascii?Q?mC6LvLEDAbAUSsDSAU/QSHlA9efx8R3FSn3vKarvRq9gj17bbf9F3mKDx213?=
 =?us-ascii?Q?PbfDOaePLn5AJRivxNxO/9kfUX6m2wqb9/QOcCBDwNej7WFFUgHLkKfOuBf+?=
 =?us-ascii?Q?cBWt7aMAJIVSuWVGO2D5AF6yix383YBUY2CIsQtjn1jFXOqOr71XA6v1Td0U?=
 =?us-ascii?Q?ULz1hyxqnFM9kPfkD6xBUez7T1XrzX959oaIL5uhw0giSbST69dB8/NN/6wv?=
 =?us-ascii?Q?SVJ+chWITxrQtDjs1CiBFlkSwnyjn+nSK1sd40WpZhnBwGGRzoj4P6tcK42a?=
 =?us-ascii?Q?iEFgvprvbGxbFO4Ki2zbkbIQa+X7r0TPqYpXvtQQp1nWsWJgtYfezy7nnRRx?=
 =?us-ascii?Q?BV/nIBmdWv4V0o0QfIaKWqOgBTL/twR2dbGi2p/hYW20auwrioFNUIsgoOu6?=
 =?us-ascii?Q?+htxr+Zh/Jl674mJLRhPFOoxjlVs2JsY/vOnlRS5qu6jDwjlK4SMsw/lFlJb?=
 =?us-ascii?Q?rikyeM7SHc37VPPvFQvNv73aZRkw7xjloJy60kyCSO1JlloTWc7+2Cal96/n?=
 =?us-ascii?Q?VmAIM7zdO+3lwJU5J/85/NsnxypXNc0zhm2NUYYc+VU72eX25VCMiRMZ/rCf?=
 =?us-ascii?Q?9f9KNxrVsA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7556fa6-8963-471f-4610-08da44638f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 06:46:02.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtN8cG0jLlOKpAJhpkNu83jL/TfGQJ+PIrZX0PtcSdt1vc1ZgyU9HP0IMbLb4lNwhClE5UGmqAhVDYPaZpp4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2907
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, May 25, 2022 3:30 PM
>=20
> On Wed, May 25, 2022 at 02:04:49AM +0000, Tian, Kevin wrote:
> > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Sent: Tuesday, May 24, 2022 6:58 PM
> > >
> > > On Tue, May 24, 2022 at 10:22:28AM +0000, Tian, Kevin wrote:
> > > > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > > > Sent: Thursday, May 19, 2022 3:21 PM
> > > > >
> > > > > The existing iommu SVA interfaces are implemented by calling the =
SVA
> > > > > specific iommu ops provided by the IOMMU drivers. There's no need
> for
> > > > > any SVA specific ops in iommu_ops vector anymore as we can achiev=
e
> > > > > this through the generic attach/detach_dev_pasid domain ops.
> > > >
> > > > set/block_pasid_dev, to be consistent.
> > > >
> > > > > +
> > > > > +	mutex_lock(&iommu_sva_lock);
> > > > > +	/* Search for an existing domain. */
> > > > > +	domain =3D iommu_get_domain_for_dev_pasid(dev, mm-
> >pasid);
> > > > > +	if (domain) {
> > > > > +		sva_domain =3D to_sva_domain(domain);
> > > > > +		refcount_inc(&sva_domain->bond.users);
> > > > > +		goto out_success;
> > > > > +	}
> > > > > +
> > > >
> > > > why would one device/pasid be bound to a mm more than once?
> > >
> > > Device drivers can call bind() multiple times for the same device and=
 mm,
> > > for example if one process wants to open multiple accelerator queues.
> > >
> >
> > Is it clearer to have a sva_bond_get/put() pair instead of calling
> > bind() multiple times here?
>=20
> I don't think it's clearer, and it would force device drivers to keep
> track of {dev, mm} pairs, when the IOMMU subsystem already does that.
> At the moment a device driver calls
>=20
> 	bond =3D iommu_sva_bind_device(dev, mm)
>=20
> for each ADI that it wants to assign to userspace. If a process happens t=
o
> want multiple ADIs on one device, then the {dev, mm} parameters are the
> same and bind() returns the same bond. Since the IOMMU driver needs to
> track these anyway, it might as well refcount them.
>=20

My impression was that when an interface returns an object
then further reference to this object is usually directly acquired
on the object hence requires the caller to track it. But not a
strong opinion here if others all agree to favor simplicity for
the caller side.

Thanks
Kevin
