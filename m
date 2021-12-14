Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9C473D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhLNHXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:23:54 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47508 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhLNHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:49 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ACD771A0930;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D5CE1A0926;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 9E7AE4043C;
        Tue, 14 Dec 2021 00:23:47 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 03/10] arm64: dts: lx2160a: add optee-tz node
Date:   Tue, 14 Dec 2021 01:23:35 -0600
Message-Id: <20211214072342.22692-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214072342.22692-1-leoyang.li@nxp.com>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@nxp.com>

Disabled by default in SoC dtsi and enables in board dts files.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 4 ++++
 4 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index d858d9c8b583..8354af0b31e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -156,6 +156,10 @@ rtc@51 {
 	};
 };
 
+&optee {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 0ec41838e54e..0c44b3cbef77 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -219,6 +219,10 @@ rtc@51 {
 	};
 };
 
+&optee {
+	status = "okay";
+};
+
 &pcs_mdio3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 2433e6f2eda8..fcde09f36018 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1751,4 +1751,12 @@ dpmac18: ethernet@12 {
 			};
 		};
 	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index e1defee1ad27..8e1b7bff64a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -307,6 +307,10 @@ rtc@51 {
 	};
 };
 
+&optee {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
-- 
2.25.1

