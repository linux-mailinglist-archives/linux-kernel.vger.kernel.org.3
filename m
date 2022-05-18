Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228052C2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiERSsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbiERSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:48:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE07229FE8;
        Wed, 18 May 2022 11:48:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so5544461ejb.4;
        Wed, 18 May 2022 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4xR0AH3E5rQf6McW3p2A8uOfbIfUKeQrN91C/yMV50=;
        b=bu0INzU1N8Nq8qn8T3l6q6vvb7+NFEg8a/ZYrgXd8RUy0a+s7qDzenAV9LWfhiCJ29
         rl1dwChQVQAea9HEFPR/j3YRj797Onghk/jZYeVlzn0iBhBp6GFbh3pB+UJEoGvzIE2i
         iG3Ry46uUgg8baoYHi1pHQdwmPEUqmlvu2RJfupuApI/MMH8hkSJ6sw04QlzxTz1tT89
         E+RAiova/yzsw5g86Cz9XexD8pJs6+osHjAWyqg5bjTbPdKElADeaHOPn0AboFX1THS3
         kUfqHWE49sc1hu8WVZhWBLEWWFWbvKVpOuq87LPjpDlC/Wna37OO32MNqho4el8nw021
         pH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4xR0AH3E5rQf6McW3p2A8uOfbIfUKeQrN91C/yMV50=;
        b=7qQ2DK3kFfUriLIeQYCKcF6LcErSmX5ZGaipMZ5sbGTxyJCwzgwHfYgwPCEFKjfbwG
         /4vV6P0Mm/MpLIbFYCIHJFh5AN80Ye4kLYZQvc+IZw6b/bxU/9DYnZpzgj/0VcQr1Awo
         B0EJ5xezPVgeO8pxXLLVpAYs3A3NIj9h+sw9V5GNrIyHraa3QeCgGwrzZp8qS2j91hMV
         Py9U7zuW5gl7BshYfx4xGjSuwbT+cWjE1juSC33f3VnIp+rVpbQFG1eJ8pOfugUTgS4o
         2w/tP5VLjd91sDwK9wQOu/jZQle2YJAcyuu6tfLZcEfZtmkMuCKD75+o4mD7GutAf06I
         uP8g==
X-Gm-Message-State: AOAM530YtKWALLTsih3aXkIhnOkyXyVGaR7xkuOEGe1koJnaF9lYVqJk
        3tw1psYPu6CaPleYYlGqLUc=
X-Google-Smtp-Source: ABdhPJz7WZDSsUusvhmfV4oySw45GZQAcTr6VqaiHZ2OKoZOxLiykjHjD1FCAa0jg84KstFaBa9NJg==
X-Received: by 2002:a17:907:7e85:b0:6f4:78f1:75b5 with SMTP id qb5-20020a1709077e8500b006f478f175b5mr913202ejc.54.1652899713856;
        Wed, 18 May 2022 11:48:33 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm1702662edt.80.2022.05.18.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:48:33 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 6/6] arm64: dts: qcom: Add PMP8074 DTSI
Date:   Wed, 18 May 2022 20:48:25 +0200
Message-Id: <20220518184825.1034976-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518184825.1034976-1-robimarko@gmail.com>
References: <20220518184825.1034976-1-robimarko@gmail.com>
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

PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
controlled via SPMI.

Since we now have support for the regulators inside of it add DTSI
for it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/pmp8074.dtsi | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
new file mode 100644
index 000000000000..0bda4997720b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@1 {
+		compatible ="qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		regulators {
+			compatible = "qcom,pmp8074-regulators";
+
+			s3: s3 {
+				regulator-name = "vdd_s3";
+				regulator-min-microvolt = <592000>;
+				regulator-max-microvolt = <1064000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			s4: s4 {
+				regulator-name = "vdd_s4";
+				regulator-min-microvolt = <712000>;
+				regulator-max-microvolt = <992000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			l11: l11 {
+				regulator-name = "l11";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
-- 
2.36.1

