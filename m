Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD244DD49B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 07:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiCRGML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 02:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiCRGMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 02:12:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616E2856B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647583850; x=1679119850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQYnw3QPKrekzTnbV8JV+eIFkWwcudQN6AKvzmsEri8=;
  b=aQ1hFenbOrH5YF84opDo1vZ/4AxOIDRCBzcsGLjAq39I4QhNgqHuFxIp
   h/UXcu/mi9GL6LI/tUmFc20BmaLOwvK5oxgMaVa79XnSZZ0CcAogXKzo7
   YS1RDcH6f6c5X2h+jCdp7/abMFZIoIm++5ygINrzhkWl/8YZ1IlS+SdsL
   4s39OmEePJvWxLBXI2Mi5Pe0WqX0OETwwd1rBeEM2sylFXF8Tpk1Z89Wr
   JYdR2GQp0kw17eYN2iSXsV7oYE+fngaU2lcKjzWYwY3I165tnJ5x9dgjl
   XDQyu4wGfUVEaIEB+QGmH4zc+mJu6WnAhS19DGN8R5PXU/CY5YlhlRVuH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255888181"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="255888181"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 23:10:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="517062545"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2022 23:10:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:10:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 23:10:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 23:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+rJgdqQJoEE3B/yioNu0Ov5XQAqNLavvWmIUOYUf9SjKf5F8zkrqPQdmQNPuQlW5CKfDc85Oa5fEB9RTW4np3qZZhheCkEyzcOGjABzuXvdJ5S+poJwuepGoexRFiKjKBDggWegO6dBv1D3Z/PWgNPxf0y6YR+TeRh1s+kFfN+G8neDk/Ux4dHuZA6UT6T7qD1bS7ZX8WVI7E4qs734dJzy2srHZgXvNY7eDbKNQJ8aJHDmPM9CLhaDT1tk8cjGxZgvNZITC05kdQ4WFxPyF2mhrBny8j+w+AUIrHHFkPxkeZW4ghpDgCguSsYoajXZGhGn6+kWdzWdAervtRzuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOTjK78p5xdZwV0X7SFuQlpntPJNCAgDzadR2L2q5a8=;
 b=ZLjHg5iBAC9jQ+mgW2D92c9wToYmPchx4y0tt0MJHbo1mqLDadJXJcmzsFVm/Vi75nkFCHD5hq4nJBEghyy+gXGs9T54rLgdZlNbK0Ln505lCUPhCfnzrKvzXzL/ZmCPKU9AbOMc2VtthX7VPnUdwd7GNomKYb314XWIhNyDxCgzmiPNbz/5ENJWB0dyroJdJ9OOXqmIb5mDE6Ud5VRUP330WHmy1euZUUHrhKVcOajSBrHwcK8eVgxQU8hFA0SGVBs78CgpX20augy2g5vyeNVCnIbFR6lInQsTBpoOhh9Y1YquviuRlUqs3H6U8dJ7AcTo1AMoExTzqS73qxyNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4232.namprd11.prod.outlook.com (2603:10b6:610:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 06:10:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:10:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 6/8] dmaengine: idxd: Use DMA API for in-kernel DMA
 with PASID
Thread-Topic: [PATCH v2 6/8] dmaengine: idxd: Use DMA API for in-kernel DMA
 with PASID
