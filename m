Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443E50D899
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiDYFFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiDYFE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:04:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1327C8233A;
        Sun, 24 Apr 2022 22:01:48 -0700 (PDT)
X-UUID: e1b52e78c8164e8cae9f58f6ec9460f2-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:33ab0d5a-3c1a-4018-b834-97e52a98695e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:33ab0d5a-3c1a-4018-b834-97e52a98695e,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:4737faef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: e1b52e78c8164e8cae9f58f6ec9460f2-20220425
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1368655794; Mon, 25 Apr 2022 13:01:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 25 Apr 2022 13:01:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 13:01:42 +0800
Message-ID: <5ec37a01b0b84140a7d171b9a5cff7ad8f9fbe87.camel@mediatek.com>
Subject: Re: [PATCH V3 12/17] dt-binding: mt8192: Add infra_ao reset bit
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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
Date:   Mon, 25 Apr 2022 13:01:42 +0800
In-Reply-To: <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
         <20220422060152.13534-13-rex-bc.chen@mediatek.com>
         <e5b18654-ce83-44ee-e4c8-4cdfc4ceaa1d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 18:28 +0800, Krzysztof Kozlowski wrote:
> On 22/04/2022 08:01, Rex-BC Chen wrote:
> > To support reset of infra_ao, add the bit definition for
> > thermal/PCIe/SVS.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  include/dt-bindings/reset/mt8192-resets.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/dt-bindings/reset/mt8192-resets.h
> > b/include/dt-bindings/reset/mt8192-resets.h
> > index be9a7ca245b9..d5f3433175c1 100644
> > --- a/include/dt-bindings/reset/mt8192-resets.h
> > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > @@ -27,4 +27,14 @@
> >  
> >  #define MT8192_TOPRGU_SW_RST_NUM				23
> >  
> > +/* INFRA RST0 */
> > +#define MT8192_INFRA_RST0_LVTS_AP_RST				
> > 0
> > +/* INFRA RST2 */
> > +#define MT8192_INFRA_RST2_PCIE_PHY_RST				
> > 15
> > +/* INFRA RST3 */
> > +#define MT8192_INFRA_RST3_PTP_RST				5
> > +/* INFRA RST4 */
> > +#define MT8192_INFRA_RST4_LVTS_MCU				12
> > +#define MT8192_INFRA_RST4_PCIE_TOP				1
> 
> These should be the IDs of reset, not some register values/offsets.
> Therefore it is expected to have them incremented by 1.
> 
> 

Hello Krzysztof,

This is define bit.

There is serveral reset set for infra_ao while it's not serial.
For MT8192, it's 0x120/0x130/0x140/0x150/0x730.
We are implement #reset-cells = <2>, and we can use this reset drive
more easier.

For example, in dts, we can define
infra_ao: syscon {
	compatible = "mediatek,mt8192-infracfg", "syscon";
 	reg = <0 0x10001000 0 0x1000>;
 	#clock-cells = <1>;
	#reset-cells = <2>;
};

thermal {
	...
	resets = <&infra_ao 0x730 MT8192_INFRA_RST4_LVTS_MCU>;
	...
};

If it's acceptabel, I can update all bit difinition from 0 to 15 for
all reset set.

BRs,
Rex
> > +
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> 
> 
> Best regards,
> Krzysztof

