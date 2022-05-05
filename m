Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD151B5E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiEEC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiEEC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:29:02 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABA12AE4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:25:24 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id m11so3048814oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jdqK6Dur5SPo0lYVwgMH9y/i4cpr1+v+A1l02sBcPXE=;
        b=tuiCr9FSJep+kbgAL7zjxv4q0EjdD4MPFudV1vifvs8o7yIRK0dXJccqAz7rjZsdcv
         Y4h4w253T0SEzBc6QTZvUPb97hHE5fD0f/PwegmvVrWb1ksP00VfxLNc1j30Ryp97tOi
         gp332t5vAlXA4ruv6uRF6n9ALOLydGs0FiLPGbr5La8KlRw52OGnz1V4TqJ9sp0IMBjH
         +dZwPvtCJASLnAuvhjhY7XG567Q9kIwaVRkkfxNnoqIoImiUA7rUPEnO4wqVH5hn5H0o
         g1La8yHLxjMKrb0hsZp1vpJJM8x670nEUkILXPRuMlGRyl6eZvGlIQ8ixOKkNDPunVbu
         IHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdqK6Dur5SPo0lYVwgMH9y/i4cpr1+v+A1l02sBcPXE=;
        b=dOXnvdCKV8zKsCkuDFnmoANvR54v0XWjz/96n+qbAJLf2IvLTDpRePOaJ/NhBGXePH
         MQ2q2/ypqn+L4XleF0nlWPabe3TM9p7wprRU7IzSXZBs+c5nT+yjNld8b5DRQt5QhxdW
         EAHcAywQKoehF3OoMsmGW79agPPsvBZY1gcGrOHOGhYPWHF+C4VqeGH1KNSUCX0dv8sf
         sov6bdEoefRL9yF5FjaSLaw8MpMxCtjl4O981OLKBcli8RIqMrzwEAQtajU3k69Q4OHA
         jQ9CO6T1eRjEqmjDBAAQeIETVEAAP74Xajat2WIaOU9xxmkFmJRMzriQ0AmXy5/189h8
         zx1g==
X-Gm-Message-State: AOAM531r407RXpSEWWdkyNqUGj4xPANsTM0Qr2Yg/US21I+9VkKSzJoS
        /eFtwZ/r0KV16c/svrQmedDO7Q==
X-Google-Smtp-Source: ABdhPJwC7eisISmz1u4nSqSApX0CR3uWLsEeNv0QU+tguMtpzU45eQvD1Bz7xMlVJrHqv+E8qzDYyA==
X-Received: by 2002:a54:468f:0:b0:322:5226:598e with SMTP id k15-20020a54468f000000b003225226598emr1252724oic.213.1651717524152;
        Wed, 04 May 2022 19:25:24 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568080a0800b00325cda1ff8csm238296oij.11.2022.05.04.19.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:25:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
Date:   Wed,  4 May 2022 19:27:04 -0700
Message-Id: <20220505022706.1692554-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
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

The DB845c has 4 "user LEDs", the last one is already supported as it's
just wired to a gpio. Now that the LPG binding is in place we can wire
up the other 3 LEDs as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..e4d3de0a1e6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -606,6 +607,36 @@ resin {
 	};
 };
 
+&pmi8998_lpg {
+	status = "okay";
+
+	qcom,power-source = <1>;
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <3>;
+
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+
+	led@4 {
+		reg = <4>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <2>;
+	};
+
+	led@5 {
+		reg = <5>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_INDICATOR;
+		function-enumerator = <1>;
+	};
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.35.1

