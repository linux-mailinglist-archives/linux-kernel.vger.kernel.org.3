Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5357AFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbiGTDxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiGTDxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:53:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876146D55C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r186so15288112pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FVoMrQ6ois4pqjY2NfvYd4Y43R1rLn8yPUTWqPBDhU=;
        b=J3E9tNKbFmfsF1rRDAbB1OQuG/o4WFnJN5KkP9ZD1b+Dc8xaIE3xg2K1p2x+RAK62c
         WH97AOI9SeQrir7Y4M1/WqzPqbEcwDXu4A5GvDnot84J0wVGjxQ7EiOIy7D+4Um+Tlo9
         uBsUxxl5BaSEJE11hjXq5fFgwFAtczvULmYw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FVoMrQ6ois4pqjY2NfvYd4Y43R1rLn8yPUTWqPBDhU=;
        b=SOvuvWQtb13xlqFKwouVF4ogBb3zAW7FAE/MXAedsoYpcaFuF4U6eBbXD31ZtzPCqg
         lpb4QsBW8QB5HZ5WJKlgGlVTCbp1EhKt4KsljixwGpHcANSEhG+dKCBvE+iz2tzV3q5O
         rpwAUr4sgDG+rijVjqRf6f1VinXft7JZXf3C1TPoVYh+igy9dfdm2SyGaJ4cblQGnDV0
         zIK11gX1WBnZfGBg6gDbZTANvLVi4czTB7xFO2B9gf0InSiOsLmbbdSfs8NXY75PW8XF
         PyEYhkOm6cE/VphAQU+3pKpbTQDJtyFOrDhGsJnGvXXN21pmVS9giM9hpsa1/Rh9f7v7
         I4sA==
X-Gm-Message-State: AJIora+U/N7j42+JcN2Krbbasay7KQhtiWCSqLsZF7HjPFWtgoL50VCI
        SLTwvkChJayI+6CsGQOWG+lQkA==
X-Google-Smtp-Source: AGRyM1uax/XnTUyB6QHoF+OgeTI1E0dxY1CDBfUj26Gj3mWQ+6JCgyzrYVMhb4vzj9sO4W9qnWqWTw==
X-Received: by 2002:a63:b05:0:b0:41a:58f:f2ba with SMTP id 5-20020a630b05000000b0041a058ff2bamr15661125pgl.543.1658289190041;
        Tue, 19 Jul 2022 20:53:10 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d14b00b0016648412514sm12378346plt.188.2022.07.19.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 20:53:09 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
Date:   Wed, 20 Jul 2022 03:52:53 +0000
Message-Id: <20220720035254.1411959-3-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220720035254.1411959-1-judyhsiao@chromium.org>
References: <20220720035254.1411959-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio dtsi for sc7280 boards that using rt5682 headset codec:
1. Add dt nodes for sound card which use I2S playback and record
   through rt5682s and I2S playback through max98357a.
2. Enable lpass cpu node and add pin control and dai-links.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

Change-Id: I233ddf2c5671b6634bebcf3706569a3460e8299c
---
 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
new file mode 100644
index 000000000000..2dbdeeb29ece
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *
+ * This file defines the common audio settings for the child boards
+ * using rt5682 codec.
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+/ {
+	/* BOARD-SPECIFIC TOP LEVEL NODES */
+	sound: sound {
+		compatible = "google,sc7280-herobrine";
+		model = "sc7280-rt5682-max98360a-1mic";
+
+		status = "okay";
+		audio-routing =
+			"Headphone Jack", "HPOL",
+			"Headphone Jack", "HPOR";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dai-link@0 {
+			link-name = "MAX98360";
+			reg = <0>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
+			};
+
+			codec {
+				sound-dai = <&max98360a>;
+			};
+		};
+
+		dai-link@1 {
+			link-name = "ALC5682";
+			reg = <1>;
+
+			cpu {
+				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
+			};
+
+			codec {
+				sound-dai = <&alc5682 0 /* aif1 */>;
+			};
+		};
+	};
+};
+
+hp_i2c: &i2c2 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	alc5682: codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_irq>;
+
+		#sound-dai-cells = <1>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
+
+		AVDD-supply = <&pp1800_alc5682>;
+		MICVDD-supply = <&pp3300_codec>;
+
+		realtek,dmic1-data-pin = <1>;
+		realtek,dmic1-clk-pin = <2>;
+		realtek,jd-src = <1>;
+		realtek,dmic-clk-rate-hz = <2048000>;
+	};
+};
+
+&lpass_cpu {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
+			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	dai-link@0 {
+		reg = <MI2S_PRIMARY>;
+		qcom,playback-sd-lines = <1>;
+		qcom,capture-sd-lines = <0>;
+	};
+
+	dai-link@1 {
+		reg = <MI2S_SECONDARY>;
+		qcom,playback-sd-lines = <0>;
+	};
+};
+
+&mi2s0_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_data1 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_mclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s0_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
-- 
2.37.0.170.g444d1eabd0-goog

