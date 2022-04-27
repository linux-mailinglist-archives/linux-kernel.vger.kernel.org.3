Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC845124CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiD0Vye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiD0Vyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:54:32 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C5AFB1D;
        Wed, 27 Apr 2022 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651096280; x=1682632280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8I14VeqMPF4ghSzGtIuWUq5aqg2zUESeOXmhbVuXIJs=;
  b=y4Y4yX20eOKYo95j+vMWAscowLT2ym0TDdxEeDBjtpMIu3lvrUKBumD/
   rrQXbVlr1XnuQlUsJIppcCV+PvCbshrkkC70/U823oRZsKIBVYUIzrW0D
   zayYSttr1ry6VlqTHsvPfAKmmQedj8IFfTcWlqQ4Y4Dvg9CD08pwerPgT
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 14:51:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 14:51:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 14:51:18 -0700
Received: from [10.111.160.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 14:51:16 -0700
Message-ID: <13730a90-b0d2-e2c3-4512-c57cd8a472a6@quicinc.com>
Date:   Wed, 27 Apr 2022 14:51:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: eDP for herobrine boards
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <quic_kalyant@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have reviewed all the display bits in this and they are in-line with

https://patchwork.kernel.org/project/linux-arm-msm/patch/1647452154-16361-3-git-send-email-quic_sbillaka@quicinc.com/

which is a working reference for this.

Hence,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

On 4/26/2022 12:41 PM, Douglas Anderson wrote:
> Add eDP support to herobrine boards, splitting up amongst the
> different files as makes sense. Rationale for the current split of
> things:
> * The eDP connector itself is on qcard. However, not all devices with
>    a qcard will use an eDP panel. Some might use MIPI and, presumably,
>    someone could build a device with qcard that had no display at all.
> * The qcard provides a PWM for backlight that goes to the eDP
>    connector. This PWM is also provided to the board and it's expected
>    that it would be used as the backlight PWM even for herobrine
>    devices with MIPI displays.
> * It's currently assumed that all herobrine boards will have some sort
>    of display, either MIPI or eDP (but not both).
> * We will assume herobrine-rev1 has eDP. The schematics allow for a
>    MIPI panel to be hooked up but, aside from some testing, nobody is
>    doing this and most boards don't have all the parts stuffed for
>    it. The two panels would also share a PWM for backlight, which is
>    weird.
> * herobrine-villager and herobrine-hoglin (crd) also have eDP.
> * herobrine-hoglin (crd) has slightly different regulator setup for
>    the backlight. It's expected that this is unique to this board. See
>    comments in the dts file.
> * There are some regulators that are defined in the qcard schematic
>    but provided by the board like "vreg_edp_bl" and
>    "vreg_edp_3p3". While we could put references to these regulators
>    straight in the qcard.dtsi file, this would force someone using
>    qcard that didn't provide those regulators to provide a dummy or do
>    an ugly /delete-node/. Instead, we'll add references in
>    herobrine.dtsi.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch most directly depends on ("arm64: dts: qcom: pm8350c: Add
> pwm support") [1] and it won't even compile without that. To be
> functional, of course, we also need the driver support for the PWM to
> land.
> 
> In order for this patch to function we also need Sankeerth's eDP
> series [2] to land.
> 
> To be schema happy, this patch also relies on my patch to add
> regulators into the schema for the PHY an the eDP controller [3].
> Several other device tree files reference these supplies without being
> in the schema, though, so we'll have to decide whether to block on
> those bindings landing. It does sound as if the regulator names may
> not be exactly correct right now, though. :(
> 
> In theory, I could break this patch up into separate patches adding
> the basic support to the qcard, then to herobrine.dtsi, and then one
> patch each for herobrine-r1, villager, and crd. Doing so didn't seem
> to make sense to me--I think it's easier to make sense of the change
> as one patch. However, if someone feels strongly that it should be
> broken up I'm happy to do so.
> 
> I've managed to get the display on my herobrine-rev1 up and running on
> today's linuxnext (next-20220422) with this series. For whatever
> reason the eDP PHY wouldn't probe unless I hacked `fw_devlink=off` in
> the config. I don't believe that problem is related to this patch,
> though.
> 
> [1] https://lore.kernel.org/r/1645509309-16142-4-git-send-email-quic_c_skakit@quicinc.com
> [2] https://lore.kernel.org/r/1650887072-16652-1-git-send-email-quic_sbillaka@quicinc.com/
> [3] https://lore.kernel.org/r/20220425210643.2420919-1-dianders@chromium.org
> 
> Changes in v2:
> - Commit message and comment cleanups from Stephen.
> 
>   .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 40 ++++++++++++++
>   .../qcom/sc7280-herobrine-herobrine-r1.dts    |  8 +++
>   .../dts/qcom/sc7280-herobrine-villager-r0.dts |  8 +++
>   .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 24 +++++++++
>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    | 54 +++++++++++++++++++
>   5 files changed, 134 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index b06f61e9b90b..a4ac33c4fd59 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -12,6 +12,27 @@
>   / {
>   	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
>   	compatible = "google,hoglin", "qcom,sc7280";
> +
> +	/* FIXED REGULATORS */
> +
> +	/*
> +	 * On most herobrine boards PPVAR_SYS directly provides VREG_EDP_BL.
> +	 * However, on CRD there's an extra regulator in the way. Since this
> +	 * is expected to be uncommon, we'll leave the "vreg_edp_bl" label
> +	 * in the baseboard herobrine.dtsi point at "ppvar_sys" and then
> +	 * make a "_crd" specific version here.
> +	 */
> +	vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_edp_bl_crd";
> +
> +		gpio = <&pm8350c_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
>   };
>   
>   /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> @@ -81,6 +102,14 @@ ap_ts: touchscreen@5c {
>   	};
>   };
>   
> +&mdss_edp {
> +	status = "okay";
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +};
> +
>   /* For nvme */
>   &pcie1 {
>   	status = "okay";
> @@ -91,6 +120,10 @@ &pcie1_phy {
>   	status = "okay";
>   };
>   
> +&pm8350c_pwm_backlight {
> +	power-supply = <&vreg_edp_bl_crd>;
> +};
> +
>   /* For eMMC */
>   &sdhc_1 {
>   	status = "okay";
> @@ -121,6 +154,13 @@ &pm8350c_gpios {
>   			  "PMIC_EDP_BL_EN",
>   			  "PMIC_EDP_BL_PWM",
>   			  "";
> +
> +	edp_bl_reg_en: edp-bl-reg-en {
> +		pins = "gpio6";
> +		function = "normal";
> +		bias-disable;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +	};
>   };
>   
>   &tlmm {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index 29c4ca095294..b69ca09d9bfb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -100,6 +100,14 @@ ap_ts: touchscreen@5c {
>   	};
>   };
>   
> +&mdss_edp {
> +	status = "okay";
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +};
> +
>   /* For nvme */
>   &pcie1 {
>   	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> index 6c2b9a14535a..d3d6ffad4eff 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> @@ -58,6 +58,14 @@ &ap_sar_sensor1 {
>   	status = "okay";
>   };
>   
> +&mdss_edp {
> +	status = "okay";
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +};
> +
>   /* For nvme */
>   &pcie1 {
>   	status = "okay";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index d58045dd7334..9cb1bc8ed6b5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -367,6 +367,11 @@ &vreg_l2c_1p8 {
>   
>   /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>   
> +&edp_panel {
> +	/* Our board provides power to the qcard for the eDP panel. */
> +	power-supply = <&vreg_edp_3p3>;
> +};
> +
>   ap_sar_sensor_i2c: &i2c1 {
>   	clock-frequency = <400000>;
>   	status = "disabled";
> @@ -420,6 +425,14 @@ tpm@50 {
>   	};
>   };
>   
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>   /* NVMe drive, enabled on a per-board basis */
>   &pcie1 {
>   	pinctrl-names = "default";
> @@ -429,6 +442,17 @@ &pcie1 {
>   	vddpe-3v3-supply = <&pp3300_ssd>;
>   };
>   
> +&pm8350c_pwm {
> +	status = "okay";
> +};
> +
> +&pm8350c_pwm_backlight {
> +	status = "okay";
> +
> +	/* Our board provides power to the qcard for the backlight */
> +	power-supply = <&vreg_edp_bl>;
> +};
> +
>   &pmk8350_rtc {
>   	status = "disabled";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index b833ba1e8f4a..fbd9f9fa9d3a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -29,6 +29,16 @@ aliases {
>   		serial0 = &uart5;
>   		serial1 = &uart7;
>   	};
> +
> +	pm8350c_pwm_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		status = "disabled";
> +
> +		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_edp_bl_en>;
> +		pwms = <&pm8350c_pwm 3 65535>;
> +	};
>   };
>   
>   &apps_rsc {
> @@ -293,11 +303,50 @@ &ipa {
>   	modem-init;
>   };
>   
> +/* NOTE: Not all Qcards have eDP connector stuffed */
> +&mdss_edp {
> +	vdda-0p9-supply = <&vdd_a_edp_0_0p9>;
> +	vdda-1p2-supply = <&vdd_a_edp_0_1p2>;
> +
> +	aux-bus {
> +		edp_panel: panel {
> +			compatible = "edp-panel";
> +
> +			backlight = <&pm8350c_pwm_backlight>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					edp_panel_in: endpoint {
> +						remote-endpoint = <&mdss_edp_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_edp_out {
> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
> +&mdss_edp_phy {
> +	vdda-pll-supply = <&vdd_a_edp_0_0p9>;
> +	vdda-phy-supply = <&vdd_a_edp_0_1p2>;
> +};
> +
>   &pcie1_phy {
>   	vdda-phy-supply = <&vreg_l10c_0p88>;
>   	vdda-pll-supply = <&vreg_l6b_1p2>;
>   };
>   
> +&pm8350c_pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pmic_edp_bl_pwm>;
> +};
> +
>   &pmk8350_vadc {
>   	pmk8350-die-temp@3 {
>   		reg = <PMK8350_ADC7_DIE_TEMP>;
> @@ -383,6 +432,11 @@ &usb_2_hsphy {
>    * baseboard or board device tree, not here.
>    */
>   
> +/* No external pull for eDP HPD, so set the internal one. */
> +&edp_hot_plug_det {
> +	bias-pull-down;
> +};
> +
>   /*
>    * For ts_i2c
>    *
