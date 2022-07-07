Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4685569745
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiGGBKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGGBKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3422D1DA;
        Wed,  6 Jul 2022 18:10:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r21so1056243eju.0;
        Wed, 06 Jul 2022 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVUxHoUX8S49LOf9UWwf0cng+gray0TrmHyVxYmOxlI=;
        b=H5Z5lKHYQ/ZOetroL0v1+dOEqnm7pS6bJu0pLT4lW0LJLKNcoUio/R4u3r3YuzgEw2
         NVrHtGSZemNrfhR9rNr2zkghtu1c413krofOSO8JsMaxEcYTPgO5hzQe0xi5svYg7hJX
         jpWwN7HEXXESZJGfarmQNtWKUQsFnrkfcMHETkymbZUSeTgf7ZWRWWEXGGRafoSFcyUR
         9uDrlAvNqNd3V1PdtvfsXSD9tWtOzlpomEygEAkfIFGM/p+lIYzD+UFnbhzQcWVyJBek
         ZKVYpgJHeQenXzTIknvDQ+WeHMCWl2xooXQb4GDcwyAWy/TGlo1dir6k38uynZHOj979
         h5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVUxHoUX8S49LOf9UWwf0cng+gray0TrmHyVxYmOxlI=;
        b=jQf3NURmRBVzeZS2m5V4/hk3q0qfTDimYn1nr9sMXq+u3bxK9NcqkShQFzwq7TJ7hL
         ggb+a4yoi7wUlkD3d/+4RdR5/Xdw8okRLfTunmVKls+bcxPcsrHd9e0iwPaAIpZw0w2L
         stjVVabpzsDGzuMMkvO8oRkGRAdiesG9CjSrpx+XNV1anaGPG1mjfqQgVUc5tYJip+CR
         33aeU26R/hir/xmJ7oc35C1rmCFiJmWaNRUBRcF973geFlt1bY8iKRSoTiL/5K7UeNPZ
         2cuetVNVSxytKIcx9CkvRH6Dp59rN7ST2+ViBpRcuqVz2N1jIXep0G6uX22r8fIj0fAv
         BPAg==
X-Gm-Message-State: AJIora8HGGI5NoT/6UHi5p0YjsQJTGMimxQA6CDAwPyttPRbTFtVX7X1
        k/LqdpcvrHayhYk5qo6mF2Y=
X-Google-Smtp-Source: AGRyM1vIVA0PE6FEJfr9ycB88tNJCB0tDlMJbE/OdArU4vcfDSCCyb4Rx2OyCLKSHrG7sgVV8+C3QQ==
X-Received: by 2002:a17:906:7ac2:b0:726:38e0:4e7d with SMTP id k2-20020a1709067ac200b0072638e04e7dmr43503363ejo.236.1657156205761;
        Wed, 06 Jul 2022 18:10:05 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:05 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v2 2/8] ARM: dts: qcom: add gsbi6 missing definition for ipq8064
Date:   Thu,  7 Jul 2022 03:09:36 +0200
Message-Id: <20220707010943.20857-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Add gsbi6 missing definition for ipq8064.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index bc9987c841d0..7cccfe99bf00 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -663,6 +663,49 @@ spi@1a280000 {
 			};
 		};
 
+		gsbi6: gsbi@16500000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			reg = <0x16500000 0x100>;
+			cell-index = <6>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			status = "disabled";
+
+			gsbi6_i2c: i2c@16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			gsbi6_spi: spi@16580000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
 		gsbi7: gsbi@16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.36.1

