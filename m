Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91207510944
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354261AbiDZToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354255AbiDZTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:44:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03245074
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:41:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h12so27465379plf.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHBLKSUrfvJeR4z2zSjlQ6DB62nxgDIAj6Q5ct6EvQc=;
        b=FynNI0RzvhcEQLb1HKwvd3SFrdKvEFoLISqa9pu+Bdx1R+J7ARz0WsOmMkg8qDgehY
         O6WvAtR7F49JvixOLLypWaK1LnMVYuB+WUl4OCFN9uDNE9h0/1c+XvY4XGvDwYjsETzu
         kotsSWKtwPKn5bq/OLCyOdS9l6rexnvL9ftOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHBLKSUrfvJeR4z2zSjlQ6DB62nxgDIAj6Q5ct6EvQc=;
        b=EAi4xUEI53/+U6F3qKx2zhixnKWY7eYIXze0nVxi6IoRf85d2vInSs2xYp6JA1wHRE
         Zz6qlR457WRVv+5F94rrnk8NxcHxgW83GCgbTaXSJnxpbY46OL/n6BBSIKK0UOg4k3XZ
         Yph59NU8jRIPSig9Vcrcuhy4N/5gjAhWhAmcrpo7ctTC+qzgTzqNBeOxrJpfZS+O+XRL
         8CIClbafaKoi/ce9ZrLk/9+1gkgtsnJ2HTc6qOflCnI96G3KKD/L01qiEbuVpAaCoHUF
         cr3okoPmThu5/5H6n5ynpR4j0d57oa4PaRKKiWt35qPT2p8JZe4+rDzBRx81eFNr7vM9
         KAwA==
X-Gm-Message-State: AOAM532iSZVNvs8lgNtFs/LU2b/0enPxJjcWp897FrCYQQKAsVncDSRj
        k8p90ZBG7tPj4OT7qMIBh0v2BA==
X-Google-Smtp-Source: ABdhPJzfOXTz4m7xoa4Cs9WuoR/+eQcm95GVTCXeZnm0Oh5cGOAE33wbcOqa8gwM4KorU2HvsIe5cQ==
X-Received: by 2002:a17:902:7789:b0:156:8b5c:606f with SMTP id o9-20020a170902778900b001568b5c606fmr23971746pll.100.1651002091921;
        Tue, 26 Apr 2022 12:41:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8e92:9f42:eda6:c0ee])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a1b0c00b001cd4989febasm4036076pjq.6.2022.04.26.12.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:41:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_kalyant@quicinc.com, Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sc7280: eDP for herobrine boards
Date:   Tue, 26 Apr 2022 12:41:03 -0700
Message-Id: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eDP support to herobrine boards, splitting up amongst the
different files as makes sense. Rationale for the current split of
things:
* The eDP connector itself is on qcard. However, not all devices with
  a qcard will use an eDP panel. Some might use MIPI and, presumably,
  someone could build a device with qcard that had no display at all.
* The qcard provides a PWM for backlight that goes to the eDP
  connector. This PWM is also provided to the board and it's expected
  that it would be used as the backlight PWM even for herobrine
  devices with MIPI displays.
* It's currently assumed that all herobrine boards will have some sort
  of display, either MIPI or eDP (but not both).
* We will assume herobrine-rev1 has eDP. The schematics allow for a
  MIPI panel to be hooked up but, aside from some testing, nobody is
  doing this and most boards don't have all the parts stuffed for
  it. The two panels would also share a PWM for backlight, which is
  weird.
* herobrine-villager and herobrine-hoglin (crd) also have eDP.
* herobrine-hoglin (crd) has slightly different regulator setup for
  the backlight. It's expected that this is unique to this board. See
  comments in the dts file.
