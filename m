Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C515449C28A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiAZENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiAZEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:13:03 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:13:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so1109357ooq.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LLMg77ELraqoTfIAPCtABOfbinmt8w5vNySYMJihYiw=;
        b=aAsyrAB0/n1oJzzMMLeshHQInjWF8VSIbuKCfDihEA3cwTzBkHvG2cbZyTQVYnbNzX
         u5q3gX5eErITWuIR3o9fXGn1p41gSSwa/ft6k6uAfZYKyefsh742TuATfm/JvM8cjUaE
         /ieFSrKzr1u02+TjmLtl7eQpDIQZyf7XrvhQY50BYtU0ANSFRf5JwQU0n9zUXVfqtdeK
         dRSsUv54Mu+YMY/+yC2NGtqmhuJtBOTdEJycmcEMsHVkv3se7KEBF1ochnbgQZmblJuu
         D/49v5W+rzKIVFlcrANjSwARr9Hh61IO1xY2zoQMHam5dnKoqwgVTHKYLQXz0Ha0HE7q
         Ie3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LLMg77ELraqoTfIAPCtABOfbinmt8w5vNySYMJihYiw=;
        b=MARezuQepdw3g2UghETYH5pmlE6kvd5rviJasWdHVgNs75oiHM6Zllwb72PbMfXmlw
         zdiHSJcWhiUCPO5xdw9II6hbUjGyiIx3y0rqCz9BJY7VKx6rYyVG5nngwRNJq61THft5
         CPGeUaHxck1A14zWjoBn9hw4+wgbSSQJCCf9Nr5EHoLghSER98lbwd4jW0DmlqsQ/NCG
         DbEQ2sp8i9+q+KB3yOpVaQhG77jYEWTi1+iqb+LsRcaXIug6A9GcUN0WVPdQ4EaNRpWR
         v8mW8EWGp1f+BMmxkKLjM2w6DQK/q3sLiJUc57c2tyOCcPis8sLE0cJkbdjbVL/yRBKd
         Q+gw==
X-Gm-Message-State: AOAM532D5x12AIYtC2UmnnEEXElBaEJzitOK3on9WGRqjMku/2OQmczA
        DBdG55pZBBNRnjeT4CUZsXcY4Q==
X-Google-Smtp-Source: ABdhPJzOWAF0z0FRI4tlJ+AKF//TlxJuLqvWMRNmhifQMBKoJxSU+ZCpshiVsT94nO8+EIAwdra/Uw==
X-Received: by 2002:a4a:96b0:: with SMTP id s45mr1693025ooi.75.1643170382627;
        Tue, 25 Jan 2022 20:13:02 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id j3sm3397646oig.37.2022.01.25.20.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:13:01 -0800 (PST)
Date:   Tue, 25 Jan 2022 22:13:00 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ben Wolsieffer <benwolsieffer@gmail.com>, linus.walleij@linaro.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: basic HP TouchPad support
Message-ID: <YfDKTGQDh3tDMECz@builder.lan>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
 <9f19df2a0017b71547445ac34df221e827c45bd0.1643075547.git.benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f19df2a0017b71547445ac34df221e827c45bd0.1643075547.git.benwolsieffer@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Jan 20:07 CST 2022, Ben Wolsieffer wrote:

> Modify the Dragonboard device tree to support the most basic hardware on
> the HP TouchPad. The headphone UART port and eMMC are supported.
> 

We typically don't have one commit for the cloning and then one to
update the content, in particular since your diffstat became rather
weird.

That said, got some comments below, things that I wouldn't have spotted
if you sent this as just a new file.

> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---

@Linus, please take a look at the regulator question below.

>  arch/arm/boot/dts/qcom-apq8060-tenderloin.dts | 549 ++----------------
>  1 file changed, 45 insertions(+), 504 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts b/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
> index 996e73aa0b0b..e294f3920b9f 100644
> --- a/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
> +++ b/arch/arm/boot/dts/qcom-apq8060-tenderloin.dts
> @@ -14,6 +14,8 @@ aliases {
>  	};
>  
>  	chosen {
> +		/* Bootloader passes console=tty1, which overrides stdout-path */
> +		bootargs = "console=ttyMSM0,115200 earlycon";
>  		stdout-path = "serial0:115200n8";
>  	};
[..]
>  
>  	soc {
>  		pinctrl@800000 {
> -			/* eMMMC pins, all 8 data lines connected */

It would be nice if you could throw a separate patch on the list that
fixes this spelling mistake in the original as well.

> -			dragon_sdcc1_pins: sdcc1 {
> +			/* eMMC pins, all 8 data lines connected */
> +			emmc_pins: sdcc1 {
>  				mux {
>  					pins = "gpio159", "gpio160", "gpio161",
>  					     "gpio162", "gpio163", "gpio164",
>  					     "gpio165", "gpio166", "gpio167",
>  					     "gpio168";
> -					     function = "sdc1";
> +					function = "sdc1";
>  				};
>  				clk {
>  					pins = "gpio167"; /* SDC1 CLK */
[..]
> @@ -171,205 +77,33 @@ pinconf {
>  				};
>  			};
>  
> -			dragon_gsbi12_i2c_pins: gsbi12_i2c {
> -				mux {
> -					pins = "gpio115", "gpio116";
> -					function = "gsbi12";
> -				};
> -				pinconf {
> -					pins = "gpio115", "gpio116";
> -					drive-strength = <16>;
> -					/* These have external pull-up 4.7kOhm to 1.8V */
> -					bias-disable;
> -				};
> -			};
> -
> -			/* Primary serial port uart 0 pins */
> -			dragon_gsbi12_serial_pins: gsbi12_serial {
> +			/* Headphone UART pins */
> +			headphone_uart_pins: gsbi12_serial {
>  				mux {
>  					pins = "gpio117", "gpio118";
>  					function = "gsbi12";
>  				};
> -				tx {
> -					pins = "gpio117";
> -					drive-strength = <8>;
> -					bias-disable;
> -				};
>  				rx {
> -					pins = "gpio118";
> +					pins = "gpio117";
>  					drive-strength = <2>;
>  					bias-pull-up;
>  				};
> -			};

I find it hard to conclude what the resulting snippet is from this
chunk, did rx swap place from gpio118 to gpio117?

[..]
> @@ -814,14 +378,16 @@ l20 {
>  					bias-pull-down;
>  				};
>  				l21 {
> -					// 1.1 V according to schematic
>  					regulator-min-microvolt = <1200000>;
>  					regulator-max-microvolt = <1200000>;
>  					bias-pull-down;
> -					regulator-always-on;
> +					/*
> +					 * RPM driver can't handle always-on regulators that are
> +					 * supplied by regulators initialized after them.
> +					 */

That looks like an oversight that should be corrected, perhaps it needs
similar attention that was given to the smd-rpm driver recently?

But this makes me wonder, how can this work on the other board? Linus?

> +					// regulator-always-on;
>  				};
>  				l22 {
> -					// 1.2 V according to schematic
>  					regulator-min-microvolt = <1150000>;
>  					regulator-max-microvolt = <1150000>;
>  					bias-pull-down;
> @@ -845,7 +411,7 @@ l25 {
>  				};
>  
>  				s0 {
> -					// regulator-min-microvolt = <500000>;
> +					// regulator-min-microvolt = <800000>;
>  					// regulator-max-microvolt = <1325000>;

This looks like the full range the regulator could do, do you see a
reason for documenting that here? Unless there's a good reason I think
you should leave the commented min/max out.

>  					regulator-min-microvolt = <1100000>;
>  					regulator-max-microvolt = <1100000>;

Regards,
Bjorn
