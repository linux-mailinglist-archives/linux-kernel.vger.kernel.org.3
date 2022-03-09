Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2D4D39E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiCITRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiCITQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989A1107EA;
        Wed,  9 Mar 2022 11:15:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q20so1959843wmq.1;
        Wed, 09 Mar 2022 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRu2fVfjqxFslFwqFKYpAJD6XGUCMfHi7upTim4v3aA=;
        b=eNLHSZpQCbWRVgfrrQ6UKvljItS8PHo5ZE3j1rxa+c1fLPptZfw748/fXP2E00VZcL
         GbRm4+8sG4A7mtdaEaD97ZtSHP/e7t3W0umbVP4gmUR9Z79/V8Xw1bee0BLtbj07SUx2
         +gerlCESid0a1WUR9S8cl8xsSpnoAy88j12lELxvcEpjVRfnTZfN/TFjCvr2vXVwKo6D
         /psOOzBrbGT3C90+5OcNljYqIWFju5mRTgWjVIIINkfJUmWobaWaG1YGWR+cPObiWu5w
         4o2jOMlrP/LxgsHSZ1yiifIsm1eqz88gl1DbI4ANNCNf08RBeLe8pWLVBdL5sfOVARVJ
         /aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRu2fVfjqxFslFwqFKYpAJD6XGUCMfHi7upTim4v3aA=;
        b=eG4Rtb90KUFs8CAUcDRauQYlMldIK3ukMcWBtG3OTClnfK90iFAl2tU17wP4r0PGUV
         mcpOSuY9j8ll+LBKV2FkwQ1/Jxpq2fzCn2Pn7Vb8NcJn6QogySvSrFfZo0aNNaipn9a7
         VRUdta41QLxS2S3AzbyTiOxmI6eTx8SeB4WotYaySNYAE13+sBJz6sHClSnlJ6/SusCb
         A0P5FAneQFtQmTz6ldGrSUPEVyzAIfKH0CX5VIaoDyyJ8MmWgn3lN4gG4LDbwIH/4EQ5
         KFJh1aaBb9U/rXugVskuvCMovvwuvmIwX3cICaHAOHg9fgpZFOLZq3iyV86f3CYUbAUJ
         +ziA==
X-Gm-Message-State: AOAM532+w4lPVbX6Dpf8fVTCbqYGUAp0aGfgsXf9Or6VnxQSX9l9oXp3
        q9iP9wqLcvnqgsKdvcRRFW4=
X-Google-Smtp-Source: ABdhPJwSoTDStTr4MQLoBDnr+kXg1mP+rEQvsvtnHqmnx0tTQeIPvfjY4qqICJk08i/LLVFPqS+f5w==
X-Received: by 2002:a05:600c:4f86:b0:389:d5bf:a7f3 with SMTP id n6-20020a05600c4f8600b00389d5bfa7f3mr707822wmq.49.1646853339420;
        Wed, 09 Mar 2022 11:15:39 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:38 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 17/18] ARM: dts: qcom: add ipq8064-v2.0 dtsi
Date:   Wed,  9 Mar 2022 20:01:51 +0100
Message-Id: <20220309190152.7998-18-ansuelsmth@gmail.com>
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

Many devices are based on the v2.0 of the ipq8064 SoC. Main difference
is a change in the pci compatible and different way to configre the usb
phy.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
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

