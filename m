Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56BE5AE928
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiIFNME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiIFNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:12:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12454643
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:12:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by6so12211208ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yOWqU/noN30I+JdUCdYobc9an3E9kR1qqO/vRiBd6KA=;
        b=SwNWX/omCq1NtZCynmzSPeNoENmgdnIUCCC67r37VRQDfChD4AVnn0JPWMJsF+GmEv
         Fyn4e/WPu7WtRzpE1hiU7B27R98P1JvlR1MHN2MVSZY3+cDzTKgHiqpx2raCKm3Rl8g2
         FBnn6C60IOuEnWIacb9lLLbLSTcea+vvJb5MaaJfvScu0NKRZtNNUeDSzhGu2tY/QmcR
         pNlfjJsNz+MybwL1VLAnyWmBGV7JNquC+QdzaBkNnVKssnK+ATLSYzVFx8LhHwFohEOG
         xWjCN/+d8Aw0uelzEJTAtvJiuHCn4zpd87LqelXGQX3hg+Qcpt+ovEXEPbPG6TtMGTDK
         oBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yOWqU/noN30I+JdUCdYobc9an3E9kR1qqO/vRiBd6KA=;
        b=jU2tL4ae8r/qSOnNKMzhkKsBs3YBW7bSx3UjTFDlS1RIMBIF9cq5ai2CoaoolXENlk
         3EWsjjim1PW3Nezi0JvdyoZX6vpSKZUW4IJGJz92pfHZ9CxPYenX01spL1sONDI1vUla
         22DH5F8m2foHNIlC66EsquSqDs0Og5fHCAMDSbfxEjvbttkc+PpoB+axAYisnPGpz/vZ
         tDVCXJJ6n8BlDQ7ezyfFh4Uigy4Shom9SqV6iClFTAl97gSNAP9iq3b9QXL4LLnYa+AL
         ouV7kHFrfUfGwnx3XjNb3pjpqARyWZUS5L1sWLTJ+aZxbwqtfBgmAMeqze8f2LLKPAwu
         VVyA==
X-Gm-Message-State: ACgBeo0PkdTdKMxsEx3yG1Z7LrHYVq07KfPJUyrv9yKKcUtbQ2TY1uDL
        IX1HqnXEYKnk23a9cvVg/8wuLQ==
X-Google-Smtp-Source: AA6agR4jzQemR2LrR1WAzy6iJ5n0+xbpOl8/JFVbFCBlif7gfwSIxEQ3iWY81gAdF3TctAFAz7VNYQ==
X-Received: by 2002:a2e:80c8:0:b0:269:6aef:b94d with SMTP id r8-20020a2e80c8000000b002696aefb94dmr4352716ljg.57.1662469918707;
        Tue, 06 Sep 2022 06:11:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q27-20020a05651232bb00b0049110ba325asm1719363lfe.158.2022.09.06.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:11:57 -0700 (PDT)
Message-ID: <71dad0f0-db66-e79e-5e01-d5fc66b0cb3e@linaro.org>
Date:   Tue, 6 Sep 2022 15:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 3/3] riscv: dts: microchip: add a devicetree for the
 Aldec TySoM
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220906121525.3212705-1-conor.dooley@microchip.com>
 <20220906121525.3212705-4-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906121525.3212705-4-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 14:15, Conor Dooley wrote:
