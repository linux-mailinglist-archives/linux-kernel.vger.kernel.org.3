Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC4481502
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhL2QLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:11:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58062 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbhL2QLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:11:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F7F61526;
        Wed, 29 Dec 2021 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDC2C36AE7;
        Wed, 29 Dec 2021 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794298;
        bh=kuj6WMDZWffrvKNJFLJudpTOyHvdDkp5i6Cc8fgdKOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCpIiQ5RIOlXzH+Z2FR7deNzwGaMzWFW5A4ciFQnC5vU07y5LYvPfl4+GZwSiZ/dL
         HtuiNO9J58I/n8Okn7fpZQqwKEsWuQGp9CfnJ3fhdFVW3vQmt580+zf8R++OMFl52+
         eyU1rxxUAtVmhGdtuD1J/yOy1d5CM3uiGfJpesFAaK/6k6fZFX5ltwN/xjPVJNreJ5
         fkW8hbyIe/6+VNcoCZc8r54MC91WysW/gdd4Wnxcwk6krSJqZU+gg9ZAIFcaK0/KIa
         dO1AU4+Lx+Fh6B+JTUV6CtTfKhuSc7PCMU/4BqeFQ6xygad/P5EpgLLpDuREiln/mZ
         cTNljo/C//NrQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: freescale: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:44 +0800
Message-Id: <20211229160245.1338-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229160245.1338-1-jszhang@kernel.org>
References: <20211229160245.1338-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
the number of iATU windows is detected at runtime, what's more,
the 'num-viewport' property parsing has been removed, so remove the
unused num-viewport from pcie nodes.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ----
 6 files changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..13e57f34ca5b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -531,7 +531,6 @@ pcie1: pcie@3400000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			num-viewport = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index fd3f3e8bb6ce..ac6e1f795bc9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -622,7 +622,6 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -649,7 +648,6 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 01b01e320411..a8d1db620497 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -879,7 +879,6 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -905,7 +904,6 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -931,7 +929,6 @@ pcie3: pcie@3600000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 687fea6d8afa..8c3166afe737 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -783,7 +783,6 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -819,7 +818,6 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -855,7 +853,6 @@ pcie3: pcie@3600000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f891ef6a3754..cfed82908e7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -550,7 +550,6 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -587,7 +586,6 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
@@ -623,7 +621,6 @@ pcie3: pcie@3600000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   /* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3cb9c21d2775..5bd651454705 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1074,7 +1074,6 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
@@ -1096,7 +1095,6 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
@@ -1118,7 +1116,6 @@ pcie3: pcie@3600000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
@@ -1140,7 +1137,6 @@ pcie4: pcie@3700000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
 			#interrupt-cells = <1>;
-- 
2.34.1

