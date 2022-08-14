Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE62591EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiHNGUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:20:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42E8D41
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660458016; x=1691994016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hkIXCy0OgriPtrl+/niokoA8dUdHf6iPrVNY678JZ2c=;
  b=CEY14pbV6v1Y2GoSh11T5pI7G3/0oxMq/vQ0wv+9j51nOqx70HlFkarx
   eWPKHBJpUOylELwxsoNxNrp7Ij7uMEmDxLo3JAeOtJkfk3aLtb1g2cSJf
   EEl1WNFNF1NsDhAxtZ+iPBZTTogSPrNuJUdXJ0nXCm4SpwMjaaV8Q1SB/
   GpFBDadqODzXm3K3g0yK+p4E1WqigObdU8bE3uT+6z4Ws9bIEAnHr74CM
   IUXd/9spcEiXQcY23e5HjzF44RlyUjIPxIhSovWb4scoQ4sYNTpbcJepN
   BBk0kI4fyF2sy38ZVfxxjM5DDAITzzF8MK8cb5/hiAOu70Dvy31bkPSCH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278757174"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278757174"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 23:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="674503406"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2022 23:20:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 23:20:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 13 Aug 2022 23:20:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 13 Aug 2022 23:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMNM6F+k+zGBxJg0yRVaoW7VkdVYqi7FFK4t6djTN3u8CxDRPO5ttB5u1z5mpXe3e0DM5YGXs0pCKuJPVdYt8oth945/93fu13EKZO9vfywG9SJbBz2Rt0JhLeCr7BAVy16jRWi+22+A+GdU4SWTihfF9C/nfwa88ScAC67CqniQxcUMUJPu55s/kUjPpuM1/HKgTRMQHq4KBKCdVWdFtM7hK7dFs41tJozDBMDsLjJWOPaSkz5WJmInhTgewLCkNcGrfc39zAONwJBX6C5VqwWTbgDsU294pOHMMW5T57nbyWRqjtoRs8/lDqKOIeIHhfL9FmNihDEKBBbAMUYNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rVXFf0jb9WYiUkvyiAlRs9kMttBB2DRy+/Qoba2h5k=;
 b=aMTIqB7RisBubUzPb6dJST5vXCKCO+MMAHn7t4nsaJdNP6bbX5f3hMB77MxtYD0QkzbDEtFytIUK5ncYpl7YeTUGy1JKLlIJ6LpS0SpCtKdyma0cu2bO2hDllHh/pJ6keECpfkUuzzqznpfjtDXnItNteE6gXAHVeb2CZj4R0FmDElEErNozLhYYjs+Ny0dbgQPCQlvsmQMg0J4pIGNP6h16o0e0JlT2nGnYSpjgQCC5uH0mPIH8oVDSg+BXuT9JJFUsll7mgRwcI6fODCqrvFdGSsPnmJ3STmWF9BD9TPCL5PMp0UF9IRDWaTLyDXpk/yIKGe7TJhjD63WG8Zi6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Sun, 14 Aug
 2022 06:20:13 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 06:20:13 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>
Subject: RE: [PATCH v1] mm: migration: fix the FOLL_GET failure on following
 huge page
Thread-Topic: [PATCH v1] mm: migration: fix the FOLL_GET failure on following
 huge page
