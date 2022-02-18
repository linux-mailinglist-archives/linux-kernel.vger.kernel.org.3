Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CE4BAE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiBRAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiBRAaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D53F5EDE0;
        Thu, 17 Feb 2022 16:30:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so6905594wrg.13;
        Thu, 17 Feb 2022 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfXxys0gIqOkj8EIWl7atX09ysCcskDGiUZE+bzH3po=;
        b=jvfZNtX6wsUR5XbjXhZId1mTasjM32M7m+diQdr7jRDbnPASqblK2Q74uNIlgmA5wx
         8NAUagsgb8mt/dV9Hm/F+48yykw8buYSXnk442VMO9V63/3voQxYAj6m4WTVZvY12RL8
         QAwhks7p1I7koYGaiGYcj+alfQzgaIHou9gXDPAEmCgPu7d3rM4krLEQB1G9W2OOQFjj
         zhrlxDkshTMmzditjzxQnyXqVcUJXXNqk7cnPYOiaVocwNtBZ5UBdt+/osvUsE8ZhYSz
         wAwBnnnbm9TtPhMyf/Vls1E5bii/+4vsBRfwT7lhcdHXCvkJkVxOtMboWQoULr0+b3l7
         bBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfXxys0gIqOkj8EIWl7atX09ysCcskDGiUZE+bzH3po=;
        b=xFZqXr81/ADzevXezlRcP7qTDB0QLaOWrquF35Nyw28HL5eJMWKt82MNWdSk2c8GyM
         fl+F8BHNkbl+n0pFx18J+/7vviEvJiVjeZFQ8ghkZzGK9HDfUsIYtl2gTqDz7DlzOPoI
         mPZAxp3V8bk7HzCVG3tV0NC274HFFvAAN7fkjaySf/TriK7riaNLNN9+OkO7t2TbnCD/
         mzuBTO/ztCE6OxSMzhIX29Id9FD9KZsrT3lzarR9wsUSAPhjv3qoIA3x9LMNEZPnRtxA
         6S58PVUUDkvaQ76Gt/hOPU6aY1c9cj9TCGeVWolf0WiYJGCkTqX4CgB0zAanEVpnmufz
         QHGw==
X-Gm-Message-State: AOAM532M3BsbaKV+t21jiB2FdFdH4rhC82XBhayBVPrEybqftax4Zq73
        NPOJjCe4f5AzWHcyo5YxDdE=
X-Google-Smtp-Source: ABdhPJwTZP+282w0cpFEV3gJxtbMurSdUbhC6Djt+V0ktY83O1R/qQ0650vtMuaIw47Vz/p04R2SGg==
X-Received: by 2002:a05:6000:349:b0:1e3:2bf6:2890 with SMTP id e9-20020a056000034900b001e32bf62890mr4146038wre.225.1645144198871;
        Thu, 17 Feb 2022 16:29:58 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:29:58 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 03/18] ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
Date:   Fri, 18 Feb 2022 01:29:41 +0100
Message-Id: <20220218002956.6590-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cells definition for rpm node and add missing regulators for the 4
regulator present on ipq8064. There regulators are controlled by rpm and
to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
reject any regulator change request.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b309bc0fbbcd..0938838a4af8 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -842,10 +842,46 @@ rpm: rpm@108000 {
 			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
 			clock-names = "ram";
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			smb208_regulators: regulators {
+				compatible = "qcom,rpm-smb208-regulators";
+				status = "okay";
+
+				smb208_s1a: s1a {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s1b: s1b {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2a: s2a {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2b: s2b {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+			};
 		};
 
 		tcsr: syscon@1a400000 {
-- 
2.34.1