Thread-Index: AQHYOCob82fGSil2V0SrGJx+WbIm9KzErLXA
Date:   Fri, 18 Mar 2022 06:10:40 +0000
Message-ID: <BN9PR11MB527625B7AD0FBC1BCEB5D2768C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-7-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-7-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90ef1c55-e620-4981-f238-08da08a60776
x-ms-traffictypediagnostic: CH2PR11MB4232:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CH2PR11MB42322563F7130276BC535D8C8C139@CH2PR11MB4232.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJjeJMkXLQtGfjmGOfC7TdZ0ITAOSpxSeXpeOa8dphNF/Wq0ppu3OIjdqNcPyqPTmtXomltFYDJ6Pab8La4YjUm5K0/XwVEoXhO9sOfhPPw9ZIdOTzqIV4+XaCM+xn+qpZDglRtopIEKS0kO8PzFGMjthY2VQ3ZKS63xE+0sI7NVrnjq+BOSIsNrkcIBuScIHDi8+1Vv2EYK6JaDRzoHwFM3nMUDsTc8d+W71PCOCwsiutZiQ8PU7jJBqqwy0hLAPWRe0nf+aBgMnU1ZOXyk3jHy+BDkCQSwSbpMqPly9ZFB0yl2X3piO4V837MPlFFFMdr3IqveMxX3LCZK3Do0e/bdWcky1zZOxpJkpmdpOrxh7RVv8Y09odZIzhgedGGku7mcs7SAe7ulO0R47AkEiquYhbakDsmT3msMVnwf0Z64njiHAvrjCZ3x4sONi9VHX2znhFTni5tkrRmCssqlThKb3cqr4URAzHW98IIzNrYfich2Bd1SBs6DLoy/eXMQNRoi1IblXv7fuB+aJuOEFpneT+e4QgcTGwxEQZJfk0eEsEBBwW/+ZLp93bHM/hb3qUH5N8yPSlg8KQWFSLeNJF6HYE0qZo+6jia2ScrvyccNQOJIrjtejckfhHQTBZI2mgkbRNcFkuQ4JInVKlmNiR61KGsF4pUn7jgf46RwsUQrm79njmojY/xSpQ65ZcjWfVta8gjdFXjw8/IKjwMqUJMDZ6gIKeMWQwDAy2n7PLbjWhFUQT1Cfk3RdSumaSFpamBD78IUg70x2bNlK9msQU3sHsQjgjBOPINVFUGyFK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(26005)(71200400001)(186003)(508600001)(966005)(6506007)(9686003)(7696005)(38100700002)(122000001)(38070700005)(83380400001)(82960400001)(2906002)(110136005)(54906003)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(4326008)(55016003)(5660300002)(316002)(52536014)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uuNJJNw5cbCuIjmrzZYhW11LXfHkevKR8iDDa9zEWiGPt8HlxTV1j8X3QWYF?=
 =?us-ascii?Q?HE6k8reXfYuGY7fRGeMsh6Ot/ussOpQB75S4+uJRQTXMCWVeaI7qidfSX6Xz?=
 =?us-ascii?Q?8TSOovFeic/6NMT7887juTQCVkaMrrB6VEmcDxR4FSDY4CsRgn8sA1eaUD77?=
 =?us-ascii?Q?eExK5x9yjAdxRteGBgXjeJp0PhUgJOVzs5bMNkzRJC0WvYYKt18TT9ljItiR?=
 =?us-ascii?Q?9CTkMDhihBkXykdDoMMTzcwu68CG9PaRhKbpaU9wcBmSmwt6gUhTPhktXIZ1?=
 =?us-ascii?Q?bmPMkB2qWp37/b+26+te7kKpwGwYrwCdtPUnWwDkIbdfm0g1UmdxXWlkg6iI?=
 =?us-ascii?Q?S3H0trTTL8PtJFvsoQeXApSy7sRw+NqHTIKSNP3AJZzJkSBQdKocQeRmF9oM?=
 =?us-ascii?Q?GKOyG5Pmd5srYs6JloIBsboroMVGbGg9e6ytI8o6MjPte5AGrM5vbYqVhmiG?=
 =?us-ascii?Q?jb/qedJkfX+3QuoGu/GXKhvPLet07d37fjJ3hUCp5/NEkgi327EMNw6b0s0R?=
 =?us-ascii?Q?hc/5Oxo8SEapnhDcdLKigK4ws78nrrCbmp0D40cMM+S/Br1L9/rDuty2SRL9?=
 =?us-ascii?Q?s8se9FuI+j9/Vp8qs4V1bX33lHwEXOny2A/0FXl0eIc+SRZrjujqVuxe1Y/A?=
 =?us-ascii?Q?9aC+jR2etAm5TJAUl743Yfywx7vOwT2kPcT/0N3GS/RpTo2s1gmYIpSnxA08?=
 =?us-ascii?Q?XrcFwfMUt6/p2/cfguUzYEPQFV6DxNM2+ieCUf6MZCO6dnGgGHnRDaUsdUwB?=
 =?us-ascii?Q?wwWYo75RLuXy4/iTIbYooo1IZbHyvTpQRCNq7sM4rebKBDvCIazV48yLJomA?=
 =?us-ascii?Q?qHevD6u5cTnUOn44H9SFrMzVP+zzQ9t9+EpCVMrrmGKi1b5IWXcZQz5ceNd7?=
 =?us-ascii?Q?4DxqWqVP3x9XnjhoXQojsrF8x+naaegRCVvcaV8oHuaW5/29PuVAas0XWyVV?=
 =?us-ascii?Q?qtMYeI1AWAMdj+zjeU7V8JkoYOiuGLpbHnIudUI96LpI+yslNkNU6kC2/aJg?=
 =?us-ascii?Q?vnB6IVrBjjEpAqk+DQD2A09plICpSpyHw3q7QWTAO6sgSr6zWBXUiLbDMvJ1?=
 =?us-ascii?Q?AluY6JDFJDDeoRE91sygJ4sThnNWrxfZDuKR3PVqpfsNANs65Tw4iJSsqGhu?=
 =?us-ascii?Q?YCIrNHiq775GPacC2ap+nbOmYtMn9iRlvGRtB1PFuhOAA2+PQ0rkcgshqwUS?=
 =?us-ascii?Q?tuvqNnQyX5D1wOvyAPic8wHv+lwgCnvVyEdXtz/k34kBo2eHm1lYPW8HQ5Nn?=
 =?us-ascii?Q?rLwNKIU6L/XUjKM8bxz7XT7pex0BwaGJ1Q4XXk8wiWgqHnqpgzkA/8Ui/oVM?=
 =?us-ascii?Q?l0TRuXzTeo+b3NxzGxkoetsXIOa3Vkp6pcrQHnjarzHJK15b92ZqTqmgJJB3?=
 =?us-ascii?Q?E4JTbEGYdC5StTWmkFJF0PlMr9aSHH7qEnxLkgvUiSt+5Jt25vlhLUVsZ2AS?=
 =?us-ascii?Q?F3LMot63TwZfjFTNzWzV3iwL4rmp6erT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ef1c55-e620-4981-f238-08da08a60776
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:10:40.6676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91TviCcMdrtUK1TFXxAhyvkWyqAe+nkC0Cq7ftGQNEvhlcSEFvfiztd+t/vUf4h5U19kASzfVMrhCJcwegzwMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4232
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
>=20
> The current in-kernel supervisor PASID support is based on the SVM/SVA
> machinery in SVA lib. The binding between a kernel PASID and kernel
> mapping has many flaws. See discussions in the link below.
>=20
> This patch enables in-kernel DMA by switching from SVA lib to the
> standard DMA mapping APIs. Since both DMA requests with and without
> PASIDs are mapped identically, there is no change to how DMA APIs are
> used after the kernel PASID is enabled.
>=20
> Link: https://lore.kernel.org/linux-
> iommu/20210511194726.GP1002214@nvidia.com/
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/dma/idxd/idxd.h  |  1 -
>  drivers/dma/idxd/init.c  | 34 +++++++++-------------------------
>  drivers/dma/idxd/sysfs.c |  7 -------
>  3 files changed, 9 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index da72eb15f610..a09ab4a6e1c1 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -276,7 +276,6 @@ struct idxd_device {
>  	struct idxd_wq **wqs;
>  	struct idxd_engine **engines;
>=20
> -	struct iommu_sva *sva;
>  	unsigned int pasid;
>=20
>  	int num_groups;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 08a5f4310188..5d1f8dd4abf6 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -16,6 +16,7 @@
>  #include <linux/idr.h>
>  #include <linux/intel-svm.h>
>  #include <linux/iommu.h>
> +#include <linux/dma-iommu.h>
>  #include <uapi/linux/idxd.h>
>  #include <linux/dmaengine.h>
>  #include "../dmaengine.h"
> @@ -466,36 +467,22 @@ static struct idxd_device *idxd_alloc(struct pci_de=
v
> *pdev, struct idxd_driver_d
>=20
>  static int idxd_enable_system_pasid(struct idxd_device *idxd)

idxd_enable_pasid_dma() since system pasid is a confusing term now?
Or just remove the idxd specific wrappers and have the caller to call
iommu_enable_pasid_dma() directly given the simple logic here.

>  {
> -	int flags;
> -	unsigned int pasid;
> -	struct iommu_sva *sva;
> +	u32 pasid;
> +	int ret;
>=20
> -	flags =3D SVM_FLAG_SUPERVISOR_MODE;
> -
> -	sva =3D iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> -	if (IS_ERR(sva)) {
> -		dev_warn(&idxd->pdev->dev,
> -			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
> -		return PTR_ERR(sva);
> -	}
> -
> -	pasid =3D iommu_sva_get_pasid(sva);
> -	if (pasid =3D=3D IOMMU_PASID_INVALID) {
> -		iommu_sva_unbind_device(sva);
> -		return -ENODEV;
> +	ret =3D iommu_enable_pasid_dma(&idxd->pdev->dev, &pasid);
> +	if (ret) {
> +		dev_err(&idxd->pdev->dev, "No DMA PASID %d\n", ret);
> +		return ret;
>  	}
> -
> -	idxd->sva =3D sva;
>  	idxd->pasid =3D pasid;
> -	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
> +
>  	return 0;
>  }
>=20
>  static void idxd_disable_system_pasid(struct idxd_device *idxd)
>  {
> -
> -	iommu_sva_unbind_device(idxd->sva);
> -	idxd->sva =3D NULL;
> +	iommu_disable_pasid_dma(&idxd->pdev->dev, idxd->pasid);
>  }
>=20
>  static int idxd_probe(struct idxd_device *idxd)
> @@ -524,10 +511,7 @@ static int idxd_probe(struct idxd_device *idxd)
>  		} else {
>  			dev_warn(dev, "Unable to turn on SVA feature.\n");
>  		}
> -	} else if (!sva) {
> -		dev_warn(dev, "User forced SVA off via module param.\n");

why removing above 2 lines? they are related to a module param thus
not affected by the logic in this series.

>  	}
> -
>  	idxd_read_caps(idxd);
>  	idxd_read_table_offsets(idxd);
>=20
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 7e19ab92b61a..fde6656695ba 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -839,13 +839,6 @@ static ssize_t wq_name_store(struct device *dev,
>  	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) =3D=3D 0)
>  		return -EINVAL;
>=20
> -	/*
> -	 * This is temporarily placed here until we have SVM support for
> -	 * dmaengine.
> -	 */
> -	if (wq->type =3D=3D IDXD_WQT_KERNEL && device_pasid_enabled(wq-
> >idxd))
> -		return -EOPNOTSUPP;
> -
>  	memset(wq->name, 0, WQ_NAME_SIZE + 1);
>  	strncpy(wq->name, buf, WQ_NAME_SIZE);
>  	strreplace(wq->name, '\n', '\0');
> --
> 2.25.1

