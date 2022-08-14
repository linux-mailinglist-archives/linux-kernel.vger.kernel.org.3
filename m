Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC3591ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiHNGtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHNGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:49:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDFE1834B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660459769; x=1691995769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0900xjxzgBAS+Puy8glJUvMHY8UCA+WtzrVBSw8Pj+4=;
  b=hXvogDJzQl4lUvSfTbmjAaFP1kbNYUdrNrkDpPW2U4FTzvYZRQcrNxDg
   xGd17HwPho31Oi7JwZwzIwJaThgc3/O/w+dWWiEKA1H/4tFKDIsHXs1WC
   rc5sZyOXjlb0FM3o7IBg70RbXJavEAdXk+Bd9GKMmQ6sIxOF1ceiUWl7U
   p5QeR3EIVvV/N9AMom3mMmH3xcTLPw15W/SKPZ3aXYYLIJOC+ZzM2VPV6
   mt+B2tdztH6YM5kbSrK2hlw/vDNcIrmKu7MuyhZOK/ys02iHrqI4ARcIO
   KjcC2Cp7lh15kEbsileeESbagG8C6Emo5hd9KFF3VOZqrptCr5eI3ekBg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292598125"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292598125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 23:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635120620"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 23:49:27 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 23:49:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 13 Aug 2022 23:49:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 13 Aug 2022 23:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9BvXoWlU8DzbHM2Y/FLrQgznoaG9wBhah3+dGhIV92Yv8DkdLfoRlXTxwLALruW5qfwd2X62A/gG8DgaeJBSgd4VXNImZwRxhATIjbDiHVPpg0rltgcK6iUw0tUDmPGWqaMsB1Uiv4i42UE3hqvmjVUe9dRlaSYLH5IONV9ua9B0f5d1vSdHW3pZMVJQSIJfKSG6lPsLBPSDK/IjTubBfUI6wph3S9/6BREjMFKaSG13AQ44ecoibwOrVghSZ+aH6YMLPVj7DvrHSKkxezUn+wclNLPOtLktWqnL0ucrr/YKUyxt2TUFZ2EKzpz/8MWqHcii7l0roOfTkQBQ/57mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57v21KiqDcds0P3G60ldIKr8sb8MB7fggT42vnVq0DI=;
 b=kO+d9PF+0kCOFC3cgS2Qx2FzR0BrkAcapDpfwqBokOKhKDWHVKpzVLOj5WlziEPhUS0JhMNFMfUTQJOnDsLhmAJUJ+2VlxTrqZztGN8/jWPs3SSZMg8UPHlsmwQItWOXYv2kiyLMZZxrAmJxRKAIIPkE/ijtwwkNnZiWaEhv+akMxFRgQx3scoAdGxuDxLrzJdH5JhIhqoeWTTWVaeQJw1qaVEmaGDnCOyvttB0Dib0ncA4IyzbCkJOe2+CaicLfkkzLeye6kgRqfjlwIguNNaW2AWG9odyJdSvUg+dXqp/BAZDU18NNmjPh6W/RHQFG1kL4D4geFfLf68FTpLuVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by SN6PR11MB2925.namprd11.prod.outlook.com (2603:10b6:805:cf::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 06:49:25 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Sun, 14 Aug 2022
 06:49:25 +0000
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
Thread-Index: AQHYrihn+urE8ucWPUyypvMRNXxw+q2tfIKAgABlxrCAABGVUA==
Date:   Sun, 14 Aug 2022 06:49:24 +0000
Message-ID: <BYAPR11MB3495AC9B3F989A3462053C24F7699@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220813162837.cc20e208e7a9d65fd2e7dc14@linux-foundation.org>
 <BYAPR11MB349546A36F2AE9C82E85EF71F7699@BYAPR11MB3495.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB349546A36F2AE9C82E85EF71F7699@BYAPR11MB3495.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 6f0436ee-91e9-4fe1-adf5-08da7dc12041
x-ms-traffictypediagnostic: SN6PR11MB2925:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KoPzwcA6ns4dTj4oI+zAZM5QXYlTm3p4hyfGHzuJnUQJng5jOoImcSe3WOLAu8yjIyXg/qkxEqTO6+YF3YKsNZBJ/JaUoU1KYRAXEqrBe0zeV6F57Eh3VdZa4HFZWofuansKP1C7bQHgzKV+ORSFg9iMMTBiHqy5w2pM4PdFw5mZjuCpJuDFKbahYhKVT2dJf4EXqsMg7Mn40ezjSH9ChmThFdsdJGGkqpo4fC4P/R3gjA6vVtYdSfgP8TJoABKK4s8Pe4gG8dQdJBme9HehK8N6YTiFBRB8WdnnWLoSqgXcescosWx1LQKn7IIlLGpBfblT0JIaLMa4GFApgMonzX5/rOyob+IgYj2Bzetwyf+qKfry6KaLcG1EDgMfaVJZcrNTCrV0xSIVt/769EkVBptYIFZY1gMCK8Z1dbysK73hdOMaNkF+gUtgJyfRVk5S3oZRevqGkRZ3WqUIhvOBCScm/p+lFpWkg5BdqvBI4QQi3QuIRWW7EcUB9dUykEQkB1qbrm8pkCfMqxVL/15Ui6mNlOwHfGDDe8/7EUVx8uK1LO0HfLfhkRNatIK1aWMaxE+3KkPvZU8KO6bNJPfUM/Ing4EHecbvtkDu1ySfbAb9dh32E4lycfgB76PQZ7eS4dFadUJW2PHyX3Q7vCiJkxgkGlLS6GQsRbynoqBaLlGXpsszIYjNXVTniO5JqcHEcVRSVjEOyMBQl1w6m6hlTxYbjn/XjXLu4ZJsjZKSgnJei3+bh9xQSXa9AVx9Vt0RJgVNmMwwL3LgqyOoqAfGL0D/JmJ8cGGqPc9K0112WZtbKXab42v7k2ZSopaN1kDnD2WUXLcj4olZKO3DMnAntgExmsinaH10XNQjcP9Csl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(376002)(39860400002)(396003)(4326008)(76116006)(2906002)(55016003)(38100700002)(186003)(122000001)(83380400001)(33656002)(9686003)(41300700001)(86362001)(26005)(8936002)(2940100002)(82960400001)(6916009)(5660300002)(6506007)(7696005)(53546011)(52536014)(478600001)(38070700005)(66476007)(64756008)(8676002)(966005)(66556008)(66446008)(316002)(66946007)(71200400001)(54906003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3jPodH7Vud/LSWkr75JeZhH04XsOmDJiBJgz0x38jMNQwopd0SVOxAUOWshi?=
 =?us-ascii?Q?7NTGwJjbUBIeErwb7X6jg37TJxnBpYL3icieCI56269alrHn5PJwvScM4UbD?=
 =?us-ascii?Q?l4luYHGI5mZ7PFVSLEKXkU+XGLa7y3dJ3Eb4BBW3x2Wp0lo6QHV/IsQjK942?=
 =?us-ascii?Q?PMJZzkojr/oMDQz5nLKU858/cRX01wQ4NE0unF6VgKN5ncnxbI+KLn0+LtJT?=
 =?us-ascii?Q?NdjwKx1/QOdtu72O9j92mI21dKnnlf6E5wXxecR2TzBREKk201fxYre5Qkb1?=
 =?us-ascii?Q?qIvxrF6A/OvZvrwbDFXQhIywLoQh+Ch0KB8I2GU5b6/OUzd2e02Cv9K53w/p?=
 =?us-ascii?Q?2hHiTp5b9qmZ8Ru8i4qvxYNTucPXu/wtgFx3yVLPsuLfoFdM82scWaSU0Ifa?=
 =?us-ascii?Q?igxjr0I9ykDzDQevcJQ95yQfLlNRx2r7hB8TjxOb8C9JcOI1LxQzggmBA/GW?=
 =?us-ascii?Q?OLE1S3/NYv9rB2dwPI73mJFg8YXW6lOTUzM2QCApZktL4BXez/rRm8E82w2B?=
 =?us-ascii?Q?Pdkpp+FPdNSSJcjimEBLISoVTylMvoC5h2lyL09PVZJmIssixJqM3pjzjeld?=
 =?us-ascii?Q?w4sIOeC87voFsx4bGaqtPPjGVmBRH5e5z9n573iKM1GyVWGO6oJ7Xa/cJ4oq?=
 =?us-ascii?Q?wCl9yxXRFvjoSsvuCLaqSezjb/FZwMhsCm172Fk5PekSpjOAPzQeHsGn0bkK?=
 =?us-ascii?Q?uPqXcbEnYrnWKfj3AdwfcvFwvRlmCpmXMX4fWosCoqkC+YajdM1g6xIsLxAp?=
 =?us-ascii?Q?dbHGnKVdZFVp//YJmcg/wKSn5YhfHtzc3bPpHAcZ/hCgWzc4l+PlJgRn1GEj?=
 =?us-ascii?Q?QdgS6mTLWDwoFNBIIZUK1NxeOM6hIivGEUfy0VuwtLbZoLlnDHDP/dPgPE7I?=
 =?us-ascii?Q?GA4NxDKbZDgDNHB4I/+Dhx18uK4l98c/CROlarfqHU0NKvW4tCjTdDdsrQfm?=
 =?us-ascii?Q?Z+DbsrVYoGR1+1j2A1LB11B4hBc99wVm9tFu4CDahREczc8dXf0LeGg1UBJD?=
 =?us-ascii?Q?VYWF+b/5n0wxB/Hcdf1cJr45AJ3Xii1JD4Ch+Cs9QHYHQwDET2KpEb1zdBH0?=
 =?us-ascii?Q?OvmVb42hRk1WHlBUZkRi+bqb4DKk1hEHCVte8GHddnp8e0rDGOFr8uDx04eO?=
 =?us-ascii?Q?G6ivaZOuGDt5yjfGz3Cz2PnETYRMrFkTaxQw7WDrixGZJ/+zwiB8Yt51ushR?=
 =?us-ascii?Q?46QW0KJU3P1UiIuqatGi/JIcdt2yWzTEiWtBMCDEIetXcvhtFumViJDI3GEQ?=
 =?us-ascii?Q?YHixToP41m0+X1v5Ypa6aHcIcWyIFHGywbKsnwChEiroP98D8Hhs0/XsPsdV?=
 =?us-ascii?Q?Jtp8KGjqXhoQQhebx12qHT28BCcA6pqZq9j22FoP6Hc93AKgt7/byFSVYHIp?=
 =?us-ascii?Q?S9slDN+bfUXWkJMSwKJcZJ1MqgfwxsC7+JQPgI6ANbCZU4fX4ipfPWHEHnUa?=
 =?us-ascii?Q?EqqO2nujZ687waydLt5+eTdFl3luZKGK0LaPBWb0tAdVqxBcusyKzQv3ai6I?=
 =?us-ascii?Q?g5sDbgHwJb1SSjNmQcD5RhKl1dLYGb8a1gWIzxnSLFy5H8HjtYmBwGH5IYBq?=
 =?us-ascii?Q?w+6f7WAgLs0NCzQugzp1B3vkmx5R8rro8BCsv9Rr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0436ee-91e9-4fe1-adf5-08da7dc12041
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2022 06:49:24.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+O/kzP46A8+Qp9+P5GPaHB9hbg+KyOhhoMCYXi/YV9HKyPir/uWfFiU8+WxyzMbPrxMq9TOk4+jaeOxA6lr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2925
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
> From: Wang, Haiyue
> Sent: Sunday, August 14, 2022 14:20
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; david@redhat.com; l=
inmiaohe@huawei.com; Huang,
> Ying <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@li=
nux.dev
> Subject: RE: [PATCH v1] mm: migration: fix the FOLL_GET failure on follow=
ing huge page
>=20
> > -----Original Message-----
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Sent: Sunday, August 14, 2022 07:29
> > To: Wang, Haiyue <haiyue.wang@intel.com>
> > Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; david@redhat.com;=
 linmiaohe@huawei.com; Huang,
> > Ying <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@=
linux.dev
> > Subject: Re: [PATCH v1] mm: migration: fix the FOLL_GET failure on foll=
owing huge page
> >
> > On Fri, 12 Aug 2022 16:49:21 +0800 Haiyue Wang <haiyue.wang@intel.com> =
wrote:
> >
> > > Not all huge page APIs support FOLL_GET option, so the __NR_move_page=
s
> > > will fail to get the page node information for huge page.
> >


> > Is a -stable backport warranted?
>=20
> Yes.
>=20
> Since the mainline has introduced the new patch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D3218f8712d6bb
>=20

Looks like 'is_zone_device_page' will cause 'FOLL_GET' page reference count=
 issue, which should
call 'put_page' before call branch jump.

try_grab_page -->=20
		if (flags & FOLL_GET)
			folio_ref_inc(folio);

Or I misunderstood the 'is_zone_device_page' ? ;-)

> The backported needs to rebase like for 5.19:
>=20
> -		if (page && !is_zone_device_page(page)) {
> +		if (page) {
>=20
> >
> > >

