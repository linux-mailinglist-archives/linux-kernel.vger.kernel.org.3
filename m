Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A304872D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiAGFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:43:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229585AbiAGFno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:43:44 -0500
X-UUID: 39b55fbe961c41f5a67f0b323c5ee1dc-20220107
X-UUID: 39b55fbe961c41f5a67f0b323c5ee1dc-20220107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1515343863; Fri, 07 Jan 2022 13:43:40 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Jan 2022 13:43:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Jan
 2022 13:43:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 13:43:37 +0800
Message-ID: <6dd101e4e65ef56dbf81d67496a383a7db8cefb5.camel@mediatek.com>
Subject: Re: [PATCH v7 4/4] arm64: dts: Add mediatek SoC mt8195 and
 evaluation board
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>
CC:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <broonie@kernel.org>,
        <bgolaszewski@baylibre.com>, <sean.wang@mediatek.com>,
        <bayi.cheng@mediatek.com>, <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>
Date:   Fri, 7 Jan 2022 13:43:37 +0800
In-Reply-To: <18c342b20ccac520eabe8019562432030ddfe017.camel@mediatek.com>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
         <20211220121825.6446-5-tinghan.shen@mediatek.com>
         <CAGXv+5GaFikojqYYv0TfQsz3NSqn7QPmTWyCJY8V2g8UYoV4OA@mail.gmail.com>
         <18c342b20ccac520eabe8019562432030ddfe017.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-06 at 19:14 +0800, Tinghan Shen wrote:
