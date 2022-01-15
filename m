Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA3E48F945
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiAOU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:28:26 -0500
Received: from h01mx15.reliablemail.org ([173.236.5.211]:48189 "EHLO
        h01mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiAOU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:28:25 -0500
X-Halon-Out: aee70083-7641-11ec-90dc-00163c81f1a9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZQuPn5tlFnu8EJAnFCCFozLyz1zqSES4ZEBobXmJ5gY=; b=d4Kp3Rmsr2xNPg8qU7nz0HCB79
        w78hzQfIle6U6ae3bTTIynrkVJcqc920IMEMHdQuSyE4+7vNr19T+sJ1YNBaBw0i+hHe4mnx+mVB0
        RzCwLyc4iyfpUywGanbXu7eNzCD9ajV9J3l5V55Ty7w1qmtxlV07hIWLL+HvatPOWBHWDkfsyCkBg
        C/AXG9EqvgwT2jszJt0DSdH8YcaZYraJT2wVHLD9F4NVIRBxUTbKC6sbO7S/vMbRVg0ih9+N7X9iS
        UTiojHxn1UI9BRX4ZYAOpnAs/FgTb25ya1vGiGO1d5FKfh6pQfvDisBJMDQ70tQykeuL045NhPqBO
        4vRTMcBA==;
Date:   Sat, 15 Jan 2022 21:28:16 +0100
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] ARM: dts: Add support for Samsung Chagallwifi
Message-ID: <YeMuO6a1f0R48Fgl@L14.lan>
References: <20220113154019.74434-1-henrik@grimler.se>
 <20220113154019.74434-4-henrik@grimler.se>
 <99e33cde-1304-a098-cd7b-8da8408d8052@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e33cde-1304-a098-cd7b-8da8408d8052@canonical.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the feedback!

On Sat, Jan 15, 2022 at 05:34:28PM +0100, Krzysztof Kozlowski wrote:
> On 13/01/2022 16:40, Henrik Grimler wrote:
> > Chagallwifi, with product name Samsung Galaxy Tab S 10.5", is based on
> > Exynos 5420. This device is one of several tablet models released in
> > 2013 - 2014 based on Exynos 5420.
> > 
> > The device tree added here contains support for:
> > 
> > - UART
> > - eMMC
> > - SD card
> > - USB
> > 
> 
> Thanks for the patches. It is a really nice work, good job!
> 
> Some comments below.
> 
> > CCI has been disabled in the hardware, enabling it would require
> > (de-)soldering a resistor on the board.  Trying to boot with it
> > enabled in kernel makes the device hang when CCI is probed.
> > Exynos5420-arndale-octa also has had CCI disabled due to issues [1].
> > 
> > To successfully boot the mainline kernel with the stock bootloader
> > (SBOOT), an additional hack is needed [2]. The same hack is also
> > needed to boot exynos4412-i9300 with stock bootloader, and probably
> > other Samsung devices of similar age.
> > 
> > [1] https://marc.info/?l=linux-arm-kernel&m=141718639200624
> 
> Commits should use 'commit SHA_12char ("subject")' format instead of
> links to mailing lists.

Will fix in v3.

[ ... ]

> > diff --git a/arch/arm/boot/dts/exynos5420-chagallwifi.dts b/arch/arm/boot/dts/exynos5420-chagallwifi.dts
> > new file mode 100644
> > index 000000000000..51eb2bbe6bf6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/exynos5420-chagallwifi.dts
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Samsung's Exynos5420 Chagallwifi board device tree source
> > + *
> > + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + * Copyright (c) 2022 Henrik Grimler
> > + */
> > +
> > +/dts-v1/;
> > +#include "exynos5420-galaxy-tab-common.dtsi"
> 
> Do you plan to have more Galaxy Tab versions?

Yes. One more ("klimt-wifi") as soon as issues here have been ironed
out, and possibly LTE-version(s) later if I actually bring it up
to a point where the hardware differences matter for the kernel.

