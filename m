Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2520F490435
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiAQIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiAQInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:43:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7595C061574;
        Mon, 17 Jan 2022 00:43:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o15so54724761lfo.11;
        Mon, 17 Jan 2022 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gei4KEt16IF1U/BK6GOeSIu4C3tKBRM/27+JDfBhFtQ=;
        b=dIuO2s4yr24DkvXm0bbnamEQhJ8+rYgX0hnFFd/9Q+m1bY22fPF0pPRbJQnZ2ojEYY
         KDVW5IjRg3ondyg7hvQ69zhrbEgbYuMoSaj5sr+QblzM4Q+kYAgni4awP/SonC/k8vdw
         tK4TYOr6jcKK9cMG1vRLNtkAPyGFd5fA9sSC8Z/7BfBKXn8Sk29yRQnBQ9aaTGG31lDu
         5C+ODfIe0RxoSzwW95ZzJY/qEXFcf0vaIqDGpjAn/RXsb0Tm6Dsb9zyp3xeNeGgAQtCf
         UcaLJpClhY6HAvnwzA5aDLbqA4V07s09JT1FGEEvFMfC1VCtLe8JWMW1xjWv3wkzBZBU
         hMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gei4KEt16IF1U/BK6GOeSIu4C3tKBRM/27+JDfBhFtQ=;
        b=5KcrzPeYc1jDIyJ1PuVPDKdGhhbPuAOmjjIUBE38gYKBWJcfw07Pu7wDxUx9ez3/sx
         LCrnW2GEJeSSzU2J7o5uZbZuLG2QQ5a2jsMK1bKTG8l1jmysdepenOrpajbzz1RZXBva
         70pjOmnqm5p95liOYCjitn0761LJL1+G6CbhSj9OCLEpQJNzxR8VgR0o2PLCXLikWCd3
         Jla7cWks0h39bbeFL1gpZSH7hmUy+EXfeMT4Cu+SSlFG3PETr/XvAjN3C32d1+sjCFzF
         DhEAysh5xOEy0wpEnZD3SEMDEx6gpcIR1Hs0yQC5r4pQEpfaC1p/g/awq5WyAEFq+mQv
         4Pdw==
X-Gm-Message-State: AOAM530x8Sgt+nZspS5cu5UPudwLabNQQGd5fAgKxwwiBdAWfY+a/8q7
        JVz3xZ17gVPVhgEVwtCOg/c=
X-Google-Smtp-Source: ABdhPJxbGCZ1V1SBZgWU+SbvrBUzDnpO9n3rKlbhqeqlSBmgiXMAWivPlrLqEGwTQN7JAf3Cw7X8mg==
X-Received: by 2002:ac2:596e:: with SMTP id h14mr15443046lfp.236.1642409033184;
        Mon, 17 Jan 2022 00:43:53 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id cf42sm1322134lfb.251.2022.01.17.00.43.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:43:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 5/9] arm64: dts: rockchip: add rk3568 tsadc nodes
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20210728135534.703028-6-pgwipeout@gmail.com>
Date:   Mon, 17 Jan 2022 09:43:49 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3AE0A81-A829-4241-A65E-EB28825E3C33@gmail.com>
References: <20210728135534.703028-1-pgwipeout@gmail.com>
 <20210728135534.703028-6-pgwipeout@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Peter Geis <pgwipeout@gmail.com> w =
