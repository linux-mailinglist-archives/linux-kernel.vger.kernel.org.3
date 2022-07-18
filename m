Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545F1578743
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiGRQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbiGRQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:24:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F334DF79;
        Mon, 18 Jul 2022 09:24:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so2000636wrr.6;
        Mon, 18 Jul 2022 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTuKiW+NEzqVP6Zl8LDwB5peMSvo60+Ram+tJ6Y05DI=;
        b=KVdXvgqm89PHHATuLfHJBXQjSlaJg2b45TnP4lQ49H3b7w0xfNnKHmSL+ncPanyoqE
         xkmO5zvTfvRgzQ3OQQXOJsLDdLVMmKbuPdec1ESnvLBm7EV9LghUpMEOm/12tTc6skrX
         3jOur5sWHWm6JZiClL20+rTCWfzz3DatzPNSDdO6FWrDa+G59C2xVvZeWtHwiTF8RTfm
         KcZQihURNLcoUElrmfxLTpd+dMhAR2oK8MwM5FfCmy0qxDriDD5cjMv0aYHo45cgq7FL
         aZTGoxYsBlWSXGRRRcD5hQjxLL9CA5JFD1s/ZeorM1HO8zDx1oNJ36mjwdTLOxj1DL28
         OZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTuKiW+NEzqVP6Zl8LDwB5peMSvo60+Ram+tJ6Y05DI=;
        b=i31w1XiRIet9pkz5/t2JTNW+i1/Hnfow23DtTrf4navlMrM2+3cGyuUtx7PpJDNgVy
         k5fXdwuPzVXD1dfDtvDOFOFe0C7Sm+cuwj7MZ2HG7aga74Lq9gdRZCOLZP/DvKGOAYfr
         3fkt3u8A6JDiCTNVYDpub7ze/qjl8sqMKtuo3JnAFIfsv8IUO8pdy8GqWFkYVqkyN2jw
         glRGvDwHUc72VI6QTO2KXhcwU/E14VVRvf/8fQYVvAhgcFUdW7FWtNXOl+lkyuoNEBmI
         TIXtcInCV0F8JgiAHVOSIswvuBSE52pbm6BSkeaeDxcypYfjVF6ZQFBaDGlZgjBVriS5
         cSgg==
X-Gm-Message-State: AJIora/ZeXYewkcP3J10Q/5tcPcAojcsyNzF+ot9rsRfDiFpQsqfpP4z
        KrQH/upMwVvZSwRNyezBDw0=
X-Google-Smtp-Source: AGRyM1u/TPPPuglxmceIjz+V7UnT6FIlHw/IgtoQi0ZhumjIII6EjGfurB5hlUjahVYhCO2GYh5uqg==
X-Received: by 2002:adf:fe81:0:b0:21b:88ea:6981 with SMTP id l1-20020adffe81000000b0021b88ea6981mr24744679wrr.616.1658161440708;
        Mon, 18 Jul 2022 09:24:00 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id q6-20020a1cf306000000b003a2e92edeccsm19150824wmq.46.2022.07.18.09.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:24:00 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/3] ARM: dts: qcom: ipq8064: add ipq8065 variant
Date:   Mon, 18 Jul 2022 18:18:26 +0200
Message-Id: <20220718161826.4943-3-ansuelsmth@gmail.com>
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

ipq8065 SoC is based on ipq8064-v2.0 with a more clocked CPU and
an increased voltage output with the smb208 regulators.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi | 37 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq8065.dtsi        |  8 +++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi
new file mode 100644
index 000000000000..803e6ff99ef8
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8065-smb208.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "qcom-ipq8065.dtsi"
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
+			regulator-min-microvolt = <775000>;
+			regulator-max-microvolt = <1275000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2b: s2b {
+			regulator-min-microvolt = <775000>;
+			regulator-max-microvolt = <1275000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq8065.dtsi b/arch/arm/boot/dts/qcom-ipq8065.dtsi
new file mode 100644
index 000000000000..ea49f6cc416d
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8065.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "qcom-ipq8064-v2.0.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ8065";
+	compatible = "qcom,ipq8065", "qcom,ipq8064";
+};
-- 
2.36.1

