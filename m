Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4125927B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiHOCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHOCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:11:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C1B7E7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660529463; x=1692065463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yj6TKUiwQpLTNCnmVlFbbknt9+PGrcFhqXOBYtjnfpM=;
  b=XKuYGeDLJvd1grOk3BTilCkV+syS6d0sg7IGTeMTjVhHvOz6Bu3k1RLh
   wyQ9jSIK/sxi0v3v4XP1+SK7SvBPtCJ2ltOU7TcGqZr0fM0zv17EtZqW8
   kYw9wDO45ky6k7PCnJBpLWnlHxqCNR9QUmMP7IhJbiRk+U1g05wQIUCrD
   RJ2b53V/mhSu/xllc7BlqA8ISJKgxpPCYmQTstBHlYvRtL2zhruP9/Y5q
   ycX47h7Gp4JOFLQ6cdz4+HP0iPOCQJr8uLtXSqf2BcCS3UwWgvi6ooU7f
   NBBjggGopuP4191SnS0x5WO91tvdnAnou2b+HeZ3Yu1udOzOF4T5BEW9P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378161915"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="378161915"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:11:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="748775736"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2022 19:11:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:11:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 19:11:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 19:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiT5fKXV5pUe1b6xi0Ea2Ky6uuxuYXtkT3SCwyjeyrQyQZA2Qe+pbt9pgxWB46syw7naut+3r4kG4Orc/8tY/5b3QTl+LnvmYcshtKVh3ZVWUPDKZCK9SGeTcMLlX+yt/RNSAH4AhPICDAd7a3ClNT0/cIrYjlK7keaTYzUqro/6t2YNps0hlVMWMG1duOyXhmqcGOzc2wgd4qppVEXmIe0UxeKMB+FaGeF9J++b4hERl6XJeG6GYkXfwbPLXxGBFTW4JE7JQhYfA+5G+arZmnnc115hoqpdyOl2HzQkoDgCJm/vI//x44mdE46aXgFn7Sb0W7hDTJqoQvToha3qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwNMMEg1o8TwZyYfppZrK5YRaSvovmiq6T07c+N0qDA=;
 b=Wvb5X7PSHyQ6ROCiMsALTem1U2YRvMcaB8U4nW+sT00Yvxk4V3Cm5gmeDSTsLPcOf2KrmW2sRNFhGutlpmD5g/TDbp325/AoZK/dxstS2rloezutzXphsmfhaRqTTFS94uzvOWHvuo2FlCYm03QvoU6qLvAis0R2yu+EkGWX5d5qU9Jlx6v2yct3egkzYIwzxQtk3+zpM0cgfJUCdF4ta9GlpwW/+ZPzPMV0t00IjDy7BBRJ1Tby6whgbYoMfphesDom8sM69Umu7VYAhyCD7Ifqgt1/mUu4odOeYTatwurpzD0KwZzz+tdPNDKEKzR7GEHUJcYnQYxlhS9nSYwDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by BN6PR11MB1859.namprd11.prod.outlook.com (2603:10b6:404:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 02:11:00 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 02:10:59 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsELdwe4rYEhX3kmQ25LUIwgSE62vNNY6gAAAhrA=
Date:   Mon, 15 Aug 2022 02:10:59 +0000
Message-ID: <BYAPR11MB34951FC5879F86F0183C8608F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
        <20220815010349.432313-1-haiyue.wang@intel.com>
        <20220815010349.432313-2-haiyue.wang@intel.com>
 <878rnqe074.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878rnqe074.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
x-ms-office365-filtering-correlation-id: b64f3ddd-75cc-45e5-b8b9-08da7e636578
x-ms-traffictypediagnostic: BN6PR11MB1859:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJ4ZkfQJRqSW0OTo9/cl6UpCgfigiZy66NRaTWkokPNxKG4kf1j1IMkYH5WkYONmK/yOUar5hG58+7M6gGPOI4xmD+2ETB26d1nieZI+h9luSq4ajdFcZu7fGmi2xJGcSDPtk+JDmOLcghdq7CqleEhFli49W2HipJNalqXWSuup/61HcwKx2IXq1aFEH3WU3x5lfqfZOd16LT/aZPXhvA9Z5gLGvyuD124mDVF5FPT/EXzs9GSu8omLkZDes9jB0Z8odOFzwo7AYSTjYS8O8XZYrgpiY9tICm6hLhEdViWOQm30uh4iLfIHIh5eZ+Z00j7A+nHmNexDk+7j7qrXi+EvLC8omRoJCrvlx1ky37euYyqThmvVQFzoDy/zk9JV89fuJTH/BN0SFbaHEzPzcp2+KzpJY6E/L3WcyxI1XsniudE/FDpHiEz9SAV+cZNI2iBZIF2AYjl0obNUFgZ7ZzRPJslXlCn2O4i0iRg5E7MEW6OiQsN9QsmW/8yvhzlTOfpmpBlPVn/IRULnS9FuRS3FdoF+y/jTje2zH4ftulw01FQAry7YKjK8LlanLUtANPGCs4q4whJiws4k2pxbEABNwyo11dfAO0iZspkz/3JKXmG9qrUIiZQ/v8YyavOJJ9O5XtQrHNF+gN38YtAQWYqiyDKAbkRxWx3cYpy3UgohWg4MMH8ppCzF4HyxyXthCYaESxMb/gvwRQZgfivZTyFFcH4+5IM1BxybpUU755QwKcTTLIjlK079YZP/DW0wV/dN5DBZFSXJ18TxIEMOf2b25sGa7xaksHjWb8qZ9liocY+GLOTG8B4/oI7OZLCTWyzzqmJt/fZ0NFQRkdHDsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(39860400002)(366004)(396003)(41300700001)(71200400001)(6636002)(316002)(54906003)(478600001)(26005)(38100700002)(4326008)(64756008)(5660300002)(66946007)(8676002)(8936002)(66446008)(76116006)(66556008)(66476007)(52536014)(6862004)(2906002)(38070700005)(53546011)(122000001)(186003)(86362001)(6506007)(33656002)(82960400001)(83380400001)(9686003)(7696005)(55016003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Ix/qad0hzrRua+hwgHP7LIw/9Y4TyhleAUGB6PVSpHbXsUH7lYYQ8oCk2aK?=
 =?us-ascii?Q?1qAxARfBVNwzTMsK+jHnf6MWZv5EoyMs0T3DqtfXgWMvVfsJn9B76SUymIKc?=
 =?us-ascii?Q?bwlMnxn1PY/9PV8RbXLsPpkf9yjX/xunm36Uw0icquYap7qoBJXt08zNYc6L?=
 =?us-ascii?Q?Quj+MbgaoIm+gFZ4UyeTbZB3kBaT9DWRlkF7xnMYbRu2ekKBKQCNY4JVgVLs?=
 =?us-ascii?Q?V3jLaEgxuZfuO8KFWf6jWxwcNCMUt6+6wzDkxYjgS5v8DLe/hVMIntLASh3H?=
 =?us-ascii?Q?6qcRVmnPZi+CUs1xQtVAF7ZqS+M7xplcu9i87+lwPS5dRZrgxUGqPwH5jhnb?=
 =?us-ascii?Q?Jdk81sYU/k+y+y+zH42Ih9+FPrXW22UPaT1u1l4MBkXjkqvxCzGjPEdd/dG7?=
 =?us-ascii?Q?cZnXDrCzaU5402AUEA7RCt5NaRQEzICPEqzJGzOSPHaIe4ylfk3MGdwpRgXU?=
 =?us-ascii?Q?rgZGo4oU44dFiZPiQfrCMUfuAokpHn8ybatkMYQ1AchkDjZokEh11GpQ5RHI?=
 =?us-ascii?Q?RIUpWzcXTGluVbHC0Ql2EQWsT/NJtoMUmvx785nE5fgEfV01kg3oS4TffAQ8?=
 =?us-ascii?Q?JbbhX+h+EDUidVBtR7EgiLtiz0o24SdBjAe7l2HdchKiO4q/NJYo0VDZSvAr?=
 =?us-ascii?Q?lTVJ9O2RuJk32/BdH14Ps1cXTmUPxAQuALy19GfdEkms/QTbpkra8S4y+Ep2?=
 =?us-ascii?Q?gYc07mpSLTjIq+d+YaHgjFmH6U+N/mlwq77ZRXaFNEOiveWQc6zngKgv4BGH?=
 =?us-ascii?Q?R4JoKTsKByZr9UI2j6KpUR3Tue5dAfaUbRjBX5cjerS/lSPN9JYJmixWpkTC?=
 =?us-ascii?Q?QeV+nyjg5RxWUDUbMOMNjspMUorsU1IZzlRMoZZt59r+JsQUimNjcpIitOMi?=
 =?us-ascii?Q?PlL3L4iBXrN2UaEsO1ndQdZn68mJZfJfkOgbDy/L+z4tlcjiXm7T++oaDzzK?=
 =?us-ascii?Q?+X9kH9mF5Mpj0yrAAmAc/WiUwoyz1naIHsVGc5bmdX/NqO3Zo9eVRCqfxe2k?=
 =?us-ascii?Q?JzpoS1ZXQc9Cv/bZn5JLpumfmi4qnQ0AIecQsD8eGoPMUal3gPEYhpxCQesv?=
 =?us-ascii?Q?OuKFv+HxSSYaVnStDY6toQ5g49wvj8nDQAxBveF6xtKxe/EHHw5xNaHPSvBP?=
 =?us-ascii?Q?ePDedUZT5cAuJsaUIHWBrC5chFlCJtGeOj2YAHpgI5IJD6TZtyCCIBGvxiF4?=
 =?us-ascii?Q?jrVt9sOiHlKe8YiUzlf/NgSnwSqpYT0VD+waqwXbN4X5xtZN1sfYzR86TuGK?=
 =?us-ascii?Q?pKJMLyPQT/ZRFqU2iPvgS+T3QgrHPvv5IB1vyogvl08W6clxv/DUPZUho7d3?=
 =?us-ascii?Q?dBBsR5UBz8S5IYUSxkFfMZlIyfYDS5X3BZ+w1XE9zUlsn+hXSHj91yG0sepo?=
 =?us-ascii?Q?7Ku2EboNQlLZKyQu0HhpBMBjdlxAeoOek3iaB91W5DvHkJUE0lXhj33oWXL6?=
 =?us-ascii?Q?8lMgxCQoDVP5b87PQW3q+8OBSRivI77usnsffaRraNrFIbtAEE7uRJ6pFDM3?=
 =?us-ascii?Q?J3PGlfc3tRHuLCDVpnEMZmdyRKJKF/ffV4x+dDqPWMCMg3CMzr9/aTVtJY7z?=
 =?us-ascii?Q?OgwY86tZqKXEGkc+o4ukM+Em9otonOIgET4TNGvH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f3ddd-75cc-45e5-b8b9-08da7e636578
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 02:10:59.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dwZtzMwrRaZgtaLfAnFNmdCRys4TZz+0az+h/dwu3drjVQlq59hovj/zbBcA8Iwx2MIDc/KauhGTGaVXlPjw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Monday, August 15, 2022 09:59
> To: Wang, Haiyue <haiyue.wang@intel.com>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; akpm@linux-foundati=
on.org; david@redhat.com;
> linmiaohe@huawei.com; songmuchun@bytedance.com; naoya.horiguchi@linux.dev=
; alex.sierra@amd.com
> Subject: Re: [PATCH v3 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> Haiyue Wang <haiyue.wang@intel.com> writes:
>=20
> > Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
>=20
> move_pages() is a syscall, so you can just call it move_pages(), or
> move_pages() syscall.

The application meets the issue, use the bellow function:
syscall (__NR_move_pages, 0, n_pages, ptr, 0, status, 0)

So I used it directly in the commit. "move_pages() syscall" is better.
Will update latter.

>=20
> > will fail to get the page node information for huge page.
>                                                  ~~~~~~~~~
> some huge pages?

OK.

>=20
> > This is an temporary solution to mitigate the racing fix.
>=20
> Why is it "racing fix"?  This isn't a race condition fix.

The 'Fixes' commit is about race condition fix.

How about " his is an temporary solution to mitigate the side effect
Of the race condition fix"

>=20
> Best Regards,
> Huang, Ying
>=20
> > After supporting follow huge page by FOLL_GET is done, this fix can be
> > reverted safely.
> >
> > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array r=
acing with memory offline")
> > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
>=20
> [snip]
