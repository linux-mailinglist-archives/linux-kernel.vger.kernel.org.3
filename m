Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A049C518D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiECTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiECTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:44:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677522B22;
        Tue,  3 May 2022 12:41:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so35449177ejb.0;
        Tue, 03 May 2022 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mR8ycYJu0OF4TRuEdkdf9RpV4LjqjkpndoBQUvBMRcw=;
        b=m0tLt4SJ8HGtLZSqujoKNb6dduAez31K8EdnR28TEQuWshM3wqk4cQQOf3f/ds073o
         DaVVKfB5u2uHnvgszQ/MvxGEA1H5SNIk1c4PhxW9d3Ksbd5F7NPkVXbb+ToTjI2U7bR5
         H8CUFet8Qo1gyLNgGu78vKJQEqklr/ArgdmI2WBGiQNuT3YWN1xyGbppXrmT/knZWBhC
         SBkvQqBPaogAWSQR25o3Mc3o48XscwfSyxlJI/HN9WNpBwMtqzm2Cs0ZOhwrBsrt7o6z
         IkKoEVzMLSKPeUSozm9kIXQH57fgoIs+3Y+7YHl8FF6dPZftW3lq4sZQjxbnXiVFlLwF
         rINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mR8ycYJu0OF4TRuEdkdf9RpV4LjqjkpndoBQUvBMRcw=;
        b=wCJLPgN9ghoQ5F3EKk3LIYG4kxqaV0ja2/ViHDHoYILnHC0YTAiLLs8bepk25/on2M
         ZEoeZAjWNkeMCKneU33eSutYAIG+KKoL4ZGI58YPgW8cfCfrMdAJBfN8iiNago+5Mds9
         czfaNmzMohmi2igRqF4dhk/vbqs4RCKWqnKICRo/DsLuPl+YNWKoBycsgj+fIwMIrLbU
         Gmv7egkKV15fE8jawEAx+016JCay+KuySZQKB+BC+FnozoCErVgbdQgCJKOkasnQDI3P
         LkXT/smFaMcIXnsTX84m5xBKetNrRF1Qyk9zjIPPLK+iY9NgiHx0P9nUfQxfA2TdQDfY
         aA+w==
X-Gm-Message-State: AOAM5329kcJpvXqnvQNF9j20f7sevSSnNiuBG2QFjN0N7erq2DonAx4F
        KLTZ49HqO9ZvgbB0usU9jBP/1G9OzzY=
X-Google-Smtp-Source: ABdhPJyf+XLg73zbOIGWptTlUwD6HY+19tzsgxjpVOK7IRYdti5xiVJufOdk4v/GOU6bGW5QsYwgsQ==
X-Received: by 2002:a17:907:3f8f:b0:6f3:d4a0:e80c with SMTP id hr15-20020a1709073f8f00b006f3d4a0e80cmr16364718ejc.709.1651606872354;
        Tue, 03 May 2022 12:41:12 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id mm29-20020a170906cc5d00b006f3ef214e0fsm4924415ejb.117.2022.05.03.12.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:41:11 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Date:   Tue, 03 May 2022 21:41:10 +0200
