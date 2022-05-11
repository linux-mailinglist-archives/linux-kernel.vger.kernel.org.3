Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7409F523A76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbiEKQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiEKQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:38:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A06EB08
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:38:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so5179607ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uf6WOD0QQFeOYWAHi4Ca6Vw+411I2zW9BmJTlu4npMU=;
        b=yRZm29EZD8NXTJOt82y7VgQZCc1i9EbIj3MZa7MCPpOpMZl1VlXFauUHWsCAulBqYR
         nFlBrfK4z2cWWBUoTLQ+oCE2ohm6xidYwifBoTuf4gnBLMzXbIn4xXY6RQRbFakdWjou
         A5FZOsXFge9f0nPAAiQejTIZJL5eFRlhbAwc75ZXZFajDb5TUGtgrwzgr7kWRRzA5ZPJ
         QQb6lCvF7XDOhnodTXk71cCgNYGiKK99bUwX6vbpPeYLfjsU570JKfU+/Wk8h3nsUdOw
         hBQcb2puFY3zj3m9ZYKGHbfG+Ex3NX6LP3+vYujuhdePqc9ff5PMjxw0O7c1yF1Qf0Qd
         LuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uf6WOD0QQFeOYWAHi4Ca6Vw+411I2zW9BmJTlu4npMU=;
        b=SPZlmIBTeDq1vmU5LLfFhB5s/Em9an34GgBf709cOhEoB2OdscYPowcukM5HiJlKQn
         vf3jZAQnpTMxytXPeB1c4VfzwUPVm8fFThvzF+vdkYVv2bm9189ZwPDzUS0GZm738vVc
         kegRzU4kw5kIjO+xWH+J6+MqNRC7WFWaseBQxbelBDoGiQhQYfUvakOX+LqvKciz4Ema
         Y+piMSteoJwM2cGPxOQ3VL/e7k2y7JDeAQvBH3cov2G+jxTnxLsZ7IqFH+rEiVSGBUk8
         UfbplYEYQydCG62u2Ke41ZBLutN/6o9PIGPyPGZmOYy2iZ0FkPH1Iilbwf9GInWvGilQ
         9iyw==
X-Gm-Message-State: AOAM530He3DQC1dL+Fqwn8pGanhnWcFGxr0JHPvKsBPuPvHSUPAupdYj
        dO7NajxpH8v0Vq34mcAN6XD5DA==
X-Google-Smtp-Source: ABdhPJz3YoiEch/iyqhcQH0Imra0Xtoh/3yO71y8URs09mYhK7A3GCg8xwRLkEjryvxhvWjYaeQiMw==
X-Received: by 2002:a17:907:2d0e:b0:6f4:e29e:5555 with SMTP id gs14-20020a1709072d0e00b006f4e29e5555mr25664302ejc.552.1652287121130;
        Wed, 11 May 2022 09:38:41 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg56-20020a05640228b800b00427ae00972dsm1500038edb.12.2022.05.11.09.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:38:40 -0700 (PDT)
