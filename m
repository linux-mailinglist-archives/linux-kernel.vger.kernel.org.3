Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5514D39B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiCITQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiCITQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9C10EC62;
        Wed,  9 Mar 2022 11:15:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x15so4533740wru.13;
        Wed, 09 Mar 2022 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrYQbT7gB4sDOImHrOdl9Fyh1u+SphMD3vmJ53y4vnM=;
        b=E6mHSeZJbG1DWv7nhOUBAuPXNy3LA4xPMvxe/mRbrJFVUIYsKWS8GfALzF/2nhL24w
         jPiuN95fLbbc890QxfwnGDftJfeW83RQ441PuL793aR/msrdXr6h/BWp4bKvtM+MCq2m
         oypU2kYAnTwL2cuEFT0vHSWg2CK5/M+zbqF3jWIr4nh2QsbWJLit4r8YqND3aNDqxHcl
         rCOgxaEHM5/PQgQe7fvIgxg5lxYcLcQhqkIbjdPx11mqZBEeS4afpvZL4L0GitwIhfMi
         wgRkfZ/wO80IaKvuyj94BOzaqsncnkhrRdG0Ksh9stPBo8l0I92BAgbUsYA6BEZHEDDh
         C+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrYQbT7gB4sDOImHrOdl9Fyh1u+SphMD3vmJ53y4vnM=;
        b=dDot9YBVGZCV2r+BwjTITXT6R60BqZD8cy0KX3FVDyju21+++sr9DeeWCHsWPHT08K
         2BEIE1FduB0CA9V5QwYgSjwxgpc51wq+OdtmC4JzA35Us/Tlo8tX8SsEKlqtUOx3PzTe
         8M9XKvdd3F8RHFRm0CAm1DcP0YOcn+YZmXsqAJoatJuogpsr/+PJMT7nGCWOxVkvQ8K7
         JBb7lRZ1jtstV+IQ/PcHbPSt37NuvGACVFSwswTlg9C3ii3bEl2osASeVzEJ5eDFmprn
         r/8vEs1wKRElJrfvFX+m/bMU8UjqRWk/BOM4hRAsBm4TfxJ6wLbBCOkFB6aPsq77YHFi
         zHNA==
X-Gm-Message-State: AOAM531JipamO3mIr2STwrTFKRJAvAPCi+/j1/sKRw1nLMVogG3okCeg
        8BBPZRb9HkyaE31JrYFCFms=
X-Google-Smtp-Source: ABdhPJz5n2QWR1K58XDR+eT7cQgTGF92J8krM6un7qhZC2WzXkRPayHsx3l6dWwnVWbYGvNL1rdMrQ==
X-Received: by 2002:adf:f348:0:b0:1f0:6849:2b7d with SMTP id e8-20020adff348000000b001f068492b7dmr849322wrp.14.1646853317611;
        Wed, 09 Mar 2022 11:15:17 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:16 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 02/18] ARM: dts: qcom: add gsbi6 missing definition for ipq8064
Date:   Wed,  9 Mar 2022 20:01:36 +0100
Message-Id: <20220309190152.7998-3-ansuelsmth@gmail.com>
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

Add gsbi6 missing definition for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cc6ca9013ab1..b309bc0fbbcd 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -665,6 +665,46 @@ spi@1a280000 {
 			};
 		};
 
+		gsbi6: gsbi@16500000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <6>;
+			reg = <0x16500000 0x100>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi6_i2c: i2c@16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gsbi6_spi: spi@16580000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gsbi7: gsbi@16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.34.1

