Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB847E318
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348208AbhLWMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:17:39 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbhLWMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:17:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHVBU018214;
        Thu, 23 Dec 2021 06:17:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640261851;
        bh=MRTBaAPYINx8g8q6Gwz5JTYLNHH239obwXFk0D+nNiE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=saad6HRBgWGnoJpMJkTJh3OfSKN+s80Q/5JLpTOboxLVUik9n6qtDY2/cZi0TipJS
         FlAhumqWLq3aY15KclhGz/Z5HLv09eFfbePlQLJEBsJSqydQMrnCoJdl0WvDAZJo5l
         zpoYicGdl9Je6HL0JHU2mPsGQO6g8TFsN5gibHXI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNCHVND052354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 06:17:31 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 06:17:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 06:17:30 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHN6D047704;
        Thu, 23 Dec 2021 06:17:28 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH-next 2/2] arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to serial2
Date:   Thu, 23 Dec 2021 17:46:50 +0530
Message-ID: <20211223121650.26868-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223121650.26868-1-vigneshr@ti.com>
References: <20211223121650.26868-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

On J721s2 Linux console is on main_uart8 but to be consistent with other
J7 family of devices, alias it to ttyS2 (serial2). This also eliminates
need to have higher number of 8250 runtime UARTs.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 708c14338eb7..b210cc07c539 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -15,13 +15,13 @@ / {
 	model = "Texas Instruments J721S2 EVM";
 
 	chosen {
-		stdout-path = "serial10:115200n8";
-		bootargs = "console=ttyS10,115200n8 earlycon=ns16550a,mmio32,2880000";
+		stdout-path = "serial2:115200n8";
+		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,2880000";
 	};
 
 	aliases {
 		serial1 = &mcu_uart0;
-		serial10 = &main_uart8;
+		serial2 = &main_uart8;
 		mmc0 = &main_sdhci0;
 		mmc1 = &main_sdhci1;
 		can0 = &main_mcan16;
-- 
2.34.1