> On Thu, 2021-12-23 at 17:59 +0800, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Mon, Dec 20, 2021 at 8:20 PM Tinghan Shen <
> > tinghan.shen@mediatek.com> wrote:
> > > 
> > > Add basic chip support for mediatek mt8195.
> > > 
> > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> > >  arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  209 ++++
> > >  arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1034
> > > +++++++++++++++++++
> > >  3 files changed, 1244 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/Makefile
> > > b/arch/arm64/boot/dts/mediatek/Makefile
> > > index 4f68ebed2e31..7aa08bb4c078 100644
> > > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > > @@ -32,4 +32,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-
> > > krane-sku0.dtb
> > >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
> > >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> > >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> > > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> > >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > > b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > > new file mode 100644
> > > index 000000000000..e581c6bbead6
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> > > @@ -0,0 +1,209 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2021 MediaTek Inc.
> > > + * Author: Seiya Wang <seiya.wang@mediatek.com>
> > > + */
> > > +/dts-v1/;
> > > +#include "mt8195.dtsi"
> > > +
> > > +/ {
> > > +       model = "MediaTek MT8195 evaluation board";
> > > +       compatible = "mediatek,mt8195-evb", "mediatek,mt8195";
> > > +
> > > +       aliases {
> > > +               serial0 = &uart0;
> > > +       };
> > > +
> > > +       chosen {
> > > +               stdout-path = "serial0:921600n8";
> > > +       };
> > > +
> > > +       memory@40000000 {
> > > +               device_type = "memory";
> > > +               reg = <0 0x40000000 0 0x80000000>;
> > > +       };
> > > +};
> > > +
> > > +&auxadc {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&i2c0 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c0_pin>;
> > > +       clock-frequency = <100000>;
> > > +       status = "okay";
> > > +};
> > > +
> > > +&i2c1 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c1_pin>;
> > > +       clock-frequency = <400000>;
> > > +       status = "okay";
> > > +};
> > > +
> > > +&i2c2 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c2_pin>;
> > > +       status = "disabled";
> > > +};
> > > +
> > > +&i2c3 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c3_pin>;
> > > +       status = "disabled";
> > > +};
> > 
> > Is there any reason in particular to list "disabled" devices here?
> > Are they part of some GPIO header? If they are not accessible, then
> > it's better to not list them. If they are, please leave a comment
> > about it.
> > 
> > > +
> > > +&i2c4 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c4_pin>;
> > > +       clock-frequency = <400000>;
> > > +       status = "okay";
> > > +};
> > > +
> > > +&i2c5 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c5_pin>;
> > > +       status = "disabled";
> > > +};
> > > +
> > > +&i2c6 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&i2c6_pin>;
> > > +       clock-frequency = <400000>;
> > > +       status = "disabled";
> > > +};
> > 
> > Same here.
> > 
> > > +
> > > +&nor_flash {
> > > +       status = "okay";
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&nor_pins_default>;
> > 
> > Please add an empty line between properties and child device nodes.
> > It helps
> > with readability and also fits the style of other parts and other
> > DT
> > files.
> > 
> > > +       flash@0 {
> > > +               compatible = "jedec,spi-nor";
> > > +               reg = <0>;
> > > +               spi-max-frequency = <50000000>;
> > > +       };
> > > +};
> > > +
> > > +&pio {
> > > +       i2c0_pin: i2c0-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> > > +                                <PINMUX_GPIO9__FUNC_SCL0>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > 
> > Please use the MTK_PULL_SET_RSEL_* macros with the bias-pull-*
> > properties.
> > We spent a lot of time defining those.
> > 
> > > +                       mediatek,drive-strength-adv = <0>;
> > 
> > This property is not part of the DT binding.
> > 
> > > +                       drive-strength = <MTK_DRIVE_6mA>;
> > 
> > Please just use raw numbers here. MTK_DRIVE_6mA just translates to
> > 6.
> > The binding already specifies mA as the unit for "drive-strength".
> > 
> > > +               };
> > > +       };
> > 
> > Above comments apply to all the other "pins" nodes.
> > 
> > Please add an empty line between different child device nodes. It
> > helps
> > with readability and also fits the style of other parts and other
> > DT
> > files.
> > 
> > > +       i2c1_pin: i2c1-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
> > > +                                <PINMUX_GPIO11__FUNC_SCL1>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > > +                       mediatek,drive-strength-adv = <0>;
> > > +                       drive-strength = <MTK_DRIVE_6mA>;
> > > +               };
> > > +       };
> > > +       i2c2_pin: i2c2-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
> > > +                                <PINMUX_GPIO13__FUNC_SCL2>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > > +                       mediatek,drive-strength-adv = <7>;
> > > +               };
> > > +       };
> > > +       i2c3_pin: i2c3-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO14__FUNC_SDA3>,
> > > +                                <PINMUX_GPIO15__FUNC_SCL3>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > > +                       mediatek,drive-strength-adv = <7>;
> > > +               };
> > > +       };
> > > +       i2c4_pin: i2c4-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
> > > +                                <PINMUX_GPIO17__FUNC_SCL4>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > > +                       mediatek,drive-strength-adv = <7>;
> > > +               };
> > > +       };
> > > +       i2c5_pin: i2c5-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO29__FUNC_SCL5>,
> > > +                                <PINMUX_GPIO30__FUNC_SDA5>;
> > > +                       bias-pull-up = <1>;
> > > +                       mediatek,rsel = <7>;
> > > +                       mediatek,drive-strength-adv = <7>;
> > > +               };
> > > +       };
> > > +       i2c6_pin: i2c6-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> > > +                                <PINMUX_GPIO26__FUNC_SCL6>;
> > > +                       bias-pull-up = <1>;
> > > +               };
> > > +       };
> > > +       i2c7_pin: i2c7-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO27__FUNC_SCL7>,
> > > +                                <PINMUX_GPIO28__FUNC_SDA7>;
> > > +                       bias-pull-up = <1>;
> > > +               };
> > > +       };
> > > +       nor_pins_default: nor-pins {
> > > +               pins0 {
> > > +                       pinmux =
> > > <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> > > +                                        <PINMUX_GPIO141__FUNC_SP
> > > IN
> > > OR_CK>,
> > > +                                        <PINMUX_GPIO143__FUNC_SP
> > > IN
> > > OR_IO1>;
> > > +                       bias-pull-down;
> > > +               };
> > > +               pins1 {
> > > +                       pinmux =
> > > <PINMUX_GPIO140__FUNC_SPINOR_CS>,
> > > +                                    <PINMUX_GPIO130__FUNC_SPINOR
> > > _I
> > > O2>,
> > > +                                    <PINMUX_GPIO131__FUNC_SPINOR
> > > _I
> > > O3>;
> > > +                       bias-pull-up;
> > > +               };
> > > +       };
> > > +       uart0_pin: uart0-pins {
> > > +               pins {
> > > +                       pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> > > +                               <PINMUX_GPIO99__FUNC_URXD0>;
> > > +               };
> > > +       };
> > > +};
> > > +
> > > +&u2port0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&u2port1 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&u3phy0 {
> > > +       status="okay";
> > > +};
> > > +
> > > +&u3phy1 {
> > > +       status="okay";
> > > +};
> > > +
> > > +&u3port0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&u3port1 {
> > > +       status = "okay";
> > > +};
No need add status property for those u*port* subnodes, add it in
parent node u*phy* is enough.

Thanks

> > > +
> > > +&uart0 {
> > > +       pinctrl-names = "default";
> > > +       pinctrl-0 = <&uart0_pin>;
> > > +       status = "okay";
> > > +};
> > > 
> > 
> 
> 