Message-ID: <1372f51c-0158-dbe3-a0bf-aeeb83f4fec3@linaro.org>
Date:   Wed, 11 May 2022 18:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-3-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510231002.1160798-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 01:10, Chris Packham wrote:
> The 98DX2530 SoC is the Control and Management CPU integrated into
> the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
> referred to as AlleyCat5 and AlleyCat5X).
> 
> These files have been taken from the Marvell SDK and lightly cleaned
> up with the License and copyright retained.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     The Marvell SDK has a number of new compatible strings. I've brought
>     through some of the drivers or where possible used an in-tree
>     alternative (e.g. there is SDK code for a ac5-gpio but two instances of
>     the existing marvell,orion-gpio seems to cover what is needed if you use
>     an appropriate binding). I expect that there will a new series of
>     patches when I get some different hardware (or additions to this series
>     depending on if/when it lands).
>     
>     Changes in v6:
>     - Move CPU nodes above the SoC (Krzysztof)
>     - Minor formatting clean ups (Krzysztof)
>     - Run through `make dtbs_check`
>     - Move gic nodes inside SoC
>     - Group clocks under a clock node
>     Changes in v5:
>     - add #{address,size}-cells property to i2c nodes
>     - make i2c nodes disabled in the SoC and enable them in the board
>     - add interrupt controller attributes to gpio nodes
>     - Move fixed-clock nodes up a level and remove unnecessary @0
>     Changes in v4:
>     - use 'phy-handle' instead of 'phy'
>     - move status="okay" on usb nodes to board dts
>     - Add review from Andrew
>     Changes in v3:
>     - Move memory node to board
>     - Use single digit reg value for phy address
>     - Remove MMC node (driver needs work)
>     - Remove syscon & simple-mfd for pinctrl
>     Changes in v2:
>     - Make pinctrl a child node of a syscon node
>     - Use marvell,armada-8k-gpio instead of orion-gpio
>     - Remove nand peripheral. The Marvell SDK does have some changes for the
>       ac5-nand-controller but I currently lack hardware with NAND fitted so
>       I can't test it right now. I've therefore chosen to omit the node and
>       not attempted to bring in the driver or binding.
>     - Remove pcie peripheral. Again there are changes in the SDK and I have
>       no way of testing them.
>     - Remove prestera node.
>     - Remove "marvell,ac5-ehci" compatible from USB node as
>       "marvell,orion-ehci" is sufficient
>     - Remove watchdog node. There is a buggy driver for the ac5 watchdog in
>       the SDK but it needs some work so I've dropped the node for now.
> 
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/armada-98dx2530.dtsi     | 313 ++++++++++++++++++
>  arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
>  3 files changed, 404 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/rd-ac5x.dts
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 1c794cdcb8e6..3905dee558b4 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -24,3 +24,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += rd-ac5x.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> new file mode 100644
> index 000000000000..724e722b4265
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree For AC5.
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "Marvell AC5 SoC";
> +	compatible = "marvell,ac5";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		spiflash0 = &spiflash0;

These should be in board DTS, not SoC.

https://lore.kernel.org/linux-rockchip/CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com/

> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		ethernet0 = &eth0;
> +		ethernet1 = &eth1;

(...)

> +
> +	clocks {
> +		core_clock: core-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <400000000>;
> +		};
> +
> +		axi_clock: axi-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <325000000>;
> +		};
> +
> +		spi_clock: spi-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};

My questions about these clocks are still unanswered. Why do you define
fixed-clocks. Aren't these part of clock controller?

> +	};
> +};
> diff --git a/arch/arm64/boot/dts/marvell/rd-ac5x.dts b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
> new file mode 100644
> index 000000000000..7ac87413e023
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/rd-ac5x.dts
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree For AC5X.
> + *
> + * Copyright (C) 2021 Marvell
> + *
> + */
> +/*
> + * Device Tree file for Marvell Alleycat 5X development board
> + * This board file supports the B configuration of the board
> + */
> +
> +/dts-v1/;
> +
> +#include "armada-98dx2530.dtsi"
> +
> +/ {
> +	model = "Marvell RD-AC5X Board";
> +	compatible = "marvell,ac5x", "marvell,ac5";

From the bindings I understood ac5x is a SoC, not board. If ac5x is a
board, not a SoC, then compatible should be rather "marvell,rd-ac5x".

> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x2 0x00000000 0x0 0x40000000>;
> +	};
> +};
> +
> +&mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	phy-handle = <&phy0>;
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +
> +	spiflash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		spi-max-frequency = <50000000>;
> +		spi-tx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
> +		spi-rx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
> +		reg = <0>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "spi_flash_part0";
> +			reg = <0x0 0x800000>;
> +		};
> +
> +		parition@1 {
> +			label = "spi_flash_part1";
> +			reg = <0x800000 0x700000>;
> +		};
> +
> +		parition@2 {
> +			label = "spi_flash_part2";
> +			reg = <0xF00000 0x100000>;
> +		};
> +	};
> +};
> +
> +&usb1 {
> +	compatible = "chipidea,usb2";

Why compatible is defined per board?

> +	phys = <&usb1phy>;
> +	phy-names = "usb-phy";
> +	dr_mode = "peripheral";
> +};
> +


Best regards,
Krzysztof
