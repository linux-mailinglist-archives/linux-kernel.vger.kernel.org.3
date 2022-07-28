Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A56583CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiG1LRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiG1LRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:17:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621C66AE4;
        Thu, 28 Jul 2022 04:17:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v17so1771795edc.1;
        Thu, 28 Jul 2022 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqSmRxqp0J7ys/zMG1Hi5UBxwd/taKfqFeKGDnawJ7Y=;
        b=LAMWKS1AXyGUSXBdqPdctmi7pC3sn/Mpmv5xMo+kR9c0MIXf/IzvY7n2PctJCJDAmW
         o6t9KqC8Pm2EUVKreDKRxNbpryxmJ4mjfEqGQ8S33ymSxVG3Re8NBxAKXFNuOdnzCv4G
         wNHNEGj2b1oj9H6OozE75YPenmKxJpE4fcN6nxjV2iDhc3qX7QME7CGXH3IXunjQRNG2
         ttuz49Rxvgw46+NviqCsPHxTOwaboUVUfCn1k8Zt9FCiYwsy99uMdISRRAAsHb3juZ4V
         qywzxytPUmznqO2yRZYZGCLo2XQve8bVkwqiElw3GYxJxkrkKe4nj5Q5yTJqeZb7qNyE
         LYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JqSmRxqp0J7ys/zMG1Hi5UBxwd/taKfqFeKGDnawJ7Y=;
        b=iqJOtlP0TSTKN5Q6SePaPWdELgp37gJElVKnMiFuS43hYV8jonRakXmLuMhJEZlFuI
         WpVKswHlO1qnMB+mT7LYzoEgYHgX7lR/NIHIULtVYI9gZ3V6/cCaKL6bObVdAEARe2+D
         wFigyBw3/96IkfcZp5+8BP16an2Trb0IJprKGlxlJTwZ1BF7kWCmSxYD6k5hz6rNdH+3
         ZaEamXdkIaU7P8WOZvum0MBbEj+3LkE5oKw7mJwYwCRdcggSlTWX1tlOaXlQvvVnlVWz
         gxGYS3o7MyZIA6LKGZAOq0b1xBSpXc7ezOwLT3HzA7lqNE+HaqM6N/YoeZWG4OMOuvA0
         gO5Q==
X-Gm-Message-State: AJIora8amhQ70iSkjb0nvb3J3r3/ePhH/tZmTe6VnM+ICfmALX8/492D
        EP/nhqH/5FLpY0SZHpc3ogI=
X-Google-Smtp-Source: AGRyM1vnp7tadQlas1BNvyD3BGrrb6Uqae0hVJ5/El2FaO0eX8Cyj9i1WSGy6xgudLs+fCHT4laM5A==
X-Received: by 2002:a05:6402:2786:b0:43a:dc4e:ea63 with SMTP id b6-20020a056402278600b0043adc4eea63mr27947904ede.175.1659007033982;
        Thu, 28 Jul 2022 04:17:13 -0700 (PDT)
Received: from brandenburg.sect.tu-berlin.de ([130.149.39.100])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906311000b0072b13a10477sm303894ejx.108.2022.07.28.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:16:47 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: qcom: msm8960: add references to USB1
Date:   Thu, 28 Jul 2022 13:16:35 +0200
Message-Id: <20220728111635.30540-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same USB definition as qcom-apq8064.dtsi, tested on Casio GzOne.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 991eb1948..a32073d61 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,lcc-msm8960.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
@@ -201,6 +202,37 @@ regulators {
 			};
 		};
 
+		usb1: usb@12500000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0x12500000 0x200>,
+			      <0x12500200 0x200>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc USB_HS1_XCVR_CLK>, <&gcc USB_HS1_H_CLK>;
+			clock-names = "core", "iface";
+			assigned-clocks = <&gcc USB_HS1_XCVR_CLK>;
+			assigned-clock-rates = <60000000>;
+			resets = <&gcc USB_HS1_RESET>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			ahb-burst-config = <0>;
+			phys = <&usb_hs1_phy>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs1_phy: phy {
+					compatible = "qcom,usb-hs-phy-msm8960",
+						     "qcom,usb-hs-phy";
+					clocks = <&sleep_clk>, <&cxo_board>;
+					clock-names = "sleep", "ref";
+					resets = <&usb1 0>;
+					reset-names = "por";
+					#phy-cells = <0>;
+				};
+			};
+		};
+
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
-- 
2.34.1

