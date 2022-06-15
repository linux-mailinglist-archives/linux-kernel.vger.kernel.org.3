Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104C554C7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiFOLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbiFOLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF764AE32;
        Wed, 15 Jun 2022 04:50:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o7so22720737eja.1;
        Wed, 15 Jun 2022 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMf+gn9LvzLdD1VC7pS9QUk31VCqeS4SgKv1PVXD/FU=;
        b=G+pqPrhvrERMKQE8/kFpbxSRzKOfTs8FDlgIjxKoXAwZVy/cnapLbut34HEdCWYCC0
         RwbN/VCBZyxwb5p846sSBjBoR7oXijGTDrlUMhXLusrnEHQzg0lITt3hhj3C82OWBwsA
         Bfl8n2rH6ULh52Ya+XJCyGtPMch5fUUT/HbjVxk9riiODq6vkd3I/n9N1BTDXFo6qC/g
         FQsMq8B5fs2rywQeYYhvgPOCn/8LC//Osbq6W18D0sJnePOL5y100sMkIbqlUnhOHY7f
         K9i9ZpUCjuVpyF/3bRh3Lz56gpEIpefgNrnQWQDvlaQzEpxXIhUwF8fpL42nvnAEKmLh
         82ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMf+gn9LvzLdD1VC7pS9QUk31VCqeS4SgKv1PVXD/FU=;
        b=ECJzKVYrEB9sXDczZWbjAIGoSSPBfaAKx/7QO6A1XAUQJr26XTeoxWA9qP1Amb/BlD
         UaJdRMUTJ/yUkgzjIbmeBB2Ji5vt3oDWUSwT+wbjFXdrntiXnKoTg9asWHGpYETjcqs4
         B+bMKufpgEfSu+Y0Wfi8gMr6m5Ivy5O2xBB2hfKAdfpy/Y6p8aX9iR/QYPKYXtXhMvuF
         o15JguywgORvxpQ45LfiePeTBClvC7ndVZL+9Kj8ISvUKX/bR1PReNQnGMXCGaYnZjnV
         ySGP1BEUIDSXyyxesAraDF3lHiqeDsrsINjFSdTV7/arFccsAn9GMyP5ETvZGHvfJt7I
         jgsg==
X-Gm-Message-State: AOAM533HVcRZLcO25GNNnX3H1Dlp8svYjkMyD5r1ACw+GU+2Ocqx3MZk
        L079sLXe4xO/DMQqXy+kjxM=
X-Google-Smtp-Source: ABdhPJypLpKRmt5Y2u7ALtLUPy499ZLRSRRhuvfvQgi/AGDpkxf3KPYyIFatSUAGGptgohT1QAKVsQ==
X-Received: by 2002:a17:906:1084:b0:712:2989:b630 with SMTP id u4-20020a170906108400b007122989b630mr8468195eju.344.1655293852417;
        Wed, 15 Jun 2022 04:50:52 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:51 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/18] ARM: dts: imx6q-apalis: Move Atmel MXT touch ctrl to SoM dtsi
Date:   Wed, 15 Jun 2022 13:49:55 +0200
Message-Id: <20220615115006.45672-8-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Reduces code duplication. While at it drop the comments which do not
apply on Apalis iMX6 but add the correct SoM pin names.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 13 -------------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 13 -------------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 13 -------------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 11 +++++++++++
 4 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index fe5d491e1399..5985d1169be1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -82,19 +82,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	pcie-switch@58 {
 		compatible = "plx,pex8605";
 		reg = <0x58>;
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 8febfc0aea93..21f88e19e87d 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -89,19 +89,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 78cf1d9583c1..6743617ad1c1 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -88,19 +88,6 @@
 &i2c1 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
-		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>; /* SODIMM 13 */
-		status = "disabled";
-	};
-
 	eeprom@50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 9413c14ce5f6..3aa66b6d0c88 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -416,6 +416,17 @@
 	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		/* These GPIOs are muxed with the iomuxc node */
+		interrupt-parent = <&gpio6>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;	/* MXM3_11 */
+		reg = <0x4a>;
+		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;	/* MXM3_13 */
+		status = "disabled";
+	};
+
 };
 
 /*
-- 
2.20.1

