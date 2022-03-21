Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE004E2103
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbiCUHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiCUHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:15:17 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BBFD3F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647846833; x=1679382833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=moXlstjs9xNdEiv8Wk3b2/rbrByV3Mk5WsTAkmLy0fA=;
  b=O20j+5y8VJiApeP2nXVaINyn8O/AogLLe0Q3Ay4xEXpa/QHM31dipehm
   sW0DVE7CO7d0Q2FO+R3pSpcbJp9681kW1zzcEBHTv6wBPTRH5WzQsjrwC
   YrLceQXmjX6xMXWwCfJYVfVDyc9HqBPR9r2YTAqB+nyqYt/YWF3YVt4Xr
   MbSSF+/8TR4SIcSIkKXnG504j6vhYCeqsMVmBgvkoZzzl+0t2Srf+Movf
   YByqQi/wXH86L3JmBFBviOZf3jNOd4FsMYMGdppbgYhh/fG9huGRGM4+w
   Nb5H03dF81jY9uaR8cb4MmjgXgNoFgt40wxPTcsAAdPkNAdKi4c80o+jL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="318196260"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="318196260"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 00:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="648459250"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 00:13:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 00:13:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 00:13:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 00:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1GT7OwQps+A1PbD8SmzluLY8FhH/QNOAhnr61uDG7dWDN0wIgCgv9FbCwnVc/ovKbhGS+JNa5Xna3VzJsAhrHygpUCRv71lHGGWbJcjYI95HLXeOcBM0qN9Uxb5COea6lGKnlvWsVVrrKL5hdhivzmJs3klGLSvL6xbsinAODDIyySoNClg3Dh9qfyQbEET4QLBtULXhh82lUl2mhTYt++OF8Wu3xosik1N83PBmw8Yj1KBQBXsmP7H2BDYCezunA4w56El/cvzfTt0ami6PMHi5sUiU0W96dEhXCDW5DsexLROGYXElzT0CiKwCs+BAcfy1zxsXb3Htn5pC+1QZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jVDKBfUAQF/+O5M5kW3/675bn2MX8jeiZa+re59rW0=;
 b=nXUjnxN4T9b3OPkUdSjIrLP6CHCyzePxBRj7JZO6BwlxQfZyviROVVq0+1BcS94k9UaMmP/7fPA+ozf5//ygy9kf+GObXW12tku05IN6g3VhGHOJTtqwRVOU/cy0MMpYyoovSeSH6Ys4vwj950+IcaQdc/36vR02jjc5ou1QaQ+memZ89qIppKDldUUIt3tl6slTXzddMvpVXxuzWKjuFRhBJJ2zXh+h5W064tUIhhSwG2imO0ZFDDfhDMX2H935oNf7SKB1/sPZJb4HP0/ys/XzbTn8aZns46Fktxn96drKCTWqkTsbKUBMLkCZv0YxJUARaYrPXiN+1XYppKrs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MN2PR11MB4301.namprd11.prod.outlook.com (2603:10b6:208:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 07:13:50 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:13:50 +0000
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
Subject: RE: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Thread-Topic: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Thread-Index: AQHYPCW7d2E43YIEHEyGJAzZ/yk3nazJbPwA
Date:   Mon, 21 Mar 2022 07:13:49 +0000
Message-ID: <BL1PR11MB527174765D1253AB4B88D2AD8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89cda9cc-76e0-4ff7-e4e7-08da0b0a5937
x-ms-traffictypediagnostic: MN2PR11MB4301:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4301163186C227D6394110138C169@MN2PR11MB4301.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwqLhjbFH9Km9OAS7zaPi3sFhdfyb5M0ithfnOrW4sZBsZ7i0eY550n8LISnRxNVpxEdzbIh/i+XgjJRTwbf0AH9Bi/fRifTINm4yCIaOicTpeWD/Cj2n003VkfynoG3wtZpE2GikA+FLklbHawpMh8241r/NwSl2s4NCHqvGyOp8QziNNbyMoMU1YH9iTvy6lvO/TZ3HVKCpUga1swfIwuumZKgTfLVFWMiUV/EpxSKvsBpu1MgwkdYzrN8dFu+nL2Foep+sySrXTYdh4rnezOzqOmO9kX7zuTtnXdCIaSx4L8VxNkVhbta42Cmcvci/XDtJBuUKDA3QOql7kv8B2wfu2xy67hoz2EVJdPz3C/7Gv8bdyzvvIktbSPI52oYBC4GzCLhRkhkdBeVyicHOQZLWGLTUHNZ/q8qoq0IgUmhTwlGFBXpbe7kuS/zgyVEVSrBobrSk0z3FmRzUJ+Z4dToy1kaURbduLr4naPxMTjZT9eKuQuTWvBRDKayq3LeoEOZXCjfB6/bKjAaymLYJFVNkueSggVZrvbmnOmEaTnPTcZXGXYpbkJTDFTmO97+x3BDxdoO3j4hGWaDbAFhUd6ExBVQVH/9mh0Bnk8EPdisu02h9zy46i1gmD5VjsCyBwdI/CQQj0LvnRYfehKb36um9Xa7RwphmqhFo6JBNtVSBHKtNYU7L09742krSkOC2Lqx6jqLBOup0zvsjKkKAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(110136005)(508600001)(54906003)(7416002)(38070700005)(5660300002)(55016003)(316002)(86362001)(66946007)(71200400001)(64756008)(76116006)(8676002)(66556008)(4326008)(66446008)(66476007)(6506007)(82960400001)(7696005)(122000001)(9686003)(33656002)(2906002)(38100700002)(83380400001)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RBBzH0RJ0aq7xs/m4Zt4YDb9NEDL2yFjC6Cqi+IZPijREkhEzhVzG0uSyEl?=
 =?us-ascii?Q?huqKhULRGjWt3EetjAQRWA5G8ekbkijO12sipMKyCtbNZyPMG7Zm/dnv4I2r?=
 =?us-ascii?Q?HJChImTMDT0ATj62nPo5M/nZUV2RKMakmPWz5CCQaK73IqJpYTr0WIvm5V53?=
 =?us-ascii?Q?RsqKFJFIIwiztQ5Z6E1sJ3EAuI5KjuaoB2kYuHw0lR2ApPgF6F2syr/67YK7?=
 =?us-ascii?Q?N8H+HxUTrV64kLLdp9Xso2vgVpKWouVh9qX08cCs3qUzdhwUaFXf78Om8iqM?=
 =?us-ascii?Q?dmEWiPtpCKYNPFerIwhCyRC43R9lsQfi6GxvDcvBJlw/ov6/oLSs3XmmuZB+?=
 =?us-ascii?Q?8TskwJMcZOPjUS233YiH82WuAOTSYNE5BSym/UYbyNpnwWJyKn3PyU3odVEa?=
 =?us-ascii?Q?V1gZGZcNuY7n7kkMahqfUVEUTGGcpW2wPx48Kj9c5MvlYFI8hX+VKHgW4C2E?=
 =?us-ascii?Q?jjk6wHyHHvncAZ3mYk80pLPpcGHQUwEJaPDTgE7OWo8DsNxKPd4EvV+wgip2?=
 =?us-ascii?Q?zDOnpqrKwWrzT7hIDxK5ga49WhxKnoZkklEadeTWaZyQ5E4vADYEt+IUMID3?=
 =?us-ascii?Q?mlMeTW6tKZW5eoB51bWBi6QuSyIaLAksg6PvQnh6BPNwXlvwXPNexONxwUXK?=
 =?us-ascii?Q?pk6FKUwADdr3Uw7uujrfZXBXHYVWE2BboK/SThDLnDx2EaFrXFyrh3A1cKre?=
 =?us-ascii?Q?AUyOKbPflFvH/8DIGDyk+RDvD50MwniOk5NR16elhNQbvfFWb+LTpUcaku+P?=
 =?us-ascii?Q?MRb2kiHvdox4bmkOuJn60cftOlAm8V/xFcAZ2d9cKVFqClZmHPm1Md0mNnto?=
 =?us-ascii?Q?LAMTCAQagCwE0j21Dn/f3+siXarco9SiaeuTPU0I1Jkq1tBiGbrInVZBwb9n?=
 =?us-ascii?Q?qJuhJojAxi59nGRNtZVfRYlT8M324XExZfZRIrQDbJxvDU5O1mG7hOnVZOPG?=
 =?us-ascii?Q?8ATh5quGeS607jO0noZuh9VQCRRS03ubaI/fCw7dmCF8yAZLgtY9J0wfHIKu?=
 =?us-ascii?Q?Lw02F+TcZhKECnGcmLXwVKC+uq8VDb4ekiAEX6c9l4gOFADhi7iu4pcAOptz?=
 =?us-ascii?Q?MIiuyoBH/oZCM+KvoqLIPtRVoUMDhRyHB2cpNKDmKEEvuHin4eAKp86Mnez2?=
 =?us-ascii?Q?ReY+3y1waY5lxpPyPv1N+iRyzDX6PmlBdEkVcBqsuo00a6e+TkHa3BEKG4vF?=
 =?us-ascii?Q?VzHYAga/NqA05xWrTbhZDUaCmkFD78P7j9Hk7L7imQfsrOZ/LPhVCwjVIQRT?=
 =?us-ascii?Q?dh66dsruM9Rc+cDNiFQnxxRO0YY5PS8C7wG6211k8QeGQHVdguK/A61OKHvc?=
 =?us-ascii?Q?+rFani7IGU25nNnvGjuvB4tSJPIGLOM+3e9mKadTt977s5g3qUFa+DQlqWuk?=
 =?us-ascii?Q?3mvWTJSeoOcn8W3kSnI1v7at44z2o2VMwSBnkwMpzQk8MPPEMMpdAMz5NXTT?=
 =?us-ascii?Q?cqmFerThAtEBtU3Dj7f/tUv6Fh59TTpD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cda9cc-76e0-4ff7-e4e7-08da0b0a5937
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:13:49.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n4Thv/grL7Pqd6eD0yuiiLJCBDTDjZy7zhaqCJYbvPk2QnZLzvsPXcee4yiJ/PGDKGkrjVlJxIVUfu6bQE7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, March 20, 2022 2:40 PM
>=20
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
>=20
>  - SVA
>  - kernel DMA with PASID
>  - hardware-assist mediated device
>=20
> This adds a pair of common domain ops for this purpose and implements a
> couple of wrapper helpers for in-kernel usage.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 22 ++++++++++++++++++++++
>  drivers/iommu/iommu.c | 41
> +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3e179b853380..e51845b9a146 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -268,6 +268,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size
> to
>   *             an iommu domain.
> @@ -285,6 +287,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device
> *dev);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);
>=20
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -678,6 +684,11 @@ int iommu_group_claim_dma_owner(struct
> iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>=20
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid);
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid);
> +
>  #else /* CONFIG_IOMMU_API */
>=20
>  struct iommu_ops {};
> @@ -1046,6 +1057,17 @@ static inline bool
> iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline int iommu_attach_device_pasid(struct iommu_domain
> *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_detach_device_pasid(struct iommu_domain
> *domain,
> +					     struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>=20
>  /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece25854..78c71ee15f36 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3167,3 +3167,44 @@ bool iommu_group_dma_owner_claimed(struct
> iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret =3D -EINVAL;
> +
> +	if (!domain->ops->attach_dev_pasid)
> +		return -EINVAL;
> +
> +	group =3D iommu_group_get(dev);
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	if (iommu_group_device_count(group) !=3D 1)
> +		goto out_unlock;

Need move the reason of above limitation from iommu_sva_bind_device()
to here:

	/*
	 * To keep things simple, SVA currently doesn't support IOMMU groups
	 * with more than one device. Existing SVA-capable systems are not
	 * affected by the problems that required IOMMU groups (lack of ACS
	 * isolation, device ID aliasing and other hardware issues).
	 */
	if (iommu_group_device_count(group) !=3D 1)
		goto out_unlock;

btw I didn't see any safeguard on above assumption in device hotplug path
to a group which already has SVA enabled...

> +
> +	ret =3D domain->ops->attach_dev_pasid(domain, dev, pasid);
> +
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +
> +	group =3D iommu_group_get(dev);
> +	if (WARN_ON(!group))
> +		return;
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->detach_dev_pasid(domain, dev, pasid);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +}
> --
> 2.25.1

