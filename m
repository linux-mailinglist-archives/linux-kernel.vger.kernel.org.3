Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F4551111E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358101AbiD0G2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiD0G2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:28:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49B91359;
        Tue, 26 Apr 2022 23:25:29 -0700 (PDT)
X-UUID: 2b52a96266724aff9836837a75e27ac7-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:385f4bc9-27d9-4079-add1-ba95771287cf,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:385f4bc9-27d9-4079-add1-ba95771287cf,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:6f8ddb2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 2b52a96266724aff9836837a75e27ac7-20220427
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 124921721; Wed, 27 Apr 2022 14:25:25 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 14:25:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 14:25:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 14:25:24 +0800
Message-ID: <c0cf89c05ee708ec3648b267c1c0a0baa1331836.camel@mediatek.com>
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt8195-demo: enable ethernet
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 14:25:23 +0800
In-Reply-To: <20220426134106.242353-6-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
         <20220426134106.242353-6-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 15:41 +0200, Fabien Parent wrote:
> Enable ethernet on the MT8195 demo board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 108
> +++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> index 08cab3b3943b..0b7985486e2a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -80,6 +80,30 @@ optee_reserved: optee@43200000 {
>  	};
>  };
>  
> +&eth {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&eth_phy>;
> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 10000 10000>;
> +	mediatek,tx-delay-ps = <2030>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default_pins>;
> +	pinctrl-1 = <&eth_sleep_pins>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy: phy@1 {
> +			compatible = "ethernet-phy-id001c.c916";
> +			#phy-cells = <0>;
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
>  &i2c6 {
>  	clock-frequency = <400000>;
>  	pinctrl-0 = <&i2c6_pins>;
> @@ -260,6 +284,90 @@ &mt6359_vsram_others_ldo_reg {
>  };
>  
>  &pio {
> +	eth_default_pins: eth-default-pins {
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
> +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
> +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
> +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
> +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
> +			input-enable;
> +		};
> +
> +		pins-phy-reset {
> +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
> +		};
> +
> +		pins-power {
> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> +			output-high;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
> +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
> +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
> +		};
> +
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
> +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
> +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +	};
> +
> +	eth_sleep_pins: eth-sleep-pins {
> +		pins-cc {
> +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
> +				 <PINMUX_GPIO88__FUNC_GPIO88>,
> +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> +				 <PINMUX_GPIO86__FUNC_GPIO86>;
> +		};
> +
> +		pins-mdio {
> +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
> +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> +			input-disable;
> +			bias-disable;
> +		};
> +
> +		pins-phy-reset {
> +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
> +			input-disable;
> +			bias-disable;
> +		};
> +
> +		pins-power {
> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> +			input-disable;
> +			bias-disable;
> +		};
> +
> +		pins-rxd {
> +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
> +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> +		};
> +
> +		pins-txd {
> +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
> +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> +		};
> +	};
> +
>  	gpio_keys_pins: gpio-keys-pins {
>  		pins {
>  			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;

Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>

Regards,
Macpaul Lin