dniu 28.07.2021, o godz. 15:55:
>=20
> Add the thermal and tsadc nodes to the rk3568 device tree.
> There are two sensors, one for the cpu, one for the gpu.
>=20
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
> .../boot/dts/rockchip/rk3568-pinctrl.dtsi     |  6 ++
> arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 71 +++++++++++++++++++
> 2 files changed, 77 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> index a588ca95ace2..b464c7bda1f7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-pinctrl.dtsi
> @@ -2420,6 +2420,12 @@ spi3m1_cs1: spi3m1-cs1 {
> 	};
>=20
> 	tsadc {
> +		/omit-if-no-ref/
> +		tsadc_gpio: tsadc-gpio {
> +			rockchip,pins =3D
> +				<0 RK_PA1 0 &pcfg_pull_none>;
> +		};
> +
> 		/omit-if-no-ref/
> 		tsadcm0_shut: tsadcm0-shut {
> 			rockchip,pins =3D
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi =
b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 77c679304916..0905fac0726a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -51,6 +51,7 @@ cpu0: cpu@0 {
> 			compatible =3D "arm,cortex-a55";
> 			reg =3D <0x0 0x0>;
> 			clocks =3D <&scmi_clk 0>;
> +			#cooling-cells =3D <2>;
> 			enable-method =3D "psci";
> 			operating-points-v2 =3D <&cpu0_opp_table>;
> 		};
> @@ -59,6 +60,7 @@ cpu1: cpu@100 {
> 			device_type =3D "cpu";
> 			compatible =3D "arm,cortex-a55";
> 			reg =3D <0x0 0x100>;
> +			#cooling-cells =3D <2>;
> 			enable-method =3D "psci";
> 			operating-points-v2 =3D <&cpu0_opp_table>;
> 		};
> @@ -67,6 +69,7 @@ cpu2: cpu@200 {
> 			device_type =3D "cpu";
> 			compatible =3D "arm,cortex-a55";
> 			reg =3D <0x0 0x200>;
> +			#cooling-cells =3D <2>;
> 			enable-method =3D "psci";
> 			operating-points-v2 =3D <&cpu0_opp_table>;
> 		};
> @@ -75,6 +78,7 @@ cpu3: cpu@300 {
> 			device_type =3D "cpu";
> 			compatible =3D "arm,cortex-a55";
> 			reg =3D <0x0 0x300>;
> +			#cooling-cells =3D <2>;
> 			enable-method =3D "psci";
> 			operating-points-v2 =3D <&cpu0_opp_table>;
> 		};
> @@ -774,6 +778,73 @@ uart9: serial@fe6d0000 {
> 		status =3D "disabled";
> 	};
>=20
> +	thermal_zones: thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive =3D <100>;
> +			polling-delay =3D <1000>;
> +
> +			thermal-sensors =3D <&tsadc 0>;
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					temperature =3D <70000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				cpu_alert1: cpu_alert1 {
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				cpu_crit: cpu_crit {
> +					temperature =3D <95000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert0>;
> +					cooling-device =3D
> +						<&cpu0 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT =
THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive =3D <20>; /* milliseconds =
*/
> +			polling-delay =3D <1000>; /* milliseconds */
> +
> +			thermal-sensors =3D <&tsadc 1>;
> +		};
> +	};
> +
> +	tsadc: tsadc@fe710000 {
> +		compatible =3D "rockchip,rk3568-tsadc";
> +		reg =3D <0x0 0xfe710000 0x0 0x100>;
> +		interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +		assigned-clocks =3D <&cru CLK_TSADC_TSEN>, <&cru =
CLK_TSADC>;
> +		assigned-clock-rates =3D <17000000>, <700000>;
> +		clocks =3D <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
> +		clock-names =3D "tsadc", "apb_pclk";
> +		resets =3D <&cru SRST_TSADC>, <&cru SRST_P_TSADC>,
> +			 <&cru SRST_TSADCPHY>;
> +		reset-names =3D "tsadc", "tsadc-apb", "tsadc-phy";
> +		rockchip,grf =3D <&grf>;
> +		rockchip,hw-tshut-temp =3D <95000>;
> +		rockchip,hw-tshut-mode =3D <1>; /* tshut mode 0:CRU =
1:GPIO */
> +		rockchip,hw-tshut-polarity =3D <0>; /* tshut polarity =
0:LOW 1:HIGH */
> +		pinctrl-names =3D "gpio", "otpout";
> +		pinctrl-0 =3D <&tsadc_gpio>;
> +		pinctrl-1 =3D <&tsadc_shutorg>;
> +		#thermal-sensor-cells =3D <1>;
> +		status =3D "disabled";
> +	};
> +
> 	saradc: saradc@fe720000 {
> 		compatible =3D "rockchip,rk3568-saradc", =
"rockchip,rk3399-saradc";
> 		reg =3D <0x0 0xfe720000 0x0 0x100>;
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Peter,

I'm trying to use this series to get thermal on rk3566 based tvbox =
(x96-x6).
Driver loads but i'm getting following error:

[  132.873979] rockchip-thermal fe710000.tsadc: failed to register =
sensor 0: -517
[  132.874650] rockchip-thermal fe710000.tsadc: failed to register =
sensor[0] : error =3D -517

Maybe you have some hints here?


