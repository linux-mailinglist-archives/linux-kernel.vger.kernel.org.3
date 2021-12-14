Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A51473D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLNHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:23:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47484 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhLNHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:49 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C3831A08C6;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EE7D1A081D;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 45ED040591;
        Tue, 14 Dec 2021 00:23:47 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>,
        Florin Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 02/10] arm64: dts: lx2160a-rdb: Add Inphi PHY node
Date:   Tue, 14 Dec 2021 01:23:34 -0600
Message-Id: <20211214072342.22692-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214072342.22692-1-leoyang.li@nxp.com>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
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

