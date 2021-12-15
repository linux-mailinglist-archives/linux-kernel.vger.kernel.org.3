Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4332A4753FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhLOH7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:59:50 -0500
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:38385
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235592AbhLOH7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:59:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLJOBJgacT0abdI5tKI6YyQijsivxizw/+Hg7XuuP1uZPGL57hU2srsokeLeiqjT0vM3WN5yoyaPxrGKbUmH/LalMssdr1yRDhN0U54qKKXkKOCehCEomaSgapMlQxV8bTRjJFRz+f8Jfh/euvsch8vdn3R/dCvBTX9o6YKTrAUYCg2+6WHRoqn4PrXYvT1QHUysfEBwb6DFP0qyL6mxBZMwjvhbqdtHOpCaA4ON9NchPdvPuucrHgJNwMDVNeMebdkMq84Qo4wXUjDMrTuQ8KitT/30nSeGrYhrgJe2yjYjYnbKqvqLmfps2jbLdVCY6GaKyQ1h6zNEsUUtbdd6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlokQtyulz9MWnz1tHNu5apYgWHePZ3obofGhtG6RXM=;
 b=HEfDB8L/CLpLEwjwnrQtI0Ceyd3pCgqTAlAKKDg4bMiYFo0xMwT3CyFgwyqbCKyEPwMpEvVmi3ugWBvU04lVAUkrE8cvBVkLcwyIht1tTgJavNs3XII+zDmmORyiQLGao11ur4M4cfaVR1niUKiF/dj/qJ6toSJYCCZY90t4460rMoT8YaCZqY+gw63pR+pjsSaqXOsCOIaBUomnoBrcN9r0DDancQX4iUNBvFiCFc8sz3Vi5icIWxGku9TQCoI6sdX0AUiKimiffOx2YHZ+YLQgz6GXQJ+k+KJ4BtdCtlWvUBYkdsRJYaDBlfKu+GLKMuXHgj3QEdlvemI+p9ehIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlokQtyulz9MWnz1tHNu5apYgWHePZ3obofGhtG6RXM=;
 b=G5gYk2uR4yXY5RZ/N6EOtK/SLHxHKZq7Zm3ki8XVGdmj48Xu7HmKtbO3kJKLFihmjiICGS2hW6tpJsyQ+Bf3rej8K9RAxtH0zraTVhIkXaVe/WYPnRyTDBRDQpUhocAe+sZLmYlLmcW+o7JnGoNt+acpMcxLVvuN97C5ZVvyvkk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 07:59:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 15 Dec 2021
 07:59:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] arm64: mm: support bootparam max_addr
Thread-Topic: [PATCH 2/2] arm64: mm: support bootparam max_addr
Thread-Index: AQHX8X+RJl0WiuN0bE2TAI+j7pq7b6wzKOQAgAAAXXA=
Date:   Wed, 15 Dec 2021 07:59:45 +0000
Message-ID: <DU0PR04MB94179C41295FF369E5D755D488769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
 <20211215064559.2843555-2-peng.fan@oss.nxp.com>
 <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
