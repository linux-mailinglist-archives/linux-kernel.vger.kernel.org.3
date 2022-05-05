Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673851B5EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiEEC33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiEEC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:29:05 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2713D34
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:25:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3033391fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28CuiJ6+N6QUrU1lecqpYcX63v6ThU0X4857o5oV5io=;
        b=zYYJ4gxCz7Rlz1zA3z1mWjWcihgkxm223I46Ok5Nm9lfnRKOyEEWMzZ6+ESXn97qlW
         IV5hv9zyswRHnyt0KToA+32MD4BUanp/HMkpULfd1PsPCV9/mXLgQzydj1pmum//cPww
         KK1AFty7kGbDelttsupxw2rFMxaAHA3iETvL5zL0yV6FW7hfRxgKNaL5sh3FpCd3rSfo
         ZCSH59wvQxiEHX/iwhgUVeQUFOq4dNKe8BTMTlFm+6F2CUmxrMYfZG6RKf+wmHgr8uTT
         9CInciSk2RVv4qadDtYCs9fBq0QFLbQiaZCQa8Km2Ae9CxJJvxSGT699bM0dtGdb7wQg
         kibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28CuiJ6+N6QUrU1lecqpYcX63v6ThU0X4857o5oV5io=;
        b=0TPBUqeKE1KU2ol5hTNOF9ZFgBhUuIReZJH5mTw7JBLrz4qOb1ZUzy6JrkpYc8HuBv
         3BVmP0IfY4mwHeauKbly0x0W6BdcGbk8UtqSNnzpQ3uop+WBNviR+wBgqaQKAFuuGJQh
         sJAhCYGX+3I040cUM2Y6plusVO8jFY5pQ4xMEW84Z3lShzOBqnVbEM7R/hTWuV4HYljk
         9qb4wpuQPe0ei+S8SBRT1mH/Cq+So1rrach24AgG+3eA8OXoz957B3WyhII2wPFNLk/4
         uJ/dA/5QmKnsSkFv2KGj5xKC/JEiFlEKriPAkmK0SW+tOcyKXwC8hkNwFN1KirpLgMtv
         8Q/w==
X-Gm-Message-State: AOAM533y0+fPw1pMIs633kj/pCYWcIuQ62RgAdzh+Q+aEMmCCSq6zhg6
        wLzrGVKI4DTYuzCjcKVTkWQvUQ==
X-Google-Smtp-Source: ABdhPJxktucYGoCB9lE0eXnZHIeEufCSHbz5dVcWr/o3lmQYRbhh11iXphH+jQ0Mt95gTCSGsIkxWg==
X-Received: by 2002:a05:6870:1807:b0:d7:2a4c:14b8 with SMTP id t7-20020a056870180700b000d72a4c14b8mr1217692oaf.97.1651717526028;
        Wed, 04 May 2022 19:25:26 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568080a0800b00325cda1ff8csm238296oij.11.2022.05.04.19.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:25:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: db820c: Add user LEDs
Date:   Wed,  4 May 2022 19:27:06 -0700
Message-Id: <20220505022706.1692554-5-bjorn.andersson@linaro.org>
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

The db820c has 4 "user LEDs", all connected to the PMI8994. The first
three are connected to the three current sinks provided by the TRILED
and the fourth is connected to MPP2.

By utilizing the DTEST bus the MPP is fed the control signal from the
fourth LPG block, providing a consistent interface to the user.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 56e54ce4d10e..e9039e68a095 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -10,6 +10,7 @@
 #include "pmi8994.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
@@ -683,6 +684,61 @@ pinconf {
 	};
 };
 
+&pmi8994_lpg {
+	qcom,power-source = <1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmi8994_mpp2_userled4>;
+
+	qcom,dtest = <0 0>,
+		     <0 0>,
+		     <0 0>,
+		     <4 1>;
+
+	status = "okay";
+
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <1>;
+
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <0>;
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <2>;
+	};
+
+	led@4 {
+		reg = <4>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <3>;
+	};
+};
+
+&pmi8994_mpps {
+	pmi8994_mpp2_userled4: mpp2-userled4-state {
+		pins = "mpp2";
+		function = "sink";
+
+		output-low;
+		qcom,dtest = <4>;
+	};
+};
+
 &pmi8994_spmi_regulators {
 	vdd_s2-supply = <&vph_pwr>;
 
-- 
2.35.1

