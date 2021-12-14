Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323B473A45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbhLNBin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:43 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237640AbhLNBik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHwxYSYCyO5ogPBB/yBfNlIlWGmry8Us9qjA4FP9stZmD8RP6XNpMNgujYP7CpYyV+tfMGMB7UbYIqyCXGyehYmwt80rGmrxuK5NxnbqF8uV5pPstNNXQuzsCvrqtt+HGKGkuCo4CIhMnWUz9dCpjMNU5TFiuL5otuvmwhIB1xUF0Rye6KV76eq9sr1F0QE384naJtB2bI/ZL1sfnX06PeTIzOPKXAy8v99pDaegx2KO1bFT26ZflnOYSy2xKkJZIzVtlJC3Esb7qXQWtgTKmMpQOp/YS+YpFQNX7DL4K1HJjKd+8HdQX/vDeqKk2e2P6mboma+SH28twE99At44ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngN5hoV5ELh9icSGKLXPvOhloA17bXGHC+gEQYm/sp4=;
 b=Kbv1tpBRO8AVgFmzvs4zmiGLGZW1WFrdJggCHUUsTQpwSjo/yjE5uj86Y8ETcAVMhyJY1d3OOp3PiiFZFgXWe3DJwhTaYUE8PhcGSJYZ70eAOCPoDZKqEgV7QwZ+O6k8qEUlDfSDVPQvsnk45SPrOl5yPaoJSUKXv6IIcIP23dO0v0Anr3BXKTbjoBBh7v2thXMY/uGs0k5520jUbhCSC2MEW+K3SuXr1PuzZvkI4kg1npT5ulcc+TmVUPqHH9BSng3SxHzGmnlmWTONQauqp1Y6yMvutMLdWuHfyaQplXXaaMTRiInH6P+nv6Y2DMynvNBTBTP0D7iMC/Cx5v9W+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngN5hoV5ELh9icSGKLXPvOhloA17bXGHC+gEQYm/sp4=;
 b=MYHqnUtjyXQRDuI46NbsMOrcOyGt5ieYcZimXLQ0+QxxtPkM6xvD5rbTUmUiGyWUBd9RuG1u/0I+M820/mvLwmo46rWrZ8y8LcTFLJe823GRx6KfXdam795HHYlZmxbpoMdKRmdUby+W2BBodg6j/AkVa+vdZOqDaaHTy2V+ibU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:37 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:36 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 02/10] Revert "arm64: dts: freescale: Fix 'interrupt-map' parent address cells"
