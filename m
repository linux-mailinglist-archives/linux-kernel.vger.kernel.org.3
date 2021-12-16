Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C347693A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhLPEpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhLPEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:45:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90664C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 20:45:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a23so17353335pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 20:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVKfSXvPtNRhzT9A26cLOBfb/g0z4KWXTgdrUcPD/9s=;
        b=XthdiZ60GyuaG/zkmkCjse0tAWN5fiEApAnABL6cV7N+H7mhWXUOEGXWM0Y9LGGms5
         xsYQshkYoZ0zm+PqAad558SiTpfU+7JS2feO0u/cX9Qk23Tin740HEzU2z/j62Ow1QiC
         hkMGfXKqjNovCtPfSgNgP+Mc4tuvLueISvj5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LVKfSXvPtNRhzT9A26cLOBfb/g0z4KWXTgdrUcPD/9s=;
        b=Xxhw53W0g8mmEPL5q3aEFmfOhX3OkI5Sl45Oj3gmKuHRVH2mTXVWD/4ffvCBiCODgb
         So6RCRd6ajrsljTyfUjTLkidXlduRi7Ru5tuiHMnvK3KpWV6ySv+9g9MZcxN3/xZWfx+
         dNIXbLAQpB//A/ACxQKY/hO4K8WbjI7hu/5jT4s1vG5pf9/ra0+E06puj9AyJkweTsnq
         gp50IUNVCzOVX4BMzv+Kcrpo9tVgVIJhKUNuKsIsyckR0Wll3Aio7uZ1H3IUXRGPKrq0
         +sVlfjoBgFNjVBEjvRxmZH2K+ypJllhNjmu9aEE4GiBQyKoMTyXMhtXdIpL0j+FJHiCB
         +jGw==
X-Gm-Message-State: AOAM530vJHUQHsMLdx5J8tfmal/O33Tg3mgTyfduLqWth3NoCoE/OOPB
        i2zp+8VkMDR76+s6+7lJhAbBKQ==
X-Google-Smtp-Source: ABdhPJw1RTTEubweIfnVdMk11v7BeieG9shZJ3SUcPcflRiH39Tu2KaA8KvZqAQFZWcCotV0CXAdWg==
X-Received: by 2002:a63:88c8:: with SMTP id l191mr511784pgd.522.1639629931082;
        Wed, 15 Dec 2021 20:45:31 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:6c0f:9060:1bc2:315])
        by smtp.gmail.com with ESMTPSA id mv22sm3727720pjb.36.2021.12.15.20.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 20:45:30 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: sc7180: Add board regulators for MIPI camera trogdor boards
Date:   Wed, 15 Dec 2021 20:45:29 -0800
Message-Id: <20211216044529.733652-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some trogdor boards have on-board regulators for the MIPI camera
components. Add nodes describing these regulators so boards with these
supplies can consume them.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20211215003639.386460-1-swboyd@chromium.org):
 * Swapped order of regulators

 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  16 +++
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  16 +++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 122 ++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 14ed09f30a73..c81805ef2250 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -142,6 +142,22 @@ skin-temp-thermistor@1 {
 	};
 };
 
+&pp1800_uf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp2800_uf_cam {
+	status = "okay";
+};
+
+&pp2800_wf_cam {
+	status = "okay";
+};
+
 &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 4ab890b2a1d4..9110fed291c4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -149,6 +149,22 @@ skin-temp-thermistor@1 {
 	};
 };
 
+&pp1800_uf_cam {
+	status = "okay";
+};
+
+&pp1800_wf_cam {
+	status = "okay";
+};
+
+&pp2800_uf_cam {
+	status = "okay";
+};
+
+&pp2800_wf_cam {
+	status = "okay";
+};
+
 &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index d4f4441179fc..261339094b3c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -144,6 +144,100 @@ pp3300_a: pp3300-a-regulator {
 		vin-supply = <&ppvar_sys>;
 	};
 
+	pp1800_ec:
+	pp1800_sensors:
+	pp1800_ldo: pp1800-ldo-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_ldo";
+
+		/* EC turns on with hibernate_l; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		/*
+		 * Actually should be pp1800_h1 but we don't have any need to
+		 * model that so we use the parent of pp1800_h1.
+		 */
+		vin-supply = <&pp3300_a>;
+	};
+
+	pp1800_uf_cam: pp1800-uf-cam-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_uf_cam";
+		status = "disabled";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&uf_cam_en>;
+
+		vin-supply = <&pp1800_ldo>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	pp1800_wf_cam: pp1800-wf-cam-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_wf_cam";
+		status = "disabled";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wf_cam_en>;
+
+		vin-supply = <&pp1800_ldo>;
+		regulator-enable-ramp-delay = <1000>;
+	};
+
+	pp2800_uf_cam: pp2800-uf-cam-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pp2800_uf_cam";
+		status = "disabled";
+
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+
+		gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * The pinconf can only be referenced once so we put it on the
+		 * first regulator and comment it out here.
+		 * pinctrl-names = "default";
+		 * pinctrl-0 = <&uf_cam_en>;
+		 */
+
+		vin-supply = <&pp3300_a>;
+	};
+
+	pp2800_vcm_wf_cam:
+	pp2800_wf_cam: pp2800-wf-cam-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pp2800_wf_cam";
+		status = "disabled";
+
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+
+		gpio = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * The pinconf can only be referenced once so we put it on the
+		 * first regulator and comment it out here.
+		 * pinctrl-names = "default";
+		 * pinctrl-0 = <&wf_cam_en>;
+		 */
+
+		vin-supply = <&pp3300_a>;
+	};
+
 	pp3300_audio:
 	pp3300_codec: pp3300-codec-regulator {
 		compatible = "regulator-fixed";
@@ -1517,4 +1611,32 @@ pinconf-sd-cd {
 			drive-strength = <2>;
 		};
 	};
+
+	uf_cam_en: uf-cam-en {
+		pinmux {
+			pins = "gpio6";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio6";
+			drive-strength = <2>;
+			/* External pull down */
+			bias-disable;
+		};
+	};
+
+	wf_cam_en: wf-cam-en {
+		pinmux {
+			pins = "gpio7";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio7";
+			drive-strength = <2>;
+			/* External pull down */
+			bias-disable;
+		};
+	};
 };

base-commit: 136057256686de39cc3a07c2e39ef6bc43003ff6
-- 
https://chromeos.dev

