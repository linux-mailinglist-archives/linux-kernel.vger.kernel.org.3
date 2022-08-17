Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0E5979AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbiHQWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbiHQWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C698A1A49;
        Wed, 17 Aug 2022 15:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78D36164A;
        Wed, 17 Aug 2022 22:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DA5C433B5;
        Wed, 17 Aug 2022 22:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775484;
        bh=Z9fjxbNnKhhvveqn7OhF0WrGiE1Ebxofzn7E5GFmuFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6Xgkpvx1+eqqGx/wbXRyJou0+sruDr1v7MNt7g0lZ3oLOzGIFJo5BC87M+GrGq2T
         icXcuFeCiK1AA98fw6RKzKwE/toTYLgzX1jgh+q8gR5x80bvN1kVgga3whoMGNAFEO
         xUIqqc1+sGPhs3+oMbfOpFY41aSCeI69MpApr2hjTp2kqb/o4FcD3rsPwWJkVBJjDM
         jOO0cUkF3TgVHfZ35vXE7sEsqkBn5hza7WZgifkcCcnai0juhMMOAAaJY2rjnl/zNj
         kBLYtv72fKB0u/Zq4WmoVfk01BV0rQjfPEx5gmNhgIZc0XceJlnrVWw1PA/PKJBs0c
         HOkWs/XPzT2sQ==
Received: by pali.im (Postfix)
        id B0D0677A; Thu, 18 Aug 2022 00:31:23 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 5/6] ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:52 +0200
Message-Id: <20220817223053.31141-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817223053.31141-1-pali@kernel.org>
References: <20220817223053.31141-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BDF of resource in DT assigned-addresses property of Marvell PCIe Root Port
(PCI-to-PCI bridge) should match BDF in address part in that DT node name
as specified resource belongs to Marvell PCIe Root Port itself.

Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-380.dtsi | 4 ++--
 arch/arm/boot/dts/armada-385.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index dd726a686a00..9334a1e64165 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -90,7 +90,7 @@
 			/* x1 port */
 			pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x40000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -120,7 +120,7 @@
 			/* x1 port */
 			pcie@3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				assigned-addresses = <0x82001800 0 0x44000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index f71cc765a7f2..313526fed3ed 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -94,7 +94,7 @@
 			/* x1 port */
 			pcie2: pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x40000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -123,7 +123,7 @@
 			/* x1 port */
 			pcie3: pcie@3,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				assigned-addresses = <0x82001800 0 0x44000 0 0x2000>;
 				reg = <0x1800 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
@@ -155,7 +155,7 @@
 			 */
 			pcie4: pcie@4,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				assigned-addresses = <0x82002000 0 0x48000 0 0x2000>;
 				reg = <0x2000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-- 
2.20.1

