Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98D84680F5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383587AbhLCX6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:37076 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383557AbhLCX6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:20 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C5D01A0784;
        Sat,  4 Dec 2021 00:54:55 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C3F2C1A0742;
        Sat,  4 Dec 2021 00:54:54 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DB0EE40577;
        Fri,  3 Dec 2021 16:54:53 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>,
        Florin Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 02/10] arm64: dts: lx2160a-rdb: Add Inphi PHY node
Date:   Fri,  3 Dec 2021 17:54:38 -0600
Message-Id: <20211203235446.8266-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211203235446.8266-1-leoyang.li@nxp.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

DPMAC5 and DPMAC6 are connected to 25G Inphi PHY

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
Signed-off-by: Florin Chiculita <florinlaurentiu.chiculita@nxp.com>
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 028ff8074b9d..0ec41838e54e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -49,6 +49,14 @@ &dpmac4 {
 	managed = "in-band-status";
 };
 
+&dpmac5 {
+	phy-handle = <&inphi_phy>;
+};
+
+&dpmac6 {
+	phy-handle = <&inphi_phy>;
+};
+
 &dpmac17 {
 	phy-handle = <&rgmii_phy1>;
 	phy-connection-type = "rgmii-id";
@@ -109,6 +117,15 @@ can-transceiver {
 	};
 };
 
+&emdio2 {
+	status = "okay";
+
+	inphi_phy: ethernet-phy@0 {
+		compatible = "ethernet-phy-id0210.7440";
+		reg = <0x0>;
+	};
+};
+
 &esdhc0 {
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
-- 
2.25.1

