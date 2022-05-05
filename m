Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1051BAEC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350398AbiEEIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiEEIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:51:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7EE49C99
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651740476; x=1683276476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5A+ur11KfBxAQDXjbB5A1CnLVJHQC+DWD4ufmtURguQ=;
  b=OT9zXGjbK9usxwrGG6Jd1lpaLn3FHNPu7oI86iSzsBvzk6LncM62gvI0
   qppfmCcUG5ujZXFRKnz9QxGPqnZelDtfMy6vlOGPF09AK3M7A4OSug3k9
   8ZFjH8L9ToLUeq1IwlhiTodGYcLlc7R/eF17o4S9Nuf/03TUUohChcrbG
   r8iQOUeKrEoqFQqP7jxwnvw2jcb2MvvgiYmxGHRNTVok1fQuUmY9tuCv1
   UAOo2v6V8xwTozvxHiJwLaLWDnsDyExuc+Ft4ktaLjvIjM2xz+f/iHDDA
   ljcCl3SpTP5gjLgYmpM0Qqt2cfNpDtQisxJz6oDO8UWdrMT3uVdgCkHub
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267642164"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="267642164"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="664876473"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2022 01:46:56 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:46:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 01:46:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 01:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmnzYNcyyS5Hb4YK3wLM42HIcEua0jEsSSzc/mWTXghKj4gH84yi4F80j3Q8ueHs482JLzYmx1IdHqlb4FSLkSo+IVOluzlJrmfyPUH1IWed/o0+XfWGIZxU5FF3ZackQ5wDtqSjEnNOMlpgIB3HB6//xjZ3bDgG46aOW3Mvq54ZU0e+zCM4X8G550nZyviD6yKTaE1evDGDkqQJmzB+cR7Vj/mXqa11vbtiTRliGgsC+nrw9+aUmMewkrTnLSd3g5cYab/VHuMyjeNa052YutkW3dt6FgiIY/sICC5yH2bDIAG/x0DmmMp0+qcNgJt9/RkrPRbIuAlTsOTZPKFVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt+37mKBs24qFx/CyHdOMnNMCRCc4Z5sXV9ePV8o5eg=;
 b=Z4+LfuANbWGkFhHXQYRHbvC8ma83tcI/r4BD0NEwjI+mdKyHsJBxTunF57gLD1vKmH1YCDCS+y4S/75JcCv1LQetDba0Makk0rDRtgFmtVSot8G2qQICs9usYE9h7R6WQBa83CYmxD5YPZWi+oCEkZ9ZD31Dg1jplhKhpS47wuHzthxgYs6E01ZFIAxLdCXT2sQmzVaqxud/r2TOyAv+NfrEd9SlwTzHMgKy9oUDRK2wc3/lTBjUsikHu94cHjxPtP+BFbfMv0OzFIb5UCUXs9sq3YHvcfO6Stp7Uj8PqtYzEMa/T3yUwdXrbv6LsUbadOV1Txq/RnRspa9Az1oczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 08:46:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:46:54 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Thread-Topic: [PATCH v2 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Thread-Index: AQHYYBzrJ4dllj3X3ka0qZkvGHwIqK0P+GJw
Date:   Thu, 5 May 2022 08:46:53 +0000
Message-ID: <BN9PR11MB52764D45B7CBC333D19A6F448CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220505010710.1477739-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156c9c3a-45f2-4988-a93b-08da2e73ce14
x-ms-traffictypediagnostic: SJ0PR11MB5940:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB594050B069E186857AE285908CC29@SJ0PR11MB5940.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfpDYoLrx6B16u9WkHmwkq6z8Fn9ujF1JVw2S6054xFjt34UlPVl5fiTF92+Xb5zqchDjNZiYicuHxxw4rG+SaVpr9Tuw0wStq1KxRF96E31HzxUw5s16CJgPn6z/iauuRfb8qroNpdUyA287GRpcjQVjxaX6SQRsVo3oIvJ9Nhfk8x+rl7GjuMK8KdEUvxYlylpOY7Sol26pjJ4/CNr0YR8JYjyWfaTAUKwBhbi/E1kW/yECP5WsjZSEvlef0qvROj5V5UXyJUxa8nUt8mcss1ynAu1U5Tg4ojA5DBaERfF4Q8/u+yDJmfAl39RqLafvKQ/mYLVqaGsoe3Q2xlCsCaigUw7QkI6r8SrzBKygOH8ArS16dbEJh6Zxu9YldKf/Rnjq7z6U3RhfNaQB+EdOzBs1wJM+YCqQcEDpZlVlt4fhPV4M/buKNC2s9L08ahdXpdMB/OSy9zBJXvM5t+ul/PPxEGS3KCK3yT84opXTXwxq8uiExBQvFBevGFnMlTIW7uG5tfbIPySLoR+Lc+k2Mqh3bgK/zwx4MZsHyZQEuhpFIOOpDpCcXCvRuso+8xMNkCGGFJ8tP00TqIo2+01CG70+VSPS5GSGfjUDdhPmDmXZlPf2EOawMKuy1VBpRBo3oZoJoZlLTjE0v7a767zUv9orkKPS+Gg1H6gTx3Ae7WquA/DhoV+Wqj/0awQBT6UClDYBjD3antD672DB8H4hetq6XKl3BcZD/PHkpPqeLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(316002)(8936002)(26005)(186003)(2906002)(38100700002)(38070700005)(5660300002)(122000001)(82960400001)(110136005)(7696005)(76116006)(64756008)(66476007)(4326008)(8676002)(83380400001)(6506007)(55016003)(66946007)(66446008)(508600001)(66556008)(33656002)(71200400001)(86362001)(54906003)(9686003)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?15mwjw7Fstd6tqcli9OwCKu9zWagws8Zs0XaKsF62wANkcrm7jtflNTU4lt8?=
 =?us-ascii?Q?EMPB3DlV4In7bPtQG6lTWSusL42p1O7D7+ahbOmgn4FcYMDUjzOo/pdW8n/K?=
 =?us-ascii?Q?eTNYSNRiQ7sbn4LB2vs/ap9CFGFZ6Z/h+fOWqogfmSXZhbO3tNII3SbqUJ93?=
 =?us-ascii?Q?bFrRpBngRM5FjIc3e3qf7w+dZUFKg8eIEsVvuGCddtuDNx7nmZ2zqZVUo79G?=
 =?us-ascii?Q?ZEZWG2QIDgVKGevaqptuUQsSVWkPDvTTcQ6F5xl8FmXyeTFpqJKWWmvmCyHi?=
 =?us-ascii?Q?OvX82lmsD4jcrYutbG5bJqjjSkMety1iI961YZTraCTZvep5ZPk6caUmIADI?=
 =?us-ascii?Q?E3NfW4rXh9OaG5EyMXmzQWK5G95jtr1eQugsnyI9LRu+kbFPUH47HbV5uUXB?=
 =?us-ascii?Q?l4+3zkrUHkjytxoIGayfsl7ulixP6DrqRrOb21pc7oFVXAGkNtFlaT8gAVWe?=
 =?us-ascii?Q?sOPlukE3i9bxFJjbWjErKH5WkCn8O0G4Hf+5OVqkFpOi1zuT62yDPqynxZ20?=
 =?us-ascii?Q?otcrxMPOV+ANWh/5finyKtoNTMZN+O0AY1dkWOJNMNtRcQ9MtBdZBuBMCriK?=
 =?us-ascii?Q?O/AVvOxG4sGsw/k2Dp7od3QL/5Mh+YONbSgXpRw4WOB1q0YOZQEG/GnxRZI0?=
 =?us-ascii?Q?+SXl7jkGYmvwAGHXs1QPMLNTpweODEguQNdMUKIOSmB9eufKct+DqhM2TTIS?=
 =?us-ascii?Q?fDtxIu4Xf6it4euqeEZRESgwKtPbsLWl2N85n0+cokv1OogvuVOJeR/Y9zSf?=
 =?us-ascii?Q?D8zye939vnZ5DsLvvYUMrgNgJUZGLH0zE3MmrbyZTNqEqiCTyYqas8NscRNK?=
 =?us-ascii?Q?H60eXnj+dNgQXysXhgc19CeMHTnGj3CF40vic1O6XJi7lfzRZ4YCXYUOeOh1?=
 =?us-ascii?Q?f66LPgdozNuGWVlLxv4mrCNJ+LYyss0DMRt2aAFctauzyqO7eYxq3/rSodfS?=
 =?us-ascii?Q?S3vQgV29CtskVkBzo7Kg46lLeY1S04FT42dvbR3xyShOCr0mYeQhLF2coOwy?=
 =?us-ascii?Q?uD4cZ7vghl4tcEqKF1x+k8oiLsv3PL2wFaKi9PSIMFgO14vyvCYv3kQSFj15?=
 =?us-ascii?Q?aPGEH7sb0cmIpPTb13tMEwp5LChKycXLewLeKYnOG/yVm8b8pxll9ZW+E6Sm?=
 =?us-ascii?Q?uBCTHuPxW1xDFpvEya/cXYe23wxVJAITCv2fH/03OsDuMYoo4X0mSFUVIF3v?=
 =?us-ascii?Q?9v4n2iaftzDgrg/HQmKzTj4N2j/yTAWaKa6Pxez/sFph10QIJYy+PR0HcpI9?=
 =?us-ascii?Q?1txwHdhDb8I7YIrrj4Am/YWi1IdUQUoT+hrumjWs60E8J0jdENi8w1ziEr7i?=
 =?us-ascii?Q?TRiqM83OU1dLLIHaIMZkr/eDYSq2HMle65h9e8oIfOWX14kgfPPxG9swKuQd?=
 =?us-ascii?Q?odvG1wagqTdIIsxzIAhEziqLt4C1ZtKa2j5u7buYOxKQiYwn3h+TIfPdQ826?=
 =?us-ascii?Q?QsdUWGeoZ2lcEn6jeqp1h9vHnAn4FJ3G1JP+CoJNsdC8RZCkDkUui0MwKVKi?=
 =?us-ascii?Q?k3ZxzdykWEmbz753SzBGWk6wA/nb6cm40p603bgu5XQ1j7MhMFvDvPyH/jjH?=
 =?us-ascii?Q?G322YWbleAfYOtrytKs7Be9FwviD06fwGXVX7N9cFVmSMEsPHgWOHrb++N+d?=
 =?us-ascii?Q?OoKXE7H8myVrMVO5BKOPBkUN4yVhxCQNv6AHXHaU4/Q9OS0T/1/6O1emhTN+?=
 =?us-ascii?Q?fRYHhKOyiTTpUFTFUWZYQUPtI6Tq9HOS5N/7iLiZcBco75+80JYBb1cHDmJV?=
 =?us-ascii?Q?7r2xgUpM/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156c9c3a-45f2-4988-a93b-08da2e73ce14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:46:53.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5DqoVhG7hbqZDbyGbd6jXC7hAkvReMmjoTJd/JcyCJi9xpBdHTTyt7+4vPGxnqnAQ9C0Pf7y29wpU7RWUR7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 5, 2022 9:07 AM
>=20
> As enforce_cache_coherency has been introduced into the
> iommu_domain_ops,
> the kernel component which owns the iommu domain is able to opt-in its
> requirement for force snooping support. The iommu driver has no need to
> hard code the page snoop control bit in the PASID table entries anymore.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit:

> ---
>  drivers/iommu/intel/pasid.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 41a0e3b02c79..0abfa7fc7fb0 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
>  	pasid_set_fault_enable(pte);
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));

Probably in a separate patch but above should really be renamed
to pasid_set_page_walk_snoop().

>=20
> -	if (domain->domain.type =3D=3D IOMMU_DOMAIN_UNMANAGED)
> -		pasid_set_pgsnp(pte);
> -
>  	/*
>  	 * Since it is a second level only translation setup, we should
>  	 * set SRE bit as well (addresses are expected to be GPAs).
> --
> 2.25.1