I am also hoping that someone else with access to other tablet
variants wants to work on addng support for additional models, through
the PostmarketOS project.

> > +
> > +/ {
> > +	model = "Samsung Chagallwifi based on exynos5420";
> 
> "Chagall WiFi"?

Will change filename and descriptions to something like that.

> > +	compatible = "samsung,chagallwifi", "samsung,exynos5420", \
> > +		     "samsung,exynos5";
> > +};
> > +
> > +&s2mps11 {
> > +	regulators {
> > +		ldo15_reg: LDO15 {
> 
> Please define these regulator nodes in DTSI (only name needed and
> comment like you have there) and override them by label (&ldo15_reg { ...).

Will do.

[ ... ]

> > +/dts-v1/;
> > +#include "exynos5420.dtsi"
> > +#include "exynos5420-cpus.dtsi"
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/clock/samsung,s2mps11.h>
> > +
> > +/ {
> > +	compatible = "samsung,exynos5420", "samsung,exynos5";

> Skip the compatible. It duplicates exynos5420.dtsi and does not bring
> any more information here.

Will do.

[ ... ]

> > +	fixed-rate-clocks {
> > +		oscclk {
> > +			compatible = "samsung,exynos5420-oscclk";
> > +			clock-frequency = <24000000>;
> > +		};
> > +
> > +		xxti {
> > +			compatible = "samsung,clock-xxti";
> > +			clock-frequency = <24000000>;
> > +		};
> > +
> > +		xusbxti {
> > +			compatible = "samsung,clock-xusbxti";
> > +			clock-frequency = <24000000>;
> > +		};
> 
> Just keep one clock - oscclk. We treat it as alias of xxti, even though
> it might not be exactly alias. I am not sure about real differences, but
> anyway the driver does not care about xxti and xusbxti. xusbxti appears
> in Exynos5420 only partially, e.g. not in all places like ballmap. Other
> boards have only oscclk, so let's do the same.

Will do.

> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +
> > +		power {
> 
> key-power and so on.

Will do.

> > +			debounce-interval = <10>;
> > +			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
> > +			label = "Power";
> > +			linux,code = <KEY_POWER>;
> > +			wakeup-source;
> > +		};
> > +
> > +		home {
> > +			debounce-interval = <10>;
> > +			gpios = <&gpx0 5 GPIO_ACTIVE_LOW>;
> > +			label = "Home";
> > +			linux,code = <KEY_HOME>;
> > +			wakeup-source;
> > +		};
> > +
> > +		volume-up {
> > +			debounce-interval = <10>;
> > +			gpios = <&gpx0 2 GPIO_ACTIVE_LOW>;
> > +			label = "Volume Up";
> > +			linux,code = <KEY_VOLUMEUP>;
> > +		};
> > +
> > +		volume-down {
> > +			debounce-interval = <10>;
> > +			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
> > +			label = "Volume Down";
> > +			linux,code = <KEY_VOLUMEDOWN>;
> > +		};
> > +	};
> > +};

[ ... ]

> > +&hsi2c_7 {
> > +	status = "okay";
> > +
> > +	s2mps11: pmic@66 {
> > +		compatible = "samsung,s2mps11-pmic";
> > +		reg = <0x66>;
> > +
> > +		interrupt-parent = <&gpx3>;
> > +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&s2mps11_irq>;
> > +
> > +		s2mps11_osc: clocks {
> > +			compatible = "samsung,s2mps11-clk";
> > +			#clock-cells = <1>;
> > +			clock-output-names = "s2mps11_ap", "s2mps11_cp",
> > +					     "s2mps11_bt";
> > +		};
> > +
> > +		buck1_reg: BUCK1 {
> 
> All regulators should be under node "regulators". It should not work
> properly without it, e.g. check
> /sys/kernel/debug/regulator/regulator_summary if values match ones you
> define.

Error on my part when re-arranging, will fix, and investigate issue
with usbdrd supplies.

> > +			regulator-name = "VDD_MIF_1V1";
> > +			regulator-min-microvolt = <700000>;
> > +			regulator-max-microvolt = <1300000>;
> > +			regulator-always-on;
> > +			regulator-boot-on;
> > +
> > +			regulator-state-mem {
> > +				regulator-off-in-suspend;
> > +				regulator-suspend-microvolt = <1100000>;
> 
> Property is deprecated and I am not sure what is it's purpose since, the
> regulator is off in suspend.

Will remove it in v3.

> > +			};
> > +		};
> > +
> > +		buck2_reg: BUCK2 {
> > +			regulator-name = "VDD_ARM_1V0";
> > +			regulator-min-microvolt = <800000>;
> > +			regulator-max-microvolt = <1500000>;
> > +			regulator-always-on;
> > +			regulator-boot-on;
> > +			regulator-ramp-delay = <12500>;
> > +
> > +			regulator-state-mem {
> > +				regulator-off-in-suspend;
> > +			};
> > +		};
> > +
> > +		buck3_reg: BUCK3 {
> > +			regulator-name = "VDD_INT_1V0";
> > +			regulator-min-microvolt = <800000>;
> > +			regulator-max-microvolt = <1400000>;
> > +			regulator-always-on;
> > +			regulator-boot-on;
> > +
> > +			regulator-state-mem {
> > +				regulator-off-in-suspend;
> > +				regulator-suspend-microvolt = <1100000>;
> 
> Same.

[ ... ]

> > +		/*
> > +		 * LDO15 varies between devices and is
> > +		 * specified in the device dts
> > +		 */
> 
> Do it like ldo25 in arch/arm/boot/dts/exynos4412-midas.dtsi. Comment is
> good.

Will do.

[ ... ]

> > +
> > +		ldo30_reg: LDO30 {
> > +			regulator-name = "VDD_TOUCH_1V8";
> > +			regulator-min-microvolt = <1900000>;
> > +			regulator-max-microvolt = <1900000>;
> 
> Name is 1.8V, voltage is 1.9V. Double check this one :)

It does indeed look a bit strange. In Samsung's vendor kernel, two
tablet variants uses 1900000, and two 1800000.  The two I have access
to both uses 1900000.

> > +
> > +			regulator-state-mem {
> > +				regulator-off-in-suspend;
> > +			};
> > +		};
> > +

[ ... ]

> > +/* Internal storage */
> > +&mmc_0 {
> > +	status = "okay";
> > +	non-removable;
> > +	card-detect-delay = <200>;
> > +	samsung,dw-mshc-ciu-div = <3>;
> > +	samsung,dw-mshc-sdr-timing = <0 4>;
> > +	samsung,dw-mshc-ddr-timing = <0 2>;
> > +	pinctrl-names = "default", "output";
> > +	clk_pin = &sd0_clk;
> > +	clk_val = <0x3>;
> 
> I think these two are not supported properties.

Indeed, fixed in next version.

> > +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> > +	vmmc-supply = <&ldo3_reg>;
> > +	vqmmc-supply = <&ldo13_reg>;
> > +	bus-width = <8>;
> > +	cap-mmc-highspeed;
> > +	mmc-hs200-1_8v;
> > +};
> > +
> > +/* External sdcard */
> > +&mmc_2 {
> > +	status = "okay";
> > +	card-detect-delay = <200>;
> > +	samsung,dw-mshc-ciu-div = <3>;
> > +	samsung,dw-mshc-sdr-timing = <0 4>;
> > +	samsung,dw-mshc-ddr-timing = <0 2>;
> > +	bus-width = <4>;
> > +	cap-sd-highspeed;
> > +	sd-uhs-sdr50;
> 
> You should define here also pins, something like Arndale Octa has.

Will do.

> > +};
> > +
> > +&pinctrl_0 {
> > +	s2mps11_irq: s2mps11-irq-pins {
> > +		samsung,pins = "gpx3-2";
> > +		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> > +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> > +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> > +	};
> > +};
> > +
> 
> 
> Best regards,
> Krzysztof

Best regards,
Henrik Grimler
