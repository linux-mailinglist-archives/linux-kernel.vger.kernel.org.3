Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092256BBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiGHOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiGHOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:32:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B691326E6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657290735; x=1688826735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HEY21QDcXm93DkaOGA727FxqPyiMIFXKy8hfMWcC/P8=;
  b=kn1p0lVZ37n2iYFHRIIeYL5pGhfQUvWVZvWukuJqGhqu2IhAM3nhs3zL
   ks7nyRX2iEooES4Km69H2giuYHt3fTQWp5iEGCXL614RUi/U1OYIrA2NQ
   rVsW6tgeoLToErGYOWah46Uv3Rahw9qXNhmCRInvOrpHcsRf6TME78FA/
   vNLRBiA1F7T+F/fuAD5RbfH5SiWlciuztrudszGYMr6IAsljtiwRDuULl
   M8RlroeDhSY2wWRoZeVQg4k1qEwAGKCA0qTwFQHv+IUCSWnjgVLEZ0dzK
   4benDA5SM6c8jI2YJSyyEaI7glbSD8R88JSodKzVpobpPJDTJpJDdxYvZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281841081"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="281841081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="651585041"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2022 07:32:13 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Jul 2022 07:32:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Jul 2022 07:32:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Jul 2022 07:32:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4z/15Y7HmQ0ZldMyylGfTf0+lArF5gpsR3IF/Wg8vFfvIMvq4x+myZ+epUXfbbPSMS/r2hC0IruFLB4VVnrBd6mueKaRxtRQ20d7Ydj9+UDot/++LD1l8xumkEpNN0cVy77QzY8vWgx7lDH/xlFKfSuGyT8bzTUBO53g7iMTEWBbH0SzA6/U/2Yf4Ar23R0Uz3ODfvNjxywabI4fEemOZ1BmI46kIpeSbGdrdSPRyw/WgrpxfYVZ8gTFcLH47+tsh6wQk1viwr6XN5ffGdINn2oUfkkQoxEDNpP7A8SYfxgzU1ZXxwCQEQZA12xMi8KFM0GMrfV0cZB7o3KijA0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+HZiXqNU8yPJ0v6/ldxlQpKS/VNV43sIsoaTQMo25w=;
 b=DcWsTtUeA6NX4tPCpCRMcKkSffIA/JqcuPopOEPIS4WcZjV+0c8+NESdqEgwBsX8shbrsNNfLUeUJFGOAYcH5RSJRjchX+S0aESvtAEzbfmlg4Nc/cE+dye87sfndY4gvGgVyX3EpweNoCOLv55tcXHsEqHoWG4mrf1I8+QlYgKLRZzG/UwLZN6Sm4EK6RjsTmi7J9bjUxjYnVfaA8v6hDYS9Ro+h6eahIi0DJOn1/QV3UHGoGBvPuEbbhCn+BCrQtvG2gOG+ak8jreckrw7Qektstv7bfJvnWxW+ur3W9No6JiZRaUxidCeKpF8bsCjabQTekClU83aHTtsK2axoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by DM6PR11MB4124.namprd11.prod.outlook.com (2603:10b6:5:4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Fri, 8 Jul 2022 14:32:11 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::e8cb:4438:828d:5f90]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::e8cb:4438:828d:5f90%7]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 14:32:10 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Marc Zyngier <maz@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        "Rafael J Wysocki" <rafael@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: RE: [PATCH V14 00/15] irqchip: Add LoongArch-related irqchip drivers
