Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36A54BAE81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiBRAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiBRAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:31:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E98280908;
        Thu, 17 Feb 2022 16:30:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7410800wmj.2;
        Thu, 17 Feb 2022 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwXakkCqC6nmpx2sSEyZ8WtyKHDP7IREPYU/Cq/R1TI=;
        b=ezSh9CjufdmAx+UAIH25lH4nwSIZ1EqSpTg7eks5CUf63nGyhv9M8ViITSxYH1KZgU
         buLM/7ofV1KFSJc2eO2XHldysQGonZ7XphIMxOoGpOn55RG/xaOcR9eE60nTzr6Cvb+u
         6bU+WuGh8Wu/2R9YQn3UouFPUI3XYFhOIvLIB7Iup3M6MW52ZLihLwYPEnxQkQKYi6yb
         X0rEIiM5SjIQrrF0npO+gWzezbqzWHBnsmWllkU0Pi81m7xw3CH/zQKPSbYp3uQbTkI+
         Hki3A2fujtH36LkBGGxwVK9LX0Vv7dR5PyaW2b4fBy0yJhkJgHyUom9ld4qBzX1r8qO6
         yRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwXakkCqC6nmpx2sSEyZ8WtyKHDP7IREPYU/Cq/R1TI=;
        b=BedgHrFqhrJL4UaiKGKUKLo8W5H4tgZai7G9xVm0YqWs/lBzdkN2Q9nS4RR/8hl4Ys
         9+PK4EnqWVnjvQd4Y+9X/ei+7hRkXhqMgGdQsYBmKDLtYsr1FFHn6iyppbJdAoR86XyR
         SL18inQkNPOZj7XICdhpdtlns+yqfS3xdJbAr2sHqtf3HNjlkMBREEdEpLDqYqUKhXQm
         bz3Wt+EaEqv6sGW/cLcifoQJmmjum/XCgpPTY2V4AuPWijdZbYMQCkZOLdZdm5Gtzq6M
         dx1XIh9bLgXtNQ8wmie+HVG/IuLtx5GzYO/ZZt2sWZHqZU7cjzQuxkFOao2HV/O/yM0Z
         OVug==
X-Gm-Message-State: AOAM531fZnX4bDQaHLbVR+uy0GiO5NN9RLIMcY48ki+wxldThmB0HbHv
        cwFrHKLXhwi6S72Sp1GkH0w=
X-Google-Smtp-Source: ABdhPJx5uQAGsw/nGgDP4S25kKdy5cFnt7vF3amEslZJG1tB5Jv5BJhwrS/m+2KV3DbzJ2a8NNyhOQ==
X-Received: by 2002:a05:600c:1e8e:b0:37b:e97a:d4c8 with SMTP id be14-20020a05600c1e8e00b0037be97ad4c8mr8205332wmb.189.1645144211680;
        Thu, 17 Feb 2022 16:30:11 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:11 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 17/18] ARM: dts: qcom: add ipq8064-v2.0 dtsi
Date:   Fri, 18 Feb 2022 01:29:55 +0100
Message-Id: <20220218002956.6590-18-ansuelsmth@gmail.com>
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
2.34.1

