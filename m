Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0D4767FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhLPCbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhLPCbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:31:44 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E513C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:31:43 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id f125so21772616pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 18:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Nyh8aXfrN+Sw6eETfR1mpYuyvth7ZZ3e8OJtXN61ek=;
        b=bQHrsiCw6P1DNZBHIo0t82szC/ZHwJTqh8M7Kk41K1+zPhcYNFrFwtrpwXohdeyQ/5
         Dj+coBZ82DEXBXw1oXCUBwlse01DnFEpA0hdaPq+ACBXeKshd5707qnDSetQPGdqB4i9
         qrO/9UhKPzdXPjJhGLipPGiPM9vnHwr7UB0P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Nyh8aXfrN+Sw6eETfR1mpYuyvth7ZZ3e8OJtXN61ek=;
        b=m9N7ecqe2bSksSVD5BEQm79UsnM1ia7Ndp2cLdtxeCfQ6fd5idm+Ry80O8SVefWNyY
         pA/LORj+7ITJjMVxmgZMLA+QU9rRzQZlKsTcgVMX+daaEs9tWOM7369FW1dMyeKBdUwK
         /d7t9/AJG+onDh0Qvs98yTP4K3ez7wj9OLl/9V7syq5Op2TBZ7W+iDdK+miXNG742SLo
         ox1U5sHj7bpjkrak0V0FFJohSYkpTVN7A7ZVaNcsHM7wMzxNNAuM4cI7DmpgLuKcwcHb
         s4xd29Q5a1mwR5ipiBY8pLC2g4uVTHHzSpgJ4cWp8vTujqSKaYbutEQLTW/n5yioQFnV
         /S4w==
X-Gm-Message-State: AOAM533GFcSRyPq/S8Z2ejqnMiJ8aM1foJJiggXLP8sA2tDM4MA1m0Vl
        aMdfnLDQhrexcDtrYDJXEIsouA==
X-Google-Smtp-Source: ABdhPJw6E8xTYPu3TCRU6+Nz/TGik/XX1DJ1dwuUmbh2KIXb77S3wAYPQrNSyD+sNzL95PUbgIuw2Q==
X-Received: by 2002:a63:fc5c:: with SMTP id r28mr10158824pgk.476.1639621903041;
        Wed, 15 Dec 2021 18:31:43 -0800 (PST)
Received: from localhost ([2620:15c:202:201:4570:3a38:a59b:d420])
        by smtp.gmail.com with UTF8SMTPSA id h13sm3768534pfv.37.2021.12.15.18.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 18:31:42 -0800 (PST)
Date:   Wed, 15 Dec 2021 18:31:41 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: sc7180: Add board regulators for MIPI camera
 trogdor boards
Message-ID: <YbqlDQogwdi52FpK@google.com>
References: <20211215003639.386460-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211215003639.386460-1-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:36:38PM -0800, Stephen Boyd wrote:
> Some trogdor boards have on-board regulators for the MIPI camera
> components. Add nodes describing these regulators so boards with these
> supplies can consume them.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  16 +++
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  16 +++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 122 ++++++++++++++++++
>  3 files changed, 154 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> index 14ed09f30a73..c81805ef2250 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> @@ -142,6 +142,22 @@ skin-temp-thermistor@1 {
>  	};
>  };
>  
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
>  &pp3300_dx_edp {
>  	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index 4ab890b2a1d4..9110fed291c4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -149,6 +149,22 @@ skin-temp-thermistor@1 {
>  	};
>  };
>  
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
>  &pp3300_dx_edp {
>  	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index d4f4441179fc..1dd8e35093a8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -113,6 +113,40 @@ src_vph_pwr: src-vph-pwr-regulator {
>  		vin-supply = <&ppvar_sys>;
>  	};
>  
> +	pp1800_uf_cam: pp1800-uf-cam-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_uf_cam";
> +		status = "disabled";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&uf_cam_en>;
> +
> +		vin-supply = <&pp1800_ldo>;
> +		regulator-enable-ramp-delay = <1000>;
> +	};
> +
> +	pp1800_wf_cam: pp1800-wf-cam-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_wf_cam";
> +		status = "disabled";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wf_cam_en>;
> +
> +		vin-supply = <&pp1800_ldo>;
> +		regulator-enable-ramp-delay = <1000>;
> +	};
> +

Shouldn't 'pp1800_ldo' be defined before these ("FIXED REGULATORS
- parents above children")?

I suggest to move these two below the top level regulators, i.e.
somwhere after pp3300_a (probably pp3300_a and pp5000_a should be
swapped, but that's beyond the scope of this patch).

>  	pp5000_a: pp5000-a-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "pp5000_a";
> @@ -144,6 +178,66 @@ pp3300_a: pp3300-a-regulator {
>  		vin-supply = <&ppvar_sys>;
>  	};
>  
> +	pp1800_ec:
> +	pp1800_sensors:
> +	pp1800_ldo: pp1800-ldo-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_ldo";
> +
> +		/* EC turns on with hibernate_l; always on for AP */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		/*
> +		 * Actually should be pp1800_h1 but we don't have any need to
> +		 * model that so we use the parent of pp1800_h1.
> +		 */
> +		vin-supply = <&pp3300_a>;
> +	};
> +
> +	pp2800_uf_cam: pp2800-uf-cam-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp2800_uf_cam";
> +		status = "disabled";
> +
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +
> +		gpio = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * The pinconf can only be referenced once so we put it on the
> +		 * first regulator and comment it out here.
> +		 * pinctrl-names = "default";
> +		 * pinctrl-0 = <&uf_cam_en>;
> +		 */
> +
> +		vin-supply = <&pp3300_a>;
> +	};
> +
> +	pp2800_vcm_wf_cam:
> +	pp2800_wf_cam: pp2800-wf-cam-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp2800_wf_cam";
> +		status = "disabled";
> +
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +
> +		gpio = <&tlmm 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * The pinconf can only be referenced once so we put it on the
> +		 * first regulator and comment it out here.
> +		 * pinctrl-names = "default";
> +		 * pinctrl-0 = <&wf_cam_en>;
> +		 */
> +
> +		vin-supply = <&pp3300_a>;
> +	};
> +
>  	pp3300_audio:
>  	pp3300_codec: pp3300-codec-regulator {
>  		compatible = "regulator-fixed";
> @@ -1517,4 +1611,32 @@ pinconf-sd-cd {
>  			drive-strength = <2>;
>  		};
>  	};
> +
> +	uf_cam_en: uf-cam-en {
> +		pinmux {
> +			pins = "gpio6";
> +			function = "gpio";
> +		};
> +
> +		pinconf {
> +			pins = "gpio6";
> +			drive-strength = <2>;
> +			/* External pull down */

Is there actually an external pull down?

> +			bias-disable;
> +		};
> +	};
> +
> +	wf_cam_en: wf-cam-en {
> +		pinmux {
> +			pins = "gpio7";
> +			function = "gpio";
> +		};
> +
> +		pinconf {
> +			pins = "gpio7";
> +			drive-strength = <2>;
> +			/* External pull down */

ditto
