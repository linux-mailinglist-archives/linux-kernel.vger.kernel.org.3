Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE2483515
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiACQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiACQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:49:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:49:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o30so19235446wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BBJjz4qSse0c3e8+RSJU1OahDp790FBGpdhk5TtZLn4=;
        b=c8mBzicIsL5lCSSW/C3YvXD5DvtHOk79hi60nDXpz2/1sfifUhW31y38ctjJq23hHz
         32tQcjFPxYYUsuqJiMMCMcCTcA3etuJ+3j4T1FWZfW9xzlnbXjWIlTuDeRrKulamIoc5
         ELneo7tO9TPkqFV4DfYLx6nzkpa41fwmgAafgS9FsFxbAm7VEym2bEwj5jmrCIRBmGQP
         N5k0+DbYaiGZcR++w0kVOHhuxL6N2LzuyOLnRotBy29BVdnPPTYl/q9yeK4gTu+/+u1X
         yKPCPPVMrX0FjEns6slmyg/mLB4EDmEJUprojqpyZRUug3i9OXgialCLT9xxlGkUr8Hg
         VkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BBJjz4qSse0c3e8+RSJU1OahDp790FBGpdhk5TtZLn4=;
        b=Rcj10DP05gzHo/I2uo1vDnCesn3ig//dAC2TwmMz4DvycS7r5eQCl+GDU8w/B7aQZv
         Jaegh8fSCaIVn2Y7jAIsJaD2x6OtucDor6VQZBrKLLbar/EuRHAr5NRC5pCKoyvAl1Cy
         ansOVzukrA6ksYZJpqy8YpZxNC7Agze90qflWqyL/PyxuJ7WsMDqJalyodE2idBrXTHy
         sYXVTLp4G1SlwEZWX5fi/VdJedQRU3BSoej/SbeIIY5rx1dvvLHiCcpH5N/i6h0im4Er
         LbRXxX0bXOZDM0SWIpfhUDb9sUSN7uFooaLbpD32NDJZyATNBfcekEaykE5n8RxO4k75
         JSFQ==
X-Gm-Message-State: AOAM530IfAJsrUkkVCJQfkrJ++AT3ZU19iRG4eqYUCpnz9NAkXl7nIC8
        zO4x2/60PfftbLgVBPWM0idX8h3NuOcCZQ==
X-Google-Smtp-Source: ABdhPJxe+rih2EdPK/ut77NiqUVJXwdNIQVZNLjnURXtOuzblLT/HaWfzBhyBkjhMXdsdZlejTZnfA==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr38162322wmc.39.1641228575612;
        Mon, 03 Jan 2022 08:49:35 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id u20sm41061871wml.45.2022.01.03.08.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 08:49:35 -0800 (PST)
Subject: Re: [PATCH v2 3/9] arm64: dts: meson: add initial device-trees for
 X96-AIR
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Benoit Masson <yahoo@perenite.com>
References: <20220103163956.6581-1-christianshewitt@gmail.com>
 <20220103163956.6581-4-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3a1c359b-7884-7072-4e08-55687b9f94cf@baylibre.com>
