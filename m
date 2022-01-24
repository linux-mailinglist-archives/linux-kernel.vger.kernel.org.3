Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F1497D62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiAXKsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:48:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235576AbiAXKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:48:12 -0500
X-UUID: 334e3aa13b91486c99bc885ab65e54c7-20220124
X-UUID: 334e3aa13b91486c99bc885ab65e54c7-20220124
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 34711595; Mon, 24 Jan 2022 18:48:10 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 24 Jan 2022 18:48:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 18:48:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 18:48:08 +0800
Message-ID: <3d3518ff5c332129af5d10766477b9776bbbf55e.camel@mediatek.com>
Subject: Re: [PATCH v21 7/8] arm64: dts: mt8192: add svs device information
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Mon, 24 Jan 2022 18:48:08 +0800
In-Reply-To: <010f9b6a-d6bf-b27a-cb2d-c5fd181c3ac7@collabora.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
         <20220107095200.4389-8-roger.lu@mediatek.com>
         <010f9b6a-d6bf-b27a-cb2d-c5fd181c3ac7@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

On Fri, 2022-01-07 at 15:33 +0100, AngeloGioacchino Del Regno wrote:
> Il 07/01/22 10:51, Roger Lu ha scritto:
> > Add compitable/reg/irq/clock/efuse/reset setting in svs node.
> 
> Typo: compitable => compatible
> .. also, you're not only adding the svs node, but also efuse: please add that
> information in the commit description.
> 
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> 
> This patch seems to not apply on top of the current linux-next, can you please
> rebase it? That would resolve issues with this series and would be picked
> sooner.
> 
> Apart from that...

Sorry to make you confuse. After having discussion internally, we'll submit
another complete mt8192.dtsi patch including this svs node. Therefore, I'll drop
this path from svs patchset in order not to make the reviewer confuse. Thanks
for the comments a lot.

> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 39 ++++++++++++++++++++++++
> >   1 file changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index c7c7d4e017ae..c111e26489dd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -9,6 +9,8 @@
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> > +#include <dt-bindings/reset/ti-syscon.h>
> > +
> >   
> >   / {
> >   	compatible = "mediatek,mt8192";
> > @@ -268,6 +270,14 @@
> >   			compatible = "mediatek,mt8192-infracfg", "syscon";
> >   			reg = <0 0x10001000 0 0x1000>;
> >   			#clock-cells = <1>;
> > +
> > +			infracfg_rst: reset-controller {
> > +				compatible = "mediatek,infra-reset", "ti,syscon-
> > reset";
> > +				#reset-cells = <1>;
> > +				ti,reset-bits = <
> > +					0x150 5 0x154 5 0 0     (ASSERT_SET |
> > DEASSERT_SET | STATUS_NONE) /* 0: svs */
> > +				>;
> > +			};
> >   		};
> >   
> >   		pericfg: syscon@10003000 {
> > @@ -362,6 +372,20 @@
> >   			status = "disabled";
> >   		};
> >   
> > +		svs: svs@1100b000 {
> > +			compatible = "mediatek,mt8192-svs";
> > +			reg = <0 0x1100b000 0 0x1000>;
> > +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			clocks = <&infracfg CLK_INFRA_THERM>;
> > +			clock-names = "main";
> > +			nvmem-cells = <&svs_calibration>,
> > +				      <&lvts_e_data1>;
> > +			nvmem-cell-names = "svs-calibration-data",
> > +					   "t-calibration-data";
> > +			resets = <&infracfg_rst 0>;
> > +			reset-names = "svs_rst";
> > +		};
> > +
> >   		spi1: spi@11010000 {
> >   			compatible = "mediatek,mt8192-spi",
> >   				     "mediatek,mt6765-spi";
> > @@ -479,6 +503,21 @@
> >   			#clock-cells = <1>;
> >   		};
> >   
> > +		efuse: efuse@11c10000 {
> > +			compatible = "mediatek,efuse";
> > +			reg = <0 0x11c10000 0 0x1000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +
> > +			lvts_e_data1: data1@1c0 {
> > +				reg = <0x1c0 0x58>;
> > +			};
> > +
> > +			svs_calibration: calib@580 {
> > +				reg = <0x580 0x68>;
> > +			};
> > +		};
> > +
> >   		i2c3: i2c3@11cb0000 {
> >   			compatible = "mediatek,mt8192-i2c";
> >   			reg = <0 0x11cb0000 0 0x1000>,
> > 
> 
> 

