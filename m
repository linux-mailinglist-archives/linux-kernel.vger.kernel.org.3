Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFCE4913B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiARBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbiARBi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22488C06173E;
        Mon, 17 Jan 2022 17:38:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m4so72773926edb.10;
        Mon, 17 Jan 2022 17:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSVdYqZu+t7n9C8goCLOO4CRPlINCB2udmlWCoWNckw=;
        b=Iw6R40fP3dkSgSlhAPTtaF00jNPOfCL5VGlZYjK03IeaMF2BLK3vaS8wUyFQGCz+VT
         cBgTI4OZBNPVFBelwT1eJO1+KqMKFheVCsrobbT1u2A/YxSO4O+e5W2Ob2JaA7pwcRV3
         2T0m7dl9oCKlzJbQG6jxq868QHu8DI2k6sny0PHD/7DOYNnAvrklvimnfuHvLM6Pfuin
         oKxayTnnoqIjHqfTzr1Xy6+EkM7Wm/mFVdJUgQn96BdR2z541XuY9485KObYP845wi64
         CCa79GTLLJ5DgaaO23Q/gnTj8cammfejLX81CYCAGAprhrQe9Kd7lq3Lp9eIq6X9moU3
         Npbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSVdYqZu+t7n9C8goCLOO4CRPlINCB2udmlWCoWNckw=;
        b=bmRSKW1yyPKI8Y/ZdoC9eMpUo7f5hwQvT++7RJjGWmROPYiWLStBOck57PQceJJQfU
         cAB62byzX+qrSWN6N/g2zse6rhOCT57vhBf9i3IKNZcGYcUt7QUCYcO+DYSPaUj5jM0D
         RiEQ8A/Gcq2BME6ki0yPlHApW3RQ1fgose1yxnsFauMK3SZrueRRZuwUvMUQQDM2bKsw
         jS9jd3UqBis1jjWe26EifT7XE6DIvNiuCYQTAEXCqB98z4npG4qkiFtOcVtNP/1p1xqg
         MfOc3UuXWlncIDlT6EyHhtLOLMQxVxAVqukDidp1TLNXGjjmxlW43ZG0roJY0a2cx62k
         bNsA==
X-Gm-Message-State: AOAM531WPI/nF13pdp1G6I4rdfM3ltPR8hLXyyJvM6I92qxBbI4+MIcf
        saBvhof8tUHiH4RsAsiTfOI=
X-Google-Smtp-Source: ABdhPJy8FgXYuNYM+kI+n9wq1fX34UI9qUsX6/Iu30R6gaimebHDFgZzRI5QUD+rzoUpJzmoIG7X7Q==
X-Received: by 2002:aa7:c30f:: with SMTP id l15mr22772398edq.310.1642469906553;
        Mon, 17 Jan 2022 17:38:26 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:26 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 16/17] ARM: dts: qcom: add ipq8064-v2.0 dtsi
Date:   Tue, 18 Jan 2022 02:20:49 +0100
Message-Id: <20220118012051.21691-20-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many devices are based on the v2.0 of the ipq8064 SoC. Main difference
is a change in the pci compatible and different way to configre the usb
phy.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
new file mode 100644
index 000000000000..c082c3cd1a19
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-ipq8064.dtsi"
+
+/ {
+	aliases {
+		serial0 = &gsbi4_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rsvd@41200000 {
+			reg = <0x41200000 0x300000>;
+			no-map;
+		};
+	};
+};
+
+&gsbi4 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+
+	serial@16340000 {
+		status = "okay";
+	};
+	/*
+	 * The i2c device on gsbi4 should not be enabled.
+	 * On ipq806x designs gsbi4 i2c is meant for exclusive
+	 * RPM usage. Turning this on in kernel manifests as
+	 * i2c failure for the RPM.
+	 */
+};
+
+&CPU_SPC {
+	status = "okay";
+};
+
+&pcie0 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie1 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie2 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&sata {
+	ports-implemented = <0x1>;
+};
+
+&ss_phy_0 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
+
+&ss_phy_1 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
-- 
2.33.1

