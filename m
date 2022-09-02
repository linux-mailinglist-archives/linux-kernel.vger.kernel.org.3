Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1075AAD35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiIBLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiIBLLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF79E68A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:11:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c59so2190337edf.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PRMWhQ4t0M1sAk+Bnx9CnAiZiIGtII9Bf7+9S4tN2rk=;
        b=K42WY8Z04t8ao6AK0yOe8Tlfi/KHnuefjaonAFKRP/3kNLxhz+vNe272kN2waZCZQj
         5GxFT3l/UApiS0wOx4eUfIW91sfZt8MmKQ1O79r030Qp4OIQr9EELMYXKLemi2BztePM
         Vm0j/9tw4nhkr5VG5KiF8rcBldKXtvKlnbT5PPoulkPTksyz4rvCII0Jwh1gB0FbjKzn
         z9OxSc5mwQTGSvkX2a5SOx0LnLKb3iY0CJaozzqi+hVFtC/l095X0NQyP0Z6vEgHZ9R7
         pkL96RWluRQnylAP4PJUZJYDZ+MmiWMTTPwrCUtTfKRWBeqd9Vws9DrhmwQPar+LEmQV
         Hfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PRMWhQ4t0M1sAk+Bnx9CnAiZiIGtII9Bf7+9S4tN2rk=;
        b=tl5cGNTCuAr+iUA8TKNWH9sewkf7hIwNoyT6sAyL6aj+p0EJcki0N2K+JMgzQ4ujsb
         s1+OIjXJQY1OqJnO+zO7Q/zWrXNMc+Bwf1r6UwUfcu2tiIH/e7D+bBoXAdMwdowluNsC
         J+Zc1Be9DFKNy6TrRdu01/qGtjGvI9toOoU915eMr2/HsIw42gD8nRHUfx8QcfSadOIQ
         AJjOZp3k4DDxNYYEXD5VfmxxEeGAnHDNjuXfG7iLuAUHSYll3kQfwwyEhp14gkjBLltd
         HgZR9jEGHfMNHBDy6/BGpr63nTYRjc8hO3RkMrshhf/ugy62WOHHdHFptTFCsnJcc0A/
         io7Q==
X-Gm-Message-State: ACgBeo3uxLcGjUX5q5smMJueyX68KTECtqnRfxbmGwM2G8BrBb3E5p9H
        zGd8GGVDdKWFlLyb8X1BQ4J3CA==
X-Google-Smtp-Source: AA6agR7y+kXFWFRqyJc/ceQtIQXv6k+bSzUFmy4sBqNhPw7LEiln9z7ysyeiwj6cbIMen9IoJiK+Sw==
X-Received: by 2002:a05:6402:524b:b0:448:6824:8788 with SMTP id t11-20020a056402524b00b0044868248788mr21156865edd.227.1662117066948;
        Fri, 02 Sep 2022 04:11:06 -0700 (PDT)
Received: from otso.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl. [31.151.115.246])
        by smtp.gmail.com with ESMTPSA id h1-20020a50cdc1000000b004483624d550sm1245624edj.71.2022.09.02.04.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 04:11:06 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add pm7250b PMIC
Date:   Fri,  2 Sep 2022 13:10:55 +0200
Message-Id: <20220902111055.106814-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902111055.106814-1-luca.weiss@fairphone.com>
References: <20220902111055.106814-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM7250B is primarily used for charger and fuel gauge on Fairphone 4
but also has some thermal zones that we can configure already.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index c76abe7587b4..30c94fd4fe61 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -12,6 +12,7 @@
 #include "sm7225.dtsi"
 #include "pm6150l.dtsi"
 #include "pm6350.dtsi"
+#include "pm7250b.dtsi"
 
 / {
 	model = "Fairphone 4";
@@ -70,6 +71,36 @@ memory@efe01000 {
 			qcom,vmid = <15>;
 		};
 	};
+
+	thermal-zones {
+		chg-skin-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm7250b_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
+		conn-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm7250b_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
 
 &adsp {
@@ -353,6 +384,42 @@ &pm6350_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm7250b_adc {
+	adc-chan@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "charger_skin_therm";
+	};
+
+	adc-chan@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "conn_therm";
+	};
+};
+
+&pm7250b_adc_tm {
+	status = "okay";
+
+	charger-skin-therm@0 {
+		reg = <0>;
+		io-channels = <&pm7250b_adc ADC5_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	conn-therm@1 {
+		reg = <1>;
+		io-channels = <&pm7250b_adc ADC5_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.37.3

