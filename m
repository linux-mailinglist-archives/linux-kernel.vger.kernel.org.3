Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874BA510E79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357057AbiD0CG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357049AbiD0CGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:06:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB04C7B1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:03:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h1so355287pfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFVyvOlELL5XODI+YbD3glMBxc9SbOBZ4/P+Bbkh1ok=;
        b=eofUnvcy5TptxOPQA1Pcipte2Ep+hB2GmiPI4fCbJBoqWRIkJCD/H+E+p7eLpcLX+Q
         z6XVvQ7Js6EtWkTCUXvrk9R+xzY88GuXp9QS8YuUILl8f4BsJZO+O2bDvQcD2r+H9hND
         9i26iV5wDnbztb9DtLAVQJsiYe1S2okgGUtoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFVyvOlELL5XODI+YbD3glMBxc9SbOBZ4/P+Bbkh1ok=;
        b=WA+WdS0nX6FZpoiOz+1+4nEVbFjjsqdIUWALUdRKP/WJgi9S1pJ3eOr8l58kyM7hJ7
         MvYx8rls4l2+sgxNZUNH077tk2sBL+8hsOHjL8ZvKeFyaKJy/+Szh+85871ecfGLVnCN
         KWwm+hhv9LktoxORhFWEV0QArcsFhtBxvW6JXTMbHpW7nB1hG7q5jfjn5YPF++/puK2c
         i1wvzpCTOa1Q3M3IzeSSxOJlf/ORTZCjAseUmsXuIxKvMt1GctOkmllOhtvaFsjiuxdP
         7UaEGU+BwTIHowVp7OvV9hhfxSn8VGGlZdOg1i7jmgrtFFfRQl1VEmqSWcJxhb60pSvS
         4s1g==
X-Gm-Message-State: AOAM531J6PLbs/96zkP8AC+OohbfbETaehcsGk2hoNOsUylsY0TwclF5
        EVy4feLaHTJbM2DiQ8emUJ6zGQ==
X-Google-Smtp-Source: ABdhPJwL9hKfueg8igk3jQbIZxvAjauLxtDwfM+AFYufdTueYG+yA2TLjIHDut7uUddtED7VuxuxsQ==
X-Received: by 2002:a65:6e4d:0:b0:39d:a6ce:14dc with SMTP id be13-20020a656e4d000000b0039da6ce14dcmr21945803pgb.476.1651025024277;
        Tue, 26 Apr 2022 19:03:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:482e:60bc:84d1:bf5c])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm18324197pfc.111.2022.04.26.19.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:03:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sc7180-trogdor: Simplify trackpad enabling
Date:   Tue, 26 Apr 2022 19:03:37 -0700
Message-Id: <20220427020339.360855-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220427020339.360855-1-swboyd@chromium.org>
References: <20220427020339.360855-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor boards with a detachable keyboard don't have a trackpad over
i2c. Instead the trackpad is on the detachable keyboard base. Let's move
the enabling of the trackpad i2c bus out of the base sc7180-trogdor.dtsi
file so that each trogdor board that is detachable, of which there are
many, doesn't have to disable the trackpad bus.

Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi   | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts        | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 1 -
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index c81805ef2250..8da61a52f150 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -111,10 +111,6 @@ ap_ts: touchscreen@5d {
 	};
 };
 
-&i2c7 {
-	status = "disabled";
-};
-
 &i2c9 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index bff2b556cc75..532c7dcc3f73 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -88,10 +88,6 @@ map1 {
 	};
 };
 
-&ap_tp_i2c {
-	status = "disabled";
-};
-
 ap_ts_pen_1v8: &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index 69666f92176a..75df5d1633b2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -19,6 +19,10 @@ &ap_sar_sensor {
 	semtech,avg-pos-strength = <64>;
 };
 
+&ap_tp_i2c {
+	status = "okay";
+};
+
 /*
  * Lazor is stuffed with a 47k NTC as charger thermistor which currently is
  * not supported by the PM6150 ADC driver. Disable the charger thermal zone
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index e90f99ef5323..410ca2a76d81 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -36,6 +36,10 @@ &alc5682 {
 	realtek,dmic-clk-driving-high = "true";
 };
 
+&ap_tp_i2c {
+	status = "okay";
+};
+
 &cpu6_alert0 {
 	temperature = <60000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 457c25499863..311c42a535ff 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -20,6 +20,10 @@ / {
 	compatible = "google,trogdor", "qcom,sc7180";
 };
 
+&ap_tp_i2c {
+	status = "okay";
+};
+
 ap_ts_pen_1v8: &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index b0efb354458c..7648be83f7e4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -727,7 +727,6 @@ ap_sar_sensor: proximity@28 {
 };
 
 ap_tp_i2c: &i2c7 {
-	status = "okay";
 	clock-frequency = <400000>;
 
 	trackpad: trackpad@15 {
-- 
https://chromeos.dev

