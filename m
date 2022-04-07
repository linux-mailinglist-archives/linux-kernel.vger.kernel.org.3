Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A274F81C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbiDGOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbiDGOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4031AE3F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x20so6604842edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAob4hjVeo8qM+UmXzHTMHiaXqZxB5KGeATzkvlQyeQ=;
        b=VkAWw3UdKCLqgiNHW6azXeT3giNhyg1isLQYm6ShYnNrTlPF0DjZuhOaMAH4bzAMF7
         AYqrHT/srA+9QpA58P6t9R+LCPtiu3ZToSWI/ZkBsSOgar1gHIyPjqesGygNqBCXTFlK
         3mfYyhifC8O9oFwN4h1SUOORLNEhITToH8Tyxeh8EuYh1sShEGZHrGsHY1yZhSRosiUf
         avWYbnCNXXB5bjarajKrY477sswo2kogSMhP9y4hZxjo9Xq9g6Cj2tnwge5mkc3mwzmJ
         scX3g8febBWIc0rS0pEe1xinDkkagNfRQrFbRvVG01ojVZs9rRk8bPg1b3ZP0hwiV/vF
         A1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LAob4hjVeo8qM+UmXzHTMHiaXqZxB5KGeATzkvlQyeQ=;
        b=4NBqUY5iwq8TvW4SjWdwKC3DhAfipdkf4LK38VY8cEomFgSC230zFJ4Ms/RwnCtsJf
         dOHEcTsqXU9o393Ft5V0TJ4VWPXOggILy/zzm9pcivjwj5kGkQYt5m32k8BlNubX5gai
         6N1U+mXKGPfI2X7qCe93/P6uiMBE9fIsnrzn9hbqt/LOIWBJaV9l1byDjI0J4HVYeVdo
         X0KtKdhEdz1Nvewh30VFxd0gEwNdhSjMLFHHYNTHwsTy83uJkRpR4i6mJa9GpXEJLT2j
         +u1USnzqHiQFqxPxfUA0xE0sb2sdcASLdga9opcgXXnkWi0NAm0c+eFjWM4UBynEH7WK
         ngQQ==
X-Gm-Message-State: AOAM530UOVui+75MizCI7iKsVFaSIebxs5oqKMyae89OUZ5awcLkhb2V
        ex9y1GiK5mCb+xMyKB6bRGYuGQ==
X-Google-Smtp-Source: ABdhPJxrfNXortbnbnCAxjUrGECnq4VtAi2PQO6is+aLbcsZUm/Tpf+CHgnVSwErA/Yq6cJje6JeEw==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr14479659eds.100.1649341988967;
        Thu, 07 Apr 2022 07:33:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x9-20020a05640226c900b0041d015bb8a5sm1135390edd.26.2022.04.07.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:33:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: omap: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:33:04 +0200
Message-Id: <20220407143304.295610-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi         | 2 +-
 arch/arm/boot/dts/am335x-sl50.dts                 | 2 +-
 arch/arm/boot/dts/am3874-iceboard.dts             | 2 +-
 arch/arm/boot/dts/am437x-cm-t43.dts               | 2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts              | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts               | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts              | 2 +-
 arch/arm/boot/dts/am574x-idk.dts                  | 2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts         | 2 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi          | 2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi            | 2 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi           | 2 +-
 arch/arm/boot/dts/dra76-evm.dts                   | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 11e8f64b6606..92a0e98ec231 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -182,7 +182,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "mx25l6405d";
 		spi-max-frequency = <40000000>;
 
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
index a7269b90d795..e7e439a0630a 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
@@ -394,7 +394,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "mx25l6405d";
 		spi-max-frequency = <40000000>;
 
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index f65cd1331315..e2cec1ffaa4c 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -331,7 +331,7 @@ &spi0 {
 	pinctrl-0 = <&spi0_pins>;
 	status = "okay";
 
-	serial_flash: m25p80@0 {
+	serial_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <48000000>;
 		reg = <0x0>;
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 6516907ed579..73b5d1a024bd 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -588,7 +588,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
 
-	flash: n25q032@1 {
+	flash: flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q032";
diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index 9423e9feaa10..c9323d1df303 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -434,7 +434,7 @@ &usb1 {
 };
 
 &mcspi1 {
-	s25fl256@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 3e3354780db8..0861e868b75a 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -302,7 +302,7 @@ &spi0 {
 		&edma 17 0>;
 	dma-names = "tx0", "rx0";
 
-	flash: w25q64cvzpig@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index 53f64e3ce735..5a74b83145cf 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -437,7 +437,7 @@ &qspi {
 	pinctrl-1 = <&qspi_pins_sleep>;
 
 	spi-max-frequency = <48000000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "mx66l51235l";
 		spi-max-frequency = <48000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 20a34d2d85df..0bc391243816 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -746,7 +746,7 @@ &qspi {
 	pinctrl-0 = <&qspi_pins>;
 
 	spi-max-frequency = <48000000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "mx66l51235l";
 		spi-max-frequency = <48000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 4f9a7251a107..1165804658bc 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -902,7 +902,7 @@ &qspi {
 	pinctrl-1 = <&qspi1_pins_sleep>;
 
 	spi-max-frequency = <48000000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "mx66l51235l";
 		spi-max-frequency = <48000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index 6dff3660bf09..47b9174d2353 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -18,7 +18,7 @@ / {
 
 &qspi {
 	spi-max-frequency = <96000000>;
-	m25p80@0 {
+	flash@0 {
 		spi-max-frequency = <96000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 2e94f32d9dfc..2fc9a5d5e0c0 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -491,7 +491,7 @@ &qspi {
 
 	spi-max-frequency = <48000000>;
 
-	spi_flash: spi_flash@0 {
+	spi_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spansion,m25p80", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 9fcb8944aa3e..c06eda817242 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -526,7 +526,7 @@ &qspi {
 	status = "okay";
 
 	spi-max-frequency = <76800000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "s25fl256s1", "jedec,spi-nor";
 		spi-max-frequency = <76800000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index 0f71a9f37a72..68c43eb12c1a 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -135,7 +135,7 @@ &qspi {
 	status = "okay";
 
 	spi-max-frequency = <76800000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "s25fl256s1";
 		spi-max-frequency = <76800000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dra72-evm-common.dtsi b/arch/arm/boot/dts/dra72-evm-common.dtsi
index f12825268188..8948e10dbeb8 100644
--- a/arch/arm/boot/dts/dra72-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra72-evm-common.dtsi
@@ -474,7 +474,7 @@ &qspi {
 	status = "okay";
 
 	spi-max-frequency = <76800000>;
-	m25p80@0 {
+	flash@0 {
 		compatible = "s25fl256s1";
 		spi-max-frequency = <76800000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index e2b7fcb061cf..57868ac60d29 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -511,7 +511,7 @@ hdmi_out: endpoint {
 
 &qspi {
 	spi-max-frequency = <96000000>;
-	m25p80@0 {
+	flash@0 {
 		spi-max-frequency = <96000000>;
 	};
 };
-- 
2.32.0

