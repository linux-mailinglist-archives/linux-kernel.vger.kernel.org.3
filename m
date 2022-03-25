Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE84E7B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiCYXp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiCYXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:45:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30FFC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:43:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so4927471pjk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk13iQejWKPW6c6v9tAWF5sh/iK/Ier5YfnNfQ8r5uE=;
        b=DOVxLHU3lgNxYO54K1GNToW/aF7F5LOVtIGQ8ikD1g7KY8uF+lVoP1/u7A/TP7327J
         1ERpFYvMsXJNWK8Gd9GtKZ5mICHhWz2LRL6j8tRInLAMovZBWEfNX8aMXJnpMoMA5f9d
         ImdwyID+qpNH6B9ORdSUpQpqTpJZ4x8fVWqj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk13iQejWKPW6c6v9tAWF5sh/iK/Ier5YfnNfQ8r5uE=;
        b=ndS5G1Fp0iHECIvxqiDG5B6Wn9WD5ZzJwuEehJbp4ARpOjdLbcR3wMf1ip9XrrieEJ
         rhWYHJBL8Rsy+ab7uAuUZGkYQWkb0iSpIWx+o/SrurxrnwOEfp2cko0WKtSnu90yasrY
         4GiLlDtoBWdnk1atMw2VDbn2ubjJeuoa1sHQEuFqH7b9EkjxPg5aTU6trif4IsqR5aiY
         5/CkSb7/OU3LMQjgjhltbjpZx25pbxzyO7k+86RZKbDu93T9PWL7F1IMgBVDhhIbQzqQ
         rBCAWhhgQMpM1mZjvzdascITXbKjMq+kW6BJhFmFSjaPiYMNTbFd/bzSEBa7QFqLo2zr
         AKiA==
X-Gm-Message-State: AOAM531i8cLxsEgMq9iTT3n4Ck3uJGBIqRD1msJSLM+YXR+Woe+wBmkI
        E8qG8GW0GdmWjenZ5ZCmLT+1KqxTKawjLg==
X-Google-Smtp-Source: ABdhPJz6q8SL5vfomH6P8C+VGsorw2J6novE5FAsblU6Ps6gXZCaE9TV/4OK73zHRJhVRkEwMrwpig==
X-Received: by 2002:a17:902:b697:b0:151:4c2e:48be with SMTP id c23-20020a170902b69700b001514c2e48bemr13937942pls.70.1648251826743;
        Fri, 25 Mar 2022 16:43:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5662:afcf:5e0a:c3a5])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm8684525pfl.70.2022.03.25.16.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 16:43:46 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Joseph Barrera <joebar@google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sc7180-trogdor: Simplify trackpad enabling
Date:   Fri, 25 Mar 2022 16:43:42 -0700
Message-Id: <20220325234344.199841-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220325234344.199841-1-swboyd@chromium.org>
References: <20220325234344.199841-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Cc: Joseph Barrera <joebar@google.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 4 ----
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 4 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 1 -
 4 files changed, 4 insertions(+), 9 deletions(-)

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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 732e1181af48..3bf40b6abcba 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -728,7 +728,6 @@ ap_sar_sensor: proximity@28 {
 };
 
 ap_tp_i2c: &i2c7 {
-	status = "okay";
 	clock-frequency = <400000>;
 
 	trackpad: trackpad@15 {
-- 
https://chromeos.dev

