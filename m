Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2C4680FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383615AbhLCX6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:35 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58128 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383570AbhLCX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 465DD200B3D;
        Sat,  4 Dec 2021 00:54:56 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E7F1200B3B;
        Sat,  4 Dec 2021 00:54:56 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8CBE840579;
        Fri,  3 Dec 2021 16:54:55 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 08/10] arm64: dts: lx2162a-qds: support SD UHS-I and eMMC HS400 modes
Date:   Fri,  3 Dec 2021 17:54:44 -0600
Message-Id: <20211203235446.8266-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211203235446.8266-1-leoyang.li@nxp.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

The default NXP SDHC adapter cards for LX2162AQDS are SD 2.0/3.0
adapter card for eSDHC1, and eMMC 5.1 adapter card for eSDHC2.
Add speed modes properties supported by the two adapters in device
tree node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index 8e1b7bff64a5..a2452efd2532 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -226,10 +226,17 @@ &emdio2 {
 };
 
 &esdhc0 {
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
 	status = "okay";
 };
 
 &esdhc1 {
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
 	status = "okay";
 };
 
-- 
2.25.1

