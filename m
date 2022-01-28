Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1697349F452
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbiA1H2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:28:03 -0500
Received: from cpanel.siel.si ([46.19.9.99]:38570 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346666AbiA1H2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y2bmZYoCptl4ZbUX6DysRdoSU4WqZpQjiOpb7Mmyne0=; b=iCnPVwV58PZyva8NHBjNoujixg
        xng/I5kT53K6h7L1JqOmdninJT2xrHP07fDyUehNere5KTqRwjyMT9B01yhRQrT6BUHWEetFf7CAk
        qmpeK/vS1w+PBxnhzrUIDtWtyFvbkFQbAn5hoeWJovYgEIiI4STCUv1FlP+vMJ26281PKFpUcq606
        WI59YlP4e+cSQr6iTqM1UPvMDmm0SEHniY0+rlO8MMQ7LK99za/mUnT6p5tbdyoafT1ZG6q00J6qD
        SO5GxF90fG116FwQ7UfbVyDlTucsp9EoHasDmfmuvZpz5c6aoKaE7LC59Y7m1AB51DnGYh3vsxD0a
        7vz6jYPg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46530 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1nDLfg-00EWky-HZ; Fri, 28 Jan 2022 08:27:56 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, y.bas@phytec.com
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-phytec: add missing pmic MFD subdevices
Date:   Fri, 28 Jan 2022 08:27:37 +0100
Message-Id: <20220128072738.157247-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
MFD subdevices so they can be used.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - fix subject to follow ARM: dts: imx6qdl-phytec: ... style
 - use MFD (capital letters) in subject and commit message
 - change rtc and watchdog lebel/node name to follow more standard
   naming scheme
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index f3236204cb5a..c6ec71f6f034 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -205,6 +205,14 @@ vdd_mx6_high_reg: ldo11 {
 				regulator-always-on;
 			};
 		};
+
+		da9063_rtc: rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		da9063_wdog: watchdog {
+			compatible = "dlg,da9063-watchdog";
+		};
 	};
 };
 
-- 
2.25.1

