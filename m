Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B503473F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhLNJdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:33:00 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48238 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhLNJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:32:52 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A6641A09F7;
        Tue, 14 Dec 2021 10:32:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFA821A09FB;
        Tue, 14 Dec 2021 10:32:47 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7218D40579;
        Tue, 14 Dec 2021 02:32:47 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 4/8] arm64: dts: ls1028a-rdb: reorder nodes to be alphabetic
Date:   Tue, 14 Dec 2021 03:32:36 -0600
Message-Id: <20211214093240.23320-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214093240.23320-1-leoyang.li@nxp.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep these overrides node in alphabetic order in order to prevent
unnoticed duplicated nodes.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 88 ++++++++++---------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 41900d351a92..7d87c90652d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -102,6 +102,52 @@ can-transceiver {
 	};
 };
 
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&enetc_mdio_pf3 {
+	/* VSC8514 QSGMII quad PHY */
+	qsgmii_phy0: ethernet-phy@10 {
+		reg = <0x10>;
+	};
+
+	qsgmii_phy1: ethernet-phy@11 {
+		reg = <0x11>;
+	};
+
+	qsgmii_phy2: ethernet-phy@12 {
+		reg = <0x12>;
+	};
+
+	qsgmii_phy3: ethernet-phy@13 {
+		reg = <0x13>;
+	};
+};
+
+&enetc_port0 {
+	phy-handle = <&sgmii_phy0>;
+	phy-mode = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sgmii_phy0: ethernet-phy@2 {
+			reg = <0x2>;
+		};
+	};
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
 &esdhc {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
@@ -192,48 +238,6 @@ rtc@51 {
 	};
 };
 
-&duart0 {
-	status = "okay";
-};
-
-&duart1 {
-	status = "okay";
-};
-
-&enetc_mdio_pf3 {
-	sgmii_phy0: ethernet-phy@2 {
-		reg = <0x2>;
-	};
-
-	/* VSC8514 QSGMII quad PHY */
-	qsgmii_phy0: ethernet-phy@10 {
-		reg = <0x10>;
-	};
-
-	qsgmii_phy1: ethernet-phy@11 {
-		reg = <0x11>;
-	};
-
-	qsgmii_phy2: ethernet-phy@12 {
-		reg = <0x12>;
-	};
-
-	qsgmii_phy3: ethernet-phy@13 {
-		reg = <0x13>;
-	};
-};
-
-&enetc_port0 {
-	phy-handle = <&sgmii_phy0>;
-	phy-mode = "sgmii";
-	managed = "in-band-status";
-	status = "okay";
-};
-
-&enetc_port2 {
-	status = "okay";
-};
-
 &mscc_felix {
 	status = "okay";
 };
-- 
2.25.1