In-Reply-To: <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35754672-8587-40ef-e0b0-08d9bfa0dc05
x-ms-traffictypediagnostic: DU2PR04MB8936:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8936B259076F876A9255B50B88769@DU2PR04MB8936.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJrAnRVK3o0jKKtnB/3dw3WRB2djbzCWKUKjgH1GyruDlZh47ZqmcyR0M+A++4LJyIaTCcEnrGHSutbgZFgLawxQRitgE7jVKQiMU/MzMOFxQ7ZWi6+I5drw/2uA40Nhjc2o2awWISrVnCpO2/eNEj9uA3rBWCXS9af+SOBIyhLAeIj4ZlC7JopOcQHGncfKRkoRoRAC9+f8F/ZgnEn7Hsoh+9hwLDcjXOavUg8hYoBvyRGnd53IHfCWsQTgppFs8q/p5z+dQ/Qs3mMO2FzWaB1EurPawU6Y18ysZ8yk+iOjLGneb7FQhglAh+tQA2/TDMMfdWsIAtaAWON1bMtu2K182Ku9SjmqRzo9LREgFythKWcfehCyZZT3g1fjIg5PfU77RMB+hpOzFO9N9WxWcFXuURLLP4EbYzXCGceE6QdxF7xsQmwHbS/r1CQznZdBrvtcysGuI1JHSQKcaSaY+S8Vc7kcash9gIdsQ+kBUiEGuog/yFbEBg5aJJtQt4IdEGWkYwN3Zfw1Tnfq1vZJvKwI6X8EVY7nPLNYmUPAt5Pj4HYGZ1IwGyA5XgcfxYBuvaTktHETx6vupJP1DzQDLbrg2r3vKdyWepAwnGl5GKXbfl6JpLUvIgRrjGcUsnbk1qDmyDF/HhRd3xBY9MaZvoocYyzMBbFtFhp6MPzKPNk8CUSYdg2+40knAV0AKw1QRsMCBm/8ZNejwoch1cQKMwBvjj4IoEA6+WiZejGXr5qX1tzE7oxzm3zELcAQIDeStbqMcxux9aNk035ofujWtcoPF9uwatyCb+8HgDltJSk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(45080400002)(8676002)(86362001)(83380400001)(55016003)(316002)(7696005)(9686003)(5660300002)(8936002)(7416002)(4326008)(966005)(44832011)(110136005)(508600001)(52536014)(54906003)(2906002)(71200400001)(33656002)(38070700005)(26005)(64756008)(6506007)(122000001)(66446008)(66476007)(66556008)(76116006)(186003)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VMjcZLJ1hMNt6VGWwUVzvQ5g4MLvIrmbwqetQxyI1HeZwMlptUjTSMkKJCCH?=
 =?us-ascii?Q?DmKbCe24X+96jFgXiva0aTL0V3xuipCeGaEdBMMMMZr0V2qrr9mObH0BWWTG?=
 =?us-ascii?Q?iKsM72iBMX7yYcyMc1EWnyTl5VQk17tPn811PNHcFA2G76tXDAgqFfUGTZUF?=
 =?us-ascii?Q?8NupyHz/a+D6ctiX9s6qp3zcmlr1Z6zHp1Sxvj1OmCP3ZWS849XghPMN+dJL?=
 =?us-ascii?Q?ri0V5GF9qSdLajs/laAhBt7FeaWhFYgeomtorRmlK1fm1KVYAcVh+oalNSBb?=
 =?us-ascii?Q?XN7jkGFhdTy8QFyeIcW2wznG6v+qp0xPnOywwG6FhbBZHUT4+dGDNc9eDwxe?=
 =?us-ascii?Q?4SZ17WbcAe9JsmpgEUGpu8mTNuwaf2hIngpP7/rk7PdwC9qR6/LdXDHfHcXz?=
 =?us-ascii?Q?8cO3oRD/HxECLRxy7jQEq7HnmH3URHjGv2MEj2pYZdRtRHo/GpEtY91SD8Ue?=
 =?us-ascii?Q?b1NcKgitL89nJGxu10GBdUHrNk6NFUdZHiWVRaPyKnfkNCGY0IubOROyc0Q/?=
 =?us-ascii?Q?wKCYKiVX/GPXQpkq8Q7+KntGNlAS2tv0TtD4Wmr0cXUcY8jb1kHBL/9Z8fRT?=
 =?us-ascii?Q?Og6FFe05HNQqHpcaMmpHFxJga/QkamjwWkCkFZ460mzv7oAFAifDDrF3TDFR?=
 =?us-ascii?Q?qMmpU9qiMBFd/yRl8LodHiYRBYLy/PZKTS24Ek3CzjDR9EV6jk7tp9BXXSYD?=
 =?us-ascii?Q?DDzzRwI7vxNOBTTdBZwYwR56QHQuzj49BNmUxU8ff2+tyw3NCsoiJfIPNmQ5?=
 =?us-ascii?Q?WokqJilJU3jb4fyKhDdGrYDywSdRgPjJ9Ykcex0najzVAvHIs82Ia+htKZ2z?=
 =?us-ascii?Q?kJLVLJDbo5GTEEU6Mi/45xYnrmObqr1Ed5cokEDGJTrkik5VrxY5gqalKr1E?=
 =?us-ascii?Q?fuGVxOhlWagqZjmNPcd3Xdlni6BkCJZCAJ2Pnkw+6Kws+Ck69kIiiCbNbGx9?=
 =?us-ascii?Q?F7PuPxpDMoeQE1K1usgCf7Lf4fer7GKDMdbVgSS4TM3e/DPKFsHPzEiBuWTM?=
 =?us-ascii?Q?952sCbBrCkb/MHnm15zdoBy0K8I9Rma0UNi4K1bVm8+8P55sRFXMAfWkMLoG?=
 =?us-ascii?Q?Rc4413AAYhHc4u6rMIs7AnP4Pr7vhPzNED/bFa0vgYk7QD3Ul12liN7YLC/A?=
 =?us-ascii?Q?iAGB37fCW1Xh66ZFAMTbSXmwuyGrAIIOkCd3ZPSdV+cuJgc4QTqN0pnq95xj?=
 =?us-ascii?Q?F80OuzjPB+8XqNhSukt7Qv8F68e+zR+ex1QTwmNK6PGkLrX25S4icHlbntbi?=
 =?us-ascii?Q?m1B//ppd6yIGe3Oo/QCCQvzBIDqE6C0HyXNqgCMEW1l1gGKe+2NncOmT2Ezn?=
 =?us-ascii?Q?BEwJNXqTN1bXVgAta/W2pzGX6aE4gj0mv+prTFAzzKV1S4aHLf/LPRrLiEaW?=
 =?us-ascii?Q?yoRdgV3EOSc1TAOdrFPqflY2e6C+qYuBT5qCWsW7xTyTtURLeURtOgcgC2A2?=
 =?us-ascii?Q?bOUxGNRz8U2tNiIjae1p3eig04feW0vyrAKmUiverNcCLC0fm223mf5rhcOq?=
 =?us-ascii?Q?npHlU9M3lG7V4jHjRH3fBJBHCCE3MMPKBBNehTNCK2TfD+c4LtPbxS/llRr3?=
 =?us-ascii?Q?R9m0WynI6EeUNAx56/9Vs/+1ZjcpVLr5yIF9OxsJ/4r7Lv6SzDRqvwSTCNVi?=
 =?us-ascii?Q?GYuPQv98KLTpo1AC8B2ae2Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35754672-8587-40ef-e0b0-08d9bfa0dc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 07:59:45.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7UBZDZ4TTrX4JY+8pkQEKazSGyPYtfgRkpNpTQ6axYBdwUXcGPRSugxG735ulLLiRKD4ockxvUvJ/TAq3C5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
