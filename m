Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418C24680F9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383563AbhLCX6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:30 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58136 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383574AbhLCX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:22 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93ED7200B20;
        Sat,  4 Dec 2021 00:54:56 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AFC6200B40;
        Sat,  4 Dec 2021 00:54:56 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D2AB940007;
        Fri,  3 Dec 2021 16:54:55 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Biwen Li <biwen.li@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 09/10] arm64: dts: lx2162a-qds: add interrupt line for RTC node
Date:   Fri,  3 Dec 2021 17:54:45 -0600
Message-Id: <20211203235446.8266-10-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211203235446.8266-1-leoyang.li@nxp.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Add interrupt line for RTC node on lx2162a-qds

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index a2452efd2532..a657835794e2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -309,6 +309,8 @@ temperature-sensor@4c {
 			rtc@51 {
 				compatible = "nxp,pcf2129";
 				reg = <0x51>;
+				/* IRQ_RTC_B -> IRQ11_B(CPLD) -> IRQ11(CPU), active low */
+				interrupts-extended = <&extirq 11 IRQ_TYPE_LEVEL_LOW>;
 			};
 		};
 	};
-- 
2.25.1

