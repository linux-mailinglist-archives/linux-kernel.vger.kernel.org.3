Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40131466D0B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377466AbhLBWll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356350AbhLBWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:41:29 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9DC061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:38:06 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p4so1543992qkm.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0diK6zWMgOO/TArP/zyW7Q3OH2Ix/QmAaJD5h2ncz4A=;
        b=awoJJBi2hfUE1F4m4zBeadCl7t1J/j0kIXhSwFGX6yFqOZwkxe6P/bSW4g8ZTDdWuT
         F2nmwEEsbgkQdWGpLAs5PkLgoumu6Zzs4vGtmpnuS/YToak13ectEyghRz5wwFldqNCo
         PEewD/KBLHcg9CeSW9KEUva3ZVHe6At4qEQF3QcAibZgpFGTrtpUJVbdBfcC3zhuseJO
         ZS7M7gYvXuYqWyQtlXdm5inJ9Ed60JPkTE1I82zDbVpZSHL8MMrWOmy69brB5m8feFL+
         Aff8nwRH3QZQ9MjPX0R80Pj8BRPzmbSFJjUXrvtor12Fw4PaeWWSQAIipiG6PvwcmR+/
         3d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0diK6zWMgOO/TArP/zyW7Q3OH2Ix/QmAaJD5h2ncz4A=;
        b=uo+eWG4PgjhK29L9N0f4l0DqSyWIjIpsVaMqBDOZZmPp6xrEvy2KHuNYRAEF/kbg4V
         X1Ti7IOHrbICPstmj5r/qKc/hSQ7+o8R8EiO0xOme4hjQUar6G68u88yXGSHDFE+Ep4r
         3fjBLwCejujUN9LbYvTR1OrO4v9fjSLtLmbpbVJ41xYp9c2MGK1MUqhUpUDKxazIW/dM
         5Nh+fectjls/ePIgjD4fN4P5kdGLKnHs2EVrDloAR4B7r0foL5xWXy0dYQ4i9xUCdwiq
         Ng20aV2KgkB2ebrzEYEdEeNNN7bgca84O/h4XmjoSKO3nktp4GRnQ/AvbiHrA6K3fDCD
         dfqw==
X-Gm-Message-State: AOAM532K5Wde7zDeK6BUSvO2JVI4QxT1WkrsotJwhdS4XelLgPMnOCnX
        6XHfZvDJctSI0RhZhi14tmkPVw==
X-Google-Smtp-Source: ABdhPJxQVbRfr9BSZgH8u3hmZetu4szGlJHsHguzhn20DLSXmmTT3Wj/07vQC6xH6L7cnqexO/15AA==
X-Received: by 2002:a05:620a:bc8:: with SMTP id s8mr14613668qki.50.1638484685510;
        Thu, 02 Dec 2021 14:38:05 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h3sm961152qko.78.2021.12.02.14.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:38:05 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm8150: Add support for LMh node
Date:   Thu,  2 Dec 2021 17:38:01 -0500
Message-Id: <20211202223802.382068-3-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202223802.382068-1-thara.gopinath@linaro.org>
References: <20211202223802.382068-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LMh nodes for cpu cluster0 and cpu cluster1 for sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..e755d7ab78dd 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3650,6 +3650,30 @@ cpufreq_hw: cpufreq@18323000 {
 			#freq-domain-cells = <1>;
 		};
 
+		lmh_cluster1: lmh@18350800 {
+			compatible = "qcom,sm8150-lmh";
+			reg = <0 0x18350800 0 0x400>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU4>;
+			qcom,lmh-temp-arm-millicelsius = <60000>;
+			qcom,lmh-temp-low-millicelsius = <84500>;
+			qcom,lmh-temp-high-millicelsius = <85000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@18358800 {
+			compatible = "qcom,sm8150-lmh";
+			reg = <0 0x18358800 0 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius = <60000>;
+			qcom,lmh-temp-low-millicelsius = <84500>;
+			qcom,lmh-temp-high-millicelsius = <85000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		wifi: wifi@18800000 {
 			compatible = "qcom,wcn3990-wifi";
 			reg = <0 0x18800000 0 0x800000>;
-- 
2.25.1

