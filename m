Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED34A85AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbiBCODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:03:00 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:7570 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350961AbiBCOC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643896976; x=1675432976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCsnc0uOCN0qsb/m7VDLjeBcg1llYDl/BF35hm4GcvI=;
  b=QNG3LlT2ZB8+uTtFNEHzasOa5pxQdMaYJ9JBYsCyIOgtmwEVjvVfI5/o
   NyH90mv17R/4opH8nvZcEL56IGY0X6Xl96lJXQ391JYYXg5bksalFG0K6
   0U4d+xGOJ7bgIXrgT1VrmjTmX77eprxY3L+Pf8VXQdjMA62uXM6UCD/kX
   GXvA/kSEPA3HzRfIjeiCcuru9ZISYSLLM3+Ad1MSyzYT43QnTbEWb5P79
   8CMMmO5mY2QEyQd8zeqAy943+XM+Wvdp698DScOYgj98OjBXq89grPJyF
   8jUq6pO73np+uXuBbfQQ0zEJPD3WH53VTPS4o2DHzM1cx5mfyVUAzRydi
   g==;
X-IronPort-AV: E=Sophos;i="5.88,340,1635199200"; 
   d="scan'208";a="21881445"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Feb 2022 15:02:53 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Feb 2022 15:02:53 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Feb 2022 15:02:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643896973; x=1675432973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCsnc0uOCN0qsb/m7VDLjeBcg1llYDl/BF35hm4GcvI=;
  b=PN0zbIDRnbGk0Obm3OQjSX0OkgUvicBfLaOyoV3EmBRmE3BPLajjYuxj
   O9Y3mVUTzn6nt0+ddcwyVZPKbOeKp6Jl1Q6jlMmFPtc64eZPMYvqdTxXW
   CECVAoZsr1qlAGvhk48w13GGWfN9K4rO4ilhIRKRHj+3kwBx80SYyQ33i
   4H+yqQYs/CBILvbPHSk7uCX5JBjmFUo/Zh8IAZ1f0G9VjZe5ay+4Aj/MX
   I1relw+FCbFpwWwugNsB3blnB/w19qdP6L+AMZHseEOrKa352o1+vGQnc
   JWiyDw19y19nFoQkwovwA5LaG3v9Zo4XJUpCopWYr8bU5Bc7KbHM6ZC24
   w==;
X-IronPort-AV: E=Sophos;i="5.88,340,1635199200"; 
   d="scan'208";a="21881444"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Feb 2022 15:02:53 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0269B280075;
        Thu,  3 Feb 2022 15:02:52 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jan.kiszka@siemens.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am65*: remove #address-cells/#size-cells from flash nodes
Date:   Thu,  3 Feb 2022 15:02:40 +0100
Message-Id: <20220203140240.973690-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying partitions directly in the flash node is deprecated, a
fixed-partitions node should be used instead. Therefore, it doesn't make
sense to have these properties in the flash nodes.

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 --
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

v2: no changes, added Jan's Acked-by

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 873c123c611ed..7eca697e1ca14 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -623,8 +623,6 @@ flash@0 {
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 821ee7f2eff04..9c06da9d6d8f7 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -340,14 +340,12 @@ &main_spi0 {
 	ti,pindir-d0-out-d1-in;
 	status = "okay";
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		spi-max-frequency = <48000000>;
-		#address-cells = <1>;
-		#size-cells= <1>;
 	};
 };
 
@@ -442,7 +440,7 @@ &ospi0 {
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 	status = "okay";
 
-	flash@0{
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -453,8 +451,6 @@ flash@0{
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 	};
 };
 
-- 
2.25.1

