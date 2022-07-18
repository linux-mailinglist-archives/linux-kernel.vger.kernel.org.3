Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1C578746
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiGRQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiGRQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:24:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836F9FE6;
        Mon, 18 Jul 2022 09:24:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v16so2000502wrr.6;
        Mon, 18 Jul 2022 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0+VW9WAfHDFP3xbpibU5Fke69H8iS3ox7I176HQdps=;
        b=YwKRewUGYwHCCfSNoxojmDu8A2dhrMyHqgdu0FzkWCJWiNc6p1YBLSTkrtXer6Q++6
         H2TDJHH4Q/Hfg/BaiP1qMYBQADRWDFQwdTrm0DcJUHwKO0DP1dzwqmQacnOryfO/cwB/
         cExTlZEUgmP6ksnLHZ9q5ImQBF9gqdxgdBGSJf9fc5oMD8NKmoSR6AofI2EGO0HScEfl
         JHVzlk8DxVi+uZEJj9FQkiXkCUebxcXGFGfkJqbD9RJ9W2SY70noF0YqFNEjPI50i9NB
         YXUK+Mcuul2ApkDK0u1DGHSftsp1r9DZp7F5gu6YrPiSZNXIYgmoRUQga2wjVQX0OgA8
         aTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0+VW9WAfHDFP3xbpibU5Fke69H8iS3ox7I176HQdps=;
        b=4nB5kuP/eUHPzCYWzfbJ7Vr3BtVJwoSdA56ihsrlXdPt92lBZ+lUDU59mVHU+MGc/k
         EQM2FKCCDkJqhbNzKBnJSlvPCxS5nIGdZDTSUJo6knhNKmucuTC0WXplC7kmutGElTsE
         6QywNHchUZnjDvuY4i0pu2RSPcSUOouzECzdMUMWelF45tY4vXZpZvE61EHrzA4CALk8
         0eZ4Wjqc1J7XQxXL2exf+abj1u/usMBYWzWz7gpOcKhDNG/Z58bhUJgJEJXpLhUY2GXn
         L8DZ7dhK96aGhoLZSWQUzW7huCMfi74Zz/+eztjQpYQ+XtUzyq+CrWKrVA8Ceclxp4oP
         W0AQ==
X-Gm-Message-State: AJIora++KJWGf1SHm/MmvPZ9FVMD7luvCAPPC4DYuI3i80qtZo27VLHK
        JNyMbHdHqhVEh0YSzMwzta0=
X-Google-Smtp-Source: AGRyM1tNHdNl9YLuNZ1bTDfv88YDJm43VHX7L/WrvbjTolNdrtnMk0Q2t2dBT8s0a/z42vKdoKvlzg==
X-Received: by 2002:a05:6000:601:b0:21d:7f3e:e231 with SMTP id bn1-20020a056000060100b0021d7f3ee231mr23565371wrb.219.1658161438342;
        Mon, 18 Jul 2022 09:23:58 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id q6-20020a1cf306000000b003a2e92edeccsm19150824wmq.46.2022.07.18.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:23:57 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
Date:   Mon, 18 Jul 2022 18:18:24 +0200
Message-Id: <20220718161826.4943-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
some additional pcie, sata and usb configuration values, additional
reserved memory and serial output.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../boot/dts/qcom-ipq8064-v2.0-smb208.dtsi    | 37 ++++++++++
 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi      | 69 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
new file mode 100644
index 000000000000..0442580b22de
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "qcom-ipq8064-v2.0.dtsi"
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
+			regulator-max-microvolt = <1250000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2b: s2b {
+			regulator-min-microvolt = < 800000>;
+			regulator-max-microvolt = <1250000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
new file mode 100644
index 000000000000..2f117d576daf
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "qcom-ipq8064.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8064-v2.0";
+
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
2.36.1

