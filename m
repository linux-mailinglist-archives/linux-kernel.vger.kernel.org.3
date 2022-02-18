Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD54BAE63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiBRAaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiBRAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529135E749;
        Thu, 17 Feb 2022 16:29:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w11so11755087wra.4;
        Thu, 17 Feb 2022 16:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kenzeLE/QK4xsXZwypHLjD1liPO03+eqYkLmazUP49s=;
        b=hfVBMkjM5hFowFo6txsQVXiIYjiPBU2FaQM3rzOYvLIabGfbKrTt2PCoG9nc90mDgp
         1PDSLbN93cI2m2Dq61lyGxYuC0p/KxYkgF1Qa74B90NOFbyRQKYcwP6jWSyHK/Pba3Cu
         OuwaNLgxyBbEh57Aw8EjTFWSuqe24x4dyukkShaBHWdrTPVz+OpoR8huV4Jrd2Thr85Y
         DrwlmGY7Cah8E5MVi5hmC4CHgykZ9qka7oUo0qmaY6VkQMx2FhHhXD+vsNS5xQD7rnHN
         E98CAeQv0gm3zd49DFHPHaxnMBVfMbSgxQIfnbvNZFgfHpmsVqswYCOgaOuX8SVYmYRO
         IjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kenzeLE/QK4xsXZwypHLjD1liPO03+eqYkLmazUP49s=;
        b=c4idwDoFDz+NmzHjCTsRE5jGgKISEECEmpvgn+kDg+tWa0uwuQ5c0/7ROQvZx3hPOE
         OA37ec9x909Hu/KpEWCX+nWDnIRXphhSu6UKI+2AniJka+DQ5H4dQyqNpLviy6MGbcLn
         bqg2cyT7Ju+wU6lkxlCDMo8t/SsPif5eaBnnxUejVX7phMSaVPDq99/bpOhkESbDwGQs
         m3f/CUFZ4MogDe2LIdq0sMRU/i0z2XQ36K0mhhduUF0z78KCjBLOiFodp2ujBAF380SC
         GMxPACvFMWp3WgWlLQ7D+ooUwDP+lWnSleRiArMkoHSKHgflyC1JrS6jyO9TlA6aK0WQ
         pnhw==
X-Gm-Message-State: AOAM531ErREkrS0rZOhOjNRK5cp437vX2QpXYMe8kajGEz7XL7LlZB5S
        PZkA+1phNRZn/YwxP5EETX0=
X-Google-Smtp-Source: ABdhPJw4AImeogmuit+wCghBsEiV25MP6L+To2pUlKQXGWSZ74iDUofaW6Nex7qvCv8FI9MRP+MnhA==
X-Received: by 2002:adf:e185:0:b0:1e2:6421:f2d0 with SMTP id az5-20020adfe185000000b001e26421f2d0mr4174052wrb.703.1645144196875;
        Thu, 17 Feb 2022 16:29:56 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:29:56 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 01/18] ARM: dts: qcom: add multiple missing pin definition for ipq8064
Date:   Fri, 18 Feb 2022 01:29:39 +0100
Message-Id: <20220218002956.6590-2-ansuelsmth@gmail.com>
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
2.34.1

