Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB464946B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 06:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358552AbiATFQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 00:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiATFQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 00:16:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3007C061401
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 21:16:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m3so17435787lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 21:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIfZNDPfDKqkYcN4EVrMCTxIOzhlZwaXVhl3QVcx8G0=;
        b=af6o9+A/c0IMnAu2aYltxQJPfWUl5Z/dWratF1h9NAfNuRQi4PKp7jImvfCgtfmM3d
         JTyp9JCBQnPOWI58bbc2kJ6mvH/dCV3d5hJxqyOn9VUYWacIGV3NjOWYzwhNEx6oc5zh
         KkfZSurp99JX+jHYXF+vmWeFrm9y/xfG1FNew9kHZ+5VBcnJzFl4hWaTFPqMJiyfgl5j
         kBBz9jq1sw3Z+TD6XPcz+PPHjHhzRUGU9tZxDdc1DhwOEpam2HuHvRzSvUw86YWnj23S
         ZNt3aBtvQ9uCtuv7c801zQpNVDt9B4/TMYX4aTipQ8X4+8v1d2/XIx1b0oQELsnpkrYS
         hccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIfZNDPfDKqkYcN4EVrMCTxIOzhlZwaXVhl3QVcx8G0=;
        b=LmlBK+PPWIDJg8Qb7Zq0aR4salxwQtjrjdgPGZBtQxbYh5I16K8bzb/3j2BAGjOsUk
         U0pFufioMOKPGBfQZ0KTSBY4xta28ZZ6arMK5A7vOYluhWxgQZT5SMe7p3V6iUfTs3qB
         X/EEPzFugMUgXksrwMlASTXhTIb6iKaRmCg+nzo46hZYNbXCryuwSGS39FsZJUz+uPxi
         1bPdtJu8oLQj+Dzy0JSXu8qjpaQE83TA731oP5hOUGyntxkNsi1KnnpK7wRbpbs5PYKL
         UZB6TY3tXIohIvwoLa1LqI50UKU7KsWLG/xo3+lT/vI3cGNmnKgJ5rPuqh2UYib+/sbU
         Kevg==
X-Gm-Message-State: AOAM533m6QKz9XvS7pzyHEkjE+z/VyIhCt8s3syGA1O6x5zc4aoFu2nI
        uYKf+7LIcNtCi087fsEkreuMCA==
X-Google-Smtp-Source: ABdhPJzCW27YgEuEp9c0NqtsFJsFA8BwBAU9C8dFth98HZpCAcFc/IpT73EFUXpXoOLnSbBG9jelTg==
X-Received: by 2002:a19:f202:: with SMTP id q2mr23455504lfh.650.1642655787034;
        Wed, 19 Jan 2022 21:16:27 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id s14sm213516lfp.79.2022.01.19.21.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 21:16:26 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v3] arm64: dts: renesas: add MOST device
Date:   Thu, 20 Jan 2022 08:15:59 +0300
Message-Id: <20220120051559.746322-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mlp device to dtsi files for R-Car Gen3 SoCs that have
it.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
v2: https://lore.kernel.org/lkml/20211226153349.2296024-1-nikita.yoush@cogentembedded.com/
Changes from v2:
- no longer part of patchset - other parts already merged
- add per-SoC compatible strings
- add resets
- keep only two interrupts - those used by the driver

v1: https://lore.kernel.org/lkml/20211226082530.2245198-4-nikita.yoush@cogentembedded.com/
Changes from v1:
- fix power domain ids so all dtbs build properly

 arch/arm64/boot/dts/renesas/r8a77951.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77960.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 12 ++++++++++++
 6 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index 1768a3e6bb8d..d09f725a33f3 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -2412,6 +2412,18 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a7795-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a7795",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77960.dtsi b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
index 2bd8169735d3..280ed4249dad 100644
--- a/arch/arm64/boot/dts/renesas/r8a77960.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
@@ -2284,6 +2284,18 @@ ssiu97: ssiu-51 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a7796-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a7796",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index a34d5b1d6431..cd212628a910 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2128,6 +2128,18 @@ ssiu97: ssiu-51 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a77961-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77961",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 08df75606430..c7e3ed0e0814 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -2147,6 +2147,18 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a77965-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77965",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 0ea300a8147d..f3ac5f087ba7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -1682,6 +1682,18 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a77990-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77990",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 16ad5fc23a67..27b1b5e32175 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -1132,6 +1132,18 @@ ssi4: ssi-4 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,r8a77995-mlp",
+				     "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 802>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77995",
 				     "renesas,rcar-dmac";
-- 
2.30.2

