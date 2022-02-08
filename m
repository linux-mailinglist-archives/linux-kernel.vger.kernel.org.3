Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585544AE4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380085AbiBHWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386563AbiBHW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:27:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C88AC03C1BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:23:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x4so566687plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vMaF5jT9/UaEWAfDk+2t6KL6ikIYvAUy+840Rteop/E=;
        b=j7gQSdsIWiZdmU//a2QwO46EbQ5SIOH5fWGlAvhnBWPyFq4bLW/fWbmZlxZwzUEr4f
         8jomGnNxVxG+1yeClJtxG+wNefH84zBQj8X1Q+/CXgcqGY0ThDT1+d0SNl+SrNbcDLGZ
         9bNGdlRDRHEbDB/cx8WWmOR4hrIdnDY9Pb6jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMaF5jT9/UaEWAfDk+2t6KL6ikIYvAUy+840Rteop/E=;
        b=U4eLfijAck9ldjUsvSTDRG2QnXHKxdDT/4PV3tIW5COMbbhtk/CEZFYfRtmfff10Wk
         WFuLUJjqUhvEWNcybIKGLaMu2TuUYpbiGNaD1iEW79LeuCdSH5NT4/Ux3X0KsA/X9Iiy
         Ei/y9oJzu9xQrIEzlKZMzqljyQRpuLr29NYP6NCR3YF+kgZMPSDdoa/qHiMTeeWU2xhB
         7OnN+ZSsmwe7rJem48s1YeA0p5pxnJzqDdjEYzIhMzXHi4z6KQZmPyQ4C1CngB04HZIf
         bxH6DJqEbWx4lJZBBdsaTNpl1MKg/QLwGZZyhMKaztXbNA/Yoctr/EMYF+XMFNps06Eg
         KibA==
X-Gm-Message-State: AOAM533Kgsgu1PgOybncwrdofKGjvrbcjlfQytv6IyLX5LT1Q+9i3uaD
        KCC7czKn+rfFjcJ+YKaspj8J6w==
X-Google-Smtp-Source: ABdhPJxcJ61KROyKtZBAr6c9l+ods/Vf3fMBBg9aC+tckxuWCgMKjcQOdpiGoKC76Uo39dfbYIvJFQ==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr99117pjh.159.1644359025755;
        Tue, 08 Feb 2022 14:23:45 -0800 (PST)
Received: from localhost ([2620:15c:202:201:23dc:d215:b887:777d])
        by smtp.gmail.com with UTF8SMTPSA id q2sm3684055pjj.32.2022.02.08.14.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 14:23:45 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:23:43 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        robdclark@gmail.com, seanpaul@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc7280: Add support for eDP
 panel on CRD
Message-ID: <YgLtb8NCGKDi2uh4@google.com>
References: <1644333525-30920-1-git-send-email-quic_sbillaka@quicinc.com>
 <1644333525-30920-3-git-send-email-quic_sbillaka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1644333525-30920-3-git-send-email-quic_sbillaka@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 08:48:43PM +0530, Sankeerth Billakanti wrote:
> Enable the eDP display panel support without HPD on sc7280 platform.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> 
> Changes in v2:
>   - sort node references alphabetically
>   - improve readability
>   - move the pwm pinctrl to pwm node
>   - move the regulators to root
>   - define backlight power
>   - remove dummy regulator node
>   - cleanup pinctrl definitions
> 
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts | 122 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    |   2 -
>  2 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..bff2707 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -21,6 +21,34 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	backlight_power: backlight-power {

nit: the other fixed regulator in sc7280-idp.dtsi is called
'nvme_3v3_regulator', if you wanted to be consistent you
could call this backlight_3v3_regulator.

> +		compatible = "regulator-fixed";
> +		regulator-name = "backlight_power";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_power>;
> +	};
> +
> +	edp_power: edp-power {

nit: see above

> +		compatible = "regulator-fixed";
> +		regulator-name = "edp_power";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_panel_power>;
> +	};
>  };
>  
>  &apps_rsc {
> @@ -76,6 +104,42 @@ ap_ts_pen_1v8: &i2c13 {
>  	};
>  };
>  
> +&edp_out {
> +	remote-endpoint = <&edp_panel_in>;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_edp {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&mdss_edp_phy {
> +	status = "okay";
> +
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l10c_0p8>;
> +};
> +
> +&mdss_dp {

should be before 'mdss_edp'.

> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp_hot_plug_det>;
> +	data-lanes = <0 1>;
> +	vdda-1p2-supply = <&vreg_l6b_1p2>;
> +	vdda-0p9-supply = <&vreg_l1b_0p8>;
> +};
> +
> +&mdss_mdp {
> +	status = "okay";
> +};
> +
>  &nvme_3v3_regulator {
>  	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>  };
> @@ -84,7 +148,65 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> +&pm8350c_pwm {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_bl_pwm>;
> +};
> +
> +&pm8350c_gpios {

should be before 'pm8350c_pwm'

> +	edp_bl_power: edp-bl-power {
> +		pins = "gpio7";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	edp_bl_pwm: edp-bl-pwm {
> +		pins = "gpio8";
> +		function = "func1";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
> +
> +&soc {
> +	edp_backlight: edp-backlight {
> +		compatible = "pwm-backlight";
> +
> +		power-supply = <&backlight_power>;
> +		pwms = <&pm8350c_pwm 3 65535>;
> +	};
> +
> +	edp_panel: edp_panel {

in difference to labels node names should use dashes as separator, not
underscores (i.e. 'edp-panel')

> +		compatible = "sharp,lq140m1jw46";
> +
> +		power-supply = <&edp_power>;
> +		backlight = <&edp_backlight>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&edp_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &tlmm {
> +	edp_panel_power: edp-panel-power {
> +		pins = "gpio80";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
> +
>  	tp_int_odl: tp-int-odl {
>  		pins = "gpio7";
>  		function = "gpio";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 3572399..f8fa716 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3012,8 +3012,6 @@
>  
>  			mdss_edp: edp@aea0000 {
>  				compatible = "qcom,sc7280-edp";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&edp_hot_plug_det>;

This was just added a few days ago by commit 118cd3b8ec0d ("arm64: dts: qcom:
sc7280: Add edp_out port and HPD lines"). The patch assumes that the 'Hot
Plug Detect line (which functions as "panel ready" in eDP) is highly likely
to be used by boards.'. If that is indeed the case and the CRD is the
exception then it seems that deleting the two properties from the CRD DT
would be a better solution.
