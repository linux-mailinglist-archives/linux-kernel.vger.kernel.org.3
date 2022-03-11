Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6A4D6AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiCKWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCKWpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:09 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD22A2B9D;
        Fri, 11 Mar 2022 14:20:40 -0800 (PST)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id C1C6960F5F;
        Fri, 11 Mar 2022 21:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1647032663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rtt0wxHubmWpKdU6ekWYzCitwnoj4zI5iwxQKYKbTWk=;
        b=eQzbJTFc57T/S09xkYoZDHtkcblS/4wW/Gl5PwOT8TmpANImFyi9Jjm7isC1rDJqurSShG
        y5frICWIR4v3YP2hVYph2WPbq2QazU3BWIi6cKrLiJib3nqjJV4FGgIZAewOeV+GszMwNt
        gch5CvVsh+eJEJNgEGdc9hBVBtvVhew=
Received: from localhost.localdomain (fttx-pool-217.61.144.196.bambit.de [217.61.144.196])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id A020640684;
        Fri, 11 Mar 2022 21:04:22 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v6 3/6] ARM: dts: spear13xx: Fix sata node name
Date:   Fri, 11 Mar 2022 22:03:54 +0100
Message-Id: <20220311210357.222830-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311210357.222830-1-linux@fw-web.de>
References: <20220311210357.222830-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 127311bf-9db5-442b-9c8e-516e6731cf9d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

After converting the binding to yaml the node name does
not match the standard pattern, change it.

arch/arm/boot/dts/spear1340-evb.dt.yaml: ahci@b1000000:
$nodename:0: 'ahci@b1000000' does not match '^sata(@.*)?$'
	From schema: Documentation/devicetree/bindings/ata/ahci-platform.yaml

Fixes: 07658d9a659b ("SPEAr13xx: Add dts and dtsi files")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm/boot/dts/spear1310.dtsi    | 6 +++---
 arch/arm/boot/dts/spear1340-evb.dts | 2 +-
 arch/arm/boot/dts/spear1340.dtsi    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 2f746a9428a7..8702c290ed8a 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -50,7 +50,7 @@ miphy2: miphy@eb808000 {
 			status = "disabled";
 		};
 
-		ahci0: ahci@b1000000 {
+		ahci0: sata@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 68 0x4>;
@@ -59,7 +59,7 @@ ahci0: ahci@b1000000 {
 			status = "disabled";
 		};
 
-		ahci1: ahci@b1800000 {
+		ahci1: sata@b1800000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1800000 0x10000>;
 			interrupts = <0 69 0x4>;
@@ -68,7 +68,7 @@ ahci1: ahci@b1800000 {
 			status = "disabled";
 		};
 
-		ahci2: ahci@b4000000 {
+		ahci2: sata@b4000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb4000000 0x10000>;
 			interrupts = <0 70 0x4>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index fd194ebeedc9..65c757cd3718 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -112,7 +112,7 @@ pcie {
 			};
 		};
 
-		ahci@b1000000 {
+		sata@b1000000 {
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 827e887afbda..f45f3046f1c8 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -33,7 +33,7 @@ miphy0: miphy@eb800000 {
 			status = "disabled";
 		};
 
-		ahci0: ahci@b1000000 {
+		ahci0: sata@b1000000 {
 			compatible = "snps,spear-ahci";
 			reg = <0xb1000000 0x10000>;
 			interrupts = <0 72 0x4>;
-- 
2.25.1

