Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E44A8525
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiBCN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:27:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59340 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350807AbiBCN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:27:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 213DR4sD019016;
        Thu, 3 Feb 2022 07:27:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643894824;
        bh=prXVC5/HJ1ZaTKDfIbtnvJ2K31oeGzG7ooYV86UmBmU=;
        h=From:To:CC:Subject:Date;
        b=JtZMk77aWVrKGL7PsHq8lsf365gpQWiqT9joWEqXAw5H0+V89af4LbEwfNYtE5dPf
         DRTcDqkyeFko6knawUskiGie6s9PYd4PgcmZZ7MU48pK8CvRuNllO+TD/AXFHUbxtZ
         fsjtMiztwS8iE9AOslsuNy+qoMguD9i0gt5CM/LY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 213DR4JG011864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Feb 2022 07:27:04 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 3
 Feb 2022 07:27:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 3 Feb 2022 07:27:03 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 213DR0Rl010241;
        Thu, 3 Feb 2022 07:27:01 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Keerthy <j-keerthy@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix the interrupt-parent for wkup_gpioX instances
Date:   Thu, 3 Feb 2022 18:56:47 +0530
Message-ID: <20220203132647.11314-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

The interrupt-parent for wkup_gpioX instances are wrongly assigned as
main_gpio_intr instead of wkup_gpio_intr. Fix it.

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 7521963719ff..6c5c02edb375 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -108,7 +108,7 @@
 		reg = <0x00 0x42110000 0x00 0x100>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
+		interrupt-parent = <&wkup_gpio_intr>;
 		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
@@ -124,7 +124,7 @@
 		reg = <0x00 0x42100000 0x00 0x100>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&main_gpio_intr>;
+		interrupt-parent = <&wkup_gpio_intr>;
 		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-- 
2.17.1

