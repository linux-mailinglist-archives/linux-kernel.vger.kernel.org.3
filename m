Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2926C521211
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbiEJKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiEJKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:24:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48EC2AC0E0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z2so30376768ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+MPU/yG6SZVcCvc/tHXC3Mpqex0MHMf4nld/6aSrL+g=;
        b=MBXQIQ1A3sscrV0utMQtnb2cLzX6RjjdykczJLpZhiFC4L3K3BS/JIYlvnUGeZRa5B
         Cwg17EuisuKQcpV+cYjqs/oypvtbUoWYJcIZD/jiQaeSQ99gIdheHFBEDdMdSvV1/0h+
         CRq6HRW2fSLANUu9BHVNHoPluFUujEitDsmIIAngk9Gxi5ZBpQAEFeax5nQt0LiFK8R3
         LNWUTWJSn4bnTt0N0MzgwUW2mB7p2vheeHrZ86Mo2cCaV4A7yAVVZALj2eIh6Gsf1Hzs
         r2Wka40fS4R5ub0NekQ06nKEHca4nM7FOXGxoY9rwYaX5b8p1mhCtFjstsIzhJeelmp5
         48+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+MPU/yG6SZVcCvc/tHXC3Mpqex0MHMf4nld/6aSrL+g=;
        b=IguadFkCTcc+4+FooZenSyaReG1Ex1nidDCYFIDqlTRLSMVWyMBQ2r9UOmfv1i0zgL
         I1GaDshbgmKjzy5fQIzl/VMIOhZQJTuuW2mEpflHc76hfUrfsdNTs5Mm8skHb3mksJ8x
         zD4HZKrhX/XWSkDWrODzbp0quaNbppu4tODRNpZyTgTHQqLV1/KSwQ1MWcck6R9f72+k
         duqlWwdqCW0ip+zNYEubj9W8yeGbenjSpwblpiQyfr6+Wj6a1iq5Slm4Qntq+mJg2igO
         g+MXbktLZ7Qr8dEhYKKEII43+tIo9RrYY7rlElYdfj25unNLI1jBLLNPbjQr3fPWTrRW
         YJqg==
X-Gm-Message-State: AOAM53257N4eCZhaT1QxRw6925Dy06owebjuL1bDYT2wshZA49TOLe5r
        PM2MriyQy7pUEw570BuUkg0ECQ==
X-Google-Smtp-Source: ABdhPJwwZT211REAuePRdB2OBz2FId1ucL0Ay7Wh3A62TKZBGwK3p2o0Zt9f9467U5dUuLtRXaYRxg==
X-Received: by 2002:a17:907:d05:b0:6f4:3729:8e36 with SMTP id gn5-20020a1709070d0500b006f437298e36mr18622304ejc.475.1652178003955;
        Tue, 10 May 2022 03:20:03 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id em21-20020a170907289500b006f3ef214e14sm6035372ejc.122.2022.05.10.03.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:20:03 -0700 (PDT)
Message-ID: <8e22cbf7-eee1-0ec7-10f9-3839ec80dfbf@linaro.org>
Date:   Tue, 10 May 2022 12:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] arm64: dts: marvell: add support for Methode eDPU
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        shawnguo@kernel.org, linus.walleij@linaro.org, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
References: <20220509110028.144226-1-robert.marko@sartura.hr>
 <20220509110028.144226-2-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220509110028.144226-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 13:00, Robert Marko wrote:
> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
> 
> They feature the same CPU, RAM, and storage as well as the form factor.
> 
> However, eDPU only has one SFP slot plus a copper G.hn port.
> 
> In order to reduce duplication, split the uDPU DTS into a common one.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../boot/dts/marvell/armada-3720-eDPU.dts     |  14 ++
>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 148 +---------------
>  .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 163 ++++++++++++++++++
>  4 files changed, 179 insertions(+), 147 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> 
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index 1c794cdcb8e6..104d7d7e8215 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Mvebu SoC Family
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> new file mode 100644
> index 000000000000..6b573a6854cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "armada-3720-uDPU.dtsi"
> +
> +/ {
> +	model = "Methode eDPU Board";
> +	compatible = "methode,edpu", "marvell,armada3720";

You need also bindings for the board compatible. Someone should convert
the Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt to YAML.

> +};
> +> +	sfp_eth1: sfp-eth1 {

Generic node names, please.

> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
> +		maximum-power-milliwatt = <3000>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs400-1_8v;
> +	marvell,pad-type = "fixed-1-8v";
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +};
> +
> +&spi0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_quad_pins>;
> +
> +	spi-flash@0 {

Run dtbs_check and fix the errors.

> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <54000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* only bootloader is located on the SPI */
> +			partition@0 {
> +				label = "firmware";
> +				reg = <0x0 0x180000>;
> +			};
> +
> +			partition@180000 {
> +				label = "u-boot-env";
> +				reg = <0x180000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&pinctrl_nb {
> +	i2c2_recovery_pins: i2c2-recovery-pins {
> +		groups = "i2c2";
> +		function = "gpio";
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default", "recovery";
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-1 = <&i2c2_recovery_pins>;
> +	/delete-property/mrvl,i2c-fast-mode;
> +	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +
> +	nct375@48 {

Generic node names, representing class of a device.

> +		status = "okay";

OK status is by default, why do you need it? Also, it goes as last property.

> +		compatible = "ti,tmp75c";
> +		reg = <0x48>;
> +	};
> +
> +	nct375@49 {
> +		status = "okay";
> +		compatible = "ti,tmp75c";
> +		reg = <0x49>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	managed = "in-band-status";
> +	phys = <&comphy1 0>;
> +};
> +
> +&eth1 {
> +	phy-mode = "sgmii";
> +	status = "okay";
> +	managed = "in-band-status";
> +	phys = <&comphy0 1>;
> +	sfp = <&sfp_eth1>;
> +};
> +
> +&usb3 {
> +	status = "okay";
> +	phys = <&usb2_utmi_otg_phy>;
> +	phy-names = "usb2-utmi-otg-phy";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};


Best regards,
Krzysztof
