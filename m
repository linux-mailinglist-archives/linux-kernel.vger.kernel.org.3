Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427B849C59C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiAZIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:55:58 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:23104
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231173AbiAZIz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:55:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyWPhtLfhyrdVWQHw9jnS5zrXh1UXZPI3McFFqO/fBGx8BhkcWsK+nrH5d40PTlz90Ay+whMHeCgvmCyB+bceDB0eu5cZeNMZ6kMgBnuDKrQ7uEuvJSUdp9+S4kKnT8zBg6xvnEiO+cYu4mXQSt+RdcXzv3UtN8N6KoEZ0k6YDJSamf+dWHlWeZRc3FzU/6ss7fOHGN5EqbxG/HKMrif+fYgATnaqUafkXJMubUzij7nn4FIA8oAVGK4zVE2uXX6koMJKRa/6ewrwOtSIMAFBsTME96oEWrCI0t2tBNDixLpgsziDHmO10pQgniEXArICAdgmhTAKKUT8OKuqgJJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/f2HUxCq0UgcdW2taiLdXo+CgSVvS8+83WMPPzRJQk=;
 b=RBYJ31QC2RshVck/IXzI8n0aG47BIa9vMHknLIB8nLIHsaYE6DUqAsonT03evx+MboFfOFqEKRV60OZboLGoI1faZSFH/ZO7ysXRcy7h6DuYEynkwZuM2WdZz525hzloRCCIPfGJIOw31EKZwZCJxPVyWioLMZafyCXj4QZBq4R2IfxGWNe1PGtPfeDOXxrlHov6el4Sf9D6hSLp/MRwwUdvCmzs7NpjuOSHKuXmewjCLbosXAyAkLGvRLQVGYsLpYhfM2QthoUbdyb674/AKq2rs3psL3FQYAvkDpPVbEayXi/wxTSGffW+NhLRN5k2k+9AF3FcnqwJ0yxYo/c6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/f2HUxCq0UgcdW2taiLdXo+CgSVvS8+83WMPPzRJQk=;
 b=rvcp2xRGmDgpdrEaJ1fOUDn9tq7WX45ZoYLu2DxDnSSyS84DvrA80+3Oyx9yXibiYd4Eohyq8wYrQYEyOaB/sjcBhIoLJaR1zAV25vfYhmqO6mo3GfEZqNPvdDFxpsoM58wVzkunnDVLskxlFJz2+eEISXQh4knMtbIYXdmYOaI=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 08:55:53 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4dad:8ae8:e38e:1ccf]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4dad:8ae8:e38e:1ccf%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 08:55:52 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [PATCH v3 8/8] arm64: dts: ls1028a-qds: add overlays for various
 serdes protocols
Thread-Topic: [PATCH v3 8/8] arm64: dts: ls1028a-qds: add overlays for various
 serdes protocols
