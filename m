Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACABE4814F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhL2QLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 11:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhL2QL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 11:11:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B1DC061574;
        Wed, 29 Dec 2021 08:11:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7841061503;
        Wed, 29 Dec 2021 16:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19948C36AE7;
        Wed, 29 Dec 2021 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640794287;
        bh=1o+tRmND6geYaRchA+NAcQjEfxBIEqn6xtnDkeqIG0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlePE6ThSaew42YmwPAMiYCjMOFUttUd2NbR48sFk2OOHkeIRH0xmjmHggocg7lhm
         tRk2uCG+4jCRaf/ah/d2wgyFdME5Svp01FOTNreNvjkbDFvfH3XGhxPJwTWv7ZIMcB
         qx/yYo1X4ehOQYnbA/C4TQaotShwhE0i9s/4ubEeiZLFyH7FbCWSHCTF9pErpKdTgG
         wIj62G9IF6HqE+phm+AKyJFYECDwc/Rk0dGniN0R3V2OpeOYdipGyBzogPgQ33WvpG
         qQccwRsxaP7SGF3BIL1kuH/is4XEgqjLgcimQNqkk0X1NaC4QJbri8B5Xb3X5JSliy
         y1Nz6CGUI0JkA==
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
Subject: [PATCH 5/7] arm64: dts: marvell: Remove unused num-viewport from pcie node
Date:   Thu, 30 Dec 2021 00:02:43 +0800
Message-Id: <20211229160245.1338-6-jszhang@kernel.org>
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
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi      | 1 -
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts | 1 -
 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts            | 1 -
 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts            | 1 -
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi              | 1 -
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi              | 1 -
 arch/arm64/boot/dts/marvell/cn9132-db.dtsi              | 2 --
 7 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index adbfecc678b5..860912e47732 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -180,7 +180,6 @@ &cp0_pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp0_pcie_pins>;
 	num-lanes = <4>;
-	num-viewport = <8>;
 	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
 	ranges = <0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
 	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>,
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index dac85fa748de..c5ba03c2194d 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -330,7 +330,6 @@ &cp0_pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp0_pcie_pins>;
 	num-lanes = <1>;
-	num-viewport = <8>;
 	reset-gpios = <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
 	ranges = <0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
 	phys = <&cp0_comphy0 0>;
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
index a7b6dfba8af5..ccb48d81604a 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
@@ -12,7 +12,6 @@ / {
 &cp0_pcie0 {
 	status = "okay";
 	num-lanes = <4>;
-	num-viewport = <8>;
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy0 0
 		&cp0_comphy1 0
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
index 0904cb0309ae..4c68c8c310ae 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
@@ -12,7 +12,6 @@ / {
 &cp0_pcie0 {
 	status = "okay";
 	num-lanes = <1>;
-	num-viewport = <8>;
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy0 0>;
 	iommu-map =
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index c00b69b88bd2..54f40674808b 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -271,7 +271,6 @@ partition@1000000 {
 &cp0_pcie0 {
 	status = "okay";
 	num-lanes = <4>;
-	num-viewport = <8>;
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp0_comphy0 0
 		&cp0_comphy1 0
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index f995b1bcda01..ccf162fa751b 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -112,7 +112,6 @@ &cp1_pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp1_pcie_reset_pins>;
 	num-lanes = <2>;
-	num-viewport = <8>;
 	marvell,reset-gpio = <&cp1_gpio1 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 	/* Generic PHY, providing serdes lanes */
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
index 3f1795fb4fe7..be96d5f3398e 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dtsi
@@ -153,7 +153,6 @@ cp2_module_expander1: pca9555@21 {
 &cp2_pcie0 {
 	status = "okay";
 	num-lanes = <2>;
-	num-viewport = <8>;
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp2_comphy0 0
 		&cp2_comphy1 0>;
@@ -163,7 +162,6 @@ &cp2_pcie0 {
 &cp2_pcie2 {
 	status = "okay";
 	num-lanes = <1>;
-	num-viewport = <8>;
 	/* Generic PHY, providing serdes lanes */
 	phys = <&cp2_comphy5 2>;
 };
-- 
2.34.1

