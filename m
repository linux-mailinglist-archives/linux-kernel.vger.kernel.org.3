Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263C47ECB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351821AbhLXHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:33:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54478 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351813AbhLXHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:33:53 -0500
X-UUID: 642cc6016aae4d9092443f83fa7722ca-20211224
X-UUID: 642cc6016aae4d9092443f83fa7722ca-20211224
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1548116192; Fri, 24 Dec 2021 15:33:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Dec 2021 15:33:48 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 15:33:47 +0800
Message-ID: <a5c9133e2bc856f8f9cbf6c70bc5196bce61639e.camel@mediatek.com>
Subject: Re: [PATCH v16 2/7] arm64: dts: mt8183: add svs device information
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
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Dec 2021 15:33:47 +0800
In-Reply-To: <70e71210-6d17-92e3-4e3f-01b83380be42@collabora.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-3-roger.lu@mediatek.com>
         <70e71210-6d17-92e3-4e3f-01b83380be42@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply. 

On Wed, 2021-10-20 at 17:20 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/04/21 08:54, Roger Lu ha scritto:
> > add compitable/reg/irq/clock/efuse setting in svs node
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 80519a145f13..441d617ece43 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -657,6 +657,18 @@
> >   			status = "disabled";
> >   		};
> >   
> > +		svs: svs@1100b000 {
> > +			compatible = "mediatek,mt8183-svs";
> > +			reg = <0 0x1100b000 0 0x1000>;
> > +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&infracfg CLK_INFRA_THERM>;
> > +			clock-names = "main";
> > +			nvmem-cells = <&svs_calibration>,
> > +				      <&thermal_calibration>;
> > +			nvmem-cell-names = "svs-calibration-data",
> > +					   "t-calibration-data";
> > +		};
> > +
> >   		pwm0: pwm@1100e000 {
> >   			compatible = "mediatek,mt8183-disp-pwm";
> >   			reg = <0 0x1100e000 0 0x1000>;
> > @@ -941,9 +953,15 @@
> >   			reg = <0 0x11f10000 0 0x1000>;
> >   			#address-cells = <1>;
> >   			#size-cells = <1>;
> > +			thermal_calibration: calib@180 {
> > +				reg = <0x180 0xc>;
> > +			};
> >   			mipi_tx_calibration: calib@190 {
> >   				reg = <0x190 0xc>;
> >   			};
> > +			svs_calibration: calib@580 {
> > +				reg = <0x580 0x64>;
> > +			};
> >   		};
> >   
> >   		u3phy: usb-phy@11f40000 {
> > 
> 
> This patch doesn't apply on the latest linux-next due to some new commits in
> mt8183.dtsi, can you please rebase?

Okay. I'll rebase it.

> Thanks,
> - Angelo

