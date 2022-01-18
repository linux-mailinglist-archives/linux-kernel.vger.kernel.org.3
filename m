Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3024913A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiARBih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbiARBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E10C06161C;
        Mon, 17 Jan 2022 17:38:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t24so72830012edi.8;
        Mon, 17 Jan 2022 17:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7F6oxNjHH6hPfwoG+gLOCRkTzbus5Vn3BRvpJDh7ZlE=;
        b=R3jWsxiWNcftQZ/9W5DAErGaQ5XK9KjYl2D++OTmU7+IiMBxqx71XLyVMF8zpfFCoV
         3qTU/prXTb49tGVI5Z87GBrH4kai69k5V5HjPg/IHaUXS8pB8hpYnTOUAlRtXub/qTE1
         HF3Fc5QfkXIiOcc1O3G/ATvzvXo4VxsU5ldLgOKlq/nhZ/TRcPxE5qjXVxKwigQAnT8r
         OeAbbOY6R7EYqaLYm9KFNINwX/fcB+Ds11YIRoqMU/OOVbjCTUJ/h8+jq3rGbZ9ymTW0
         IiR9F9FVaaEVnxxvqVfcjnJuuoynR7psD95kKQZu2ogPHpQYPQXE2ol9z4zbotl74EmR
         Pmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7F6oxNjHH6hPfwoG+gLOCRkTzbus5Vn3BRvpJDh7ZlE=;
        b=1aPTo6LQhSvov0nrFuwRd3blBoAQ4TMU2UMZr5/P7lHEdesLtzlM3rqtlz8T/SW6y+
         bVtkhL8puYAzmyMLzluLXYT/kbdjnXER64XYT3Q37Feo8mMdKqYa5Zathi8QLsU0jxPg
         GZ7MvcULU/i1lmvINNQPjEIW1NixSqE9SXvsTxEscS6KF66wLvc769yK5UyVWjLYyALl
         CyeqmO4bMVUeqViAop3U84fZPdCEPV7/rkNiIjJ8Kq7qVuRblRlwaFzpsET1Qi4PFxnu
         lpHpYoT4nFkfMYspFV5CSUrixngd+L4TUYXza0ZlV5aa7HrdBTYajnDjp29qLDJF8OzD
         pWpg==
X-Gm-Message-State: AOAM532aHa4EB170nPN7+/4DFNQkhmpYH3uxjD6HmcPVP8oVwh9zhzds
        WHephgd4QAq/nzT9uDqjLm4=
X-Google-Smtp-Source: ABdhPJy/SaMMm96q+5cRlN3OZa1N+jasoEwqzcSQYMLtbb58S8RvEJDb4GPgqcc4pz0B/x3iC+nlDw==
X-Received: by 2002:a05:6402:524c:: with SMTP id t12mr13399269edd.42.1642469899869;
        Mon, 17 Jan 2022 17:38:19 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:19 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 11/17] ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
Date:   Tue, 18 Jan 2022 02:20:41 +0100
Message-Id: <20220118012051.21691-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tag for gsbi to make them usable for ipq8064 SoC. Add missing
gsbi7 i2c node and gsbi1 node.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 50 ++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b82beb297291..6f9075489e58 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -556,6 +556,41 @@ sic_non_secure: sic-non-secure@12100000 {
 			reg = <0x12100000 0x10000>;
 		};
 
+		gsbi1: gsbi@12440000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <1>;
+			reg = <0x12440000 0x100>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi1_serial: serial@12450000 {
+				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+				reg = <0x12450000 0x100>,
+				      <0x12400000 0x03>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+
+			gsbi1_i2c: i2c@12460000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x12460000 0x1000>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -579,7 +614,7 @@ gsbi2_serial: serial@12490000 {
 				status = "disabled";
 			};
 
-			i2c@124a0000 {
+			gsbi2_i2c: i2c@124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
 				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
@@ -728,6 +763,19 @@ gsbi7_serial: serial@16640000 {
 				clock-names = "core", "iface";
 				status = "disabled";
 			};
+
+			gsbi7_i2c: i2c@16680000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16680000 0x1000>;
+				interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI7_QUP_CLK>, <&gcc GSBI7_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		rng@1a500000 {
-- 
2.33.1

