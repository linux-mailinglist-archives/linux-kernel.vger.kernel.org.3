Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7280551D405
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390354AbiEFJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiEFJPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:15:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FB463385;
        Fri,  6 May 2022 02:11:31 -0700 (PDT)
X-UUID: 7ec90e02d7174affa5478d16998bcd79-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b11e263e-5739-4ce0-a49f-a69c5d786999,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:883cd3b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 7ec90e02d7174affa5478d16998bcd79-20220506
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1845255351; Fri, 06 May 2022 17:11:26 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 6 May 2022 17:11:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 May 2022 17:11:25 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 17:11:24 +0800
Message-ID: <6f4aba72d8224223685bca4c03599281878ae1ab.camel@mediatek.com>
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt8195-demo: enable ethernet
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 6 May 2022 17:11:25 +0800
In-Reply-To: <20220429152203.ppuimwcka5d6rvq4@radium>
References: <20220426134106.242353-1-fparent@baylibre.com>
         <20220426134106.242353-6-fparent@baylibre.com>
         <c0cf89c05ee708ec3648b267c1c0a0baa1331836.camel@mediatek.com>
         <f4256b5e-e6b8-f9de-fe97-3e9c6cdcb00c@gmail.com>
         <20220429152203.ppuimwcka5d6rvq4@radium>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-29 at 17:22 +0200, Fabien Parent wrote:
> On Fri, Apr 29, 2022 at 04:00:32PM +0200, Matthias Brugger wrote:
> > 
> > 
> > On 27/04/2022 08:25, Macpaul Lin wrote:
> > > On Tue, 2022-04-26 at 15:41 +0200, Fabien Parent wrote:
> > > > Enable ethernet on the MT8195 demo board.
> > > > 
> > > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > > ---
> > > >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 108
> > > > +++++++++++++++++++
> > > >   1 file changed, 108 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > index 08cab3b3943b..0b7985486e2a 100644
> > > > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > > @@ -80,6 +80,30 @@ optee_reserved: optee@43200000 {
> > > >   	};
> > > >   };
> > > > +&eth {
> > > > +	phy-mode = "rgmii-rxid";
> > > > +	phy-handle = <&eth_phy>;
> > > > +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> > > > +	snps,reset-delays-us = <0 10000 10000>;
> > > > +	mediatek,tx-delay-ps = <2030>;
> > > > +	pinctrl-names = "default", "sleep";
> > > > +	pinctrl-0 = <&eth_default_pins>;
> > > > +	pinctrl-1 = <&eth_sleep_pins>;
> > > > +	status = "okay";
> > > > +
> > > > +	mdio {
> > > > +		compatible = "snps,dwmac-mdio";
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		eth_phy: phy@1 {
> > > > +			compatible = "ethernet-phy-
> > > > id001c.c916";
> > > > +			#phy-cells = <0>;
> > > > +			reg = <0x1>;
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > >   &i2c6 {
> > > >   	clock-frequency = <400000>;
> > > >   	pinctrl-0 = <&i2c6_pins>;
> > > > @@ -260,6 +284,90 @@ &mt6359_vsram_others_ldo_reg {
> > > >   };
> > > >   &pio {
> > > > +	eth_default_pins: eth-default-pins {
> > > > +		pins-cc {
> > > > +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
> > > > +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>
> > > > ,
> > > > +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>
> > > > ,
> > > > +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
> > > > +			drive-strength = <MTK_DRIVE_8mA>;
> > > > +		};
> > > > +
> > > > +		pins-mdio {
> > > > +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
> > > > +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>
> > > > ;
> > > > +			input-enable;
> > > > +		};
> > > > +
> > > > +		pins-phy-reset {
> > > > +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
> > > > +		};
> > > > +
> > > > +		pins-power {
> > > > +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> > > > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > > > +			output-high;
> > > > +		};
> > > > +
> > > > +		pins-rxd {
> > > > +			pinmux =
> > > > <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> > > > +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>
> > > > ,
> > > > +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>
> > > > ,
> > > > +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>
> > > > ;
> > > > +		};
> > > > +
> > > > +		pins-txd {
> > > > +			pinmux =
> > > > <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> > > > +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>
> > > > ,
> > > > +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>
> > > > ,
> > > > +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>
> > > > ;
> > > > +			drive-strength = <MTK_DRIVE_8mA>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	eth_sleep_pins: eth-sleep-pins {
> > > > +		pins-cc {
> > > > +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
> > > > +				 <PINMUX_GPIO88__FUNC_GPIO88>,
> > > > +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> > > > +				 <PINMUX_GPIO86__FUNC_GPIO86>;
> > > > +		};
> > > > +
> > > > +		pins-mdio {
> > > > +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
> > > > +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> > > > +			input-disable;
> > > > +			bias-disable;
> > > > +		};
> > > > +
> > > > +		pins-phy-reset {
> > > > +			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
> > > > +			input-disable;
> > > > +			bias-disable;
> > > > +		};
> > > > +
> > > > +		pins-power {
> > > > +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> > > > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > > > +			input-disable;
> > > > +			bias-disable;
> > > > +		};
> > > > +
> > > > +		pins-rxd {
> > > > +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
> > > > +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> > > > +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> > > > +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> > > > +		};
> > > > +
> > > > +		pins-txd {
> > > > +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
> > > > +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> > > > +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> > > > +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> > > > +		};
> > > > +	};
> > > > +
> > > >   	gpio_keys_pins: gpio-keys-pins {
> > > >   		pins {
> > > >   			pinmux =
> > > > <PINMUX_GPIO106__FUNC_GPIO106>;
> > > 
> > > Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > > 
> > 
> > I get the following error:
> > Error: arch/arm64/boot/dts/mediatek/mt8195.dtsi:582.26-27 syntax
> > error
> 
> I think he used my upstreaming branch where I store the patches I
> sent
> and will send to the mailing list: [0].
> 
> I forgot there is a dependency between this patch and [1], and I
> forgot
> to test this patch serie independenly from the other commits from my
> branch. I will make sure to not forget next time.
> 
> So from this patch serie, only patch 1-2, 6-7 can be applied since
> they
> don't have any hidden dependency:
>   dt-bindings: usb: mediatek,mtu3: add binding for MT8195 SoC
>   arm64: dts: mediatek: mt8195: add ssusb support
>   arm64: dts: mediatek: mt8195-demo: Remove input-name property
>   arm64: dts: mediatek: mt8195-demo: enable uart1
> 
> [0] https://github.com/Fabo/linux/tree/mt8195-demo
> [1] 
> https://lore.kernel.org/all/20210615173233.26682-7-tinghan.shen@mediatek.com/
> 
> > 
> > 
> > 
> > How did you test?
> > 
> > Regards,
> > Matthias

Sorry for replying the mail late.

Actually, I've maintained a working tree based on 5.18-rc1 with minimum
changeset support booting to UART. Then pickup required patches for
testing individaul drivers. I should add the patch dependencies in
previous mail if there were a dependency list. However, attach a
dependency list might still be confusing since there is lots of patches
keep updating everyday for mediatek tree. I guess the best practice for
avoiding this kind of mess is using for-next tree to verify new patches
instead of using 5.18-rc1 tree since some of the dependencies were
already merged. Sorry for wasting your time.

I'll replace my local
working tree to Matthias's working tree for verifing these kind of
patches.

Thanks!
Macpaul Lin

