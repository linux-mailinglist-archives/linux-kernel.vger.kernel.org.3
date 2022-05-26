Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970E3535497
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbiEZUi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348715AbiEZUiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:38:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA5E2772
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id rs12so5022551ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE4BNjFdqLE0+GuEKPforw6u34ofhCy2Rfxq0TB6A5c=;
        b=oidgsHlBxWTgyl8UEMdxGOEbv0if3NzKgUQfQ6gzbfw7GlEZ8DAKZbXDv+Gfi5Tg5a
         v55Pgj3p1bdPdnzZIzsU5iXkY5mLEuMqAoRyL5G6xEjO7WhLxyuLT3O2kigDwOWsSAE9
         adpvtkk7tHVu9VfnOViCi8nYwH30glJZal8TJBaWyJnkKqY43BCfGaKq2sM/a2dhj01u
         utTw1jXzZDL8GfrxtB3XqkalX6tYlCW9Moam94jpSrP/59F1ROHThuccPpHc4BITRpor
         NHsgHpe55QtObrKVOSG9BFSF1JhtCT2h4F8S/Sbs8HD05ZZCMMhoLRJk5qDv19wi547O
         yCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SE4BNjFdqLE0+GuEKPforw6u34ofhCy2Rfxq0TB6A5c=;
        b=XeJfYoKH/gWPp2U334CVWE1eYV84QvY5ESv6oxx2eE71qqTZpWoDqIlwT49k9C2aUf
         PXxaosVpuHUKq1w/Iucs4U9abhPftY1AL78r7FBlLgNXSL7S21ChTsglwA1fhywrkJSJ
         ghMJyNoZtCAQW6bXThryAml29QcXrqFBmKJrs1IOhrlcJ7UX/xGHt1HpUMPObtBNKKPe
         B8Lwb6VVn3gaM0c2kGLUz3lcw6w3cSvxgRBXJTylu5NejQrOrI77LaSY037A5EKMAjoC
         AUnZO1NQmXYdf2HTIPYNcz7RnGxdC6LSzygJihgJXQ/RLsZq0R3T1tnVMMHuhRaHhB0T
         UAag==
X-Gm-Message-State: AOAM533HbAuF/re1I57fHTSJgBBCAsmdE3rtcp7Zbc3OLOYGn2PH73al
        Bq6TTKe3ZzWecCqKlM96m1OGCg==
X-Google-Smtp-Source: ABdhPJyxzdY9k14chD6ueVnbFF/pTmmgU2qpDaplGqdPnajbWBTlH4U65Qdhrdte2YfL/oMvjT3jsA==
X-Received: by 2002:a17:907:a089:b0:6ff:29b5:49c3 with SMTP id hu9-20020a170907a08900b006ff29b549c3mr3285275ejc.86.1653597498368;
        Thu, 26 May 2022 13:38:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u19-20020a50a413000000b0042aaecf8707sm1212343edb.70.2022.05.26.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:38:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: spear: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:38:15 +0200
Message-Id: <20220526203815.831383-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/spear1310-evb.dts | 2 +-
 arch/arm/boot/dts/spear1340-evb.dts | 2 +-
 arch/arm/boot/dts/spear1340.dtsi    | 2 +-
 arch/arm/boot/dts/spear300-evb.dts  | 2 +-
 arch/arm/boot/dts/spear310-evb.dts  | 2 +-
 arch/arm/boot/dts/spear320-evb.dts  | 2 +-
 arch/arm/boot/dts/spear320-hmi.dts  | 2 +-
 arch/arm/boot/dts/spear320.dtsi     | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index ddd1cf4d0554..05408df38203 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -170,7 +170,7 @@ sdhci@b3000000 {
 
 		smi: flash@ea000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@e6000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index 3a51a41eb5e4..7700f2afc128 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -168,7 +168,7 @@ sdhci@b3000000 {
 
 		smi: flash@ea000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@e6000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index 13e1bdb3ddbf..818886e11713 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -88,7 +88,7 @@ pinmux: pinmux@e0700000 {
 		};
 
 		pwm: pwm@e0180000 {
-			compatible ="st,spear13xx-pwm";
+			compatible = "st,spear13xx-pwm";
 			reg = <0xe0180000 0x1000>;
 			#pwm-cells = <2>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/spear300-evb.dts b/arch/arm/boot/dts/spear300-evb.dts
index 2beb30ca2cba..303ef29fb805 100644
--- a/arch/arm/boot/dts/spear300-evb.dts
+++ b/arch/arm/boot/dts/spear300-evb.dts
@@ -80,7 +80,7 @@ sdhci@70000000 {
 
 		smi: flash@fc000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@f8000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index 1c41e4a40334..ea0b53036f7b 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -94,7 +94,7 @@ gmac: eth@e0800000 {
 
 		smi: flash@fc000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@f8000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index c322407a0ade..3c026d021c92 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -95,7 +95,7 @@ sdhci@70000000 {
 
 		smi: flash@fc000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@f8000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index b587e4ec11e5..34503ac9c51c 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -167,7 +167,7 @@ sdhci@70000000 {
 
 		smi: flash@fc000000 {
 			status = "okay";
-			clock-rate=<50000000>;
+			clock-rate = <50000000>;
 
 			flash@f8000000 {
 				#address-cells = <1>;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 47ac4474ed96..b12474446a48 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -78,7 +78,7 @@ spi2: spi@a6000000 {
 		};
 
 		pwm: pwm@a8000000 {
-			compatible ="st,spear-pwm";
+			compatible = "st,spear-pwm";
 			reg = <0xa8000000 0x1000>;
 			#pwm-cells = <2>;
 			status = "disabled";
-- 
2.34.1

