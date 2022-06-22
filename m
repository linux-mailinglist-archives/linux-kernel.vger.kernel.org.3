Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9526B5548BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357594AbiFVMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiFVMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:06:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526C3DDCC;
        Wed, 22 Jun 2022 05:06:16 -0700 (PDT)
X-UUID: 89cb5cfe996d45b8b5e117f9fbc5ef64-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:bca889a7-37dd-4ebc-a06b-0b4a1495cc5c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:dd68c12d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 89cb5cfe996d45b8b5e117f9fbc5ef64-20220622
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 428670532; Wed, 22 Jun 2022 20:06:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Jun 2022 20:06:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 20:06:10 +0800
Message-ID: <9a02f733ffcffd03d173bd7d0daac1802b7dcff3.camel@mediatek.com>
Subject: Re: [PATCH v6 16/16] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chun-jie.chen@mediatek.com" <chun-jie.chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 22 Jun 2022 20:06:10 +0800
In-Reply-To: <3a587e20-f991-adf8-fe4e-a09caa1e14c7@gmail.com>
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
         <20220503093856.22250-17-rex-bc.chen@mediatek.com>
         <3a587e20-f991-adf8-fe4e-a09caa1e14c7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 19:08 +0800, Matthias Brugger wrote:
> 
> On 03/05/2022 11:38, Rex-BC Chen wrote:
> > We will use mediatek clock reset as infracfg_ao reset instead of
> > ti-syscon. To support this, remove property of ti reset and add
> > property of #reset-cells for mediatek clock reset.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> 
> My understanding is that using the old DTS with a newer kernel
> wouldn't 
> introduce a regression, correct?
> 
> Applied, thanks!
> 

Hello Matthias,

yes, because there is no user for this infra reset controller in
upstream mainline.

In addition, could you also help to give us some suggestion for Nancy's
series?

Thanks for your big support!

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=651900

BRs,
Bo-Chen

> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 13 +------------
> >   1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index b57e620c2c72..8e5ac11b19f1 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -10,7 +10,6 @@
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/phy/phy.h>
> >   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> > -#include <dt-bindings/reset/ti-syscon.h>
> >   
> >   / {
> >   	compatible = "mediatek,mt8195";
> > @@ -295,17 +294,7 @@
> >   			compatible = "mediatek,mt8195-infracfg_ao",
> > "syscon", "simple-mfd";
> >   			reg = <0 0x10001000 0 0x1000>;
> >   			#clock-cells = <1>;
> > -
> > -			infracfg_rst: reset-controller {
> > -				compatible = "ti,syscon-reset";
> > -				#reset-cells = <1>;
> > -				ti,reset-bits = <
> > -					0x140 18 0x144 18 0 0
> > (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* pcie */
> > -					0x120 0  0x124 0  0 0
> > (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> > -					0x730 10 0x734 10 0 0
> > (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> > -					0x150 5  0x154 5  0 0
> > (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* svs gpu */
> > -				>;
> > -			};
> > +			#reset-cells = <1>;
> >   		};
> >   
> >   		pericfg: syscon@10003000 {

