Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E983473D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhLNHXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:23:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41186 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhLNHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 35E1F20019E;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0474200CF9;
        Tue, 14 Dec 2021 08:23:47 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id EDA7540590;
        Tue, 14 Dec 2021 00:23:46 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zhang Ying-22455 <ying.zhang22455@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 01/10] arm64: dts: lx2160a: fix scl-gpios property name
Date:   Tue, 14 Dec 2021 01:23:33 -0600
Message-Id: <20211214072342.22692-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214072342.22692-1-leoyang.li@nxp.com>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Fix the typo in the property name.

Fixes: d548c217c6a3c ("arm64: dts: add QorIQ LX2160A SoC support")
Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index dc8661ebd1f6..2433e6f2eda8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -719,7 +719,7 @@ i2c0: i2c@2000000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			scl-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
 
@@ -768,7 +768,7 @@ i2c4: i2c@2040000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			scl-gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
 			status = "disabled";
 		};
 
-- 
2.25.1

