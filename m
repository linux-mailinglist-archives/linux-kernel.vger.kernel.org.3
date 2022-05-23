Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF1530899
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiEWFLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355580AbiEWFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:11:12 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA964E3;
        Sun, 22 May 2022 22:11:08 -0700 (PDT)
X-UUID: d0e94660af9e45fab79506a3429d015a-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:dfedd619-e106-4cfd-bcb2-3fe3a4a78c3a,OB:30,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:dfedd619-e106-4cfd-bcb2-3fe3a4a78c3a,OB:30,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:55782ce3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:c4fd7da82419,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: d0e94660af9e45fab79506a3429d015a-20220523
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1933216122; Mon, 23 May 2022 13:11:03 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 23 May 2022 13:11:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 May 2022 13:11:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 13:11:01 +0800
Message-ID: <39132f3173df651ea0e2d7ea399008b9ba8d1892.camel@mediatek.com>
Subject: Re: [PATCH v7 16/19] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
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
Date:   Mon, 23 May 2022 13:11:01 +0800
In-Reply-To: <20220520153034.v4dvh4bn2pon6nnr@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
         <20220519125527.18544-17-rex-bc.chen@mediatek.com>
         <20220520153034.v4dvh4bn2pon6nnr@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 23:30 +0800, Nícolas F. R. A. Prado wrote:
> Hi Rex,
> 
> On Thu, May 19, 2022 at 08:55:24PM +0800, Rex-BC Chen wrote:
> > We will use mediatek clock reset as infracfg_ao reset instead of
> > ti-syscon. To support this, remove property of ti reset and add
> > property of #reset-cells for mediatek clock reset.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index b57e620c2c72..8e5ac11b19f1 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -10,7 +10,6 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> > -#include <dt-bindings/reset/ti-syscon.h>
> >  
> >  / {
> >  	compatible = "mediatek,mt8195";
> > @@ -295,17 +294,7 @@
> >  			compatible = "mediatek,mt8195-infracfg_ao",
> > "syscon", "simple-mfd";
> 
> I believe the 'simple-mfd' compatible was added only to make the
> reset-controller subnode probe (at least this was the case for
> mt8192), so it
> might make sense to drop it here as well.
> 
> Thanks,
> Nícolas
> 

Hello Nícolas,
ok, I will drop 'simple-mfd' in next version.

BRs,
Rex

> >  			reg = <0 0x10001000 0 0x1000>;
> >  			#clock-cells = <1>;
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
> >  		};
> >  
> >  		pericfg: syscon@10003000 {
> > -- 
> > 2.18.0
> > 
> > 