> The TySOM-M-MPFS250 is a compact SoC prototyping board featuring
> a Microchip PolarFire SoC MPFS250T-FCG1152. Features include:
> - 16 GB FPGA DDR4
> - 16 GB MSS DDR4 with ECC
> - eMMC
> - SPI flash memory
> - 2x Ethernet 10/100/1000
> - USB 2.0
> - PCIe x4 Gen2
> - HDMI OUT
> - 2x FMC connector (HPC and LPC)
> 
> Link: https://www.aldec.com/en/products/emulation/tysom_boards/polarfire_microchip/tysom_m_mpfs250
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile        |   1 +
>  .../dts/microchip/mpfs-tysom-m-fabric.dtsi    |  47 +++++
>  .../riscv/boot/dts/microchip/mpfs-tysom-m.dts | 168 ++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi
>  create mode 100644 arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts
> 
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> index 7427a20934f3..c54922a325fd 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -3,4 +3,5 @@ dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
>  dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
>  dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
>  dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
> +dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
>  obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi
> new file mode 100644
> index 000000000000..51d0c5176b9e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-tysom-m-fabric.dtsi
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2022 Microchip Technology Inc */
> +
> +// #include "dt-bindings/mailbox/miv-ihc.h"
> +
> +/ {
> +	fabric_clk3: fabric-clk3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <62500000>;
> +	};
> +
> +	fabric_clk1: fabric-clk1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +	};
> +
> +	pcie: pcie@2000000000 {
> +		compatible = "microchip,pcie-host-1.0";
> +		#address-cells = <0x3>;
> +		#interrupt-cells = <0x1>;
> +		#size-cells = <0x2>;
> +		device_type = "pci";
> +		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
> +		reg-names = "cfg", "apb";
> +		bus-range = <0x0 0x7f>;
> +		interrupt-parent = <&plic>;
> +		interrupts = <119>;
> +		interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +				<0 0 0 2 &pcie_intc 1>,
> +				<0 0 0 3 &pcie_intc 2>,
> +				<0 0 0 4 &pcie_intc 3>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
> +		clock-names = "fic0", "fic1", "fic3";
> +		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
> +		msi-parent = <&pcie>;
> +		msi-controller;
> +		status = "disabled";
> +		pcie_intc: interrupt-controller {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +		};
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts b/arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts
> new file mode 100644
> index 000000000000..5ad2fbd1b7ae
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-tysom-m.dts
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Original all-in-one devicetree:
> + * Copyright (C) 2020-2022 - Aldec
> + * Rewritten to use includes:
> + * Copyright (C) 2022 - Conor Dooley <conor.dooley@microchip.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "mpfs.dtsi"
> +#include "mpfs-tysom-m-fabric.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define MTIMER_FREQ		1000000
> +
> +/ {
> +	model = "Aldec TySOM-M-MPFS250T";
> +	compatible = "aldec,tysom-m-mpfs250t", "microchip,mpfs";
> +
> +	aliases {
> +		ethernet0 = &mac0;
> +		ethernet1 = &mac1;
> +		serial0 = &mmuart0;
> +		serial1 = &mmuart1;
> +		serial2 = &mmuart2;
> +		serial3 = &mmuart3;
> +		serial4 = &mmuart4;
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	cpus {
> +		timebase-frequency = <MTIMER_FREQ>;
> +	};
> +
> +	ddrc_cache_lo: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +		status = "okay";
> +	};
> +
> +	ddrc_cache_hi: memory@1000000000 {
> +		device_type = "memory";
> +		reg = <0x10 0x00000000 0x0 0x40000000>;
> +		status = "okay";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		status = "okay";
> +
> +		led0 {

Typically this is led-0

> +			gpios = <&gpio1 23 1>;

Does '1' stand for some GPIO flag?

> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	hwmon: hwmon@45 {
> +		status = "okay";

No need for status.

> +		compatible = "ti,ina219";
> +		reg = <0x45>;
> +		shunt-resistor = <2000>;
> +	};
> +};
> +
> +&gpio1 {
> +	interrupts = <27>, <28>, <29>, <30>,
> +		     <31>, <32>, <33>, <47>,
> +		     <35>, <36>, <37>, <38>,
> +		     <39>, <40>, <41>, <42>,
> +		     <43>, <44>, <45>, <46>,
> +		     <47>, <48>, <49>, <50>;
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	phy-mode = "gmii";
> +	phy-handle = <&phy0>;
> +
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	phy-mode = "gmii";
> +	phy-handle = <&phy1>;
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&mbox {
> +	status = "okay";
> +};
> +
> +&mmc {
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	no-1-8-v;
> +	disable-wp;
> +	status = "okay";
> +};
> +
> +&mmuart1 {
> +	status = "okay";
> +};
> +
> +&mmuart2 {
> +	status = "okay";
> +};
> +
> +&mmuart3 {
> +	status = "okay";
> +};
> +
> +&mmuart4 {
> +	status = "okay";
> +};
> +
> +&refclk {
> +	clock-frequency = <125000000>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Are these needed? Does it pass dtbs_check?

> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		status = "okay";

No need for status.

Best regards,
Krzysztof
