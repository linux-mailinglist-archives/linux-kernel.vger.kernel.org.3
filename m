Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71554A9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352809AbiFNGtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352649AbiFNGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9039BA5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189361; x=1686725361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6t35hDNofuhMr6QQT457n5sOiFuQgLzZv8nzroB1M64=;
  b=L2RnyzE/L53uCH46Oi35MZroh1EkSzFj+NCz6FkYyDw6yz7m/Lc18ZK2
   /URLF1NVcf4REaLX1gQl/hv6Ptdx8Sic2B+0Y+R0q6LzAg4HuNb6tlsiR
   B+UsXKbzE/JWDtO5p+fkzx1wpHuAB0oMjzuqNTbd04LOoHIRn5KBPpfcd
   vOCnAQejjcLQ+fbN6FlooDlp+7VU5zv1coJ97VTbX4x6VT+51W5M9vOnC
   auPhf6amU3bi6SAbk47df7+APAxPfZaCI6HOkCQeF+T5ahpXVO8+X3EuN
   qGIesr9nxMahNTefdpjpkAY4lWtIxOsZjonqd8Jou3c+tE5+khCKBYUdp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267214192"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267214192"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910821121"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2022 23:49:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 23:49:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 23:49:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 23:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqAMbRDhlrTXjn9IPSRZYrOJQWuB8rCcXGv+n6N5Qo4h96OcPEDNbSCvA/fKM40FR5NVyQ7qK4eZS0rCxQBMJnEMYzu+MaPz3Hmt8XYcHqr2erPSplL/lqRHSfe23Y/ya9MqxAEh0fTq6EZreXT2NjwqNfGHLX5BkkwYfF+kE4KQjK7dwXit0hBZjaI1GcjuvqTZy6SmdN5FN74zM3DwBEMrtaplBLbeTFuPlD7ur/2nvCjlPO2XVc81GDFUZAsct9mYCM3Y2nvT0SdUIBnF4sOCFCPF+Eh8gtchl9hCli653mxRyqcL60H4dbc6bYI0Ocv1a/8F6wTKoulj9pSuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jxe3k7no8npXuwFQBO8Cwrm5so1ThPp0k00QcZxa/t4=;
 b=MHyG0dGGmHrVhgCyc0wXZt4E0Rhy0ZLneHc9mVHxG/xvyKpv5vzwRt9VJhk5u8MolXsAc6QAA7NZRIhUTRffz+dlqHHaehJU19DMHda8ObX4vvO6Qro/Qy6WgHRHFeDNrPj6WaVRlbX40W/GCuTXgHoUsvTugjbkgxkvnaTw9nAcJUXm5Rx+WpJsSNdPsq9xYan9PUdckkiJwK/7lII3VwFDk76z+n6lKMu02nBDWDYywKloyHyKw7Xh85JGeESFLPHv76rTfM1UyLmMlsKYgOXeNO3Ui/1HNEkzU+P6OOMeEcmQCWCAXxlD+kD418jIA2XjNKqIxfrsmgjuXHEpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 06:49:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 06:49:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYf5pCZKyuaZgwUEG5kY3NWG6Wj61OdPXg
