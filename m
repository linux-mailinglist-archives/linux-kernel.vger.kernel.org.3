Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA649137B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbiARBiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243964AbiARBiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:12 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36698C061574;
        Mon, 17 Jan 2022 17:38:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 30so72949495edv.3;
        Mon, 17 Jan 2022 17:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfiPFTK7aa2/cNj8UOENvtQ7VnFmUVbOf3sQJvnWYV4=;
        b=WTYPVqiSfdWU7C3S0/+Q5zPBuuonlTlIehWUZ/1lB7HvbrAE6oNlvTc/JqEYugCwtD
         05G1I65QbLlsq967lZb2AZGKVKS+o5TVOAoBU/cVBUIl/Gk/tsrgCsppOxo7cBDm5Tpj
         vVUFHLjN+6Y+MXOLR+MFwMTnCPwZ7riHlrhqTCLMEj7MRHixwuGvINoSMSDDUtf5vhSh
         RIEtszMle3U3SsLBrxVoDtD+xatL5fOCwtFZ3QQaGQPJaNvvK7Vdnn0hNxHqJXD3X6RM
         ITRQLoVqHnK33cmkBQrAso0KcMsOXIGG4eP8FD45tyQ9F+vb7FEf2PZMQhV/AjjppnYf
         axCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfiPFTK7aa2/cNj8UOENvtQ7VnFmUVbOf3sQJvnWYV4=;
        b=BVrRAygN2TZFPNBkwFqFbH5C02BL2U2gjNaftu8Ja8oCVurf+rNtzTI6j2RuDJ8O2K
         PmK4SSBrTOm+GmcJYjE/VVmD50/KGClGbpxkZ4VznDmLtIhLtm4VFUb3Mqr1pMrriqfw
         Wo/j0BnhWlPR6h8frt0LvZTN3R66kUkUs8jNagUBOORoKRzSdbvEdqJJYgRdUtllcnqC
         i/jgnCI/v1DVSBPHrnPSuGXcsj3grHVqT5JiJo9F/ZDN/5+rGgZDKatGMEPgJRok5I3J
         YOXgzbE2DlAN0+z7HhLGa6+3588/7aziYQQkc5yezcXO+E+8fvw3/kZVr/FzXa9uIqKW
         hZiw==
X-Gm-Message-State: AOAM533w3xjAtr/SMGJYy0nbyQ66OgLwlUmJha9lZh8k2f4xyec96Ahy
        1qLfe+XNekmM2E/2/yYd7qs=
X-Google-Smtp-Source: ABdhPJwfwYOhCR/cg7EWcrbNeo1+TDArwfIPUk6X7F/BDqaJPgLGaunkc38n5S1dyUdkmNsBCLo0og==
X-Received: by 2002:a17:906:5d0e:: with SMTP id g14mr18570231ejt.171.1642469890730;
        Mon, 17 Jan 2022 17:38:10 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:10 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 01/17] ARM: dts: qcom: add multiple missing pin definition for ipq8064
Date:   Tue, 18 Jan 2022 02:20:31 +0100
Message-Id: <20220118012051.21691-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing definition for mdio0 pins used for gpio-bitbang driver,i2c4
pins and rgmii2 pins for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 11481313bdb6..cc6ca9013ab1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -382,6 +382,15 @@ mux {
 				};
 			};
 
+			i2c4_pins: i2c4_pinmux {
+				mux {
+					pins = "gpio12", "gpio13";
+					function = "gsbi4";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+
 			spi_pins: spi_pins {
 				mux {
 					pins = "gpio18", "gpio19", "gpio21";
@@ -424,6 +433,8 @@ mux {
 
 				pullups {
 					pins = "gpio39";
+					function = "nand";
+					drive-strength = <10>;
 					bias-pull-up;
 				};
 
@@ -431,9 +442,32 @@ hold {
 					pins = "gpio40", "gpio41", "gpio42",
 					       "gpio43", "gpio44", "gpio45",
 					       "gpio46", "gpio47";
+					function = "nand";
+					drive-strength = <10>;
 					bias-bus-hold;
 				};
 			};
+
+			mdio0_pins: mdio0_pins {
+				mux {
+					pins = "gpio0", "gpio1";
+					function = "mdio";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			rgmii2_pins: rgmii2_pins {
+				mux {
+					pins = "gpio27", "gpio28", "gpio29",
+					       "gpio30", "gpio31", "gpio32",
+					       "gpio51", "gpio52", "gpio59",
+					       "gpio60", "gpio61", "gpio62";
+					function = "rgmii2";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		intc: interrupt-controller@2000000 {
-- 
2.33.1

