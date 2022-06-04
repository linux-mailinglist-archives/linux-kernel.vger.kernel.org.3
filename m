Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19BC53D794
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiFDP6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiFDP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:57:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E26A22BCC;
        Sat,  4 Jun 2022 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0vnK3UEVR6EXO17rYqPTO6dCpcjgtUEXe5tgO2RW2Ks=; b=jDxnS3Z/hdBdX+gYdKilbu9mfK
        SBi9f/YVCIqSc85Lcdk3btgHp/5eENW9u6EQUyfV6snAj1WBHaX3GUVghGcYAEOD82sNEkqogH7D3
        4t0TLwg3aitoLMWtMA2VOYEEbl9b9t3JB4bpccG6RbhDqiT5/QFN1Qez+9Y5DrQNTfbE=;
Received: from p200300ccff3313001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff33:1300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nxW9t-0007tr-GM; Sat, 04 Jun 2022 17:57:49 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1nxW9s-002PNK-TO; Sat, 04 Jun 2022 17:57:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: imx6: fix node names for ebook reader keys
Date:   Sat,  4 Jun 2022 17:57:48 +0200
Message-Id: <20220604155748.574153-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names are supposed to start with key-

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/e60k02.dtsi                | 4 ++--
 arch/arm/boot/dts/e70k02.dtsi                | 8 ++++----
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
index 1a49f15f2df2..935e2359f8df 100644
--- a/arch/arm/boot/dts/e60k02.dtsi
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -22,14 +22,14 @@ chosen {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		cover {
+		key-cover {
 			label = "Cover";
 			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_LID>;
diff --git a/arch/arm/boot/dts/e70k02.dtsi b/arch/arm/boot/dts/e70k02.dtsi
index 156de653f2cd..27ef9a62b23c 100644
--- a/arch/arm/boot/dts/e70k02.dtsi
+++ b/arch/arm/boot/dts/e70k02.dtsi
@@ -26,14 +26,14 @@ chosen {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		cover {
+		key-cover {
 			label = "Cover";
 			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_LID>;
@@ -41,13 +41,13 @@ cover {
 			wakeup-source;
 		};
 
-		pageup {
+		key-pageup {
 			label = "PageUp";
 			gpios = <&gpio4 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PAGEUP>;
 		};
 
-		pagedown {
+		key-pagedown {
 			label = "PageDown";
 			gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_PAGEDOWN>;
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index a17b8bbbdb95..86ad93cbe60c 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -27,7 +27,7 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_keys>;
 
-		cover {
+		key-cover {
 			label = "Cover";
 			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_LID>;
@@ -35,19 +35,19 @@ cover {
 			wakeup-source;
 		};
 
-		fl {
+		key-fl {
 			label = "Frontlight";
 			gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BRIGHTNESS_CYCLE>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-- 
2.30.2

