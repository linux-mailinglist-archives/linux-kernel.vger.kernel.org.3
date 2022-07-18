Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793E578742
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiGRQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbiGRQYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:24:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C24D13E;
        Mon, 18 Jul 2022 09:24:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so17800473wrx.12;
        Mon, 18 Jul 2022 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BXIuiTzxtlmot7xs2OPUQviOT47w/ii5+w9JsxW/x0=;
        b=d+CffPtNXOcMinD5eonNi1zv5qZ6aqIg4H9AoLlbROZTdJcB7GCbzPIt2gS9eNZJQJ
         JOXmtEtC4Bc9eheg5iOYTjHgM8atx1D4UkzmudM9pM+Ri87crv8TgTwmepj0TMTU9VXy
         MZZi0/sKUc/HA1SEL6gFa6q+o25k5RLagQjBSjwHlmMqw0MxXbubXvVJs9SyFgMr7U1G
         IapfL0Xl2J7Amp3JTUNx43D/2lCOI+kmeRN4SaVT1orF5hn2cPMwJjelQPxvZBbEIsD1
         5nvd9u+Fn5+bEzbYXo4dZJm7y3anmzsI6hVzjSYAnKODT5ji3ezCA8CP2q4YaT3670vV
         6cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BXIuiTzxtlmot7xs2OPUQviOT47w/ii5+w9JsxW/x0=;
        b=MNnETQIcP8NR3hzdHM1igsd5qxbkVj2j4yQ2Js2A/Jd8QpL7TgkpozQ/xnbd20VLOD
         W3s5I7So9r1dJ8qOisDfxA9KIsB9cX2KlOmFW5YtQBfCsuGtKDmwvznAKRIPcCvbpQhG
         0XrJ0d8ud1bOfeeGAQ6IRbFouCMYKM4MSYzVLOsVHSSLe3nwG8V5f5Ouq/x963CAurgA
         YL4gojGSZbKRrp9ayDrtHLK0E9q8F0tMF/l6qw1uBMrZgjEThZOtKJH9Fc8QwdRA4BQN
         E4VR63NMdLOXOUuo6vs4Anc785ZxBoNn8MGpZRGaCF9VfLM3Ffa5GdMQR0wmKU3Q7iTd
         VizQ==
X-Gm-Message-State: AJIora+v4JYBZELNAfhxyaO6BgpaTXyzAdRDSvOPuBCnujkZoz3/QtKK
        IjZUH7i3HH4wbFo0ikRhQsKUZzstUJE=
X-Google-Smtp-Source: AGRyM1uA27sbQ8Yn4A18XdO9CpAQD4Ku9dB5nL/li4959vSmJ0lPTTJzIWBV67c5VPa0w//XOjKo9Q==
X-Received: by 2002:adf:dd4d:0:b0:21d:f587:ac53 with SMTP id u13-20020adfdd4d000000b0021df587ac53mr9790899wrm.292.1658161439565;
        Mon, 18 Jul 2022 09:23:59 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id q6-20020a1cf306000000b003a2e92edeccsm19150824wmq.46.2022.07.18.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:23:59 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/3] ARM: dts: qcom: ipq8064: add ipq8062 variant
Date:   Mon, 18 Jul 2022 18:18:25 +0200
Message-Id: <20220718161826.4943-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718161826.4943-1-ansuelsmth@gmail.com>
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipq8062 SoC is based on ipq8064-v2.0 with lower supported freq, lack of
usb port and a reduced voltage output with the smb208 regulators.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi | 37 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8062.dtsi        |  8 +++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8062.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi
new file mode 100644
index 000000000000..9d06255104c7
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8062-smb208.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "qcom-ipq8062.dtsi"
+
+&rpm {
+	smb208_regulators: regulators {
+		compatible = "qcom,rpm-smb208-regulators";
+
+		smb208_s1a: s1a {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s1b: s1b {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2a: s2a {
+			regulator-min-microvolt = < 800000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2b: s2b {
+			regulator-min-microvolt = < 800000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom-ipq8062.dtsi
new file mode 100644
index 000000000000..5d3ebd3e2e51
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8062.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "qcom-ipq8064-v2.0.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8062";
+	compatible = "qcom,ipq8062", "qcom,ipq8064";
+};
-- 
2.36.1

