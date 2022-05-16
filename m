Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89752825A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiEPKmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiEPKlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:41:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF9261C;
        Mon, 16 May 2022 03:41:37 -0700 (PDT)
X-UUID: 6456a25257d540899786888d20ed49f0-20220516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:14da1c38-918c-4adf-b92e-1cf13a3a5ae1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:89bb2e94-563e-4fc2-8a0d-fda4821947ab,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 6456a25257d540899786888d20ed49f0-20220516
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1875934610; Mon, 16 May 2022 18:41:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 16 May 2022 18:41:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 May 2022 18:41:31 +0800
Message-ID: <e1dffbf98c034b99b1d7fd10aa009a645812abdc.camel@mediatek.com>
Subject: Re: [PATCH v6 09/10] arm64: dts: mediatek: Add MediaTek CCI node
 for MT8183
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <khilman@baylibre.com>, <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Date:   Mon, 16 May 2022 18:41:31 +0800
In-Reply-To: <CAGXv+5FW59B1Dq8eH=5KjEdTxgT64GuvYZHZ9LnnTuaVrK3XpQ@mail.gmail.com>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
         <20220505115226.20130-10-rex-bc.chen@mediatek.com>
         <CAGXv+5FW59B1Dq8eH=5KjEdTxgT64GuvYZHZ9LnnTuaVrK3XpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-16 at 13:35 +0800, Chen-Yu Tsai wrote:
> On Thu, May 5, 2022 at 8:04 PM Rex-BC Chen <rex-bc.chen@mediatek.com>
> wrote:
> > 
> > Add MediaTek CCI devfreq node for MT8183.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts    | 4 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 7 +++++++
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > index 8953dbf84f3e..7ac9864db9de 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -412,6 +412,10 @@
> > 
> >  };
> > 
> > +&cci {
> > +       proc-supply = <&mt6358_vproc12_reg>;
> > +};
> > +
> >  &cpu0 {
> >         proc-supply = <&mt6358_vproc12_reg>;
> >  };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index 8d5bf73a9099..b035e06840e6 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -230,6 +230,10 @@
> >         status = "okay";
> >  };
> > 
> > +&cci {
> > +       proc-supply = <&mt6358_vproc12_reg>;
> > +};
> > +
> >  &cpu0 {
> >         proc-supply = <&mt6358_vproc12_reg>;
> >  };
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index cecf96b628b7..11caf3dd85cd 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -280,6 +280,13 @@
> >                 };
> >         };
> > 
> > +       cci: cci {
> > +               compatible = "mediatek,mt8183-cci";
> > +               clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> > +               clock-names = "cci_clock";
> 
> Binding says there should be two clocks: the actual clock that drives
> CCI, and a stable "intermediate" clock to switch to during clock rate
> changes. So I think this should look like:
> 
>     clocks = <&mcucfg CLK_MCU_BUS_SEL>,
>              <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
>     clock-names = "cci", "intermediate";
> 
> 
> ChenYu
> 

Hello Chen-Yu,

Thanks for your reminder.
I will update this and sned next version.

BRs,
Rex

> > +               operating-points-v2 = <&cci_opp>;
> > +       };
> > +
> >         cpus {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > --
> > 2.18.0
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek

