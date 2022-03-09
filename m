Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34F34D39A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiCITQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiCITQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729C10EC62;
        Wed,  9 Mar 2022 11:15:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r6so4155615wrr.2;
        Wed, 09 Mar 2022 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPb0ZHaX4n2j/HuJtdDVFRVrvshVUuEuH9P0kN+WquE=;
        b=J/cJRDGqCuR41sqLsRnLfoD7L4HbAUMvKHYTip5ACUyfdch+8TxvfJz7Lq7k3l83lF
         EOAHBz/eapTwghajTYPjhtCksQCCl4uFvgQtqqAOgxD6ygf3El5z+nAU0NZC03pVZIMd
         HPjiYtxKNBTwcRp6dFQkIUd4QBX8NvkGceET0TrWw3OZt8EJscO0KaTzqoG8A5Yq1eWV
         NKmuESyWW+zWxZPccnCeorGi07zkg8oBUWnoKi3LgvSzMMqWsWWspGZ7NyyyuPKsM8VI
         JUDbIVtxqqQyJ/XTk2LoqYCA5WUimDHIkrmI7DyKa57H9rjzAJHXauvMjtulwIQF33Gx
         hRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPb0ZHaX4n2j/HuJtdDVFRVrvshVUuEuH9P0kN+WquE=;
        b=Mkr8EQd5tDPH2V4ZnoedKS071wF+RH3nQC0N4oiqZIOLQ5FhyEvmaoePSGq/GiUt4L
         7C4CX2wcFgRD5SkvF3dT/yLtqCicSZ+mlpRukg3xknDiV/vHPJJlQQYgm4+bHrU3irdi
         K+IPJDCx0ccVT4BwOJJIHU9pQghLSMUixNTPAQE/QTNAN2Adtc6oC9N+ffUZTyZfhUUo
         oXRyveB7oOwSNBZopm5/7qRRVV5S4A5pD4k7b6Na04s8hqr2KYKVKdcqAOoCp7qYNvOg
         yQSgCzMKSLuqGKe4bY+4vudyQriPyssl58UYwf1lpoCuodRXxrHMJWyDNCFckjZ+b+xd
         gdPw==
X-Gm-Message-State: AOAM533rTrVJihn77drEJ6XZ2+SfP8TIzMVzKZqjQRquBrK1vG0uwEye
        9ASXo8aYfJi+reodebqQIp0AucjCXFI=
X-Google-Smtp-Source: ABdhPJzUaI7K0kdW0OW/BykvJZUJPfbQSMNy5mV5WZma/gyDrT/JdFQpokZxTf/+bzuRh4jJmYlz3A==
X-Received: by 2002:adf:f5c5:0:b0:1ed:bc44:63e4 with SMTP id k5-20020adff5c5000000b001edbc4463e4mr870158wrp.236.1646853315795;
        Wed, 09 Mar 2022 11:15:15 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:15 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 01/18] ARM: dts: qcom: add multiple missing pin definition for ipq8064
Date:   Wed,  9 Mar 2022 20:01:35 +0100
Message-Id: <20220309190152.7998-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add missing definition for mdio0 pins used for gpio-bitbang driver,i2c4
pins and rgmii2 pins for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
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
2.34.1