Date:   Mon, 3 Jan 2022 17:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220103163956.6581-4-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2022 17:39, Christian Hewitt wrote:
> The Amediatek X96-AIR is based on Amlogic S905X3 reference board
> designs and ships in multiple configurations:
> 
> – 4GB DDR3 + 64GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
> – 4GB DDR3 + 32GB eMMC + WiFi a/b/g/n/ac + BT + Gb Ethernet
> – 4GB DDR3 + 32GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
> – 2GB DDR3 + 16GB eMMC + WiFi b/g/n (no BT) + 10/100 Ethernet
> ...
> - HDMI 2.1 video
> - S/PDIF optical output
> - AV output
> - 2x USB 2.0 inc. OTG port
> - 1x USB 3.0 port
> - IR receiver
> - 1x micro SD card slot (internal)
> - 1x Reset/Update button (in AV jack)
> - 7-segment VFD
> 
> The device-tree with -gbit suffix supports models with Gigabit
> Ethernet, and the device-tree with no suffix supports models
> with 10/100 Ethernet.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>  .../dts/amlogic/meson-sm1-x96-air-gbit.dts    | 133 ++++++++++++++++++
>  .../boot/dts/amlogic/meson-sm1-x96-air.dts    | 112 +++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> 
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 5148cd9e5146..1c0e554f54fc 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -56,4 +56,6 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> new file mode 100644
> index 000000000000..7e1a74046ba5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre SAS. All rights reserved.
> + * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1-ac2xx.dtsi"
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible = "amediatech,x96-air-gbit", "amlogic,sm1";
> +	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "X96-AIR";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&arb {
> +	status = "okay";
> +};
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&ethmac {
> +	status = "okay";
> +
> +	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
> +	pinctrl-names = "default";
> +	phy-mode = "rgmii-txid";
> +	phy-handle = <&external_phy>;
> +
> +	rx-internal-delay-ps = <800>;
> +};
> +
> +&ext_mdio {
> +	external_phy: ethernet-phy@0 {
> +		/* Realtek RTL8211F (0x001cc916) */
> +		reg = <0>;
> +		max-speed = <1000>;
> +
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <80000>;
> +		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
> +
> +		interrupt-parent = <&gpio_intc>;
> +		/* MAC_INTR on GPIOZ_14 */
> +		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&ir {
> +	linux,rc-map-name = "rc-x96max";
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> new file mode 100644
> index 000000000000..cd93d798f2a3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre SAS. All rights reserved.
> + * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-sm1-ac2xx.dtsi"
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> +
> +/ {
> +	compatible = "amediatech,x96-air", "amlogic,sm1";
> +	model = "Shenzhen Amediatech Technology Co., Ltd X96 Air";
> +
> +	sound {
> +		compatible = "amlogic,axg-sound-card";
> +		model = "X96-AIR";
> +		audio-aux-devs = <&tdmout_b>;
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
> +				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
> +				"TDM_B Playback", "TDMOUT_B OUT";
> +
> +		assigned-clocks = <&clkc CLKID_MPLL2>,
> +				  <&clkc CLKID_MPLL0>,
> +				  <&clkc CLKID_MPLL1>;
> +		assigned-clock-parents = <0>, <0>, <0>;
> +		assigned-clock-rates = <294912000>,
> +				       <270950400>,
> +				       <393216000>;
> +		status = "okay";
> +
> +		dai-link-0 {
> +			sound-dai = <&frddr_a>;
> +		};
> +
> +		dai-link-1 {
> +			sound-dai = <&frddr_b>;
> +		};
> +
> +		dai-link-2 {
> +			sound-dai = <&frddr_c>;
> +		};
> +
> +		/* 8ch hdmi interface */
> +		dai-link-3 {
> +			sound-dai = <&tdmif_b>;
> +			dai-format = "i2s";
> +			dai-tdm-slot-tx-mask-0 = <1 1>;
> +			dai-tdm-slot-tx-mask-1 = <1 1>;
> +			dai-tdm-slot-tx-mask-2 = <1 1>;
> +			dai-tdm-slot-tx-mask-3 = <1 1>;
> +			mclk-fs = <256>;
> +
> +			codec {
> +				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
> +			};
> +		};
> +
> +		/* hdmi glue */
> +		dai-link-4 {
> +			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
> +
> +			codec {
> +				sound-dai = <&hdmi_tx>;
> +			};
> +		};
> +	};
> +};
> +
> +&arb {
> +	status = "okay";
> +};
> +
> +&clkc_audio {
> +	status = "okay";
> +};
> +
> +&ethmac {
> +	status = "okay";
> +	phy-handle = <&internal_ephy>;
> +	phy-mode = "rmii";
> +};
> +
> +&frddr_a {
> +	status = "okay";
> +};
> +
> +&frddr_b {
> +	status = "okay";
> +};
> +
> +&frddr_c {
> +	status = "okay";
> +};
> +
> +&ir {
> +	linux,rc-map-name = "rc-beelink-gs1";
> +};
> +
> +&tdmif_b {
> +	status = "okay";
> +};
> +
> +&tdmout_b {
> +	status = "okay";
> +};
> +
> +&tohdmitx {
> +	status = "okay";
> +};
> 

Missing:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # X96-Air with Gbit/s PHY
Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com> # X96-Air with 10/100 Eth