Thread-Index: AQHX8M2Q9BBvqqe7XkOlYvrFX4zXI6x1PUoAgAAAhgA=
Date:   Wed, 26 Jan 2022 08:55:52 +0000
Message-ID: <AS8PR04MB8946E671ABAF95E88E26D9038F209@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-9-leoyang.li@nxp.com> <20220126083348.GG4686@dragon>
In-Reply-To: <20220126083348.GG4686@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f017f74-e8a2-40e4-c611-08d9e0a9a871
x-ms-traffictypediagnostic: DB7PR04MB4298:EE_
x-microsoft-antispam-prvs: <DB7PR04MB429813F50D93603EB62F1BCA8F209@DB7PR04MB4298.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btOSoNKEtDWn92wtsfcuTm4yN7K9dNSBQ6eVA5RVkTH1VZ4gbNMY9ItJsoIDSdfLQv8wEEFmfQb75VEpz+RRilQI4ijMnmcxQs08SzpU18WYTnHMYboMl4mxzOoQ5veI+vGt+mMJ3Ii58nCUlGCkAYLmzTSa6Q9ilAWHAHAYyIz3eQFshds2RFsC7umaz6hgg0M1MtmrJrLl4wSUKsbokHxsYqZk95/ToenVIdJJods+V90qyVCAsHULOQQ4eI+Vx1fuPR8woojp+7qp5pgGlUjofdcAF3JWq/btCzWV/kJKLEl5IG55t5a6rCpnyNb9aWSNi85GiOgug4i1+hsulOouskKmxAI1aI+52QEoNrjrOd7PlUegmR3IsR51edlGWGRPxa+s/6uU/llB7q5EWiYK5JnAwPHvTr3k206M0WNYrLNOl66u4+l9TkFrWLi6qAiqeXAJaLxmMjmbeGlLK84jEN1Kef7bXPZxgYFTjbIaSqECWUXOz3Mrozi6xiwkkG77aQvxZE1MvGQIRv3Wc53NO/pi1BoCLUHUu2C9Y+zAc51vFmVwgHRBHEslK0hNam47icAXsBqsiYZsaEk/zdgg8apMXu4Ziwhh/zSZMXRI7AUDS+tm2wZqhQZ4sg4cyqzdbUB5d7Oc+sckSwAQizkg3CgqtuNVJyeKdhFBG5XlUFFeFosIOtMaKnNTdbib29jlUS4WKy/bZsImEDvMOX2sRxiFZc9w3YpCLUpPkI9zgBejtunleoCjoPKVRCGHwU1JdBPBSBKGvPTNy8+SxHK+zcOPhiQDWRJv/pjwrQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(45080400002)(9686003)(83380400001)(966005)(508600001)(186003)(26005)(86362001)(2906002)(33656002)(38100700002)(5660300002)(4326008)(30864003)(122000001)(71200400001)(38070700005)(8936002)(52536014)(8676002)(6506007)(54906003)(55016003)(316002)(66946007)(66476007)(66556008)(66446008)(64756008)(76116006)(7696005)(6916009)(559001)(579004)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NtfuxD/Zj0zmPEWil1Blq5SH4w9VZMAR6n6xxGV6O694cC4ihkbDXTz6Qn9U?=
 =?us-ascii?Q?fe/wOfDYCMwDZloPZxQC6Y4wFwP6czm0CqcaG4oQA70Q/E+0nsxrHZD9NrSI?=
 =?us-ascii?Q?zM+6v84F6QXB+akEd6qGMR8ORZwC44+eq07v7xhXg3B14yzxRQ2DDb+ZxU0V?=
 =?us-ascii?Q?WHyn33S6xEQv5GrAS0LLxZ9wQRwxzj+Hw8q9v0ADS0HGAbTMPyx32xs+lsTw?=
 =?us-ascii?Q?W5N2aP9RvC/iGMQIIRUrOaK3RiqZVtCz8xdetmPvXgITazcWfj8Z0kQ4dDr9?=
 =?us-ascii?Q?yuEt1NEqrv3NATpgM6+SQmPbyJ4xk795hRMPn76nOhbuJaN3LJv2JsF9pPxL?=
 =?us-ascii?Q?EEcoCBONWPC8WQGEAorNlQcX3HL17ujytKYStSNPwwvjVsvwsMVX20ShZBw2?=
 =?us-ascii?Q?XQHedaUSpC2QO92jWVlQRfQyse1Uy73o5JtwGs5PVkQlJKfOoUXu5EFGGZlt?=
 =?us-ascii?Q?ulwHLajahHcIVNl1rNfj9BOZgQrNPKAClFa8uOeQUoVGX6I54BURjGZyZaSj?=
 =?us-ascii?Q?PYkyiUC46m3IyX0WH36uhjmeDeabi/n8/uTX2ZcGbKO5MU9Beej90FELEbRf?=
 =?us-ascii?Q?gadVi23BZum+ZuJ3OITRJqztYHGq1iiJOK2Co/QjwKlifRq2ym/bLqmyJwb2?=
 =?us-ascii?Q?n3/ceHfJhIW69p9aPbYk5JLobUbTS/Dxqx8TULta3qNQYY20dGExSfJrtbbl?=
 =?us-ascii?Q?+sB1PdbISl4VbmMprYmWYduQO1QqSmcKQmnNSe4BWfgcBHQWMSq2rnO0RIB4?=
 =?us-ascii?Q?3m0kq7hy3xk1D6wQzmGxh0t0L7NYFDICvXIDd03TvUtrPcGtjCUtMFkheg9b?=
 =?us-ascii?Q?57n+RL7usauzcyP4dBCf7/+2EZZya2Voiz4jcO0KaIPkLa/uKG3fFJCFaszv?=
 =?us-ascii?Q?XtS33oMzjdUEOkzvL3R6khyG+yNNyQk6Ji2daf+9fbbrhLXED1fbXzhH5peg?=
 =?us-ascii?Q?5bGkK7iODwByVqC8B8kuoFYipl8osLoiKMwCOY/f3Ghf8C0JU1fXWH4tQpg/?=
 =?us-ascii?Q?UD+PuoUqUghJTFNd5+d1Fl/Chwjv5pRjl+laBXw3Ik11sl7XLwyYk3scK0Kr?=
 =?us-ascii?Q?yXumrf4mlmy3lmlL2xGzvf99f4qM14l2Rd8Qq0EMqmAQvxMNP/DkiIAZw/FK?=
 =?us-ascii?Q?okcwYPT6IOioW5FNhUvqmV1dZnl9vRN369nDagntuDsQEk9PFQ0AyRVFkqLr?=
 =?us-ascii?Q?8zxnE2MHILoDIEiWAignQaSe5Y6l5thsgt4Q2oKObPYyxx1JmZRCXQ5nTF8x?=
 =?us-ascii?Q?JH39WgX+F1Wn2LGXpVxVUQfJrD1ViHlnQ2PQRlL4tH53WB213On3YlrnJzZI?=
 =?us-ascii?Q?Gy492c3FjGRRHXquBZ/jMsQEjmbXCrbaAeWdMbsIRt7rXldNnIZrhjjaUbxr?=
 =?us-ascii?Q?0RJHEHtXR+JQLXo9vBeQxgpb/tCyo9hrV3BHksWtcVCr7k4EC1YdF9XN4H4R?=
 =?us-ascii?Q?pPXMmS4DDMFyb2JDxb3rLl1czNDJO0PM0oFw6jjOxNnddlDyBXGmDoiRBJGj?=
 =?us-ascii?Q?8Kn+SmWSn9VTipSHok1H864o+i/y8ZpsrI8law9aEFOYakTA4LgQ9YMjCwTq?=
 =?us-ascii?Q?pDFUmqGyG9REwS3lUrLfEupHl4lR3yI0wkyqGpwRNKWTkXkd+JBmNEtXl8M6?=
 =?us-ascii?Q?Ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f017f74-e8a2-40e4-c611-08d9e0a9a871
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 08:55:52.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ejt3ajf9znPbgTof2rAFPlE06BT2t2NGIqCr3FSZZ7sg7KSLxfLdXVF1nPyz4lheKxBhtkC/dnEVidSzqm984A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Wednesday, January 26, 2022 4:34 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Alexandru Marginean <alexandru.marginean@nxp.com>; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Jason
> Liu <jason.hui.liu@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>
> Subject: Re: [PATCH v3 8/8] arm64: dts: ls1028a-qds: add overlays for var=
ious
> serdes protocols
>=20
> Hi Leo,
>=20
> On Tue, Dec 14, 2021 at 03:32:40AM -0600, Li Yang wrote:
> > From: Alex Marginean <alexandru.marginean@nxp.com>
> >
> > Add overlays for various serdes protocols on LS1028A QDS board using
> > different PHY cards.  These should be applied at boot, based on serdes
> > configuration.  If no overlay is applied, only the RGMII interface on
> > the QDS is available in Linux.
> >
> > Building device tree fragments requires passing the "-@" argument to
> > dtc, which increases the base dtb size and might cause some platforms
> > to fail to store the new binary. To avoid that, it would be nice to
> > only pass "-@" for the platforms where fragments will be used, aka
> > LS1028A-QDS. One approach suggested by Rob Herring is used here:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fpatchwork%2Fpatch%2F821645%2F&amp;data=3D04%7C01%7
> Cleoyang
> > .li%40nxp.com%7C05d70cc78d8e432dfb8908d9e0a69c47%7C686ea1d3bc2b
> 4c6fa92
> >
> cd99c5c301635%7C0%7C0%7C637787828474973256%7CUnknown%7CTWFpb
> GZsb3d8eyJ
> >
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000
> >
> &amp;sdata=3DFF7G4XlUbxPoZ%2FPu2ERMSe2I5tg%2F8R1nm0wx8W7dxc4%3
> D&amp;rese
> > rved=3D0
> >
> > Also moved the enet* override nodes in dts file to be in alphabetic ord=
er.
> >
> > Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |  16 +++
> >  .../dts/freescale/fsl-ls1028a-qds-13bb.dts    | 113 ++++++++++++++++++
> >  .../dts/freescale/fsl-ls1028a-qds-65bb.dts    | 108 +++++++++++++++++
> >  .../dts/freescale/fsl-ls1028a-qds-7777.dts    |  82 +++++++++++++
> >  .../dts/freescale/fsl-ls1028a-qds-85bb.dts    | 107 +++++++++++++++++
> >  .../dts/freescale/fsl-ls1028a-qds-899b.dts    |  75 ++++++++++++
> >  .../dts/freescale/fsl-ls1028a-qds-9999.dts    |  79 ++++++++++++
> >  .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  19 ++-
> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   2 +-
> >  9 files changed, 595 insertions(+), 6 deletions(-)  create mode
> > 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
> >  create mode 100644
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
> >  create mode 100644
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
> >  create mode 100644
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
> >  create mode 100644
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
> >  create mode 100644
> > arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index a14a6173b765..f518eb1e1142 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -1,4 +1,14 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +
> > +# required for overlay support
> > +DTC_FLAGS_fsl-ls1028a-qds :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-13bb :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-65bb :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-7777 :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-85bb :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-899b :=3D -@
> > +DTC_FLAGS_fsl-ls1028a-qds-9999 :=3D -@
> > +
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-frdm.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-frwy.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1012a-oxalis.dtb @@ -11,6
> > +21,12 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D
> > fsl-ls1028a-kontron-sl28-var2.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D
> > fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-kontron-sl28-var4.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-13bb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-65bb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-7777.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-85bb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-899b.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-qds-9999.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1028a-rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls1043a-rdb.dtb diff --git
> > a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
> > new file mode 100644
> > index 000000000000..f748a2c12a70
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 13bb
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board with lane B rework.
> > + * Requires a SCH-30841 card with lane A of connector rewired to PHY l=
ane
> C.
> > + * Set-up is a SCH-30842 card in slot 1 and SCH-30841 in slot 2.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
>=20
> I cannot find this mdio_slot1 node (and mdio_slot2 below) in any upstream
> device tree.  We are not going to maintain a bunch of overlays which are =
only
> meant to apply on the out-of-tree DTs.

