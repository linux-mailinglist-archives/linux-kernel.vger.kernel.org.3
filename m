Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15451AFCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378376AbiEDU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiEDU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:56:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37351322
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:52:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so1669780ots.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78wyRzQ5DjH1PDbOlX/8S7WrCIMcVv9/em5vGahsukg=;
        b=YgyaI1cI6Edppv1Nw1S69ew6QG83NjUZuk7w4r5CMEtxbAvDepHEyY2tn0PEsfkuMd
         Tbc17mHoFbigVTi0bwFaKfZlbcUgF3UmtE3r+d+c9eexCImdGDI0GB0r9NWAijnA8Lgf
         2yOfJK5AZrjqVWmR9qnBwjP/vy2a4IPaWDYppr9K1jOQm9T+bVKvulEuxYwwETbW8plI
         BniC5yZGQ5jDOjCVLUKaswOYhEYsPmMhsvzwSXwm7hOdgvKlrckYY2sJNpbeYMXUd7ux
         36odESCpczA0CYi3LT1ZYlzo7UDE5fhBBOZp6t9xBD32+n1XRl2Y7ovD8CBd6i8DfgfW
         q3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78wyRzQ5DjH1PDbOlX/8S7WrCIMcVv9/em5vGahsukg=;
        b=VO/fLfnssZIjumhqs91oiSQG8sA/Sn03UKIOijmQCPT7OFvSoyRgm8p8Lv49IYCYQn
         047AFvjYbnlZdxiEv0rScJcONrQY+1Fm5nOIVZSvYVbEEweXiLrluvSVij3x4GJH1DPl
         ULq2Wy3izdebifltFwDtAA0pWkORD9TFlswRdkDh8ck2TBD5fko+bhW28hBfN7Z5UXfT
         FpqkaQEO7tnmrePibR3fBDchA/6WDvI1hkwhkfHDZPIEnlxf7TXU0a6WPbqiaU12VDHw
         9v4vuXRukNKDSNBwgEliT9DtHV0xJA1Yf+ehscMYuUQvsRbMK3yzbwoL9JW+88OmysLt
         b3ww==
X-Gm-Message-State: AOAM530DCLaFMV5ftCdmJy0Tw4rr0DJ2Ar9NulSJsOLWYc/6LK7KfK13
        7PnFTaH4bFlde8dBczpB7m/1Ww==
X-Google-Smtp-Source: ABdhPJxUJ6MQIvvvAVaWWkl4Rl/PdSMgsm4x6cwgJCUgJ1pXfcxcmeWi5Y98W/GpkYdYpUxHtDG2WQ==
X-Received: by 2002:a9d:6ac7:0:b0:605:a666:5c06 with SMTP id m7-20020a9d6ac7000000b00605a6665c06mr8175321otq.15.1651697549339;
        Wed, 04 May 2022 13:52:29 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q23-20020a05683031b700b0060603221234sm5520468ots.4.2022.05.04.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:52:28 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
Date:   Wed,  4 May 2022 13:54:11 -0700
Message-Id: <20220504205411.1510667-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Castor and Honami has RGB LEDs driven by the PM8941 LPG, define
these.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 30 +++++++++++++++++++
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 30 +++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 1d21de46f85c..9891d0d40945 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -172,6 +173,35 @@ gpio_keys_pin_a: gpio-keys-active {
 	};
 };
 
+&pm8941_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	rgb-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <7>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pm8941_wled {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 9bd8faea61a5..da1593192306 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -3,6 +3,7 @@
 #include "qcom-pm8841.dtsi"
 #include "qcom-pm8941.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
@@ -288,6 +289,35 @@ lcd_dcdc_en_pin_a: lcd-dcdc-en-active {
 
 };
 
+&pm8941_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	rgb-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <7>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <6>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <5>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &rpm_requests {
 	pm8941-regulators {
 		compatible = "qcom,rpm-pm8941-regulators";
-- 
2.35.1

