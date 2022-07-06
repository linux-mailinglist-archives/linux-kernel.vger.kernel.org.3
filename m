Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE8567CED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiGFECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGFECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:02:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E114014;
        Tue,  5 Jul 2022 21:02:06 -0700 (PDT)
X-UUID: ce02886f8f534f04a89634c157529cdf-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:afe0df47-7923-4ea8-a583-c275ae9651a5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:a12c8663-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: ce02886f8f534f04a89634c157529cdf-20220706
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 709273467; Wed, 06 Jul 2022 12:01:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 6 Jul 2022 12:01:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 12:01:57 +0800
Message-ID: <6886a99699aa8240b2a59eb068dbf48061001d06.camel@mediatek.com>
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update
 condition for mt8195 smi node
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
Date:   Wed, 6 Jul 2022 12:01:57 +0800
In-Reply-To: <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
         <20220704100028.19932-3-tinghan.shen@mediatek.com>
         <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 14:36 +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
> > The max clock items for the dts node with compatible
> > 'mediatek,mt8195-smi-sub-common' should be 3.
> > 
> > However, the dtbs_check of such node will get following message,
> > arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0']
> > is too long
> >          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-
> > common.yaml
> > 
> > Remove the last 'else' checking to fix this error.
> 
> Missing fixes tag.
> 
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../memory-controllers/mediatek,smi-common.yaml        | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > index a98b359bf909..e5f553e2e12a 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> > @@ -143,7 +143,15 @@ allOf:
> >              - const: gals0
> >              - const: gals1
> >  
> > -    else:  # for gen2 HW that don't have gals
> > +  - if:  # for gen2 HW that don't have gals
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - mediatek,mt2712-smi-common
> > +            - mediatek,mt8167-smi-common
> > +            - mediatek,mt8173-smi-common
> > +
> 
> Without looking at the code, it's impossible to understand what you are
> doing here. The commit msg says one, but you are doing something else.
> 
> Write commit msg explaining what you want to achieve and what you are doing.
> 
> 
> Best regards,
> Krzysztof

Ok, I'll update in next version.

Thanks,
TingHan

