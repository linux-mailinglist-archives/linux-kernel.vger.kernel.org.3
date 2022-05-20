Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5512852F3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353277AbiETTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346424AbiETTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:48:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267F16F912
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:48:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so8694338pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gkc82O7PaKdKkRxUJGMxoAWWDNBCmeUjeFabaWuuuZg=;
        b=PqNLOs88i2r/hYuPWzvOtUEQweTuKWXYsfEjYPk2rd/7klIufF29F59+0PBPIdTIJZ
         5/pzadMoyFy2ycDX4lw79K3IRWsGg5Pr6vHJzQ71Ta9yS59Cv3kpP5fNtyhYam864eSQ
         xRB6ough6AFryDPDrGWCf023tLe3zffF26b90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gkc82O7PaKdKkRxUJGMxoAWWDNBCmeUjeFabaWuuuZg=;
        b=ROLt5nyCIV4R3/WcMXiXvbI1vJGe4aOZwdbGaPS5oO6XgHVFHDDEyZPkejWoQwgXKZ
         o8MnaBb8lenHOwrqMAXOLlVpah6UPruGV/m92XnFcSjk/jdSKuOABC34w9sIYeZ5jRXm
         njnHCqNQJEZtp7iVqJuOWclYPdGjhC8AFFU7TFSzTRqavzRuiJCBH126FVugii8QEYad
         KdoCUqgsSYVF65JU/q9fbxp2oueN54tlWtThd5gKf8Q1SONAAxs+RrPLgTGivnSGqCEO
         O4wkMgoCZw5kMOm5hsbUQOvztgevlxFeoW+8Xlxwlr94HwX7gc8SmDGMu9TbDmtwdsXn
         2K0Q==
X-Gm-Message-State: AOAM5308uzQ67nMw9TPL3LL2Ml6v6ggBMA0RKsZwhYKyfaB37h3eBw33
        hdgRqWmdqgxyhlmsSaIpG/bnEw==
X-Google-Smtp-Source: ABdhPJytVyk99zp7E/sbxxFZ660xpfRG+5QYCHh9efeV/6QzW+Iv283XMdlmyWxdE5yGnBRQuY9dqw==
X-Received: by 2002:a17:902:ee8d:b0:161:5c5c:d0e6 with SMTP id a13-20020a170902ee8d00b001615c5cd0e6mr11597325pld.32.1653076127113;
        Fri, 20 May 2022 12:48:47 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:5332:2096:60a3:3455])
        by smtp.gmail.com with UTF8SMTPSA id q16-20020a170902eb9000b00161b50c3db4sm131915plg.94.2022.05.20.12.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 12:48:46 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: Enable keyboard backlight for villager
Date:   Fri, 20 May 2022 12:48:40 -0700
Message-Id: <20220520124834.1.I7c51c6255bb53086a82c5b3f4fafffcc5ccbc4ae@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Villager has a backlit keyboard, enable support for the backlight.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi            | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index d3d6ffad4eff..b6a6a1454883 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -58,6 +58,10 @@ &ap_sar_sensor1 {
 	status = "okay";
 };
 
+&keyboard_backlight {
+	status = "okay";
+};
+
 &mdss_edp {
 	status = "okay";
 };
@@ -76,6 +80,10 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pwmleds {
+	status = "okay";
+};
+
 /* For eMMC */
 &sdhc_1 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..4b8bdcd6d9f4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -295,7 +295,7 @@ pp1200_wf_cam: pp1200-wf-cam-regulator {
 
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
 
-	pwmleds {
+	pwmleds: pwmleds {
 		compatible = "pwm-leds";
 		status = "disabled";
 		keyboard_backlight: keyboard-backlight {
-- 
2.36.1.124.g0e6072fb45-goog

