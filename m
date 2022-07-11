Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FDF57019E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGKMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGKMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:04:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02DAE47;
        Mon, 11 Jul 2022 05:03:52 -0700 (PDT)
X-UUID: 3c8c5df364dc4235a485009a948a9808-20220711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1200bcbc-04a8-40e6-a4a9-6eae801b09d6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:6c941a87-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3c8c5df364dc4235a485009a948a9808-20220711
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 485703959; Mon, 11 Jul 2022 20:03:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 11 Jul 2022 20:03:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 11 Jul 2022 20:03:46 +0800
Message-ID: <459bb032c68be7c5be682d90462becfbb17ccda8.camel@mediatek.com>
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
Date:   Mon, 11 Jul 2022 20:03:46 +0800
In-Reply-To: <c8f8f5f4-173e-797d-e060-e5eaac7ca822@linaro.org>
References: <20220707054710.1396-1-johnson.wang@mediatek.com>
         <41e17a56-5cb0-8e90-c7ae-a7a56de986d0@linaro.org>
         <3216ec92952c7d722feaeb76986e0a6a54340646.camel@mediatek.com>
         <c8f8f5f4-173e-797d-e060-e5eaac7ca822@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 13:02 +0200, Krzysztof Kozlowski wrote:
> On 07/07/2022 09:30, Johnson Wang wrote:
> > On Thu, 2022-07-07 at 08:46 +0200, Krzysztof Kozlowski wrote:
> > > On 07/07/2022 07:47, Johnson Wang wrote:
> > > > This commit adds dt-binding documentation of mmc for MediaTek
> > > > MT8188 SoC
> > > > platform.
> > > > 
> > > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > index 2a2e9fa8c188..3fbf33ad4f7c 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > @@ -32,6 +32,9 @@ properties:
> > > >        - items:
> > > >            - const: mediatek,mt8186-mmc
> > > >            - const: mediatek,mt8183-mmc
> > > > +      - items:
> > > > +          - const: mediatek,mt8188-mmc
> > > 
> > > You duplicate quite a lot. Use enum.
> > > 
> > > Best regards,
> > > Krzysztof
> > 
> > Hi Krzysztof,
> > 
> > Thanks for you suggestion.
> > 
> > I will use 'enum' to place this compatible strings.
> > 
> > Just like this:
> > - items:
> >     - enum:
> >         - mediatek,mt8186-mmc
> >         - mediatek,mt8188-mmc
> >         - mediatek,mt8192-mmc
> >         - mediatek,mt8195-mmc
> >     - const: mediatek,mt8183-mmc
> > 
> > Moreover, it seems that missing an "items:" between oneOf and enum
> > in
> > the compatible property.
> > Is my understanding wrong?
> 
> I did not propose to remove items, so where are they missing? Not
> sure
> what you are asking about...
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Sorry for the confusion.
That was my misunderstanding. Please ignore it...

BRs,
Johnson Wang

