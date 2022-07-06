Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD4568799
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiGFMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiGFMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:00:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1C237DD;
        Wed,  6 Jul 2022 05:00:39 -0700 (PDT)
X-UUID: 6b753b0c425c4b7083e08b8d4a98e225-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:803bd319-e2e1-46dc-8456-d9e271f6ee69,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:435bb586-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6b753b0c425c4b7083e08b8d4a98e225-20220706
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1654993368; Wed, 06 Jul 2022 20:00:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 6 Jul 2022 20:00:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 20:00:32 +0800
Message-ID: <eec6aee5cd023fff6d986882db0330e1ab85a59d.camel@mediatek.com>
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains
 controller
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 6 Jul 2022 20:00:32 +0800
In-Reply-To: <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
         <20220704100028.19932-9-tinghan.shen@mediatek.com>
         <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

After discussing your message with our power team, 
we realized that we need your help to ensure we fully understand you.

On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
> > Add power domains controller node for mt8195.
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
> >  1 file changed, 327 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 8d59a7da3271..d52e140d9271 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -10,6 +10,7 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> > +#include <dt-bindings/power/mt8195-power.h>
> >  
> >  / {
> >  	compatible = "mediatek,mt8195";
> > @@ -338,6 +339,332 @@
> >  			#interrupt-cells = <2>;
> >  		};
> >  
> > +		scpsys: syscon@10006000 {
> > +			compatible = "syscon", "simple-mfd";
> 
> These compatibles cannot be alone.

the scpsys sub node has the compatible of the power domain driver.
do you suggest that the compatible in the sub node should move to here?

> > +			reg = <0 0x10006000 0 0x1000>;
> > +			#power-domain-cells = <1>;
> 
> If it is simple MFD, then probably it is not a power domain provider.
> Decide.

this MFD device is the power controller on mt8195. Some features need 
to do some operations on registers in this node. We think that implement 
the operation of these registers as the MFD device can provide flexibility 
for future use. We want to clarify if you're saying that an MFD device 
cannot be a power domain provider.



Best regards,
TingHan