>=20
> On Wed, 15 Dec 2021 at 07:56, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is a "mem=3D[x]" boot parameter, but when there is a whole
> > reserved by secure TEE, the continuous DRAM area is split with two
> memblocks.
> >
> > For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
> > [0x50000000, 0x51000000), the memblock will be split into [0x40000000,
> > 0x50000000) and [0x51000000, 0xffffffff].
> >
> > If pass "mem=3D1024MB", the actually max addr will be 0x81000000.
> > However if need the max addr be 0x80000000, mem=3D1008MB should be
> used.
> >
> > There also might be multiple other holes that no visible to Linux,
> > when we wanna to limit the max addr usable by Linux, using
> > "max_addr=3D[X]" is much easier than "mem=3D[X]"
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> mem=3D is a hack already, please don't add another one. Limiting the memo=
ry
> like this is far too tricky, given that the kernel itself and the initrd =
could end up
> in memory that is excluded, and we have to go and fix things up if that
> happens.

We wanna to use the reserved memory with request_mem_region, but with
commit 86588296acbfb1 ("fdt: Properly handle "no-map" field in the memory r=
egion ")

request_mem_region will fail, because the reserved memory are now as
kernel memory.

So we use "mem=3DX" to work around the issue, but "mem=3DX" is not user fri=
endly
compared with "max_addr=3D" when there are multiple holes used by others.

Thanks,
Peng.

>=20
>=20
> > ---
> >  arch/arm64/mm/init.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > db63cc885771..3364b5e7a7fe 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
> > EXPORT_SYMBOL(pfn_is_map_memory);
> >
> >  static phys_addr_t memory_limit __ro_after_init =3D PHYS_ADDR_MAX;
> > +static phys_addr_t max_addr __ro_after_init =3D PHYS_ADDR_MAX;
> >
> >  /*
> >   * Limit the memory size that was specified via FDT.
> > @@ -189,6 +190,18 @@ static int __init early_mem(char *p)  }
> > early_param("mem", early_mem);
> >
> > +static int __init set_max_addr(char *p) {
> > +       if (!p)
> > +               return 1;
> > +
> > +       max_addr =3D memparse(p, &p) & PAGE_MASK;
> > +       pr_notice("Memory max addr set to 0x%llx\n", max_addr);
> > +
> > +       return 0;
> > +}
> > +early_param("max_addr", set_max_addr);
> > +
> >  void __init arm64_memblock_init(void)  {
> >         s64 linear_region_size =3D PAGE_END -
> > _PAGE_OFFSET(vabits_actual); @@ -253,6 +266,9 @@ void __init
> arm64_memblock_init(void)
> >                 memblock_add(__pa_symbol(_text), (u64)(_end -
> _text));
> >         }
> >
> > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > +               memblock_cap_memory_range(0, max_addr);
> > +
> >         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size)
> {
> >                 /*
> >                  * Add back the memory we just removed if it results
> > in the @@ -427,4 +443,9 @@ void dump_mem_limit(void)
> >         } else {
> >                 pr_emerg("Memory Limit: none\n");
> >         }
> > +
> > +       if (max_addr !=3D PHYS_ADDR_MAX)
> > +               pr_emerg("Max addr: 0x%llx\n", max_addr);
> > +       else
> > +               pr_emerg("Max addr: none\n");
> >  }
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flist=
s
> > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D04%
> 7C0
> >
> 1%7Cpeng.fan%40nxp.com%7C3ad0ef697ad64542556208d9bf9d1e1f%7C68
> 6ea1d3bc
> >
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637751503805222488%7CUnknow
> n%7CTWFpbG
> >
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%
> >
> 3D%7C3000&amp;sdata=3DiKVO4PUPnaRr%2B5gHcXxaaRxBt%2BK%2Fjytg8eQ
> dCqgqh5o%
> > 3D&amp;reserved=3D0
