Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BA4C80CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiCACOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiCACOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:14:05 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300045.outbound.protection.outlook.com [40.107.130.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718692BC7;
        Mon, 28 Feb 2022 18:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM79hbaPhmH6+LWARuaHo/uuV6liQi4aqaNFqoDuuTjcr4aDssEB3Nlfv3iZ/y83hQv3EC9igdMmlGHZ+0V3JirEsDQ4eT4OAdYFwBmm2hu1oPigRSPOGVgS1Bw9+htAHtQF+bUZf1ZojUnqF279dlINe6x8HRJJ8SRtsdrHRqPxMnOHSZAslMaxHdSQdQ7fw+4CNrcwojIr/zkaee6iI/xX9qCuQiPsGj8IrY8QPju5QGqzrVAPEnnnYfg02fe8+qgDQo4ZKE0ye3chsBLpnLaX20AI3WgTuLuSyr2j0cozL++DjutN/sIAI3mbw55fs4hdMre3ODCy0iGuQ4J2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB9u4PgBnnSJ1xJSkoaeqmegpVBT+RvzKohZU+6Z890=;
 b=ateXl5pp5WYtjhRV1ZWpTPMRwQJes3zjGOjTF+xeeXum3MRb7TmxrVnLZ28kxztwhMmySDd3PDJAu5vfwo9MAkHqg1xFgj+8X+LdFHTGBrz4KnAyBIRXgg9mOsBcKC/I0FnO6CDVZ/omlT/IpAi87UU46VjCNk+T1mUEJ9rvJpHGUSzI9WYrvpW+stAFy9/WkPktD8ll3zW1DYPFI9eL+LzDHopnUFy3y8Wt4skgV42ICeILGXMN/vt8gXXOMIvHfGw7F3xrWbcKjO92Ay/EwXe3oetw6td/Oxjt0lIXebg0PbqRQ4NYhwV6DWF4ywAH4nvBurTxMeUIUwcsL6f0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB9u4PgBnnSJ1xJSkoaeqmegpVBT+RvzKohZU+6Z890=;
 b=CsvdAAj0Am2jRqkzjdSkjUnHUJyX7UtjsIZ07W6g9H0tncyrWql2YkTTDF1Sa/wJiYy91WSXBGUBvqsxXMybvKOcBhroHlCd9eFhtBQVgK2IJsRGw46HO1VmBXo3PjbXIdSFy8Pu2YbDtH1DHNOG6W1J999Z3GiciBKRc3MFZJg=
Received: from HK0PR03MB3937.apcprd03.prod.outlook.com (2603:1096:203:97::12)
 by SG2PR03MB4638.apcprd03.prod.outlook.com (2603:1096:4:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Tue, 1 Mar
 2022 02:13:17 +0000
Received: from HK0PR03MB3937.apcprd03.prod.outlook.com
 ([fe80::d4cb:8c23:fd24:a205]) by HK0PR03MB3937.apcprd03.prod.outlook.com
 ([fe80::d4cb:8c23:fd24:a205%4]) with mapi id 15.20.5038.013; Tue, 1 Mar 2022
 02:13:17 +0000
From:   "CFLi0@nuvoton.com" <CFLi0@nuvoton.com>
To:     Rob Herring <robh@kernel.org>
CC:     "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] clk: nuvoton: Add dt-bindings header for ma35d1
Thread-Topic: [PATCH] clk: nuvoton: Add dt-bindings header for ma35d1
Thread-Index: AQHYJw+eIAFbyMLQxUihf/UpImgagaykpycAgAUuB6A=
Date:   Tue, 1 Mar 2022 02:13:17 +0000
Message-ID: <HK0PR03MB39376D6401C2D094ACB5E77EF2029@HK0PR03MB3937.apcprd03.prod.outlook.com>
References: <20220221104134.6300-1-cfli0@nuvoton.com>
 <Yhkocqu/44ne3QLE@robh.at.kernel.org>
In-Reply-To: <Yhkocqu/44ne3QLE@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38afd5fc-b040-49d4-8056-08d9fb290cc4
x-ms-traffictypediagnostic: SG2PR03MB4638:EE_
x-microsoft-antispam-prvs: <SG2PR03MB46383187B1E3988D69251397F2029@SG2PR03MB4638.apcprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyEcN/ViwGjjBT8ObPCa/lJGeI/r2k5HBfUETsjXcpck0Uk96f3dxIh+5TecGZoekRnKDWC120ijIv/kFKxjpFEAMr5k4RdaBQv6gJYQwg5C4jHCkMNmMrrgehmK1Q5gYe5BFFCghQuXj8knOiWafcuxHwzeccM2R0gvefxXte1ypWyZAbAQabRxhTO9uD6Thmrc3idm2tiPFW80lm+6yKqYm7ZMeRltuONGQfXAr/fyMbyxdfUSGjRfRU8CE9Rank28m4DDIOuGEBOB/oGeLXi/jKWtWd8UOhMXBBJoXrZoJP+KZWaPOuwjzK1TYlEXjSKoY1K72Jvj+qBBN4TYg4Mw7iYijX/vsUUmej3ldGR8GUx6kQttLj66MaQCtibBcBjwhbdOlEP/StdFMZiNaX8XdRrLKEAXI7a/y+lq8LYz9OtmdaFzHVGbyMdgNdUrakUf9aIn7lGeutU2zcTbjf4jDbEAAGEJpRwIBlmUhAJ5x8Eu9N8yhS1zmUG2NAVndluwM7dw4WvbT2WQsXYzrfKxbkNVRM/vfMvKnfX7ZZ5O4F/rI6bLLHDQlBuJp7/Ih2lgcTEiKTtMC/c3YKUAmVSDY5mLJnbjxILOaorEDi0OYWzFArEnXawfZqc8dLO3BmFYLKQA6+jb19H8xTisyR4SXeayhpH/pn51cZftzQUMXYt301IdooA15nuvp7cteBbCTu5zYiTM8fUamUBO48swHwfqsD7/hchb84NuCEVtUEf89SZWqm4ApR7Akdxd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3937.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(55016003)(6506007)(66446008)(186003)(66476007)(64756008)(8936002)(4326008)(316002)(33656002)(54906003)(6916009)(7696005)(66946007)(122000001)(508600001)(9686003)(71200400001)(86362001)(53546011)(38100700002)(76116006)(38070700005)(52536014)(83380400001)(5660300002)(26005)(66556008)(2906002)(138113003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAbDYJuXYANmj+sYoBJDbcJdp8CZyVq4rj4wOE2d8kx9v3oLNHFqpapQdNuq?=
 =?us-ascii?Q?FSoaUQhvOPmlnGwhDCSxNSekOwBmV8/qVT+hVR7qbfJ05lAQlHaEwpmuFDJ2?=
 =?us-ascii?Q?J8KMwybw/Ng7HESDFHTC2jDfv5wP1Z+WcWwecjOsYaJ1mZ2P4dFbo9UEZgHu?=
 =?us-ascii?Q?+3FA2aIMrMbLP7tUgPso0Is31pINxShXrd9jql/kEU4XH7sYNq6w/VziV15b?=
 =?us-ascii?Q?u7JpJ0FqN1ki1zTQMxHoVut1yDjI4+hZ8LmoI/njvQ8krHmcKP1mKlCA6Q9e?=
 =?us-ascii?Q?XsS8LPhKfFSWWe4EAInao9ZFTGlsjjFP0Nm7bHsNIwx9me/kJ8tkZqF4S2Mp?=
 =?us-ascii?Q?SxBvZ4IvjhiAvF5CmIPbtCF0+3l0Z5yFcBWhS1u7B87GpCncRpSEDBpBCNdr?=
 =?us-ascii?Q?7hTi9ABRi3kWsx5gmjzZ6xOiLCg/YTq3j2irAqSonXDfVQ8hWdDGECAVFiJ2?=
 =?us-ascii?Q?Nx6Zr0pchNbDRWPMAKIAx4wflm4jkNL5Bze1JjxxN1j/er0Nc/ajYny0UH4g?=
 =?us-ascii?Q?vG1ijBVJ4WMHLA+i6d406Xh85jIOKfE8Mc01cJlUHzQ63r/kQB4yN5z9uC68?=
 =?us-ascii?Q?4+8sO5Kr65feuA8wyQTO9iV93TtVsv57n4/arqVU3Xy9AbXGVZQLnG4v6W6i?=
 =?us-ascii?Q?Dfn79eia1L4deHDEWGwueSW6nkHnHVatDwjITFyXKhMFvbd80pfnJbcckkwX?=
 =?us-ascii?Q?8xJoqLCKf5wVDy5ddf6BBF3qiQ3rCTo1s1zx66ltxEqApw+dN1KunW8h2Zir?=
 =?us-ascii?Q?FTDviHudvQx46n+i72D3Ksb46tLh65PLZehR8se5YAdRZAOgv/ioxWpI5ni2?=
 =?us-ascii?Q?8S7nVibDWz0evJSWXd6IPMnpJmfx3iAR7eMj+0GwjQY/acZTfM2YA3VzOHXz?=
 =?us-ascii?Q?vQTUnQfCdLhUtLzIpa3x7u3rBmb96OGqZjPFUHIiAQ3quTfILCldOAf4dxpy?=
 =?us-ascii?Q?MsrXcUKZedU9pP0NJSHuNEtLNTeZkIGUjoQ1y9xL4D2D7jeUWDkWGAZKwtHZ?=
 =?us-ascii?Q?52Nx4O9cTRd08kHmArMPqSQaKBq8VSBuuvN6TIV7fE8Ec48Pdxt9QpFIkXCG?=
 =?us-ascii?Q?55fb1JbpEFc0hQyd6WcO00C3GdYhOe30HpkjpPoo1OYWB9pUQrFc593c3KS5?=
 =?us-ascii?Q?r+YiOROMv38RU/Pf6bn3zPjv0myE+SDrzMaZJjc1dgAbCnMWTDpL4hqHqGIe?=
 =?us-ascii?Q?c3HdLA/g4dE4l7WjV6OL4ISPA6rlvCfgyQWMJGW6vCm4+hkTshv7FP7pQxUQ?=
 =?us-ascii?Q?36mIYO2dPhmpiOELA51ihtoXs25iOLny3DnPeWzCJrxtLnRonmLZXko3DLCH?=
 =?us-ascii?Q?lkTGZpLuSr1RbVcjSu1GLnJceeVNrg24o0TLaQS4piAdG84MH/k7TFopxuse?=
 =?us-ascii?Q?AC8kQ++UV9hp6/V83LGBE1nXLOHvTn+nCKbkkPtTblw3APKpvQKKvn/yl6ti?=
 =?us-ascii?Q?peTcteZ59lryo2ZCDZcSJdD16eJmedLd7Ien3OAlOnMP2hcpLsrr5njecGK8?=
 =?us-ascii?Q?/9M3ccmbAGEsb7Tod9G9eFY8py0F3LTQUCH4qKaKsnGTxk3wh0ZowV1IeoVm?=
 =?us-ascii?Q?sYAG6i4JUHD2V6SidQgNnd/s8fdWd1dsWJNFMNcRI4KMR+iXb725oLNQL3N0?=
 =?us-ascii?Q?gXPK1IjwT0basYksCwf4k34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3937.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38afd5fc-b040-49d4-8056-08d9fb290cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 02:13:17.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKD/5QJBAoKlzYjgBpbAuDEfNoxJB0wHAV4L4vbIONuXVmqklPnm6PA34+wF57mN9QSW9TjAXSRnKMe79pDozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4638
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review and comments.
We are going to submit a series of patches for ma35d1, an ARM Cortex-A35 du=
al-core SOC.
Please ignore this patch. I will submit again with the corresponding bindin=
g schema and double license.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, February 26, 2022 3:05 AM
> To: MS10 CFLi0 <CFLi0@nuvoton.com>
> Cc: krzysztof.kozlowski@canonical.com; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH] clk: nuvoton: Add dt-bindings header for ma35d1
>
> On Mon, Feb 21, 2022 at 06:41:34PM +0800, CF Li wrote:
> > Add dt-bindings header with clock definitions for the ma35d1.
>
> Is there a corresponding binding schema? They'd normally be together.
>
> >
> > Signed-off-by: CF Li <cfli0@nuvoton.com>
> > ---
> >  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
> >  1 file changed, 262 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> >
> > diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/d=
t-
> bindings/clock/nuvoton,ma35d1-clk.h
> > new file mode 100644
> > index 000000000000..b8bbc7f9903f
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
> > @@ -0,0 +1,262 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>
> Dual license please.
>
> > +/*
> > + * Copyright (C) 2022 Nuvoton Technology Corporation.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_MA35D1_CLK_H
> > +#define _DT_BINDINGS_MA35D1_CLK_H
> > +
> > +/* Clock Sources */
> > +/* External and Internal oscillator clocks */
> > +#define        HXT                             0
> > +#define        HXT_GATE                        1
> > +#define        LXT                             2
> > +#define        LXT_GATE                        3
> > +#define        HIRC                            4
> > +#define        HIRC_GATE                       5
> > +#define        LIRC                            6
> > +#define        LIRC_GATE                       7
> > +
> > +/* PLLs */
> > +#define        CAPLL                           8
> > +#define        SYSPLL                          9
> > +#define        DDRPLL                          10
> > +#define        APLL                            11
> > +#define        EPLL                            12
> > +#define        VPLL                            13
> > +
> > +/* EPLL Divider */
> > +#define        EPLL_DIV2                       14
> > +#define        EPLL_DIV4                       15
> > +#define        EPLL_DIV8                       16
> > +
> > +/* CA35 CPU Clock, System Clock, AXI, HCLK and PCLK */
> > +#define        CA35CLK_MUX                     17
> > +#define        AXICLK_DIV2                     18
> > +#define        AXICLK_DIV4                     19
> > +#define        AXICLK_MUX                      20
> > +#define        SYSCLK0_MUX                     21
> > +#define        SYSCLK1_MUX                     22
> > +#define        SYSCLK1_DIV2                    23
> > +#define        HCLK0                           24
> > +#define        HCLK1                           25
> > +#define        HCLK2                           26
> > +#define        PCLK0                           27
> > +#define        PCLK1                           28
> > +#define        PCLK2                           29
> > +#define        HCLK3                           30
> > +#define        PCLK3                           31
> > +#define        PCLK4                           32
> > +
> > +/* Peripheral clocks */
> > +/* AXI and AHB Clocks */
> > +#define        USBPHY0                         33
> > +#define        USBPHY1                         34
> > +#define        DDR0_GATE                       35
> > +#define        DDR6_GATE                       36
> > +#define        CAN0_MUX                        37
> > +#define        CAN0_DIV                        38
> > +#define        CAN0_GATE                       39
> > +#define        CAN1_MUX                        40
> > +#define        CAN1_DIV                        41
> > +#define        CAN1_GATE                       42
> > +#define        CAN2_MUX                        43
> > +#define        CAN2_DIV                        44
> > +#define        CAN2_GATE                       45
> > +#define        CAN3_MUX                        46
> > +#define        CAN3_DIV                        47
> > +#define        CAN3_GATE                       48
> > +#define        SDH0_MUX                        49
> > +#define        SDH0_GATE                       50
> > +#define        SDH1_MUX                        51
> > +#define        SDH1_GATE                       52
> > +#define        NAND_GATE                       53
> > +#define        USBD_GATE                       54
> > +#define        USBH_GATE                       55
> > +#define        HUSBH0_GATE                     56
> > +#define        HUSBH1_GATE                     57
> > +#define        GFX_MUX                         58
> > +#define        GFX_GATE                        59
> > +#define        VC8K_GATE                       60
> > +#define        DCU_MUX                         61
> > +#define        DCU_GATE                        62
> > +#define        DCUP_DIV                        63
> > +#define        EMAC0_GATE                      64
> > +#define        EMAC1_GATE                      65
> > +#define        CCAP0_MUX                       66
> > +#define        CCAP0_DIV                       67
> > +#define        CCAP0_GATE                      68
> > +#define        CCAP1_MUX                       69
> > +#define        CCAP1_DIV                       70
> > +#define        CCAP1_GATE                      71
> > +#define        PDMA0_GATE                      72
> > +#define        PDMA1_GATE                      73
> > +#define        PDMA2_GATE                      74
> > +#define        PDMA3_GATE                      75
> > +#define        WH0_GATE                        76
> > +#define        WH1_GATE                        77
> > +#define        HWS_GATE                        78
> > +#define        EBI_GATE                        79
> > +#define        SRAM0_GATE                      80
> > +#define        SRAM1_GATE                      81
> > +#define        ROM_GATE                        82
> > +#define        TRA_GATE                        83
> > +#define        DBG_MUX                         84
> > +#define        DBG_GATE                        85
> > +#define        CKO_MUX                         86
> > +#define        CKO_DIV                         87
> > +#define        CKO_GATE                        88
> > +#define        GTMR_GATE                       89
> > +#define        GPA_GATE                        90
> > +#define        GPB_GATE                        91
> > +#define        GPC_GATE                        92
> > +#define        GPD_GATE                        93
> > +#define        GPE_GATE                        94
> > +#define        GPF_GATE                        95
> > +#define        GPG_GATE                        96
> > +#define        GPH_GATE                        97
> > +#define        GPI_GATE                        98
> > +#define        GPJ_GATE                        99
> > +#define        GPK_GATE                        100
> > +#define        GPL_GATE                        101
> > +#define        GPM_GATE                        102
> > +#define        GPN_GATE                        103
> > +
> > +/* APB Clocks */
> > +#define        TMR0_MUX                        104
> > +#define        TMR0_GATE                       105
> > +#define        TMR1_MUX                        106
> > +#define        TMR1_GATE                       107
> > +#define        TMR2_MUX                        108
> > +#define        TMR2_GATE                       109
> > +#define        TMR3_MUX                        110
> > +#define        TMR3_GATE                       111
> > +#define        TMR4_MUX                        112
> > +#define        TMR4_GATE                       113
> > +#define        TMR5_MUX                        114
> > +#define        TMR5_GATE                       115
> > +#define        TMR6_MUX                        116
> > +#define        TMR6_GATE                       117
> > +#define        TMR7_MUX                        118
> > +#define        TMR7_GATE                       119
> > +#define        TMR8_MUX                        120
> > +#define        TMR8_GATE                       121
> > +#define        TMR9_MUX                        122
> > +#define        TMR9_GATE                       123
> > +#define        TMR10_MUX                       124
> > +#define        TMR10_GATE                      125
> > +#define        TMR11_MUX                       126
> > +#define        TMR11_GATE                      127
> > +#define        UART0_MUX                       128
> > +#define        UART0_DIV                       129
> > +#define        UART0_GATE                      130
> > +#define        UART1_MUX                       131
> > +#define        UART1_DIV                       132
> > +#define        UART1_GATE                      133
> > +#define        UART2_MUX                       134
> > +#define        UART2_DIV                       135
> > +#define        UART2_GATE                      136
> > +#define        UART3_MUX                       137
> > +#define        UART3_DIV                       138
> > +#define        UART3_GATE                      139
> > +#define        UART4_MUX                       140
> > +#define        UART4_DIV                       141
> > +#define        UART4_GATE                      142
> > +#define        UART5_MUX                       143
> > +#define        UART5_DIV                       144
> > +#define        UART5_GATE                      145
> > +#define        UART6_MUX                       146
> > +#define        UART6_DIV                       147
> > +#define        UART6_GATE                      148
> > +#define        UART7_MUX                       149
> > +#define        UART7_DIV                       150
> > +#define        UART7_GATE                      151
> > +#define        UART8_MUX                       152
> > +#define        UART8_DIV                       153
> > +#define        UART8_GATE                      154
> > +#define        UART9_MUX                       155
> > +#define        UART9_DIV                       156
> > +#define        UART9_GATE                      157
> > +#define        UART10_MUX                      158
> > +#define        UART10_DIV                      159
> > +#define        UART10_GATE                     160
> > +#define        UART11_MUX                      161
> > +#define        UART11_DIV                      162
> > +#define        UART11_GATE                     163
> > +#define        UART12_MUX                      164
> > +#define        UART12_DIV                      165
> > +#define        UART12_GATE                     166
> > +#define        UART13_MUX                      167
> > +#define        UART13_DIV                      168
> > +#define        UART13_GATE                     169
> > +#define        UART14_MUX                      170
> > +#define        UART14_DIV                      171
> > +#define        UART14_GATE                     172
> > +#define        UART15_MUX                      173
> > +#define        UART15_DIV                      174
> > +#define        UART15_GATE                     175
> > +#define        UART16_MUX                      176
> > +#define        UART16_DIV                      177
> > +#define        UART16_GATE                     178
> > +#define        RTC_GATE                        179
> > +#define        DDR_GATE                        180
> > +#define        KPI_MUX                         181
> > +#define        KPI_DIV                         182
> > +#define        KPI_GATE                        183
> > +#define        I2C0_GATE                       184
> > +#define        I2C1_GATE                       185
> > +#define        I2C2_GATE                       186
> > +#define        I2C3_GATE                       187
> > +#define        I2C4_GATE                       188
> > +#define        I2C5_GATE                       189
> > +#define        QSPI0_MUX                       190
> > +#define        QSPI0_GATE                      191
> > +#define        QSPI1_MUX                       192
> > +#define        QSPI1_GATE                      193
> > +#define        SMC0_MUX                        194
> > +#define        SMC0_DIV                        195
> > +#define        SMC0_GATE                       196
> > +#define        SMC1_MUX                        197
> > +#define        SMC1_DIV                        198
> > +#define        SMC1_GATE                       199
> > +#define        WDT0_MUX                        200
> > +#define        WDT0_GATE                       201
> > +#define        WDT1_MUX                        202
> > +#define        WDT1_GATE                       203
> > +#define        WDT2_MUX                        204
> > +#define        WDT2_GATE                       205
> > +#define        WWDT0_MUX                       206
> > +#define        WWDT1_MUX                       207
> > +#define        WWDT2_MUX                       208
> > +#define        EPWM0_GATE                      209
> > +#define        EPWM1_GATE                      210
> > +#define        EPWM2_GATE                      211
> > +#define        I2S0_MUX                        212
> > +#define        I2S0_GATE                       213
> > +#define        I2S1_MUX                        214
> > +#define        I2S1_GATE                       215
> > +#define        SSMCC_GATE                      216
> > +#define        SSPCC_GATE                      217
> > +#define        SPI0_MUX                        218
> > +#define        SPI0_GATE                       219
> > +#define        SPI1_MUX                        220
> > +#define        SPI1_GATE                       221
> > +#define        SPI2_MUX                        222
> > +#define        SPI2_GATE                       223
> > +#define        SPI3_MUX                        224
> > +#define        SPI3_GATE                       225
> > +#define        ECAP0_GATE                      226
> > +#define        ECAP1_GATE                      227
> > +#define        ECAP2_GATE                      228
> > +#define        QEI0_GATE                       229
> > +#define        QEI1_GATE                       230
> > +#define        QEI2_GATE                       231
> > +#define        ADC_DIV                         232
> > +#define        ADC_GATE                        233
> > +#define        EADC_DIV                        234
> > +#define        EADC_GATE                       235
> > +
> > +#define        CLK_MAX                         236
> > +#define        MA35D1_CLK_MAX_IDX              236
> > +
> > +#endif/*_DT_BINDINGS_MA35D1_CLK_H*/
> > --
> > 2.17.1
> >
> > ________________________________
> > ________________________________
> >  The privileged confidential information contained in this email is int=
ended
> for use only by the addressees as indicated by the original sender of thi=
s
> email. If you are not the addressee indicated in this email or are not
> responsible for delivery of the email to such a person, please kindly rep=
ly to
> the sender indicating this fact and delete all copies of it from your com=
puter
> and network server immediately. Your cooperation is highly appreciated. I=
t is
> advised that any unauthorized use of confidential information of Nuvoton =
is
> strictly prohibited; and any information in this email irrelevant to the =
official
> business of Nuvoton shall be deemed as neither given nor endorsed by
> Nuvoton.
> >
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
