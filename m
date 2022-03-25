Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906914E7BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiCYVSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiCYVSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:18:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4841F90
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:16:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y6so6938902plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd2A4gk9xK3tLH00ck1BN3xfWfC5TA/QpCG6NwPucEQ=;
        b=O1s8d3XHPhekNzgBEmXvGepqjFetseGB144M4AgcKgcYAUGRE7zBo9ixCKqDgedRwg
         3rkrFv2MDg/7DN9lljYdn5rCElSaNoI+7Ig4AZnC12vkQdVqBEPgBiGlOwiw/pnPntnS
         0+Sb+PLTOltwq483DCIFmP3MN3N7byMEyE7f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qd2A4gk9xK3tLH00ck1BN3xfWfC5TA/QpCG6NwPucEQ=;
        b=gc2U8mDrmBAeB4A7/T8Can32kqEnjKLL2RgodIRFZkxZLLl29+IfJ02+ATLDvw0ISb
         JnenozVfU4L/6NnRsCbjoe0spP/8oiUatLowMbGSnpuz3sQBskEWv8zuUrRvgRobgXVx
         YlXa66MO2MzrLh1c9XVI8WYGHfmONExr04/jPk/7yoEwPUHRitKB9qIdgZaeDLrP6yaX
         gWid5XN6s18v7nBq7Wa5J9DgWq3VIad3GMup274e6HBNpzb/iuPgnqn+dcrHapsd4RYU
         Dx0APg7nqfBA1nQcx7dNHes0uknUd4KLKMWtXZM0po2PFHKr48r3tTJxAWRPcHKDdNky
         2TXw==
X-Gm-Message-State: AOAM532XmDnBqbgfePdNjSZVQUplra42DzhbVkLwZ3TeZ8kt1PhXkCxm
        INDKB0m2ofUUGmVCqfRQvjvfIQ==
X-Google-Smtp-Source: ABdhPJxp+Q2lEHiTSqcfeG0Ag2zKcaferXjcM8frFkQ1yQYCEQMyY1+Bhg5/6mkZV22bXypAf/2eqQ==
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id az5-20020a170902a58500b0014d58ef0065mr13660731plb.139.1648243002382;
        Fri, 25 Mar 2022 14:16:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5662:afcf:5e0a:c3a5])
        by smtp.gmail.com with ESMTPSA id l27-20020a63701b000000b0038233e59422sm6043022pgc.84.2022.03.25.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:16:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180-trogdor: Simply SAR sensor enabling
Date:   Fri, 25 Mar 2022 14:16:40 -0700
Message-Id: <20220325211640.54228-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SAR node, ap_sar_sensor, needs to be enabled in addition to the i2c
bus it resides on. Let's simplify this by leaving the sensor node
enabled by default while leaving the i2c bus disabled by default. On
boards that use the sensor, we already enable the i2c bus so we can
simply remove the extra bit that enables the sar sensor node. This saves
some lines but is otherwise a non-functional change.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi             | 1 -
 4 files changed, 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
index e16ba7b01f25..eb20157f6af9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dts
@@ -13,10 +13,6 @@ / {
 	compatible = "google,lazor-rev1-sku0", "google,lazor-rev2-sku0", "qcom,sc7180";
 };
 
-&ap_sar_sensor {
-	status = "okay";
-};
-
 &ap_sar_sensor_i2c {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
index c5c9feff41b8..8913592b2d82 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dts
@@ -20,10 +20,6 @@ / {
 		"qcom,sc7180";
 };
 
-&ap_sar_sensor {
-	status = "okay";
-};
-
 &ap_sar_sensor_i2c {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
index 344b57c035d0..8107f3d932eb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dts
@@ -17,10 +17,6 @@ / {
 	compatible = "google,lazor-sku0", "qcom,sc7180";
 };
 
-&ap_sar_sensor {
-	status = "okay";
-};
-
 &ap_sar_sensor_i2c {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 732e1181af48..b0efb354458c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -722,7 +722,6 @@ ap_sar_sensor: proximity@28 {
 		vdd-supply = <&pp3300_a>;
 		svdd-supply = <&pp1800_prox>;
 
-		status = "disabled";
 		label = "proximity-wifi";
 	};
 };

base-commit: 52deda9551a01879b3562e7b41748e85c591f14c
-- 
https://chromeos.dev