* There are some regulators that are defined in the qcard schematic
  but provided by the board like "vreg_edp_bl" and
  "vreg_edp_3p3". While we could put references to these regulators
  straight in the qcard.dtsi file, this would force someone using
  qcard that didn't provide those regulators to provide a dummy or do
  an ugly /delete-node/. Instead, we'll add references in
  herobrine.dtsi.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch most directly depends on ("arm64: dts: qcom: pm8350c: Add
pwm support") [1] and it won't even compile without that. To be
functional, of course, we also need the driver support for the PWM to
land.

In order for this patch to function we also need Sankeerth's eDP
series [2] to land.

To be schema happy, this patch also relies on my patch to add
regulators into the schema for the PHY an the eDP controller [3].
Several other device tree files reference these supplies without being
in the schema, though, so we'll have to decide whether to block on
those bindings landing. It does sound as if the regulator names may
not be exactly correct right now, though. :(

In theory, I could break this patch up into separate patches adding
the basic support to the qcard, then to herobrine.dtsi, and then one
patch each for herobrine-r1, villager, and crd. Doing so didn't seem
to make sense to me--I think it's easier to make sense of the change
as one patch. However, if someone feels strongly that it should be
broken up I'm happy to do so.

I've managed to get the display on my herobrine-rev1 up and running on
today's linuxnext (next-20220422) with this series. For whatever
reason the eDP PHY wouldn't probe unless I hacked `fw_devlink=off` in
the config. I don't believe that problem is related to this patch,
though.

[1] https://lore.kernel.org/r/1645509309-16142-4-git-send-email-quic_c_skakit@quicinc.com
[2] https://lore.kernel.org/r/1650887072-16652-1-git-send-email-quic_sbillaka@quicinc.com/
[3] https://lore.kernel.org/r/20220425210643.2420919-1-dianders@chromium.org

Changes in v2:
- Commit message and comment cleanups from Stephen.

 .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 40 ++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |  8 +++
 .../dts/qcom/sc7280-herobrine-villager-r0.dts |  8 +++
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 24 +++++++++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    | 54 +++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index b06f61e9b90b..a4ac33c4fd59 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -12,6 +12,27 @@
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
 	compatible = "google,hoglin", "qcom,sc7280";
+
+	/* FIXED REGULATORS */
+
+	/*
+	 * On most herobrine boards PPVAR_SYS directly provides VREG_EDP_BL.
+	 * However, on CRD there's an extra regulator in the way. Since this
+	 * is expected to be uncommon, we'll leave the "vreg_edp_bl" label
+	 * in the baseboard herobrine.dtsi point at "ppvar_sys" and then
+	 * make a "_crd" specific version here.
+	 */
+	vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_edp_bl_crd";
+
+		gpio = <&pm8350c_gpios 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_bl_reg_en>;
+
+		vin-supply = <&ppvar_sys>;
+	};
 };
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
@@ -81,6 +102,14 @@ ap_ts: touchscreen@5c {
 	};
 };
 
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
 /* For nvme */
 &pcie1 {
 	status = "okay";
@@ -91,6 +120,10 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pm8350c_pwm_backlight {
+	power-supply = <&vreg_edp_bl_crd>;
+};
+
 /* For eMMC */
 &sdhc_1 {
 	status = "okay";
@@ -121,6 +154,13 @@ &pm8350c_gpios {
 			  "PMIC_EDP_BL_EN",
 			  "PMIC_EDP_BL_PWM",
 			  "";
+
+	edp_bl_reg_en: edp-bl-reg-en {
+		pins = "gpio6";
+		function = "normal";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index 29c4ca095294..b69ca09d9bfb 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -100,6 +100,14 @@ ap_ts: touchscreen@5c {
 	};
 };
 
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
 /* For nvme */
 &pcie1 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index 6c2b9a14535a..d3d6ffad4eff 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -58,6 +58,14 @@ &ap_sar_sensor1 {
 	status = "okay";
 };
 
+&mdss_edp {
+	status = "okay";
+};
+
+&mdss_edp_phy {
+	status = "okay";
+};
+
 /* For nvme */
 &pcie1 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index d58045dd7334..9cb1bc8ed6b5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -367,6 +367,11 @@ &vreg_l2c_1p8 {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
+&edp_panel {
+	/* Our board provides power to the qcard for the eDP panel. */
+	power-supply = <&vreg_edp_3p3>;
+};
+
 ap_sar_sensor_i2c: &i2c1 {
 	clock-frequency = <400000>;
 	status = "disabled";
@@ -420,6 +425,14 @@ tpm@50 {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 /* NVMe drive, enabled on a per-board basis */
 &pcie1 {
 	pinctrl-names = "default";
@@ -429,6 +442,17 @@ &pcie1 {
 	vddpe-3v3-supply = <&pp3300_ssd>;
 };
 
+&pm8350c_pwm {
+	status = "okay";
+};
+
+&pm8350c_pwm_backlight {
+	status = "okay";
+
+	/* Our board provides power to the qcard for the backlight */
+	power-supply = <&vreg_edp_bl>;
+};
+
 &pmk8350_rtc {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index b833ba1e8f4a..fbd9f9fa9d3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -29,6 +29,16 @@ aliases {
 		serial0 = &uart5;
 		serial1 = &uart7;
 	};
+
+	pm8350c_pwm_backlight: backlight {
+		compatible = "pwm-backlight";
+		status = "disabled";
+
+		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_edp_bl_en>;
+		pwms = <&pm8350c_pwm 3 65535>;
+	};
 };
 
 &apps_rsc {
@@ -293,11 +303,50 @@ &ipa {
 	modem-init;
 };
 
+/* NOTE: Not all Qcards have eDP connector stuffed */
+&mdss_edp {
+	vdda-0p9-supply = <&vdd_a_edp_0_0p9>;
+	vdda-1p2-supply = <&vdd_a_edp_0_1p2>;
+
+	aux-bus {
+		edp_panel: panel {
+			compatible = "edp-panel";
+
+			backlight = <&pm8350c_pwm_backlight>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					edp_panel_in: endpoint {
+						remote-endpoint = <&mdss_edp_out>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&mdss_edp_out {
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss_edp_phy {
+	vdda-pll-supply = <&vdd_a_edp_0_0p9>;
+	vdda-phy-supply = <&vdd_a_edp_0_1p2>;
+};
+
 &pcie1_phy {
 	vdda-phy-supply = <&vreg_l10c_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
 };
 
+&pm8350c_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_edp_bl_pwm>;
+};
+
 &pmk8350_vadc {
 	pmk8350-die-temp@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
@@ -383,6 +432,11 @@ &usb_2_hsphy {
  * baseboard or board device tree, not here.
  */
 
+/* No external pull for eDP HPD, so set the internal one. */
+&edp_hot_plug_det {
+	bias-pull-down;
+};
+
 /*
  * For ts_i2c
  *
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

