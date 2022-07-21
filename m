Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB657C68C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiGUIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiGUIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:39:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEC41D36
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b9so1121501pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eXXIpwZAECFfkkq0izZcTMvjDDE7E9zOtvkutXm7Brc=;
        b=aBKcuDATeqJ6S40tt4tUzTTaKgwREE6DI+zA2hAKLd9NBOsKSAs3HIwGnKI7wmSkXe
         U7gDEInqQ13ZeqyDEqRt5/5/gu+Z9eN64DlbcNgVOnuvZQdM7wB4im6ExToTvBkuDJuE
         U2wLXnb8Vw+NpbhCcCSsaA6F0OvFP3mYn08sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXXIpwZAECFfkkq0izZcTMvjDDE7E9zOtvkutXm7Brc=;
        b=Pp7RDX23sydYFTnIcgKKiMjtY7KK5aLCsiOURz3wTu23GtL/A2KqRVGXVfs5jDa2Q8
         EHzH2tKn09TNx4hDmIj35VcD9DT65EY7GtLFXqnGCdhoiBz/ZCobYrveYm40lb+QyX3D
         16UDyYnDgwjR4kQll6cu+y6pcsyQV6oKqeIfA3AeHiKmkdYcp1JKTTcR4ouSO9tWleBq
         KQz62XeE/ibGca3v4M+uRUjfmTvjl7K2h/vyGJCM7BPdaurVm9jXN/Ww9tqKnnUFMvjd
         erJ/oM43uBwPEWdZpDnkHPjmRqs77vCQOIAutEWhUo5gV/odPQxZZsBdATJaLuVHdVX0
         vU3g==
X-Gm-Message-State: AJIora+zTUK3b9CKzFGzCijGmtPxRHorVqjWn7G946NYdZgr4glhrgkG
        JpYkETeoWnkxt3j4fV0HvkXs+g==
X-Google-Smtp-Source: AGRyM1ssLVZNcBFN4a61tzoB2/ugdBRFTMu7lXsQHwakff7xRdUs64FPxnY8/cUbpY39PYz5bVjQ/g==
X-Received: by 2002:a62:140e:0:b0:52b:780d:fb9d with SMTP id 14-20020a62140e000000b0052b780dfb9dmr17920385pfu.65.1658392746237;
        Thu, 21 Jul 2022 01:39:06 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b0016cd74e5f87sm1025943plh.240.2022.07.21.01.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:39:05 -0700 (PDT)
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
Subject: [PATCH v4 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
Date:   Thu, 21 Jul 2022 08:38:48 +0000
Message-Id: <20220721083849.1571744-3-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721083849.1571744-1-judyhsiao@chromium.org>
References: <20220721083849.1571744-1-judyhsiao@chromium.org>
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

