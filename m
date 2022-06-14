Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77254AA09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352947AbiFNHHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiFNHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:07:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339123AA71
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655190436; x=1686726436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hSECckKKUHc910DJ6dc4Sb5bQkT1v1jHl61YvZK+UtY=;
  b=NAeiXBJX6p45qjbXIg0drwjwKhIJ/GnXWDgtfbg9l4+b3V0nRJFFhfWM
   IDrwTUJr6CpgX4CQvSlC55Kq4q4+PU8jnKHWazwqzeD19RzsjoKUPT1rk
   3q+hi9DeIUOXIDnLCJZ90dSzxEQKFHvpLObHL/VZFjngnGtX4skRWpFeW
   1m6pYtSC/76NAO8381X7vjuDj9LKqWcV2u4yipG7FqNRDjHAKEcW+xJU0
   klD4fSnNvvp9r394GkaqsL762dEUPxd1pZUuAa6rYMFRMnNDN5lyFBuDP
   j9k3m2ZOvOvEu3z2iGDelYKI/n+AXr051ITvDDv7sBj+SrClb1WYQqqZJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276067810"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="276067810"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910830697"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2022 00:07:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 00:07:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 00:07:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 00:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeXH+uOGiGIt210wBXOA/aeZ69XKRaAtbg8rY2IcfunXtfbMJy9CeVL2/5YyiWkzswi+0XBKZui0Bho9KNFPKwVknQxzML/nHNtD8jhlgxH4YZbEAh4zFasRinNGg0ByY5XOOn3M4VzJSncsYTLFabiSODBnxQNWfLBguva2W2lQdVTd0lUxVcyJ+jfIBuTawfh+a4L6V3FvImPT3Zq2YlVKCsm5/fVJ/BoPX8EUXX23UdgdhejXY49/u11Frd+JmoZNVW4yuUx70cJOrrDH/jUDFcOLlh71bLw/A8bovYDM63yKdBZaQGSZtYLmUzRaCxZ7H0VQ+bwF086R/ntBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDJvO+jWBO+q7HCtI4o2ZEwS+vV9E8GkHusvz8LE00g=;
 b=bKu4naJ5U8MqmcQbXK6GFPFdqJkPxY4ivPDFWtrJNTui4bw7zQWA33XZnQJ33UkJm9t/4vrmxtZlJl2US0yVvjmY007Tx5h0FRz2uo6D3SZ9kHsHbx7t3H2XJOCxGMJbWAHqAsqZnKS5s3GIT1LkxgK6opE+zdvJaIboqpho96CzkwzdN8UojTbwooPziTGcLcw5nYA0GtIC+VXpjNorK7yuvzNReM3KepMYyySkVbd/8ghxb9GSjB9/Y2Hw2SUl9fae8AyZNgXKAioFiCfXE9oh32u2lMbMzim/9BynBsSM0nz4IGQuT6EPycjyvEdIICnLNycQtDAl+1K7N6XW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2796.namprd11.prod.outlook.com (2603:10b6:5:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 07:07:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:07:12 +0000
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
Subject: RE: [PATCH v2 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info()
 into its caller
Thread-Topic: [PATCH v2 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info()
 into its caller
Thread-Index: AQHYf5pQVVvZSiKiRku2lLBcXn/g861OeYJA
Date:   Tue, 14 Jun 2022 07:07:12 +0000
Message-ID: <BN9PR11MB527646793F6DFD18145A455D8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-11-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fc49196-f415-4db7-5e5c-08da4dd4817e
x-ms-traffictypediagnostic: DM6PR11MB2796:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB279647DAA707AA2649E59B178CAA9@DM6PR11MB2796.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLqKr4+8zsshfxg1/U2Oi5N2NBcEy7QSg4UGuIa7ke579bWkWxDtnlaYG3cVrTjLW8/OXxrOxkk+4p8wmwzDkK78rmz+fKrgovti1S2UrIfUlmYYKgv8fJpg7TQUFQiPHXHVvci5DXStw/Bl/RTgqspyye2pF8+5B1ZvdGAtUmp+ft/DxfjvIJRxcal4thYVuz+dyQppgP04aXVzjDPKqEOU4m+6tndhLycuf6668HikzAWOoYO+4RNGllIP7hTyfZeqQyLuSvA1tvrTZH7+eWH4mvm9Jo7a79MD7IZyGw/c04b3nKrX06sGSwDDMvmTot6kwKq0FHCoO3khfFDcrP8hWatIxWbCFzkrHNd0iSvaIqbZre5VZKo7SYCk0+nUej6mvcRJ754gNhLfLoDEpJRvlH6meehAcXQu4W2EJDyLo+Fx9/gV6ZERAYA7D4Zg42wNFioiiR4MOn6Pb6xGZh/QO8ozt9v0H0npcQ1/JH6LcEynqF3951NwyJHZVYcoKc+5hhzYPmKDCr9faUWCjErc7Y65YaETdTXNbMTEy77JQAbQvXwWhjwRRddrFJyLPgZg4rTYTlzuuMTghb/xk8DA3C9fNMkxq96CQ/1xA0bsgq70UCFHkmzSq+z1TscsAb4RWry8rYceJof76rjBlHn6XFzVVMq7BC5iaE8SgBJ51XLHXeWImPsXkz3R5RI+SXlKbNeWzgz+1nCCscJ7YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4326008)(5660300002)(8676002)(316002)(66476007)(66446008)(66556008)(33656002)(76116006)(66946007)(64756008)(83380400001)(52536014)(8936002)(54906003)(110136005)(71200400001)(2906002)(55016003)(508600001)(38070700005)(122000001)(9686003)(26005)(7696005)(6506007)(86362001)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tJyx5rqfnmuQ/HiwRTQRwTTNux32ggQPMBkAPr2b7mlI6A5dZLZsWgkYMzV7?=
 =?us-ascii?Q?kKRDYZH93UvSu5i7FtTjNINZkq3CqiS6Dg9gpy90wtQS+pCASOYbmOnE+Igv?=
 =?us-ascii?Q?8bXefnFaRM1cNg+MLoubxkqHUZiE8LD2Pwq+xYqIcTngV9+vGmSYeXXCxNLy?=
 =?us-ascii?Q?CflqigNyzcH65nTnN1vK0X4RdacB9u5JHhLDKQVEqt6C9Ir299lihplAgatQ?=
 =?us-ascii?Q?ShPQjmd2eQx4EiMi2xDkvTD93d9Cpt03+9c/f+28GM04GoFj9bWCW86Y56YO?=
 =?us-ascii?Q?8021kTNE/ugv42enW4ihoAKwXytn04XfMDijhP8TICRxXIvDnw3mSzfk1gp1?=
 =?us-ascii?Q?TeJOueCMs7G8H+tzfuzgSrM0F0yAO+QGk7vlXz0zbMPvs1nnagQ2ANc6ewIQ?=
 =?us-ascii?Q?H8Jq5dFvqRjrbIf3UrEvNCNJpNCV9DouHSGAbNysNEyb+GjJ+yIP0lVsxRNE?=
 =?us-ascii?Q?RaFl7ObCAuJ2Dq1O1ZB3ta8xXw4s9s47Sct7yf6/zK+gvSVJkdM4fDzNZCM2?=
 =?us-ascii?Q?bCk2Ky6zR6ipPTsAnk+dtAR08D3A2jIVmM+Iuw4UHhbSGhoo+ZODEQ+QA1wZ?=
 =?us-ascii?Q?ipxA3xBtBu0Sts17hHx388RS3FFk/u20eDrhm4bWBltvt7ovBOed271VkMnl?=
 =?us-ascii?Q?ojNFgbOu/GqKEWLLGgRkoW6csp/gfFScQkQb9WbN/qbSQS+1Hs6wqiuvrQn6?=
 =?us-ascii?Q?BgmJahK7p9O43B0ZL7X7lQMoRlLKIS3CufONgP00WQTdWou+Bwfgw3lM85OJ?=
 =?us-ascii?Q?lzykQLFoj4wwkko3x1bgIiL+vkectFp3n+X1p27x/SKHPgBpwbXEa2Gh3emH?=
 =?us-ascii?Q?4pcLvA2ONqa6tgcL0c3RYoUSh+LGpo1u/pBFpTWYfz7jkXi9q0PRy/DbznJD?=
 =?us-ascii?Q?e3NENcGZdAaJ7OOhkYNPokxl5orjmTXo1BEIkbsN8J/h5m+DU0zBsRDreC8M?=
 =?us-ascii?Q?sgneKfz2VFWcoaDL1N66Kzoo3JvcPrJ/2YiP+Vmo47UWNmO2Vzp0I26rEcuM?=
 =?us-ascii?Q?6ruEzFnSDj887Xt2XPGkUmFocHxW+nvVWAtTKTQUqrwo3/XknfZO3XGMZy/L?=
 =?us-ascii?Q?C96PCKuqrBdy82k48QLUczRNgnwC3y5lI/AKPPN0JVrpIwIdpsR86Vft3tD/?=
 =?us-ascii?Q?6mTvrxH4nRsIclpRRUpeGq60Oc5W/+Jw3Ul+Gak3aYr37nrzSJ2Fbzt+C8/F?=
 =?us-ascii?Q?8yPt+42wsndUwo6wXyjmZ9KLNbpc0aRkwbEVdYOBnumw9WtfBzuKXxJLynJx?=
 =?us-ascii?Q?hRy4uphGeG9/dkURVAgivgt+Q86sLi5TtooCnKmTd3XaA1V9fitjzU8K1q19?=
 =?us-ascii?Q?R5llw/JLVV6/OyeNI3sAPebLHA0jQNJ5z0LthiM9PkIupBxs+SXLrhpw6oBp?=
 =?us-ascii?Q?CZf+kOWTJqNcyHuDMquw4jtzeCcPN44MIBUeljwZjLpH3UUk/Rpl9eK3MmkM?=
 =?us-ascii?Q?nIpgEUF98mWmrX1eqHthy05uAk3SSSbh+Bg7RjWD7bB7MZZoFTLEr6uyi9IZ?=
 =?us-ascii?Q?gx1JMkhfpx3Lj0hAiJShhJusKPsPjEZVQXYlIQJJ/RTI+hM30Yin0AWiutAu?=
 =?us-ascii?Q?CokqDCEQdY4LnzasX9qwkQwFUnPg0vFly17d5FLlFv5ZjARMOgmcBY66sxUm?=
 =?us-ascii?Q?zZGeagvwAf/bLFD/HxQ3TEJvUDiCK8UrrrcFnfUCHuBpNxtReP8v4cBx2UwW?=
 =?us-ascii?Q?/HuUwmRyiNxKJc8LAYYAi+glj4BBlezK2VpBQ0Xd4Q12+4ejne6RXDor7XhZ?=
 =?us-ascii?Q?Fzdy3tl92w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc49196-f415-4db7-5e5c-08da4dd4817e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:07:12.6982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3McZCUi/7TXKBdrZmLQZsrPEA0glUqgMmcNToY4LcWtKo/QsHCCdVmTYHHJqDRH5hE/fD2BbWehSpyWumz/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2796
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 10:52 AM
>=20
> Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info()
> which
> is its only caller. Make the spin lock critical range only cover the
> device list change code and remove some unnecessary checks.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index af22690f44c8..8345e0c0824c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
>  static int g_num_of_iommus;
>=20
>  static void dmar_remove_one_dev_info(struct device *dev);
> -static void __dmar_remove_one_dev_info(struct device_domain_info *info);
>=20
>  int dmar_disabled =3D !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
>  int intel_iommu_sm =3D
> IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
> @@ -4141,20 +4140,14 @@ static void domain_context_clear(struct
> device_domain_info *info)
>  			       &domain_context_clear_one_cb, info);
>  }
>=20
> -static void __dmar_remove_one_dev_info(struct device_domain_info *info)
> +static void dmar_remove_one_dev_info(struct device *dev)
>  {
> -	struct dmar_domain *domain;
> -	struct intel_iommu *iommu;
> -
> -	assert_spin_locked(&device_domain_lock);
> -
> -	if (WARN_ON(!info))
> -		return;
> -
> -	iommu =3D info->iommu;
> -	domain =3D info->domain;
> +	struct device_domain_info *info =3D dev_iommu_priv_get(dev);
> +	struct dmar_domain *domain =3D info->domain;

this local variable is not required as there is just one reference
to info->domain.

btw I didn't see info->domain is cleared in this path. Is it correct?

> +	struct intel_iommu *iommu =3D info->iommu;
> +	unsigned long flags;
>=20
> -	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
> +	if (!dev_is_real_dma_subdevice(info->dev)) {
>  		if (dev_is_pci(info->dev) && sm_supported(iommu))
>  			intel_pasid_tear_down_entry(iommu, info->dev,
>  					PASID_RID2PASID, false);
> @@ -4164,20 +4157,11 @@ static void
> __dmar_remove_one_dev_info(struct device_domain_info *info)
>  		intel_pasid_free_table(info->dev);
>  	}
>=20
> -	list_del(&info->link);
> -	domain_detach_iommu(domain, iommu);
> -}
> -
> -static void dmar_remove_one_dev_info(struct device *dev)
> -{
> -	struct device_domain_info *info;
> -	unsigned long flags;
> -
>  	spin_lock_irqsave(&device_domain_lock, flags);
> -	info =3D dev_iommu_priv_get(dev);
> -	if (info)
> -		__dmar_remove_one_dev_info(info);
> +	list_del(&info->link);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	domain_detach_iommu(domain, iommu);
>  }
>=20
>  static int md_domain_init(struct dmar_domain *domain, int guest_width)
> --
> 2.25.1

