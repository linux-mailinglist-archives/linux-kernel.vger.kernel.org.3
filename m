Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7011E55DDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiF0I32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiF0I3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:29:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D196178
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656318564; x=1687854564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vN3Egb1d4xsSJ8FPno3WfCJGm4s4rri1v9QU6MV6QNo=;
  b=Dlca/JpkrumHSC7+gvtxshjgnHq/+MS0BULr1u/pl8YaKyFURe31IFYW
   WwuyhpN9didUKn4mCssePrry2JXnE6THS6ATnpXOwP1xOWAc9theJFnOO
   HLN939Gi/tNAfeh97/bP/7/jUuHlaL8AzTmJeXEPwug09cqTVYooxpy4N
   I6YsOT7LuBFOQH2l9IGmJujpm0KWZMnYJzO+lhOhw/SiYelTqXCIcIGO2
   Dcz8JlqwYvkSt6ghtZKbWQYgGgmFISgYm0XQEFip7c0uf6eMO+hyiuFWT
   su8lGbB/mLx+4vHOlvm2Utl5r7Pbo1wDICFA2TVqnqVty5OFPKG/X02MQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282130515"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="282130515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 01:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="692523543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2022 01:29:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 01:29:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 01:29:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 01:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvQkl8wdegaQoOakz56yhTDOfRKt3BY6owGt/f+MiwSdh/lbWKXFq3Zl/4XXgfgfWMvKXkTmtP3WxgBEb19q41HyxgEfk309UU6ojKze1mvnQaSN7KulNT9qy2e5oTSTQjlPj3ceQiWcV2iwSpHrthZNgaqoTWbUGjueMBaDKHmB/rg7y7K4GJ+fMmDaG5/c1Fo+mmZYPk62V8cQijEzkq9XA2YHnnFbJrQdLmiUjbTtSKb5dYQjudTQT82/UUbl1r62aKpZOcLdce2xzemn9drF5rnxYs7UdEbA1R+OGCjh0WQiOUdD/3V8neVflA32/mf6xIFVoupoTxO7AUURrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LgqJHGJZbdv+TAnYV0UYxrAg9/yQSn4e8imbdRosgk=;
 b=Org9j+e6LK7z3KaGvxC0tyJbEf5/+bScNINTm1rssrZ35Z8LB4Zg3xLUKI+VUyxvel141l0MtkBSUbaIWTicgtZIfhhQvgRKZ6PEYUPTCQjSPrLp5dppCtUE/QxkW9ZNb2YOmf9X0gSactOUHz2opj4wEeCiKhbtxdrKXD4Zy72XOu6o5c2BoqgBMUhqt5LioN3RTlL5622GYPd6YWaKHp9Kdeup4jNMDmKfZO29uiiHmjDCxPbFGwEvttaM7xhDG4y/iwII3Mnu82jnZGcX5btqjGP4RMYYqVfGcbtatBHa0xY/4JTzZX9is8fOqJVR/KEfMCtPhNZTJ/dbhQkvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1834.namprd11.prod.outlook.com (2603:10b6:3:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 08:29:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 08:29:21 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
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
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Topic: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Index: AQHYhX35xSpIBtEUJk2c4sDKhBGbeq1i8Q6w
Date:   Mon, 27 Jun 2022 08:29:21 +0000
Message-ID: <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2492c1e-51f4-4264-74de-08da5817229f
x-ms-traffictypediagnostic: DM5PR11MB1834:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7Do+KHARq+oPxSE+lZOw3L02ONExTD1UE6ruuXdLzKtT81GgAm1X9jXpHVmhSfpmwZVR3I596CP59RvZr1bG9kuI4bfY/EfxwHa3vqxRIs+RQEZwNLkxExOmUkzfpZeaTgsiu2fMYagZrkOWzgVerBfSQRxeoiAEi98hIntvUJcRA2JR8LWiMw8MFyd3g/bIZiY9/DEUCaYC3WqVOA++j20mxVCa/pzC+ALLsOl+n9dZM1DDszeCqXuqGOBXKm/WSPHlrJXchbwqx2Fznh60pYS7UGjXBju1x4L+ZNnWGsszXGdNOjcnQ7kB1rygzZkeZUPUirrHw00KIOLbccP7dzfGwoc0KfGtcJp8bj30pFIxL/eV7gjRIh0iL1vFcjsOTJk4+uEun4p/NUrI2iPJFJ+SXzfQm7758P4cb+GT+Nvyr9eTPmhCyy4I6pw1a0uK86MQcoYIEEqodGPmqLLJTM6qgfSg9IfomoR2t+ElAdgnPGcjTd0k+WtPvumEjw+ewRZ5sh5pLY5jNu/kUYfLCaPdzjqugNmTMo0eFtE7N1uJ1WpeG1hlFlS+v7I4qxxfOCHlRqap9zjIzzPZ8WihtrbIOayxHZrN0F8kFWmqQ/aMqSZWnzuGpPxYgdIfn641A/LvwRrc6IQl0yFyQN+jBZSVyo585MW6vklroPExc+zKEhPix3TPiFurzCLJKI1KNlVa06vGemuK5KNkCO1PCfpE8LJcMulxFJhN+7M4da6QpMnyi2SlV3Iaks/07Bl1COaAYEyH+xeVstzfO8UJGF8DTpA8B8RQHR/kmO0AOjf7Yahjt9Q+Icc8XA/8VPf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(55016003)(110136005)(122000001)(54906003)(82960400001)(38100700002)(316002)(921005)(38070700005)(9686003)(66556008)(71200400001)(2906002)(41300700001)(76116006)(66476007)(83380400001)(66946007)(5660300002)(86362001)(478600001)(33656002)(8936002)(52536014)(7416002)(26005)(8676002)(64756008)(66446008)(7696005)(6506007)(186003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SoR9V7ZJuQhcunk/D6D3GKy/YXlkm+sLeLoRw8QJSkmqFdH2qdwtNsYJenDz?=
 =?us-ascii?Q?kfrXYIlRn/kg6P2VR+hsgCYTgDA+GxMnNjSDizW3oILDYKypkTCFAjMXCxzT?=
 =?us-ascii?Q?y2uzX0eeUxyp2vNyyWX1tQ0NNSaHgQc3lOiOrSYFCLG5htmTuXBmkyhNmHjK?=
 =?us-ascii?Q?4FRW10R/GekvxRhT1GqZ83dqzAOJLsUMHqoqg2R5ew5JDS5BLOMecddPE+Xa?=
 =?us-ascii?Q?UrgEAonBP5QM/le8rCIuILZHdlKDPwkQwE/euiYCQHq0JH5Q44RaazNXuChz?=
 =?us-ascii?Q?eS/bcWSds85/wSWSbef2bmZAf7uUJxs6rDzZbmynkhLQkrT67l9bBOKE0g9n?=
 =?us-ascii?Q?Z24MFpnduDkfTH9fCdYWmMtrO/bEc6hGqEckuc85wBSflGP4/rMZW2Zvw+Op?=
 =?us-ascii?Q?NDGLAHnWhE6EiR0xaP99pdzlcs4ENiz8bi3gU52DWi/L3Wyl+qifaN5kgZbW?=
 =?us-ascii?Q?/2v5RG7+UHmCKWfz0YlNCxxiHOr0P7GOOmrBZbC8zJ0ghgBUj6e6dabHYfh+?=
 =?us-ascii?Q?jGIPaZSS5WyQkwhZFJytTbCcMCk0OecLjEhRCOeLHf+08JYsS395CrJ77KG/?=
 =?us-ascii?Q?WtX7rnLxe0Fj0zuS+rewKODRildTK0ImB/B599Uyym9OO8xY/PeGXArCtMCB?=
 =?us-ascii?Q?4C7SPs10EAGHeOugYLyNmjdePG/szv042TVibUslOdAZmSqPtNkUCd9R24R5?=
 =?us-ascii?Q?8uldd/hdL4NbZZ9t1tVd8y5J0+ZWHBx7i1Qdvpuuc09ls/pFWAlFj+fbRhlC?=
 =?us-ascii?Q?uHwqKPuKHQqZHG712PfN0DPug+W+MFoJSa5+EPM6ZgY9Voz/D1VV4GFyx9nr?=
 =?us-ascii?Q?Kyph8MOFm1VOqrG5RaOyMZ7NYUam/yJCs0WxXy42BIDZ0wtbl2GoiaGBcJDk?=
 =?us-ascii?Q?Ghaa1hFy3mXdvZ4GNbUONi62SjGhYKJZe/IkZ143YkbNWEmAvhWhpfbp7TGl?=
 =?us-ascii?Q?IUwiYMfBoT43Iani3LHd8GXBhWJxtw69iYuuM/DsrcUxmC3PAgG+6fqoPP4Q?=
 =?us-ascii?Q?3xPLG2m5sB3DvIRm1ieCrat/5rBz6hZedMNNR2FTO0I6X5Ywa+yNhyVXmNtq?=
 =?us-ascii?Q?yXvBMenIddlZ9b/7zoYrwTPRv55kvFm9OpZHzbOyHL7at9/3I0jm81fQZ3hQ?=
 =?us-ascii?Q?hFJjX3SLkGE9XkfmLsHpdmrGvFbYJjabsNRSOnlF+3bAUA5D33TdMm9o4IB2?=
 =?us-ascii?Q?HpJ9RBGt9fLhUtpi1iaOStaK2H6kdSRIqCae891P5ev1DbBNca6Ob+hXq+SW?=
 =?us-ascii?Q?XwBWqljU0Jsbwfj9Nneq/FMQAWMG2F9YI3YW/oV+qjB6ZirqQ9KMHQo6Sv7G?=
 =?us-ascii?Q?0frrr3oxTBknWUhPZ5bny+Y56No3R/MhINP+fKXH1OkXNkxkHVzcLmGed0B0?=
 =?us-ascii?Q?nt+Vwx7Peocx+oYgKTnVXDkUr1UMct+4jMD9fQGhxgMxEut9DBDZT7/Fa+BK?=
 =?us-ascii?Q?1Do0nXnNijRcQY2gLUfig7OlzT2YC9CRBA38JiCNu4b5eU3yFmEGEv2zHxcx?=
 =?us-ascii?Q?qr4k8xvaWxjTw4wnmvmupetDUtiNGrXEPBSk6t4HG1LJR4RYg0HNE3x2gRaV?=
 =?us-ascii?Q?lxqcbrSmMtTi4bk3rwzRhZ18IHwz2kxTmMceJ0wn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2492c1e-51f4-4264-74de-08da5817229f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 08:29:21.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0G27U5uxOPxtcL6j5SsTfG5snDBV+H+Au0T4v+tOu7Ln/gfMIT5dIocdzvpWC65HcWtSmRrj0jsFVPFXXAbVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1834
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 10:44 PM
>=20
> The sva iommu_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
>=20
> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA
> domain
>   type. The IOMMU drivers that support SVA should provide the sva
>   domain specific iommu_domain_ops.
> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>   is still used to free an SVA domain.
> - Add helpers to attach an SVA domain to a device and the reverse
>   operation.
>=20
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
>=20
> The iommu_attach/detach_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc.

I'd split this into two patches. One for adding iommu_attach/
detach_device_pasid() and set/block_dev_pasid ops, and the
other for adding SVA.

>  struct iommu_domain {
>  	unsigned type;
>  	const struct iommu_domain_ops *ops;
>  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> -	iommu_fault_handler_t handler;
> -	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	union {
> +		struct {	/* IOMMU_DOMAIN_DMA */
> +			iommu_fault_handler_t handler;
> +			void *handler_token;
> +		};

why is it DMA domain specific? What about unmanaged=20
domain? Unrecoverable fault can happen on any type
including SVA. Hence I think above should be domain type
agnostic.

> +		struct {	/* IOMMU_DOMAIN_SVA */
> +			struct mm_struct *mm;
> +		};
> +	};
>  };
>=20



> +
> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
> +					    struct mm_struct *mm)
> +{
> +	const struct iommu_ops *ops =3D dev_iommu_ops(dev);
> +	struct iommu_domain *domain;
> +
> +	domain =3D ops->domain_alloc(IOMMU_DOMAIN_SVA);
> +	if (!domain)
> +		return NULL;
> +
> +	domain->type =3D IOMMU_DOMAIN_SVA;

It's a bit weird that the type has been specified when calling
ops->domain_alloc while it still leaves to the caller to set the
type. But this is not caused by this series. could be cleaned
up separately.

> +
> +	mutex_lock(&group->mutex);
> +	curr =3D xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
> GFP_KERNEL);
> +	if (curr)
> +		goto out_unlock;

Need check xa_is_err(old).
