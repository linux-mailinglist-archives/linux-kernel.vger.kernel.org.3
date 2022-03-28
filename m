Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE34E98A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbiC1NtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243452AbiC1Ns4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:48:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D105E77A;
        Mon, 28 Mar 2022 06:47:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A277A1F42914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648475233;
        bh=xm/p5RUG4xpEDHVeoyt/7MmfTaEkbWMuA9kH+M+Y73E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LVSwo0YoQOQ0czBBLU/3eTNmt7ceqqhFo/I8a8yOQDffYMSIG/ztREzP7rplHVTA+
         Xr9rdwb4WjYwkYG2xyaFTZ5LKO8GbclE5SiHinvAf2jQvYpg7DvIlIH+nZU5kmRYLV
         GPZGZ0M5mGOszMTIJ+bcGnRw5EMhIWIblyQsX3dPKWf5j/GXWBbityZjT6ZtGdPCL6
         FmJtZZ9dHLFgRY3Gwt6xWZOSIMggdAltUosjvkI2rOIlPE8LR74G9gRta06/Lz4N7H
         aCAdT51vB1LJ6VSsJG9OrlFIDmEVQgw4L4D+cj9308vzr6CTEahtUWlR/X73Bc+Oir
         Yd4a7vNe5h+3Q==
Message-ID: <94d231cf-ce4c-22f5-b9af-41ae68f1e659@collabora.com>
Date:   Mon, 28 Mar 2022 15:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: Add device-tree for MT8195
 Demo board
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220327200312.3090515-1-fparent@baylibre.com>
 <20220327200312.3090515-3-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220327200312.3090515-3-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/03/22 22:03, Fabien Parent ha scritto:
> Add basic device-tree for the MT8195 Demo board. The
> Demo board is made by MediaTek and has a MT8195 SoC,
> associated with the MT6359 and MT6360 PMICs, and
> the MT7921 connectivity chip.
> 
> The IOs available on that board are:
> * 1 USB Type-C connector with DP aux mode support
> * 1 USB Type-A connector
> * 1 full size HDMI RX and 1 full size HDMI TX connector
> * 1 uSD slot
> * 40 pins header
> * SPI interface header
> * 1 M.2 slot
> * 1 audio jack
> * 1 micro-USB port for serial debug
> * 2 connectors for DSI displays
> * 3 connectors for CSI cameras
> * 1 connector for a eDP panel
> * 1 MMC storage
> 
> This commit adds basic support in order to be able to boot.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2:
>   * remove empty i2c nodes
>   * remove empty spi node
>   * remove unused pcie pinctrls
>   * fixup node nodes to not contains underscore
>   * rename mt6360 pmic node
>   * move mmc1 node right after mmc0 node
>   * use generic node name for gpio-keys
>   * uniformize pinctrl node names
> 
>   arch/arm64/boot/dts/mediatek/Makefile        |   1 +
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 447 +++++++++++++++++++
>   2 files changed, 448 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> 

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> new file mode 100644
> index 000000000000..d94b4e01159a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -0,0 +1,447 @@

..snip..

> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		input-name = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins>;
> +
> +		key-0 {

key-volup is more descriptive, can you please change that?

> +			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
> +			label = "volume_up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +	};
> +};
> +

..snip..

> +
> +&pmic {
> +	interrupt-parent = <&pio>;
> +	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;

I would instead use interrupts-extended here:

	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;

> +};
> +
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c6_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	mt6360: pmic@34 {
> +		compatible = "mediatek,mt6360";
> +		reg = <0x34>;
> +		interrupt-controller;
> +		interrupt-parent = <&pio>;
> +		interrupts = <101 IRQ_TYPE_EDGE_FALLING>;

Same here

> +		interrupt-names = "IRQB";
> +

...snip...

> +
> +&pio {
> +	mmc0_default_pins: mmc0-default-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
> +				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
> +				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
> +				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
> +				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
> +				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
> +				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
> +				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
> +				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pin-clk {

This is supposed to be "pins-clk", not "pin-clk"... same for all the other
instances of the "pin-".

Before pushing patches upstream, please run dtbs_check, as these are all
mistakes that will be pointed out by that.

Regards,
Angelo

