Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BCC5660B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiGEB3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiGEB3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:29:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6ABE0;
        Mon,  4 Jul 2022 18:29:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 146E65C0114;
        Mon,  4 Jul 2022 21:29:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Jul 2022 21:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656984587; x=
        1657070987; bh=uvC4YU6+mtd4YBT4Ou6ubQeGMQvVq+lOXjHFVHvybSk=; b=E
        dRFuECHgqHX36E+J8o2kpDdnYrBbpRvi9JfLF8XZjvezcHf+b4NTcQx3gVG6A39q
        8RWrE3DNhTxfNL02yM6ODywvz+0INxokkKGXHAPGJvjKObIuMS5gJX9pqLLArrt+
        r+dCetRK88TmaW6Cd2ALbGkhJSVSx9oGbU8bMxaYUphjMfOBUcCVgV1jNM2590vu
        nR2qbhxBvMuFaerkp7OBoG9t+zu0n1Jev8qtgmxR1i7cYWSLy0NhaUckZa96K5cl
        snUzIMj1DtAblnMVsJApq16mJOxWPr53MNNQpjM3GxWa6FUGFJZ3ID4tYNTCoZ0l
        yvo8eEeFC/Dky7Pu+qSZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656984587; x=
        1657070987; bh=uvC4YU6+mtd4YBT4Ou6ubQeGMQvVq+lOXjHFVHvybSk=; b=v
        kP9dOxGVcxIrsLXkmJcyef4s3h4IH2ecLX2FdlzeoWLrWn2RMYTP3yEEC/WuyOrm
        0Gb/OJZx3MaPSNSiVIqIlQyPqY4NE6rvGqacQSBX6pLxq4jhA3E49brYbxTNQMK4
        wUbdhCRNqthTzez1uOEGqGZnEgDUgW+6u1t7ngSlxQvdCgKCMOyehYq1/sOQ/AZZ
        Zx2SXIH528Gv2qMZPZLhCJCevpw91sCpI6TFBEx1bAGZ7lkXZxfdvcIOXTI2KNqT
        lLfb5040PFfl2ldKy7Q+NyWtg7eqYFPl3UiOulnfYuWo5evRqkc7PSg5c/prIMZa
        O1rYpLBR13MIW+uyVAR8A==
X-ME-Sender: <xms:CpTDYi7enNUoYIB0uXIoCnLFzLzocjf7-I_XNL1GBampN4l-XU9QlQ>
    <xme:CpTDYr4JxuFUu9-p8bIPV-uEkpDqlqzW00MoL6voKnVYeBmDoAZoX8bjqTlvDXddS
    cID2Z8BCMtJIqSzOg>
X-ME-Received: <xmr:CpTDYhcym8Qw0P5vwBM86PMaUjhX4zvr-txy3mPLHq_EItjWHSoJJtFOC54_XGHZl9rMCSXbAlgTIdao_eWbIK0oBokHqlSkI1l3RGdAkpA0DX4nbxBVq6Jh3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:CpTDYvJpLIlX6jKA5mqn8TTsocfJLaa8uXPgw3NX0WsIAZCpDuEbfw>
    <xmx:CpTDYmJMdBIbhOtgt2sdYEHeNqlRZXlV-kQq_zL7XAk6QBbV0kxlyQ>
    <xmx:CpTDYgwuYz8sfzMcw7R-Hu-XpUDYkI-GpLO778OClqdXV-uMj9rgcA>
    <xmx:C5TDYl_O5qucGj5w6O78Ymyd6Rzl8W6JLQaph3ez1tMidh6By2j87g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Jul 2022 21:29:45 -0400 (EDT)
Subject: Re: [PATCH v12 7/7] arm64: dts: allwinner: h616: Add X96 Mate TV box
 support
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220701112453.2310722-1-andre.przywara@arm.com>
 <20220701112453.2310722-8-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <22aa3412-2dc2-4d7e-1c61-c5d35b25fe6d@sholland.org>
Date:   Mon, 4 Jul 2022 20:29:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220701112453.2310722-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 6:24 AM, Andre Przywara wrote:
> The X96 Mate is an Allwinner H616 based TV box, featuring:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 2GiB/4GiB RAM (fully usable!)
>   - 16/32/64GiB eMMC
>   - 100Mbps Ethernet (via embedded AC200 EPHY, not yet supported)
>   - Unsupported Allwinner WiFi chip
>   - 2 x USB 2.0 host ports
>   - HDMI port
>   - IR receiver
>   - 5V/2A DC power supply via barrel plug
> 
> Add a basic devicetree for it, with SD card and eMMC working, as
> well as serial and the essential peripherals, like the AXP PMIC.
> 
> This DT is somewhat minimal, and should work on many other similar TV
> boxes with the Allwinner H616 chip.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Looks good to me, with one question below.

Reviewed-by: Samuel Holland <samuel@sholland.org>

> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h616-x96-mate.dts    | 177 ++++++++++++++++++
>  2 files changed, 178 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index df2214e6d946a..6a96494a2e0a3 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -39,3 +39,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> new file mode 100644
> index 0000000000000..30b76140b9c8a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2021 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "X96 Mate";
> +	compatible = "hechuang,x96-mate", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&reg_dcdce>;
> +	vqmmc-supply = <&reg_bldo1>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +
> +	axp305: pmic@745 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x745>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext";
> +				status = "disabled";

If you disable these nodes, the regulator core will ignore them and not apply
the voltages. Is that what you want?

Regards,
Samuel

> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo3: aldo3 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +				status = "disabled";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_bldo2: bldo2 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc1v8-2";
> +				status = "disabled";
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-name = "vcc2v5";
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = <810000>;
> +				regulator-max-microvolt = <1080000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = <1360000>;
> +				regulator-max-microvolt = <1360000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-always-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> 