Thread-Topic: [PATCH V14 00/15] irqchip: Add LoongArch-related irqchip drivers
Thread-Index: AQHYkgBkiBXSOIjTQkyfpeKYt8QMx610ilrg
Date:   Fri, 8 Jul 2022 14:32:10 +0000
Message-ID: <BYAPR11MB32564676BFFB21931CDC8C9487829@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <87zghlkrvs.wl-maz@kernel.org>
In-Reply-To: <87zghlkrvs.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d8dbc15-011a-438e-16cb-08da60eea4bf
x-ms-traffictypediagnostic: DM6PR11MB4124:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQR585r2eWeThG4+eMoq0ex8GVpR85ASTUwSaLXPvgTHurYosntEZ53pPSHcMSDCS3X76mUnvh5rM0vaWvedYjgCBTS92v+WbCUGO7BCg4MoJ1wBQOTDKAG3oMS7uuPozrjoIjnDJFwOxwHRWFOFeyUFetZe6hGi4rschvrg4FnrZADKsQ75t7qK2DE+AahHckvmJq4ts6oNjmDOEG+HRk6jV2swEsJcpV7j68bbZx/PySKBGscdEUe2VzP/ISJsF6ZUTKgaaa9Gy9BcB+cc6CYuhUN2iRH6NHKAhPqmTQQ91G56SCEwSsXqEmEjUkcibpKByQNeDHi9sUtTgHTlf0A64ZuVqRABTMivgXzn6v75pLLYbZA2rU34ooKhCjj1qT5evNHLyd/2VIxA2Aa/rCPjcxHn2mMsETwVSpWcgtClLzPp3HNXrOHkVOcKAbfuQoaXTNm7YjvuZKtoOcvS9dQudjGIWbhX+ahA+xYf7GxxMd5qvSijXsE6LeuXQU9gSNK9qFm8PIBUi5CMrEKwj8FCLzd9H6wEHZbXUlE2fLnm+PlUm26D8Hp3ri7cfRPxk0j3GkFY6qin6BvEacDzCc9O1IvxV+l8FDKfn79cvcsJnI83mlUBijUcIjjMnn4ckoogSWYjLpQAunjERlsM3xmxmiljlZFfEZ6uFPhYgFHB2IKUtbM16ATgZk1/owurSVooQ741+uMrPQm3r6Z2YWEK/EOUeOGWNnlaB9QoTe6z+QC1XqhRHghufsdtGv1Ylc4iIiyES3GhK/Zbad7uLLcNyL5IgmfY09IPX9dYI7Zcj/X3bFxbmlp8dGfiLZIS4DZR1FdT3QvqlRzc37E2+V6lNlJ0rX1qeqmYiYnr/Lc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(136003)(396003)(33656002)(2906002)(38100700002)(186003)(82960400001)(5660300002)(122000001)(52536014)(8936002)(55016003)(966005)(38070700005)(66446008)(64756008)(4326008)(8676002)(66476007)(66946007)(66556008)(76116006)(83380400001)(110136005)(86362001)(71200400001)(54906003)(53546011)(26005)(9686003)(478600001)(7696005)(41300700001)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u18x1RuHBwjcPoYRRqE/03+xXUoKiIiYKAZJpn7AnrtV5xSvGUqaGmwsRdat?=
 =?us-ascii?Q?Po/PmkjsEM4g5kHNDrFoYQZJNlSg1gD8isL1yPb7GB7MnySJ2RHDx0plc/tD?=
 =?us-ascii?Q?OpSwcRwQWuNYPZngTt8VLuOz6t7UT70PnSHdCr2h4j8FzZ1I300DjocE2+Bw?=
 =?us-ascii?Q?I0pWVFsQRwTRScyeYXU5FHKsFnD7y38el9BNERlkA6ibFE+Ys+JJfFAZ4bEJ?=
 =?us-ascii?Q?R/EIOzZCMcsGezqCU8rVyneezVpPbXGGFzSRnQ+CVjOHZ4QuBTU4jMl0Bg9A?=
 =?us-ascii?Q?R1XoHunLRaJhy/RWe0PTjYWtLZECFnHvIFwJBGBekjW6L3C5U9a1a1+2LPcn?=
 =?us-ascii?Q?UYhMwwBxkCK8kNOVRlbkQKjckOLMJr08KRpP/jynAi1+IYBAufYsIIMht0p4?=
 =?us-ascii?Q?h2iEaCgBGjX/irgAPhXjHbAvsm2w/F9Mt2iGZ2addZb2IqdmwqbqGNsimERm?=
 =?us-ascii?Q?QacIpT2Vev3lUdgm3lT3v5TLGg7TFqLnqZfBd4VEbFZRpZaU0N0LaXuxD/TU?=
 =?us-ascii?Q?75ZU8vcWfCP1YpO+Uy6lYD4hiYWGcuG6mdX8ZQOQHTvIB8+i4XStLTO2Q7ww?=
 =?us-ascii?Q?hUqJwhQFqYO5LIgKhPP+ok7xop1mESzYb8VZPecqftQdcwIZLCzCy2e10npi?=
 =?us-ascii?Q?u6xuwt7dS7C0xhnlVB+XkoMl7tlCi8tcsKoIOcpJK9Ho8pZC2wm8/JZPcn5O?=
 =?us-ascii?Q?pvKefxwzJTi14Xcz3r5MppKxtXENkcNpi+123kDnoi1Q36l2ypiPimDyfgNE?=
 =?us-ascii?Q?X6oRXc3jdNHTd2EfU/pe/LnFyDMYsPGGIjTf4urqhRY80D4ZIZbO9ZxzOlEu?=
 =?us-ascii?Q?DGghEsIy7GXYoy+qcdEz/zvDZNzy5t2yQcR2507e61TMVy+v7C4195YXLv9g?=
 =?us-ascii?Q?mSaTb27autdAEhJFWXLN6JoaX9S8rHfA1cHS+L6rr4cTVDfCXo6NyFU5o43R?=
 =?us-ascii?Q?julTY9T1T6ATrOhuNTbbNPrgknvgcgt40+bxOw4M8DDaXQpl8uWumQuah86p?=
 =?us-ascii?Q?ZuYJVe56zHCBg5wp9vUaCedSLEQumRnzoKLgGxYCHKZHqAw8OFaWyhoWt8t/?=
 =?us-ascii?Q?NS3+8R4KGHjVuqgjEH1ISGGL/DouEaV/AKb4iGESc6iuAzF8JsXnN2DQj+Qm?=
 =?us-ascii?Q?GbdA3EKzse0yW6IhbCYRykoh9f73LIAW/2eZYyy5vAxYQHt4RvDn9AyMSLt/?=
 =?us-ascii?Q?yJ0lV/CugpJebmaCEPo8zEDArYn6sYs/hNY6JDYSp9zsMn/1QiNYArxTZaW0?=
 =?us-ascii?Q?v+dqrU7KaPikrTz2gWlcLz/+YO6XC2kwoIpGbD599v8YFA3XqELMAUs598xU?=
 =?us-ascii?Q?oiZPdSdH5uHbGic3iXhFU32hE/sB7zNs6g07oP6ZM8YpcyDI6XiK7sn25CSk?=
 =?us-ascii?Q?Qs4/438N/oMt5vVtTVC7KwwvAboMPu9RWVXQwbsD+wtSZMb6jGZM3s2Odz0s?=
 =?us-ascii?Q?cJhMHXurLc91E/Hs27qyX8TnskhJEev9KakO53XFZjIQ76Vn+IsHhqGpjjKa?=
 =?us-ascii?Q?FPfWT+awzKKPZOn8GyHREznxEabCKW+BYCUahBHJARFawUpREwxA4huUomdx?=
 =?us-ascii?Q?qGGcgBhmnCtieJStouugo0SImjyrpFjzOM+dZr9h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8dbc15-011a-438e-16cb-08da60eea4bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 14:32:10.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+vIT5a5qPxboU0Fth43aVdAXqpuFZXx3HjdwIa1lKb9g0BWicAPBkKoo4HmSvv7eWnQ+1+fqOJ3F6pFeogfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't take any patches that are unreleased in the ACPI specification (le=
