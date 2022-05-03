Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C05181A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiECJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiECJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:52:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661032076;
        Tue,  3 May 2022 02:48:55 -0700 (PDT)
X-UUID: 836079bdcd134897a60b65e3fceb4c88-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:88119768-a24f-4bdb-9fbd-6599b695476b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:88119768-a24f-4bdb-9fbd-6599b695476b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:cf3950c7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 836079bdcd134897a60b65e3fceb4c88-20220503
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 950611729; Tue, 03 May 2022 17:48:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 17:48:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 3 May 2022 17:48:47 +0800
Message-ID: <528f8b2528d694dd4742c2b0b439bb30474c911c.camel@mediatek.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: display: mediatek: dsi: Convert
 dsi_dtbinding to .yaml
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <airlied@linux.ie>,
        <krzysztof.kozlowski+dt@linaro.org>, <daniel@ffwll.ch>,
        <xinlei.lee@mediatek.com>, <devicetree@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <cellopoint.kai@gmail.com>
Date:   Tue, 3 May 2022 17:48:47 +0800
In-Reply-To: <YmxFRuBWmPaCyw0I@robh.at.kernel.org>
References: <20220428133753.8348-1-rex-bc.chen@mediatek.com>
         <20220428133753.8348-2-rex-bc.chen@mediatek.com>
         <1651177993.334386.220464.nullmailer@robh.at.kernel.org>
         <9f601c458bd3401b216992e8dd72485a10f34597.camel@mediatek.com>
         <YmxFRuBWmPaCyw0I@robh.at.kernel.org>
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

On Fri, 2022-04-29 at 15:06 -0500, Rob Herring wrote:
> On Fri, Apr 29, 2022 at 09:55:37AM +0800, Rex-BC Chen wrote:
> > On Thu, 2022-04-28 at 15:33 -0500, Rob Herring wrote:
> > > On Thu, 28 Apr 2022 21:37:50 +0800, Rex-BC Chen wrote:
> > > > From: Xinlei Lee <xinlei.lee@mediatek.com>
> > > > 
> > > > Convert mediatek,dsi.txt to mediatek,dsi.yaml format
> > > > 
> > > > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > > ---
> > > >  .../display/mediatek/mediatek,dsi.txt         |  62 ---------
> > > >  .../display/mediatek/mediatek,dsi.yaml        | 122
> > > > ++++++++++++++++++
> > > >  2 files changed, 122 insertions(+), 62 deletions(-)
> > > >  delete mode 100644
> > > > Documentation/devicetree/bindings/display/mediatek/mediatek,dsi
> > > > .txt
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/display/mediatek/mediatek,dsi
> > > > .yam
> > > > l
> > > > 
> > > 
> > > Running 'make dtbs_check' with the schema in this patch gives the
> > > following warnings. Consider if they are expected or the schema
> > > is
> > > incorrect. These may not be new warnings.
> > > 
> > > Note that it is not yet a requirement to have 0 warnings for
> > > dtbs_check.
> > > This will change in the future.
> > > 
> > > Full log is available here: 
> > > 
https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/__;!!CTRNKA9wMg0ARbw!wKbRsUmeUS_4mtOwj1t30buVNEilHYYhsUmEd5MvZ7P9VyDXg6cikERof47mkwETQzFL$
> > >  
> > > 
> > > 
> > > dsi@1400c000: compatible: ['mediatek,mt7623-dsi',
> > > 'mediatek,mt2701-
> > > dsi'] is too long
> > > 	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
> > > 	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb
> > > 
> > > dsi@14014000: #address-cells:0:0: 2 was expected
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-
> > > sku2.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku6.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku7.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> > > sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb
> > > 
> > > dsi@14014000: 'port' is a required property
> > > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-
> > > sku2.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku6.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku7.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> > > sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb
> > > 
> > > dsi@14014000: #size-cells:0:0: 2 was expected
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-
> > > sku2.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku6.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > > sku7.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> > > sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > > sku1.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb
> > > 
> > > dsi@1401b000: 'port' is a required property
> > > 	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
> > > 	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
> > > 
> > 
> > Hello Rob,
> > 
> > Thanks for your comments.
> > The purpose of this series is not to fix dts for previous SoCs.
> > Therefore, if there is a chance, we could send another series to
> > fix
> > them.
> 
> Conversions often find that the actual dts files vary a bit more
> than 
> the binding doc said. You should look at the warnings and decide if
> they 
> should be fixed or the schema relaxed. It's a judgement call. I have
> no 
> idea if you did that already or not, so I send this out on
> conversions. 
> The check runs automatically, but sending it I review briefly.
> 
> Rob

Hello Rob,

Thanks for your explanation!
In addition, do you have any suggestion for this conversion?

BRs,
Rex

