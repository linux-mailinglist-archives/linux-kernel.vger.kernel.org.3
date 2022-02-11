Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB434B1D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiBKDu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:50:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiBKDuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:50:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C55F70;
        Thu, 10 Feb 2022 19:50:21 -0800 (PST)
X-UUID: 72d46629b6ee4554b7c4332d403dfb72-20220211
X-UUID: 72d46629b6ee4554b7c4332d403dfb72-20220211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1846382315; Fri, 11 Feb 2022 11:50:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Feb 2022 11:50:17 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Feb 2022 11:50:17 +0800
Message-ID: <199f0e547431d103dc22f8037a72f72dcd0ccf54.camel@mediatek.com>
Subject: Re: [V11,PATCH 16/19] arm64: dts: mt8183: add dvfsrc related nodes
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Date:   Fri, 11 Feb 2022 11:50:17 +0800
In-Reply-To: <e08c8a92-a4c6-61a0-4fe7-6d8e2d83163b@collabora.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
         <20210812085846.2628-17-dawei.chien@mediatek.com>
         <e08c8a92-a4c6-61a0-4fe7-6d8e2d83163b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-03 at 16:16 +0100, AngeloGioacchino Del Regno wrote:
> Il 12/08/21 10:58, Dawei Chien ha scritto:
> > From: Henry Chen <henryc.chen@mediatek.com>
> > 
> > Add DDR EMI provider dictating dram interconnect bus performance
> > found on
> > MT8192-based platforms
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> 
> This patch definitely has to be squashed with patch 07/19.
> 
> Same for patch 17 and 19.
> 
> Also, sign-off.
> 

I would squash patch 07/16, 08/17, 09/18 on next version, thank you.

> > ---
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 7ad4cf646579..86f85c34c88a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -7,6 +7,7 @@
> >   
> >   #include <dt-bindings/clock/mt8183-clk.h>
> >   #include <dt-bindings/gce/mt8183-gce.h>
> > +#include <dt-bindings/interconnect/mtk,mt8183-emi.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/memory/mt8183-larb-port.h>
> > @@ -586,6 +587,7 @@
> >   		ddr_emi: dvfsrc@10012000 {
> >   			compatible = "mediatek,mt8183-dvfsrc";
> >   			reg = <0 0x10012000 0 0x1000>;
> > +			#interconnect-cells = <1>;
> >   		};
> >   
> >   		pwrap: pwrap@1000d000 {

