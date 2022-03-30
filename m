Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3444ECA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbiC3RSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbiC3RSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:18:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE76CA57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:16:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so21100875plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cp6lFLTphQ3Deq4H0+a0uRQ+P8BapY6dZKm1M1RzBpk=;
        b=BF7YAqQUmzdmP/sXeEGABfOEXWbxtX6tKcEXAZjjmEWZFTkJIBPIitHJTcjm7l5nFC
         6XqNYe9QdQ1+w4ebzz9Usy1Xg3NCAsdpCKZDyvQpqrIToxGHADAzyFtdDv0mLAptTylA
         pud92Bg7hiZMLJVI0rCd29OivOvHVr+a13gKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cp6lFLTphQ3Deq4H0+a0uRQ+P8BapY6dZKm1M1RzBpk=;
        b=r50Tz+V8tIzgAm7ZYmHcYnBXHTC4yKh7T6ifaSkYoUbZx/qsZEsnlSt7SJfWpFnuNc
         PqP6Rk6N0j2Pv40Nf3PQHh2bfV9n9OMkYmUQD8vD8V4bLApFUexDdMn48u/OCOWa8O09
         4rrMwaqbsDqwhHoFRrXApJvv3Wq67lbmmUSYPp91p+3pmrQnu2y+c/MEjRoahPH7Ibf8
         N06FVLatVr2Zy8pHN//rvqpF20RxCT+YsNJOVmPBc5gxaSVkCFVZn+BATRfz0MrgQPaM
         ukiYNp4f5SnePpxkJdVbVZ/AKBy5A+OkfY+1exHwiSCfTyQIOb2Er5OKqUarKzDZhWHA
         x/Lw==
X-Gm-Message-State: AOAM530DTmA99/7WOPdt8HxcnCJBC35wvH5I+pnEGXZnouYvjxUPWjKi
        QPNsB2HOk2NuJnY9tGvjg5Gihw==
X-Google-Smtp-Source: ABdhPJxqKrJtMh6jDf1VRoyl3BE9nogtzaH0F2a5nx8LdUyh6+nNVTBmTTzf1r+/xO5gfOIAOQdkBg==
X-Received: by 2002:a17:903:248:b0:155:e8c6:8770 with SMTP id j8-20020a170903024800b00155e8c68770mr23714396plh.129.1648660581408;
        Wed, 30 Mar 2022 10:16:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d50d:daac:acf3:cda6])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm24881569pfk.8.2022.03.30.10.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:16:20 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:16:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Message-ID: <YkSQY5NSYcov21Ig@google.com>
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:09:46PM +0800, Mars Chen wrote:

> Subject: CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie

No CHROMIUM tag for upstream posts.

> Initial attempt at Gelarshie device tree.

This is not very useful. If you don't want to reveal much information
about an unreleased device you could say something generic like
"Add device tree for Gelarshie, a trogdor variant".

> BUG=b:225756600
> TEST=emerge-strongbad chromeos-kernel-5_4

drop these

> Signed-off-by: Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sc7180-trogdor-gelarshie-r0.dts  |  15 +
>  .../dts/qcom/sc7180-trogdor-gelarshie.dtsi    | 304 ++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index f9e6343acd03..cf8f88b065c3 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-gelarshie-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> new file mode 100644
> index 000000000000..027d6d563a5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie-r0.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Gelarshie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7180-trogdor-gelarshie.dtsi"
> +
> +/ {
> +	model = "Google Gelarshie (rev0+)";
> +	compatible = "google,gelarshie", "qcom,sc7180";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> new file mode 100644
> index 000000000000..842f6cac6c27
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-gelarshie.dtsi
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Gelarshie board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7180.dtsi"
> +#include "sc7180-trogdor-mipi-camera.dtsi"

drop the mipi camera include, it is not upstream

> +
> +ap_ec_spi: &spi6 {};
> +ap_h1_spi: &spi0 {};
> +
> +#include "sc7180-trogdor.dtsi"
> +#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
> +
> +/* Deleted nodes from trogdor.dtsi */
> +
> +/delete-node/ &alc5682;
> +/delete-node/ &pp3300_codec;
> +
> +/ {
> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
> +
> +	adau7002: audio-codec-1 {
> +		compatible = "adi,adau7002";
> +		IOVDD-supply = <&pp1800_l15a>;
> +		wakeup-delay-ms = <80>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&backlight {
> +	pwms = <&cros_ec_pwm 0>;
> +};
> +
> +&camcc {
> +	status = "okay";
> +};
> +
> +&cros_ec {
> +	cros_ec_proximity: proximity {
> +		compatible = "google,cros-ec-mkbp-proximity";
> +		label = "proximity-wifi";
> +	};
> +};
> +
> +ap_ts_pen_1v8: &i2c4 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@5d {
> +		compatible = "goodix,gt7375p";
> +		reg = <0x5d>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +
> +		vdd-supply = <&pp3300_ts>;
> +	};
> +};
> +
> +&i2c7 {
> +	status = "disabled";
> +};
> +
> +&i2c9 {
> +	status = "disabled";
> +};
> +
> +&mdp {
> +	chromium-enable-overlays;
> +};

I can't find documentation for 'chromium-enable-overlays', what is this
supposed to do?

> +
> +&panel {
> +	compatible = "edp-panel";
> +};
> +
> +&pm6150_adc {
> +	skin-temp-thermistor@4e {
> +		reg = <ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time = <200>;
> +	};
> +};
> +
> +&pm6150_adc_tm {
> +	status = "okay";
> +
> +	skin-temp-thermistor@1 {
> +		reg = <1>;
> +		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
> +		qcom,ratiometric;
> +		qcom,hw-settle-time-us = <200>;
> +	};
> +};

The thermistor is currently unused, drop it and add it later when you
add the corresponding thermal zone.

> +
> +&pp1800_uf_cam {
> +	status = "okay";
> +};
> +
> +&pp1800_wf_cam {
> +	status = "okay";
> +};
> +
> +&pp2800_uf_cam {
> +	status = "okay";
> +};
> +
> +&pp2800_wf_cam {
> +	status = "okay";
> +};
> +
> +&pp3300_dx_edp {
> +	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +};
> +
> +&sn65dsi86_out {
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&sound {
> +	compatible = "google,sc7180-coachz";

Is 'sc7180-coachz' intended because the config is the same as for
coachz or should this be 'sc7180-gelarshie'?