Thread-Index: AQHYrihn+urE8ucWPUyypvMRNXxw+q2tfIKAgABlxrA=
Date:   Sun, 14 Aug 2022 06:20:13 +0000
Message-ID: <BYAPR11MB349546A36F2AE9C82E85EF71F7699@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220813162837.cc20e208e7a9d65fd2e7dc14@linux-foundation.org>
In-Reply-To: <20220813162837.cc20e208e7a9d65fd2e7dc14@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f069b0-8630-4bba-70b7-08da7dbd0c29
x-ms-traffictypediagnostic: BN9PR11MB5244:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RENcFiLd0NT+2FcUpPiF+ObxoJyjJcbyNaPlqylAcI5naOxgkrO8bxszj77JzV+oDcDVUWeKxynUcIsSq3ej8YEcy8xLDTZ4lf6vhcOfahXJvbZHygo24Ibu91QtiORq3q9z4L889iZ/7NEOGHl6Oon/AJ7fa9rkojmBkGeikt3pssESI+J30gRmgRGU/o6EnNcx841Fb7osTW1jLUEsn3o5OqlZav16bS9UUnHtS6pR1uaBukSHwV0ZjhWK3rU+aPzW4EWCRCNYw3CcrLUVWCSM9NQwihcWBWfL0wgxlAkKxraulx9PfMAeAelUiV75+Tsz+BVYmO8c9misUUAzgIJ9+hLFGX3eb67QfSzBytCrsJR7JkMJ441+8/k/NuI8eVAs1uJj4/5Cr6MJ22PrZGdfmE2V+kQaymeyjwvF3JGW/l7dHFTEfmXhRMNTN2IQczFQFW85T9kG9VaHbfC6qFuKNdj7HcwA7Q9LlLpyHCHabeotCIN7SQiCEXqKTA5EsayvHXCr7VEJTpaiP+1iZ9n315XhM6fMC190PCK4tmORUrARnk440ov+e6U9D+JdvXRP+kczYx80clgNncgaDlbyNdMCdx7d7P40AZby4T9VTCEahiGXTSpvFMBhx0xYQlTX6tLIlHJKjGsm0lu8j2hW8F8+gKL3pubIL2tT92cTRXPsgyPRuQHn2H4BcpvNY1CpQflaxpWGmUsYHZVz0HS/Ge/yHlJtLwMLnU5A8NjnTuoQUKNmIemZ6vKxxm1joSNkGK7UqXnPzF717sIZRU7fXSTVumYFogn+CxoauOHoQpTqWZoPLmR69RWdt1xJp7/RX98nx5IvzlyBBTSRrON79yGmYB7CirTlloOB90I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(366004)(376002)(39860400002)(33656002)(186003)(26005)(38100700002)(82960400001)(122000001)(6506007)(86362001)(53546011)(83380400001)(9686003)(38070700005)(6916009)(41300700001)(54906003)(478600001)(966005)(71200400001)(66446008)(64756008)(66946007)(5660300002)(76116006)(316002)(66556008)(4326008)(52536014)(66476007)(8676002)(55016003)(2906002)(8936002)(7696005)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iOjAnVW73xgF4gaHJ4GAkcF50/lcyUG6uBqa8EtIdUTIfkHJTC3JYaaJ6b9a?=
 =?us-ascii?Q?tMvT87dwfZAiCYs+RDqHxtAgov5ciIpjB+UeUMJYs2CNVC6i8SjjrrGcgjlY?=
 =?us-ascii?Q?74abk1QU6oyviESSu2Xztg7nvL5PvQMALS8RY33MdmL3+Hx4gZv2u80po/LZ?=
 =?us-ascii?Q?ErcAweR7WQOXuwSom/XUTjQL2rcvF8m7h71zt3Ug5PNI9xivepvNd6SyA+8C?=
 =?us-ascii?Q?Oh9JCL7lXlo03EP2sNaBD1okynWGXNauljvpKLeNF9+K1uuc433z+Dy/UV6s?=
 =?us-ascii?Q?R64d9xsuIypHDcnO2HqpMRYfFEFDadmUBxaJ1LF1nBjMa3sYUie2IFcgIHFD?=
 =?us-ascii?Q?u0u5WL1Ne2dek4qzoyTdl4otR8GYjaBbfEohyKHksXnarLfi6EZVYKZi8zbC?=
 =?us-ascii?Q?L8P6JnLkgHe/sFOA5XojboMS0oSPpzjpzce/suUDW+RtAacMZWuZe8JmfUBZ?=
 =?us-ascii?Q?1X4GmgfZslTqKOmavcFc1euOH7pAW+jjCS2dWVQ4iuZ1pYWDm7BiKDWN4bUi?=
 =?us-ascii?Q?49c9gEKdW5DtKaurZofw9fP2YwZu1nUd0ANJaqqbfqGDaUWYQ5kKWeCM4qq0?=
 =?us-ascii?Q?etKIF4Nc15J8wiegyGO+XtTiGyOgLGftLAVRrKLtmhBZXEGjY2ZUUOchTK/x?=
 =?us-ascii?Q?6stRmknd7muYVZfwEha0G8JREjE7Dnwa1X02u2Svky2ezOkJNrfQgez76KAW?=
 =?us-ascii?Q?70kdmiZIObQEHuZpZGnKVa+KoucArRty6bqPgufE9Eve/knlXjA3hskRpXNf?=
 =?us-ascii?Q?BA7roV6TvOWx/xhYdu4xl5wlwjNvHOQUFKwNXpgJnle9aIjvjce3UVMOTjSt?=
 =?us-ascii?Q?lXrLDOXZ8TG8OIBt1Y9FPDunDO+WWe/bUZxOWFwG5B6BcanqFXE1IxCI8vCW?=
 =?us-ascii?Q?DcO2R1mIPk/Y6AaOV3n6Bh3jyHZ0pLQJJ9Re7HSCguzUTVlvvacwTDoP1E8R?=
 =?us-ascii?Q?jx0KDJWlebF4171rugh3BjoOdUsvKwBfAYlo7aojH1GMg/t3/45O6n3786hA?=
 =?us-ascii?Q?Cz3txJ9792l4cnk0aAtX3X5fi8YxerYwFckyTVRu+Kkhuz5gg86p9ewT9vYQ?=
 =?us-ascii?Q?GIH+WV11nqF1VCqSzuqsoMsv8/Jv/2OMqdOzQFDkbE8F8KpcAS513y7KpKnp?=
 =?us-ascii?Q?rS+WsRZc1kDOt+pjQrBsS6yq/QEdM6e9l5Fv4FVOeC0SVdpEvuYcGmLwg7kP?=
 =?us-ascii?Q?ZuxMZyAFXWjx+0dkfWMLNnzubr4gCSrVrlyMwLA+GPX3ZtJ7hrq5lmWAzYi7?=
 =?us-ascii?Q?jhlnzsjQCCq8B71U7XSPqcfrbvzykm8FS/jAsWWKjM0bPZ84jR1hHtV63O9E?=
 =?us-ascii?Q?TLwUlokgrZZmU+2I6lCHrJTz0yO0JpO3PB1sSwMgw1dYRXWc3pDcbH73KW2p?=
 =?us-ascii?Q?jP2KeTjNkBFC71UkqFQyaTsAIt7sYFwH/dgv+eMVqsh58WzF0ykKSScKFm0J?=
 =?us-ascii?Q?LOBmOxJEC0ly0B5ILEhfpmZGia/uFlTlH69Jy5UfjcakOUU6hVUkaUxGuz4K?=
 =?us-ascii?Q?xJL3HvEDC9qTWSZg7vtiOiIWwZ2YPOBWSAKRnfbOOgkkte363H1M2bxFkHam?=
 =?us-ascii?Q?2plbHEb6yDsQ8P6WkThsnbHgXCeNbcz9jtWfdo48?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f069b0-8630-4bba-70b7-08da7dbd0c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 06:20:13.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L8OVtv44a5CD6SouxZVYpvvzJlfEgFksIC4To0DgCTmaXwlvmUfvfPCHwhAkgbLxOh+WBLdC/ZFg39f3ljQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: Sunday, August 14, 2022 07:29
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; david@redhat.com; l=
inmiaohe@huawei.com; Huang,
> Ying <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@li=
nux.dev
> Subject: Re: [PATCH v1] mm: migration: fix the FOLL_GET failure on follow=
ing huge page
>=20
> On Fri, 12 Aug 2022 16:49:21 +0800 Haiyue Wang <haiyue.wang@intel.com> wr=
ote:
>=20
> > Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
> > will fail to get the page node information for huge page.
>=20
> Which ones need fixing?

1. 'follow_huge_pud' arch/s390/mm/hugetlbpage.c

2. 'follow_huge_addr' arch/ia64/mm/hugetlbpage.c

3. 'follow_huge_pgd' mm/hugetlb.c

And I found that only 'pud' and 'pmd' need to check 'is_vm_hugetlb_page' li=
ke:
pud_huge(*pud) && is_vm_hugetlb_page(vma)
pmd_huge(pmdval) && is_vm_hugetlb_page(vma)

So I'm not sure whether my patch can cover 2 & 3 for other huge page use ca=
ses
except by hugetlbfs.

>=20
> What are the user-visible runtime effects of this bug?
>=20

In my test, the '__NR_move_pages' system call will return '-2' for 1GB huge=
 page
memory map when dump the page node information. [Test on linux-5.19 stable]

> Is a -stable backport warranted?

Yes.

Since the mainline has introduced the new patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D3218f8712d6bb

The backported needs to rebase like for 5.19:

-		if (page && !is_zone_device_page(page)) {
+		if (page) {

>=20
> > This is an temporary solution to mitigate the racing fix.
> >
> > After supporting follow huge page by FOLL_GET is done, this fix can be
> > reverted safely.
> >

