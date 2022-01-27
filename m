Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2751149DA83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiA0GSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiA0GSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:18:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A81C061714;
        Wed, 26 Jan 2022 22:18:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u18so2172700edt.6;
        Wed, 26 Jan 2022 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4AH18SqUt3875X1csGckeQTmdeWFVcmVXOtHFyC7kz4=;
        b=A+E+wvx3lHw1w4emZKAFoqzSw2nwDE+qG8qCxhSTNhQePLcchO5h4QG3vimuFqHOdF
         0RsjioK2H0mVp2PDj17aOb/r8FO/kPBBCqcvqkArvKMXxMq+x6OKwT5S6fQ2yRLVMNIx
         UKhOWhTuQ/I0X8LQKb8T9DNSN7eeZn7/wHKKhN2WjC21B0f6KSRUljBKpOj2S3qLBuJs
         k3vHTcgzfWn8tC38vlV78Du4zdl0kluCZTvvn1Qfdj3SdSPgiYuI8OFtZtJ0BoBfP/8R
         3/o3HuMeFd59aJ0gNdc/21oy+DXODCVsP9z6ai5CgIsR/LxGJtK7MrcUlkBtKCSPWKTq
         NGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4AH18SqUt3875X1csGckeQTmdeWFVcmVXOtHFyC7kz4=;
        b=f6x5AfbmBkWRCfkkgGoQYiVlzwa4ZgiVbcil3czmSU3CuJfcOkj9sLv28J+Uw2dkNI
         jqViCWEQEy29L2rJtSqYNyI4l46mlTOFAfHOfl+knCZEZbcN++3AwYx6MOKpAaosAKfP
         tsjO9HKaFb0ZFQ2JZ9zVZHom1qEEJGLfFSpRggverpnKi8zNlLYRyYSVM7GurvvAqqvO
         8NmR4X6BXzDLJveVOcqCO0JHgLQozrGCVayPVWYbYFBPO0tKWFcl2/6ozkAGZKqruuvN
         OQNAi5K72iquOJ5cKd2V6mZgDcXYaKRtkGEd0IQYeH7OjBA20Ph0kbaKgiv6OzRgqk1A
         hhLw==
X-Gm-Message-State: AOAM5323LmMO/2/K6h0hzF2+w1IBjnxTohg2MWcSVxZtGHEivqC8vjbi
        MpQefJ01uvHQudHaE8430IVJziYJesCXhQ==
X-Google-Smtp-Source: ABdhPJwQ8vX8FeqC2S0Sb+2I0GE54PRSylU6GWyscqXvsAB8TvF4rhL1nxhMv7ep+IRr/jbK4KaYPA==
X-Received: by 2002:aa7:d1cd:: with SMTP id g13mr2304830edp.70.1643264312604;
        Wed, 26 Jan 2022 22:18:32 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cf13sm8388353ejb.141.2022.01.26.22.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 22:18:31 -0800 (PST)
Message-ID: <07281029-0efd-0a74-0d96-92e3dcf5bbb7@gmail.com>
Date:   Thu, 27 Jan 2022 07:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127010023.3169415-1-pgwipeout@gmail.com>
 <20220127010023.3169415-4-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220127010023.3169415-4-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/22 02:00, Peter Geis wrote:
> The sdmmc1 node on Quartz64-A supports the optional wifi module from
> Pine64.
> Add the sdmmc1 node and requisite sdio_pwrseq to enable wifi support on
> the Quartz64-A.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index 33c2c18caaa9..1d73ac6557c5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -91,6 +91,18 @@ simple-audio-card,codec {
>  		};
>  	};
>  
> +	sdio_pwrseq: sdio-pwrseq {

> +		status = "okay";

When a node is not previously disabled, then there's no need for "okay".

> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk817 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <5000000>;
> +	};
> +
>  	vcc12v_dcin: vcc12v_dcin {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -147,6 +159,17 @@ vcc_sys: vcc_sys {
>  		regulator-max-microvolt = <4400000>;
>  		vin-supply = <&vbus>;
>  	};
> +
> +	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
> +	vcc_wl: vcc_wl {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_wl";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sys>;
> +	};
>  };
>  
>  &cpu0 {
> @@ -475,6 +498,12 @@ pmic_int_l: pmic-int-l {
>  		};
>  	};
>  
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	vcc_sd {
>  		vcc_sd_h: vcc-sd-h {
>  			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> @@ -516,6 +545,22 @@ &sdmmc0 {
>  	status = "okay";
>  };
>  
> +&sdmmc1 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;

> +	disable-wp;

From mmc-controller.yaml:

  disable-wp:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      When set, no physical write-protect line is present. This
      property should only be specified when the controller has a
      dedicated write-protect detection logic. If a GPIO is always used
      for the write-protect detection logic, it is sufficient to not
      specify the wp-gpios property in the absence of a write-protect
      line. Not used in combination with eMMC or SDIO.

> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_wl>;
> +	vqmmc-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
>  &spdif {
>  	status = "okay";
>  };