Date:   Tue, 14 Dec 2021 03:37:52 +0200
Message-Id: <20211214013800.2703568-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f29015bc-a122-4965-880a-08d9bea272af
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB6944DDF623306EF2E086D35AE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSwGaSJGZuVX63MXFkGVfPLEukCo+jN/2Lu4AHAnG9gFYNu50kSu2l9MDy7y66wZpzsWyemK03rVSlfHfNjuY9An7donwxlqk4KSK8Xb86RNssBnCquXcyctTtKS1AtLTd8e8XOQVa4jHA3iyrit5fX/nTl3caMERXFLX3Buim7WkUUogSFE3jA9HMuogLLkMgc9tGZbgKVx71iANXE49miLJmS51agHUX9k5zT36DzdpF1uOKsKKDl2IEGh5OlWcazR82zSLEkUHshwwlJ+C5jimKGWAraQe9n53Oe/eu8zsb91zmYFQgmc5QdkycVdyLimqlcKNKqODrHyIk832uHTO1gHPJgjiDSG9YQ9jk8aqxx5GKqa7Wbo8qN7LmMemtzU+mob9KY0f99WrY098B8oyMx6EXHB2t1lKGBN6Vh9XM8VWycWRRnLvzSuJESjCt6aE2ZzadoIkFKYv6TlVOZrzyvUjs/UovZK+ZNFn9yBjEb9gsI6OHikIZgwhML7UiC7IjVUxxjWuAyU5LgRsxmfUWcrey6t42W0FMiGrCDnC7WYJGU6DENWa033zQPoP52WEXmYh0zLrgv82KD7mM7cmw4+5S/GZSHYjR129QF5IzoGTGSW0VUknA50lFUKGEggNl1sYxSbdGUgMBBPE3qxg34bXUJhLwWBi5+vEgs2utsyreGzsjzzr+cQipERrUeoiiy/ofgvCyIRnRb0Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CBmPKef83YId35w+inbGnTcBidKY7l6ihn/Jgkre94qMbm7BwTsdGpfVR/i?=
 =?us-ascii?Q?SYFe6FGKHhTlVQ6EOYj9F22KD0p2AWvAgVGcP8EV/K2XZOdH4KVuHrDvl/aH?=
 =?us-ascii?Q?CWPRvihW5FOcfSJUTPnG0EybfARrnAejyU0mhbmlOiLcCjNsSK7Y3ZCw/XtI?=
 =?us-ascii?Q?zl0bhx6susJTGltqhckdZZtnRybn8e6zUZCfQ5GGkFaPD/+phGx78KXj3MXw?=
 =?us-ascii?Q?UONzzMzqu1sN8gOKVPKS3JGCLOX90KDwLyZM/3BTMWyGRDqm+jYFPTDCDiPF?=
 =?us-ascii?Q?mXXRHyTddakjH0D+GoSjpZQcDqLgZZh01tzsq2k0axlmode9Npxngl4P7GQX?=
 =?us-ascii?Q?GeOkDgCYY5yDwLvASd82GN9pSzXsnl9M6SUjjZMJQNqo9S/KxUtqjO0zQ2Br?=
 =?us-ascii?Q?+0vGUPjTK5fmyTb/v8b/FTkQkmBrv44kYY7sINZuVS1X7QcJkSH328NRr/ue?=
 =?us-ascii?Q?9YvXdsfcL74AosXsewtg6VZ+4EzwU6VtWrmEc62FnHNCT+Z23kgHHK84Kd/o?=
 =?us-ascii?Q?k9gIfi4qxlz9K95pvh+mQLBy+/u8uHtHO7selyc9EcgguBQacNyHo+/C0EEP?=
 =?us-ascii?Q?1DpomZNFxq7Ir8oqeVTCm0fmjQJMaBRlijo77KVEFAjerxvaqVbrDciQJVN4?=
 =?us-ascii?Q?xj5xNMHzqSNyRERVeos6L4b3Qkjo7C7/gd6YeR/ok64T5OEDkNYdIMei/w6J?=
 =?us-ascii?Q?2Ce+akj3Odc4QhHFXilCk0PPKQLg4JjoQUpTc8y0UFYyIHKFRL8yDvhNPY/u?=
 =?us-ascii?Q?7M+fu9QfXiLT9MbTbQK3R4l63ktyjt8zysgs8D7QVCQC/+NT+tcIMwfuk7xT?=
 =?us-ascii?Q?rhyKvHjn/U6P7GCllvDuKjRL73ibqUmzyKIj8mFMzyS1vmjF0nLftGUEgur9?=
 =?us-ascii?Q?agFtP+CY0NscY3lNBwP4rLFe9AV9FdYnlqTpiwO6IkcXZZ695CRbYqPyCDOX?=
 =?us-ascii?Q?YyMrGtaYiTob7TjlqSb/cOMXAmBUWCS0RiaBeFOWqAJsk0hyMENHOIDC3Scx?=
 =?us-ascii?Q?JdiDUwbkgHKTumAqmakpxclfKrnn1emyclg8vglMyteqpy3GmVtMknD+aR1G?=
 =?us-ascii?Q?tYqWMnblP6ym9T4MdsQUmCn5zqSp/FVkhbdROfivdit2VeCIAJj9fjAKmIOn?=
 =?us-ascii?Q?RcpTVB/AAR6pQ6zJGRgmdFvLfp/suDCRjLWfA0olhWERaRCPikoCcGris+KE?=
 =?us-ascii?Q?nOKFjaEPtUHvJb19bCfGeqv5THt677OivW/mF8fOgPn/Yji/55SgGxPPvuim?=
 =?us-ascii?Q?tR72KKVYIgNdKXs8oSOB4MUZFeDSVEWOidXqCI5O6x1tZQZSTxEY6vkQmiE9?=
 =?us-ascii?Q?X5KCGPrLcB1CFUjRoufTlBAl/Pkgg4WtVRKmYg7ja/J50oX4VsNAFoWDzLK1?=
 =?us-ascii?Q?SnZgX14zjb48s04iagaWWqBuRen0Wl8yIMlaVnY67lXZZxTwPTv4EbkOSEqL?=
 =?us-ascii?Q?O282WOA8V7acfnCMhU/nQb3LgEIfe4Z6kuvg/nnTxxsCLAEHBdhCey12FTjj?=
 =?us-ascii?Q?5jmHcwRa9RDORpBUFdfL3ELjCuwzhTEt8vSEEiyymMYLvXkuFsi4pZF6G+pk?=
 =?us-ascii?Q?039+LhyOedVqBfexEXq5NROyH74DpazS+eFOO8jkLBcLLvkgWpAWUIihXAtC?=
 =?us-ascii?Q?pQJK1rr0RoYxlTuvPhc3fC8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29015bc-a122-4965-880a-08d9bea272af
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:36.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiRk/tBn8jhfEJmEGZdpX/k3nXHCPvFgIe3/3HVhFIQy4TqLAXhHmOxjqE2kGA25iDFwGuqSmumuDKohgBxMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
updated the expected device tree binding format for the ls-extirq
driver, without also updating the parsing code to the new format.

While the fsl-extirq driver may have a non-standard format (one that
doesn't take into consideration the #address-cells of the interrupt
parent), it also has no business in making use of the "interrupt-map"
property in the first place. So the argument for the blamed patch was
kind of moot in the first place.

This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
previous bindings. A follow-up change will also rename "interrupt-map"
to "fsl,extirq-map" to prevent any further automatic conversions from
causing breakage. Keeping the revert as a separate change allows those
renaming changes to look the same on kernels that include the reverted
patch as on kernels that don't.

Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map' parent address cells")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 24 +++++++++----------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f891ef6a3754..605072317243 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -241,18 +241,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3cb9c21d2775..1282b61da8a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -293,18 +293,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index dc8661ebd1f6..c4b1a59ba424 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -680,18 +680,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
-- 
2.25.1