Date:   Tue, 14 Jun 2022 06:49:18 +0000
Message-ID: <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f0a4486-6142-4764-3bc6-08da4dd20131
x-ms-traffictypediagnostic: CO1PR11MB4930:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB4930A6867C209398E9CEAEDD8CAA9@CO1PR11MB4930.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g45V3SOAL9nu1w/jviOm/y5qfGsANHLpzbKung7WM3DF1Q3UjVyjqV2gFD/oQ08r8Ija87qeU+1S2OTrCckfZfzh8OImUzXvx0Ms1lhwnfcSA9s8ijgRE8LZMOIV+ia9vPU3pEeDR9QErZ20qL2GYJ+hihFVCxhs2MwjwDMAaYhLbFdLBDp3SzKmWaeMJEVVhr3C6PMtdY9VJyZZ+8PXw5bLgvtaNdbFianmN9am0nuNyrOpHzS0tM+NyeJFs3FiY+cXvOjRWYJaOtUZx1EHN7eXzUQ0I4TXU9/vd3Ydh5SyIzbGKYIt69y1DaG4M6JSvOVRcBxfnArMCk0G/ZfuGBTu8PbRC1IYwB9lwBFJwNEqblXorrDArSpEY0lbiYZIzXgrlnpm03jZ7QZJR/q1B4SqdfoKmPVYLPOJmifx4nzc7g217vXYYtu2WDdVZQhvDe7WllNBKQM8gFfPkyFKcDH/3macR+LnV6ft3My+dLGuOdVBfOZYXKp8h74g/5kdeFGaAIUBSt0vq2MN2RFcSOSX9OLBJ4X2eXpL0fOG/JprDzEiI0qA7gd/GDszr6y3vCvJFyATACr+XKlA4oy4vjJsrxRlUhj0TGbMDaIqWuNpuUeeZTIWI2LYpDjiNGMeha+RpE4kqHsTLlHtNE7Q4lhQkjfzRBZOva2KlN5dr39zA77d9qsYPfc57DkoQnLphRreJQKzi28eG2Zp3Qr1aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(33656002)(55016003)(38070700005)(110136005)(83380400001)(26005)(2906002)(52536014)(6506007)(8936002)(71200400001)(7696005)(66476007)(4326008)(66946007)(5660300002)(76116006)(66446008)(64756008)(66556008)(8676002)(86362001)(122000001)(38100700002)(316002)(508600001)(54906003)(82960400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hAsAlhEPpYBGj/9uhlpHe9k4jQIgZuSrNd7O9XfMSFvz+LF3s2KLd2+JM0VS?=
 =?us-ascii?Q?GrvF101QJdPkWQX6Gdc6QY4Gx/mAe1Szusen53/UVsT4u2F/ImBWY/+pi8fg?=
 =?us-ascii?Q?F+SVeN5X50OQ+HmNHQPvFfVerBcX3AF604DvSmYv5XzwRQ0jCtXyxX2kPShW?=
 =?us-ascii?Q?xLuahOdezGvNocUNkFPws6kGzjlL77D/8o+YOx1Z83JwTpD79dOzlgHTnMvI?=
 =?us-ascii?Q?rsCi89hyQFer31YWXVTLpi53Yl/U5vPdQLhEzfAZuXnNC82vXe6HaIJli3A6?=
 =?us-ascii?Q?Qd6GVyhyFybQcUkFj2d6R3M+ZlCQHuMto2ogLa70PhSag3VikjkmeCRvJ9du?=
 =?us-ascii?Q?eZHO27FfxubqM1Puy4WkAVniXQnRjRpmZ98VFI/DCiTTi6bZhQd/dlKMR/Xe?=
 =?us-ascii?Q?oQaePhXVdsvPWF6cvzIRK5uog9NNzR0FVOtVuVjIRdeSyXATqjsv7v6pa377?=
 =?us-ascii?Q?4bWKy4hBFjQ0fVLGlz4n1WXXj6DLHHp8gpH+8jyO1C4u5A+i8kZ8yUtjF2nu?=
 =?us-ascii?Q?IyiMcDnI7pSLcViuUIcS9QNFYfn8KxJ9Tquewq/ealiDxWjg9HEBLNReahPR?=
 =?us-ascii?Q?qF7x1PQyM5i+yCiwmTsWXMDDXP1Pzm4hJquJWaTd0DIXuI5mTNW2UbHyDfdm?=
 =?us-ascii?Q?Wag7D3IGAuCejDkfd4+jMXidjlu1yoIAr8MfBne4JpnWZR+uVXy+kjRuAh/O?=
 =?us-ascii?Q?NTxlyqGci6UA30KSX2bWq/9wiQJbLzXAY9G9KBqXBo77fkyIUrm3Jxn3ULjY?=
 =?us-ascii?Q?4po8uKr9TA9ENtSIzkznCntgeTrHyHXzoqw5NWQ2W1luBTKdgg9guTlTzhLQ?=
 =?us-ascii?Q?NAyVRPU0tL41XAcmxz2vdK9W0pleGtXp6AxYGQq+OMPtUvLsqcXN2FZPyZD3?=
 =?us-ascii?Q?HoUgKuUISkjRbh/QvYoPi/256fN6PAGbA7+gLh40WxRmgCV5hmhV4sdozCTG?=
 =?us-ascii?Q?WQdezJ7XC0oSlGnmZ8HeFZvq+RLO5hgtfpxtZBunNWlrT1Xw0VnVNcWRRKmg?=
 =?us-ascii?Q?DSfHawcXfAVo5MjPID2+F0Exxs3RPlruKNlWFmTp6CQY0mO89XKVAeKaBWD8?=
 =?us-ascii?Q?rsqJ5BpEUySG9CnkybuEqVZyKo6tW3L2eVBPBka75FhhkHmgEzy37JO1BBlk?=
 =?us-ascii?Q?cgU/DeReHh+r8USa7oNzpEKukMHa5ktfbTqW9dGyPGksU6lVZkLqPQ+eY8Y0?=
 =?us-ascii?Q?T6ZTdcoVeHeemzM417OxWRxRk6BQXWbtyYnP5CN0Y6ugtCXbdLabE1EDj7fu?=
 =?us-ascii?Q?u/29BbUIQ3LS8hXEr1ZIO9K+gF1QLGkHe5v07oB4OvdlL88sAa9dhcZJTgjX?=
 =?us-ascii?Q?ehif6ITNgOkKQQHkM/bDMSY2wGKKfb1xslOsoEFPwyGxETrQdpSmIK++kEvu?=
 =?us-ascii?Q?PTjDQiWLusWOcDRCXCVFkCbqbitBtH39dtrdwp0/IX28cqBBVaRW6JVjLuqc?=
 =?us-ascii?Q?q9MkIe9JTUkbSrBLl8BkhbPnSNLqpWk40RqaEYplPAo+/TBo+Q16vj5eS2+o?=
 =?us-ascii?Q?BiQZUIc64U4urLR3T5f6PBruG4qEJqk+cVCwdF5RLef28hulxNFk8Hd2JP4i?=
 =?us-ascii?Q?uoHXJODWvTJ4U7rTflv2wIXyytKxqSe7gg6e8e4Zj+gvBEOzPK7154XYJBQh?=
 =?us-ascii?Q?GAOR2HT07q9yDlEaU4d5NOow7GMSK7dmiGbMntHL/lrab6Zyx/FZORU1WM7T?=
 =?us-ascii?Q?32u/i+uNs3ZfsQGYKz/FwE/m31euSmgsToyP3sQaVR5hAwKTMzrJmNHk3nT2?=
 =?us-ascii?Q?Lrx3nhwykA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0a4486-6142-4764-3bc6-08da4dd20131
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 06:49:18.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eAV6ACRd4KoRkf1p3bD8Bqwjli0k0B4xSmuzHcfjHDd6Ah2ehlpNRQTw6t6idhKLBskHl3fT9quUtL6ywyjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 10:51 AM
>=20
> The disable_dmar_iommu() is called when IOMMU initialization fails or
> the IOMMU is hot-removed from the system. In both cases, there is no
> need to clear the IOMMU translation data structures for devices.
>=20
> On the initialization path, the device probing only happens after the
> IOMMU is initialized successfully, hence there're no translation data
> structures.

Out of curiosity. With kexec the IOMMU may contain stale mappings
from the old kernel. Then is it meaningful to disable IOMMU after the
new kernel fails to initialize it properly?

>=20
> On the hot-remove path, there is no real use case where the IOMMU is
> hot-removed, but the devices that it manages are still alive in the
> system. The translation data structures were torn down during device
> release, hence there's no need to repeat it in IOMMU hot-remove path
> either. This removes the unnecessary code and only leaves a check.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h |  1 +
>  drivers/iommu/intel/iommu.c | 21 +++++++--------------
>  2 files changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 583ea67fc783..2afbb2afe8cc 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -39,6 +39,7 @@
>   * only and pass-through transfer modes.
>   */
>  #define FLPT_DEFAULT_DID		1
> +#define NUM_RESERVED_DID		2
>=20
>  /*
>   * The SUPERVISOR_MODE flag indicates a first level translation which
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ff6018f746e0..695aed474e5d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1715,23 +1715,16 @@ static int iommu_init_domains(struct
> intel_iommu *iommu)
>=20
>  static void disable_dmar_iommu(struct intel_iommu *iommu)
>  {
> -	struct device_domain_info *info, *tmp;
> -	unsigned long flags;
> -
>  	if (!iommu->domain_ids)
>  		return;
>=20
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
> -		if (info->iommu !=3D iommu)
> -			continue;
> -
> -		if (!info->dev || !info->domain)
> -			continue;
> -
> -		__dmar_remove_one_dev_info(info);
> -	}
> -	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	/*
> +	 * All iommu domains must have been detached from the devices,
> +	 * hence there should be no domain IDs in use.
> +	 */
> +	if (WARN_ON(bitmap_weight(iommu->domain_ids,
> cap_ndoms(iommu->cap))
> +		    !=3D NUM_RESERVED_DID))
> +		return;
>=20
>  	if (iommu->gcmd & DMA_GCMD_TE)
>  		iommu_disable_translation(iommu);
> --
> 2.25.1