Sorry the patch adding mdio_slot nodes has been missed from the tree mainte=
nance.

>=20
> So please either submit those missing device nodes in the base DT, or I w=
ill
> have to revert the patch.

Will submit the patch right away.

>=20
> Shawn
>=20
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			slot1_sgmii: ethernet-phy@2 {
> > +				/* AQR112 */
> > +				reg =3D <0x2>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&enetc_port0>;
> > +
> > +		__overlay__ {
> > +			phy-handle =3D <&slot1_sgmii>;
> > +			phy-mode =3D "usxgmii";
> > +			managed =3D "in-band-status";
> > +			status =3D "okay";
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mdio_slot2>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* 4 ports on AQR412 */
> > +			slot2_qxgmii0: ethernet-phy@0 {
> > +				reg =3D <0x0>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot2_qxgmii1: ethernet-phy@1 {
> > +				reg =3D <0x1>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot2_qxgmii2: ethernet-phy@2 {
> > +				reg =3D <0x2>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot2_qxgmii3: ethernet-phy@3 {
> > +				reg =3D <0x3>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@3 {
> > +		target =3D <&mscc_felix_ports>;
> > +
> > +		__overlay__ {
> > +			port@0 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qxgmii0>;
> > +				phy-mode =3D "usxgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qxgmii1>;
> > +				phy-mode =3D "usxgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qxgmii2>;
> > +				phy-mode =3D "usxgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@3 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qxgmii3>;
> > +				phy-mode =3D "usxgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@4 {
> > +		target =3D <&mscc_felix>;
> > +
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
> > new file mode 100644
> > index 000000000000..8ffb707a1576
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 69xx
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board with lane B rework.
> > + * Requires a SCH-30842 card in slot 1 and a SCH-28021 card in slot 2.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			slot1_sgmii: ethernet-phy@2 {
> > +				/* AQR112 */
> > +				reg =3D <0x2>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&enetc_port0>;
> > +
> > +		__overlay__ {
> > +			phy-handle =3D <&slot1_sgmii>;
> > +			phy-mode =3D "2500base-x";
> > +			managed =3D "in-band-status";
> > +			status =3D "okay";
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mdio_slot2>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* 4 ports on VSC8514 */
> > +			slot2_qsgmii0: ethernet-phy@8 {
> > +				reg =3D <0x8>;
> > +			};
> > +
> > +			slot2_qsgmii1: ethernet-phy@9 {
> > +				reg =3D <0x9>;
> > +			};
> > +
> > +			slot2_qsgmii2: ethernet-phy@a {
> > +				reg =3D <0xa>;
> > +			};
> > +
> > +			slot2_qsgmii3: ethernet-phy@b {
> > +				reg =3D <0xb>;
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@3 {
> > +		target =3D <&mscc_felix_ports>;
> > +
> > +		__overlay__ {
> > +			port@0 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii0>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii1>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii2>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@3 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii3>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@4 {
> > +		target =3D <&mscc_felix>;
> > +
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
> > new file mode 100644
> > index 000000000000..eb6a1e674f10
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 7777
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board without lane B rework.
> > + * Requires a SCH-30841 card without lane A/C rewire and with a FW
> > +with muxing
> > + * disabled, plugged in slot 1.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* 4 ports on AQR412 */
> > +			slot1_sxgmii0: ethernet-phy@0 {
> > +				reg =3D <0x0>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot1_sxgmii1: ethernet-phy@1 {
> > +				reg =3D <0x1>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot1_sxgmii2: ethernet-phy@2 {
> > +				reg =3D <0x2>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +
> > +			slot1_sxgmii3: ethernet-phy@3 {
> > +				reg =3D <0x3>;
> > +				compatible =3D "ethernet-phy-ieee802.3-c45";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&mscc_felix_ports>;
> > +
> > +		__overlay__ {
> > +			port@0 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sxgmii0>;
> > +				phy-mode =3D "2500base-x";
> > +			};
> > +
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sxgmii1>;
> > +				phy-mode =3D "2500base-x";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sxgmii2>;
> > +				phy-mode =3D "2500base-x";
> > +			};
> > +
> > +			port@3 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sxgmii3>;
> > +				phy-mode =3D "2500base-x";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mscc_felix>;
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
> > new file mode 100644
> > index 000000000000..8e90c3088ba1
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 85bb
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board with lane B rework.
> > + * Requires a SCH-24801 card in slot 1 and a SCH-28021 card in slot 2.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			slot1_sgmii: ethernet-phy@1c {
> > +				/* 1st port on VSC8234 */
> > +				reg =3D <0x1c>;
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&enetc_port0>;
> > +
> > +		__overlay__ {
> > +			phy-handle =3D <&slot1_sgmii>;
> > +			phy-mode =3D "sgmii";
> > +			managed =3D "in-band-status";
> > +			status =3D "okay";
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mdio_slot2>;
> > +
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* 4 ports on VSC8514 */
> > +			slot2_qsgmii0: ethernet-phy@8 {
> > +				reg =3D <0x8>;
> > +			};
> > +
> > +			slot2_qsgmii1: ethernet-phy@9 {
> > +				reg =3D <0x9>;
> > +			};
> > +
> > +			slot2_qsgmii2: ethernet-phy@a {
> > +				reg =3D <0xa>;
> > +			};
> > +
> > +			slot2_qsgmii3: ethernet-phy@b {
> > +				reg =3D <0xb>;
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@3 {
> > +		target =3D <&mscc_felix_ports>;
> > +
> > +		__overlay__ {
> > +			port@0 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii0>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii1>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii2>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@3 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot2_qsgmii3>;
> > +				phy-mode =3D "qsgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@4 {
> > +		target =3D <&mscc_felix>;
> > +
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
> > new file mode 100644
> > index 000000000000..5d0a094e6c44
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 85xx
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board without lane B rework.
> > + * Requires a SCH-24801 card in slot 1.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* VSC8234 */
> > +			slot1_sgmii0: ethernet-phy@1c {
> > +				reg =3D <0x1c>;
> > +			};
> > +
> > +			slot1_sgmii1: ethernet-phy@1d {
> > +				reg =3D <0x1d>;
> > +			};
> > +
> > +			slot1_sgmii2: ethernet-phy@1e {
> > +				reg =3D <0x1e>;
> > +			};
> > +
> > +			slot1_sgmii3: ethernet-phy@1f {
> > +				reg =3D <0x1f>;
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&enetc_port0>;
> > +		__overlay__ {
> > +			phy-handle =3D <&slot1_sgmii0>;
> > +			phy-mode =3D "sgmii";
> > +			managed =3D "in-band-status";
> > +			status =3D "okay";
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mscc_felix_ports>;
> > +		__overlay__ {
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii1>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii2>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@3 {
> > +		target =3D <&mscc_felix>;
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > new file mode 100644
> > index 000000000000..1ef743c48e84
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree fragment for LS1028A QDS board, serdes 85xx
> > + *
> > + * Copyright 2019-2021 NXP
> > + *
> > + * Requires a LS1028A QDS board without lane B rework.
> > + * Requires a SCH-24801 card in slot 1.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +	fragment@0 {
> > +		target =3D <&mdio_slot1>;
> > +		__overlay__ {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			/* VSC8234 */
> > +			slot1_sgmii0: ethernet-phy@1c {
> > +				reg =3D <0x1c>;
> > +			};
> > +
> > +			slot1_sgmii1: ethernet-phy@1d {
> > +				reg =3D <0x1d>;
> > +			};
> > +
> > +			slot1_sgmii2: ethernet-phy@1e {
> > +				reg =3D <0x1e>;
> > +			};
> > +
> > +			slot1_sgmii3: ethernet-phy@1f {
> > +				reg =3D <0x1f>;
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@1 {
> > +		target =3D <&mscc_felix_ports>;
> > +		__overlay__ {
> > +			port@0 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii0>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@1 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii1>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@2 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii2>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +
> > +			port@3 {
> > +				status =3D "okay";
> > +				phy-handle =3D <&slot1_sgmii3>;
> > +				phy-mode =3D "sgmii";
> > +				managed =3D "in-band-status";
> > +			};
> > +		};
> > +	};
> > +
> > +	fragment@2 {
> > +		target =3D <&mscc_felix>;
> > +		__overlay__ {
> > +			status =3D "okay";
> > +		};
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > index 782853a449cc..177bc1405f0f 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > @@ -211,6 +211,16 @@ &duart1 {
> >  	status =3D "okay";
> >  };
> >
> > +&enetc_port1 {
> > +	phy-handle =3D <&qds_phy1>;
> > +	phy-mode =3D "rgmii-id";
> > +	status =3D "okay";
> > +};
> > +
> > +&enetc_port2 {
> > +	status =3D "okay";
> > +};
> > +
> >  &esdhc {
> >  	status =3D "okay";
> >  };
> > @@ -326,17 +336,16 @@ rtc@51 {
> >  	};
> >  };
> >
> > -&enetc_port1 {
> > -	phy-handle =3D <&qds_phy1>;
> > -	phy-mode =3D "rgmii-id";
> > +&lpuart0 {
> >  	status =3D "okay";
> >  };
> >
> > -&lpuart0 {
> > +&lpuart1 {
> >  	status =3D "okay";
> >  };
> >
> > -&lpuart1 {
> > +&mscc_felix_port4 {
> > +	ethernet =3D <&enetc_port2>;
> >  	status =3D "okay";
> >  };
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 5a7b26a1bad2..5bb8c26e0825 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -1115,7 +1115,7 @@ mscc_felix: ethernet-switch@0,5 {
> >  				interrupts =3D <GIC_SPI 95
> IRQ_TYPE_LEVEL_HIGH>;
> >  				status =3D "disabled";
> >
> > -				ports {
> > +				mscc_felix_ports: ports {
> >  					#address-cells =3D <1>;
> >  					#size-cells =3D <0>;
> >
> > --
> > 2.25.1
> >