Message-ID: <21450610.EfDdHjke4D@kista>
In-Reply-To: <3165164.aeNJFYEL58@kista>
References: <20220428230933.15262-1-andre.przywara@arm.com> <20220428230933.15262-4-andre.przywara@arm.com> <3165164.aeNJFYEL58@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 03. maj 2022 ob 21:05:11 CEST je Jernej =C5=A0krabec napisal(a):
> Hi!
>=20
> Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara napisal(a):
> > This (relatively) new SoC is similar to the H6, but drops the (broken)
> > PCIe support and the USB 3.0 controller. It also gets the management
> > controller removed, which in turn removes *some*, but not all of the
> > devices formerly dedicated to the ARISC (CPUS).
> > And while there is still the extra sunxi interrupt controller, the
> > package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> >=20
> > The reserved memory node is actually handled by Trusted Firmware now,
> > but U-Boot fails to propagate this to a separately loaded DTB, so we
> > keep it in here for now, until U-Boot learns to do this properly.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++++++++
> >  1 file changed, 574 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm6=
4/
> boot/dts/allwinner/sun50i-h616.dtsi
> > new file mode 100644
> > index 000000000000..cc06cdd15ba5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > @@ -0,0 +1,574 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +// Copyright (C) 2020 Arm Ltd.
> > +// based on the H6 dtsi, which is:
> > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > +
> > +/ {
> > +	interrupt-parent =3D <&gic>;
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		cpu0: cpu@0 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <0>;
> > +			enable-method =3D "psci";
> > +			clocks =3D <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <1>;
> > +			enable-method =3D "psci";
> > +			clocks =3D <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <2>;
> > +			enable-method =3D "psci";
> > +			clocks =3D <&ccu CLK_CPUX>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			compatible =3D "arm,cortex-a53";
> > +			device_type =3D "cpu";
> > +			reg =3D <3>;
> > +			enable-method =3D "psci";
> > +			clocks =3D <&ccu CLK_CPUX>;
> > +		};
> > +	};
> > +
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > +		secmon_reserved: secmon@40000000 {
> > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > +			no-map;
> > +		};
> > +	};
>=20
> I'm not a fan of above. If anything changes in future in BL31, U-Boot wou=
ld=20
> need to reconfigure it anyway. Can we just skip it?
>=20
> > +
> > +	osc24M: osc24M-clk {
> > +		#clock-cells =3D <0>;
> > +		compatible =3D "fixed-clock";
> > +		clock-frequency =3D <24000000>;
> > +		clock-output-names =3D "osc24M";
> > +	};
> > +
> > +	pmu {
> > +		compatible =3D "arm,cortex-a53-pmu";
> > +		interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-affinity =3D <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> > +	};
> > +
> > +	psci {
> > +		compatible =3D "arm,psci-0.2";
> > +		method =3D "smc";
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		arm,no-tick-in-suspend;
> > +		interrupts =3D <GIC_PPI 13
> > +			(GIC_CPU_MASK_SIMPLE(4) |=20
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 14
> > +			(GIC_CPU_MASK_SIMPLE(4) |=20
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 11
> > +			(GIC_CPU_MASK_SIMPLE(4) |=20
> IRQ_TYPE_LEVEL_HIGH)>,
> > +			     <GIC_PPI 10
> > +			(GIC_CPU_MASK_SIMPLE(4) |=20
> IRQ_TYPE_LEVEL_HIGH)>;
> > +	};
>=20
> Vendor kernel sets IRQ to low level. What is the difference?
>=20
> > +
> > +	soc@0 {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		ranges =3D <0x0 0x0 0x0 0x40000000>;
> > +
> > +		syscon: syscon@3000000 {
> > +			compatible =3D "allwinner,sun50i-h616-system-
> control";
> > +			reg =3D <0x03000000 0x1000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges;
> > +
> > +			sram_c: sram@28000 {
> > +				compatible =3D "mmio-sram";
> > +				reg =3D <0x00028000 0x30000>;
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > +				ranges =3D <0 0x00028000 0x30000>;
> > +			};
> > +		};
> > +
> > +		ccu: clock@3001000 {
> > +			compatible =3D "allwinner,sun50i-h616-ccu";
> > +			reg =3D <0x03001000 0x1000>;
> > +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> > +			clock-names =3D "hosc", "losc", "iosc";
> > +			#clock-cells =3D <1>;
> > +			#reset-cells =3D <1>;
> > +		};
> > +
> > +		watchdog: watchdog@30090a0 {
> > +			compatible =3D "allwinner,sun50i-h616-wdt",
> > +				     "allwinner,sun6i-a31-wdt";
> > +			reg =3D <0x030090a0 0x20>;
> > +			interrupts =3D <GIC_SPI 50=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&osc24M>;
> > +		};
> > +
> > +		pio: pinctrl@300b000 {
> > +			compatible =3D "allwinner,sun50i-h616-
pinctrl";
> > +			reg =3D <0x0300b000 0x400>;
> > +			interrupts =3D <GIC_SPI 51=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 52=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 53=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 43=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 54=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 55=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 56=20
> IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 57=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&rtc=20
> 0>;
> > +			clock-names =3D "apb", "hosc", "losc";
> > +			gpio-controller;
> > +			#gpio-cells =3D <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <3>;
> > +
> > +			ext_rgmii_pins: rgmii-pins {
> > +				pins =3D "PI0", "PI1", "PI2",=20
"PI3",=20
> "PI4",
> > +				       "PI5", "PI7", "PI8",=20
"PI9",=20
> "PI10",
> > +				       "PI11", "PI12", "PI13",=20
> "PI14", "PI15",
> > +				       "PI16";
> > +				function =3D "emac0";
> > +				drive-strength =3D <40>;
> > +			};
> > +
> > +			i2c0_pins: i2c0-pins {
> > +				pins =3D "PI6", "PI7";
> > +				function =3D "i2c0";
> > +			};
> > +
> > +			i2c3_ph_pins: i2c3-ph-pins {
> > +				pins =3D "PH4", "PH5";
> > +				function =3D "i2c3";
> > +			};
> > +
> > +			ir_rx_pin: ir-rx-pin {
> > +				pins =3D "PH10";
> > +				function =3D "ir_rx";
> > +			};
> > +
> > +			mmc0_pins: mmc0-pins {
> > +				pins =3D "PF0", "PF1", "PF2",=20
"PF3",
> > +				       "PF4", "PF5";
> > +				function =3D "mmc0";
> > +				drive-strength =3D <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc1_pins: mmc1-pins {
> > +				pins =3D "PG0", "PG1", "PG2",=20
"PG3",
> > +				       "PG4", "PG5";
> > +				function =3D "mmc1";
> > +				drive-strength =3D <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			mmc2_pins: mmc2-pins {
> > +				pins =3D "PC0", "PC1", "PC5",=20
"PC6",
> > +				       "PC8", "PC9", "PC10",=20
> "PC11",
> > +				       "PC13", "PC14", "PC15",=20
> "PC16";
> > +				function =3D "mmc2";
> > +				drive-strength =3D <30>;
> > +				bias-pull-up;
> > +			};
> > +
> > +			spi0_pins: spi0-pins {
> > +				pins =3D "PC0", "PC2", "PC3",=20
"PC4";
> > +				function =3D "spi0";
> > +			};
> > +
> > +			spi1_pins: spi1-pins {
> > +				pins =3D "PH6", "PH7", "PH8";
> > +				function =3D "spi1";
> > +			};
> > +
> > +			spi1_cs_pin: spi1-cs-pin {
> > +				pins =3D "PH5";
> > +				function =3D "spi1";
> > +			};
> > +
> > +			uart0_ph_pins: uart0-ph-pins {
> > +				pins =3D "PH0", "PH1";
> > +				function =3D "uart0";
> > +			};
> > +
> > +			uart1_pins: uart1-pins {
> > +				pins =3D "PG6", "PG7";
> > +				function =3D "uart1";
> > +			};
> > +
> > +			uart1_rts_cts_pins: uart1-rts-cts-pins {
> > +				pins =3D "PG8", "PG9";
> > +				function =3D "uart1";
> > +			};
>=20
> Please add /omit-if-no-ref/ where applicable.
>=20
> > +		};
> > +
> > +		gic: interrupt-controller@3021000 {
> > +			compatible =3D "arm,gic-400";
> > +			reg =3D <0x03021000 0x1000>,
> > +			      <0x03022000 0x2000>,
> > +			      <0x03024000 0x2000>,
> > +			      <0x03026000 0x2000>;
> > +			interrupts =3D <GIC_PPI 9=20
> (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <3>;
> > +		};
> > +
> > +		mmc0: mmc@4020000 {
> > +			compatible =3D "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg =3D <0x04020000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu=20
> CLK_MMC0>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC0>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 35=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&mmc0_pins>;
> > +			status =3D "disabled";
> > +			max-frequency =3D <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mmc1: mmc@4021000 {
> > +			compatible =3D "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg =3D <0x04021000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu=20
> CLK_MMC1>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC1>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 36=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&mmc1_pins>;
> > +			status =3D "disabled";
> > +			max-frequency =3D <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		mmc2: mmc@4022000 {
> > +			compatible =3D "allwinner,sun50i-h616-emmc",
> > +				     "allwinner,sun50i-a100-
emmc";
> > +			reg =3D <0x04022000 0x1000>;
> > +			clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu=20
> CLK_MMC2>;
> > +			clock-names =3D "ahb", "mmc";
> > +			resets =3D <&ccu RST_BUS_MMC2>;
> > +			reset-names =3D "ahb";
> > +			interrupts =3D <GIC_SPI 37=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&mmc2_pins>;
> > +			status =3D "disabled";
> > +			max-frequency =3D <150000000>;
> > +			cap-sd-highspeed;
> > +			cap-mmc-highspeed;
> > +			mmc-ddr-3_3v;
> > +			cap-sdio-irq;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		uart0: serial@5000000 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05000000 0x400>;
> > +			interrupts =3D <GIC_SPI 0=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART0>;
> > +			resets =3D <&ccu RST_BUS_UART0>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		uart1: serial@5000400 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05000400 0x400>;
> > +			interrupts =3D <GIC_SPI 1=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART1>;
> > +			resets =3D <&ccu RST_BUS_UART1>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		uart2: serial@5000800 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05000800 0x400>;
> > +			interrupts =3D <GIC_SPI 2=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART2>;
> > +			resets =3D <&ccu RST_BUS_UART2>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		uart3: serial@5000c00 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05000c00 0x400>;
> > +			interrupts =3D <GIC_SPI 3=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART3>;
> > +			resets =3D <&ccu RST_BUS_UART3>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		uart4: serial@5001000 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05001000 0x400>;
> > +			interrupts =3D <GIC_SPI 4=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART4>;
> > +			resets =3D <&ccu RST_BUS_UART4>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		uart5: serial@5001400 {
> > +			compatible =3D "snps,dw-apb-uart";
> > +			reg =3D <0x05001400 0x400>;
> > +			interrupts =3D <GIC_SPI 5=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			reg-shift =3D <2>;
> > +			reg-io-width =3D <4>;
> > +			clocks =3D <&ccu CLK_BUS_UART5>;
> > +			resets =3D <&ccu RST_BUS_UART5>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		i2c0: i2c@5002000 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x05002000 0x400>;
> > +			interrupts =3D <GIC_SPI 6=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_I2C0>;
> > +			resets =3D <&ccu RST_BUS_I2C0>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&i2c0_pins>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		i2c1: i2c@5002400 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x05002400 0x400>;
> > +			interrupts =3D <GIC_SPI 7=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_I2C1>;
> > +			resets =3D <&ccu RST_BUS_I2C1>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		i2c2: i2c@5002800 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x05002800 0x400>;
> > +			interrupts =3D <GIC_SPI 8=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_I2C2>;
> > +			resets =3D <&ccu RST_BUS_I2C2>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		i2c3: i2c@5002c00 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x05002c00 0x400>;
> > +			interrupts =3D <GIC_SPI 9=20
IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_I2C3>;
> > +			resets =3D <&ccu RST_BUS_I2C3>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		i2c4: i2c@5003000 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x05003000 0x400>;
> > +			interrupts =3D <GIC_SPI 10=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_I2C4>;
> > +			resets =3D <&ccu RST_BUS_I2C4>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		spi0: spi@5010000 {
> > +			compatible =3D "allwinner,sun50i-h616-spi",
> > +				     "allwinner,sun8i-h3-spi";
> > +			reg =3D <0x05010000 0x1000>;
> > +			interrupts =3D <GIC_SPI 12=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu=20
> CLK_SPI0>;
> > +			clock-names =3D "ahb", "mod";
> > +			resets =3D <&ccu RST_BUS_SPI0>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&spi0_pins>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		spi1: spi@5011000 {
> > +			compatible =3D "allwinner,sun50i-h616-spi",
> > +				     "allwinner,sun8i-h3-spi";
> > +			reg =3D <0x05011000 0x1000>;
> > +			interrupts =3D <GIC_SPI 13=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu=20
> CLK_SPI1>;
> > +			clock-names =3D "ahb", "mod";
> > +			resets =3D <&ccu RST_BUS_SPI1>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&spi1_pins>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};

Please remove default pins for SPI controllers. There are few different=20
combinations possible, so better add them in board DT files.

Best regards,
Jernej

> > +
> > +		emac0: ethernet@5020000 {
> > +			compatible =3D "allwinner,sun50i-h616-emac",
> > +				     "allwinner,sun50i-a64-emac";
> > +			syscon =3D <&syscon>;
> > +			reg =3D <0x05020000 0x10000>;
> > +			interrupts =3D <GIC_SPI 14=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names =3D "macirq";
> > +			resets =3D <&ccu RST_BUS_EMAC0>;
> > +			reset-names =3D "stmmaceth";
> > +			clocks =3D <&ccu CLK_BUS_EMAC0>;
> > +			clock-names =3D "stmmaceth";
> > +			status =3D "disabled";
> > +
> > +			mdio0: mdio {
> > +				compatible =3D "snps,dwmac-mdio";
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <0>;
> > +			};
> > +		};
> > +
> > +		rtc: rtc@7000000 {
> > +			compatible =3D "allwinner,sun50i-h616-rtc";
> > +			reg =3D <0x07000000 0x400>;
> > +			interrupts =3D <GIC_SPI 101=20
> IRQ_TYPE_LEVEL_HIGH>;
>=20
> Above interrupt doesn't seem to be correct according to documentation. It=
=20
> should be 104.
>=20
> > +			clocks =3D <&r_ccu CLK_R_APB1_RTC>, <&osc24M>,
> > +				 <&ccu CLK_PLL_SYSTEM_32K>;
> > +			clock-names =3D "bus", "hosc",
> > +				      "pll-32k";
> > +			clock-output-names =3D "osc32k", "osc32k-out",=20
> "iosc";
> > +			#clock-cells =3D <1>;
> > +		};
> > +
> > +		r_ccu: clock@7010000 {
> > +			compatible =3D "allwinner,sun50i-h616-r-ccu";
> > +			reg =3D <0x07010000 0x210>;
> > +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>,
> > +				 <&ccu CLK_PLL_PERIPH0>;
> > +			clock-names =3D "hosc", "losc", "iosc", "pll-
> periph";
> > +			#clock-cells =3D <1>;
> > +			#reset-cells =3D <1>;
> > +		};
> > +
> > +		r_pio: pinctrl@7022000 {
> > +			compatible =3D "allwinner,sun50i-h616-r-
> pinctrl";
> > +			reg =3D <0x07022000 0x400>;
> > +			interrupts =3D <GIC_SPI 43=20
> IRQ_TYPE_LEVEL_HIGH>;
>=20
> Above interrupt is already used for port E in first pinctrl. Is this shar=
ed=20
> somehow?
>=20
> Best regards,
> Jernej
>=20
> > +			clocks =3D <&r_ccu CLK_R_APB1>, <&osc24M>,=20
> <&rtc 0>;
> > +			clock-names =3D "apb", "hosc", "losc";
> > +			gpio-controller;
> > +			#gpio-cells =3D <3>;
> > +			interrupt-controller;
> > +			#interrupt-cells =3D <3>;
> > +
> > +			r_i2c_pins: r-i2c-pins {
> > +				pins =3D "PL0", "PL1";
> > +				function =3D "s_i2c";
> > +			};
> > +
> > +			r_rsb_pins: r-rsb-pins {
> > +				pins =3D "PL0", "PL1";
> > +				function =3D "s_rsb";
> > +			};
> > +		};
> > +
> > +		ir: ir@7040000 {
> > +			compatible =3D "allwinner,sun50i-h616-ir",
> > +				     "allwinner,sun6i-a31-ir";
> > +			reg =3D <0x07040000 0x400>;
> > +			interrupts =3D <GIC_SPI 106=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&r_ccu CLK_R_APB1_IR>,
> > +				 <&r_ccu CLK_IR>;
> > +			clock-names =3D "apb", "ir";
> > +			resets =3D <&r_ccu RST_R_APB1_IR>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&ir_rx_pin>;
> > +			status =3D "disabled";
> > +		};
> > +
> > +		r_i2c: i2c@7081400 {
> > +			compatible =3D "allwinner,sun50i-h616-i2c",
> > +				     "allwinner,sun6i-a31-i2c";
> > +			reg =3D <0x07081400 0x400>;
> > +			interrupts =3D <GIC_SPI 105=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&r_ccu CLK_R_APB2_I2C>;
> > +			resets =3D <&r_ccu RST_R_APB2_I2C>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +
> > +		r_rsb: rsb@7083000 {
> > +			compatible =3D "allwinner,sun50i-h616-rsb",
> > +				     "allwinner,sun8i-a23-rsb";
> > +			reg =3D <0x07083000 0x400>;
> > +			interrupts =3D <GIC_SPI 109=20
> IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&r_ccu CLK_R_APB2_RSB>;
> > +			clock-frequency =3D <3000000>;
> > +			resets =3D <&r_ccu RST_R_APB2_RSB>;
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&r_rsb_pins>;
> > +			status =3D "disabled";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +		};
> > +	};
> > +};
> > --=20
> > 2.35.3
> >=20
> >=20
>=20
>=20
>=20