gal reasons). Hopefully this will happen this month.

-----Original Message-----
From: Marc Zyngier <maz@kernel.org>=20
Sent: Thursday, July 07, 2022 5:52 AM
To: Jianmin Lv <lvjianmin@loongson.cn>; Rafael J Wysocki <rafael@kernel.org=
>; Moore, Robert <robert.moore@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; linux-kernel@vger.kernel.org; Han=
jun Guo <guohanjun@huawei.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.co=
m>; Jiaxun Yang <jiaxun.yang@flygoat.com>; Huacai Chen <chenhuacai@loongson=
.cn>
Subject: Re: [PATCH V14 00/15] irqchip: Add LoongArch-related irqchip drive=
rs

+ Rafael, Robert

On Sun, 03 Jul 2022 09:45:17 +0100,
Jianmin Lv <lvjianmin@loongson.cn> wrote:
>=20
> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit=20
> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its=20
> boot protocol LoongArch-specific interrupt controllers (similar to=20
> APIC) are already added in the ACPI Specification 6.5(which may be=20
> published in early June this year and the board is reviewing the draft).

Can the ACPI/ACPICA maintainers eyeball patch #1 in this series[1]? It adds=
 some new, yet unpublished ACPI MADT updates, and I need an Ack on that bef=
ore considering taking this series.

Patches 2 and 3 could also do with an Ack from the ACPI maintainers (though=
 Hanjun did review an earlier version).

Thanks,
	M.

[1] https://lore.kernel.org/r/1656837932-18257-2-git-send-email-lvjianmin@l=
oongson.cn

--
Without deviation from the norm, progress is not possible.
