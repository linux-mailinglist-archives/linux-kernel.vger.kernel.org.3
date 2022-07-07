Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02707569B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiGGHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGGHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:30:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05331235;
        Thu,  7 Jul 2022 00:30:44 -0700 (PDT)
X-UUID: d2c34ff1fee144f4b921b7d1d663d878-20220707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:6841d9ae-7ef7-40e6-9bc8-40cef7c34611,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:6841d9ae-7ef7-40e6-9bc8-40cef7c34611,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:5e91a763-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:95ab2f9f30ad,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d2c34ff1fee144f4b921b7d1d663d878-20220707
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 583295451; Thu, 07 Jul 2022 15:30:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 7 Jul 2022 15:30:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 7 Jul 2022 15:30:40 +0800
Message-ID: <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add compatible for MediaTek MT8188
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 7 Jul 2022 15:30:40 +0800
In-Reply-To: <41e17a56-5cb0-8e90-c7ae-a7a56de986d0@linaro.org>
References: <20220707054710.1396-1-johnson.wang@mediatek.com>
         <41e17a56-5cb0-8e90-c7ae-a7a56de986d0@linaro.org>
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

On Thu, 2022-07-07 at 08:46 +0200, Krzysztof Kozlowski wrote:
> On 07/07/2022 07:47, Johnson Wang wrote:
> > This commit adds dt-binding documentation of mmc for MediaTek
> > MT8188 SoC
> > platform.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 2a2e9fa8c188..3fbf33ad4f7c 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -32,6 +32,9 @@ properties:
> >        - items:
> >            - const: mediatek,mt8186-mmc
> >            - const: mediatek,mt8183-mmc
> > +      - items:
> > +          - const: mediatek,mt8188-mmc
> 
> You duplicate quite a lot. Use enum.
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thanks for you suggestion.

I will use 'enum' to place this compatible strings.

Just like this:
- items:
    - enum:
        - mediatek,mt8186-mmc
        - mediatek,mt8188-mmc
        - mediatek,mt8192-mmc
        - mediatek,mt8195-mmc
    - const: mediatek,mt8183-mmc

Moreover, it seems that missing an "items:" between oneOf and enum in
the compatible property.
Is my understanding wrong?

BRs,
Johnson Wang


