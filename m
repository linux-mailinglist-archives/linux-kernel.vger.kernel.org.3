Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998F4EBBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbiC3HfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243827AbiC3HfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:35:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BA2128CD;
        Wed, 30 Mar 2022 00:33:24 -0700 (PDT)
X-UUID: 8c46d7339c6a4ab3a740c16bdc33d4e3-20220330
X-UUID: 8c46d7339c6a4ab3a740c16bdc33d4e3-20220330
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1717705257; Wed, 30 Mar 2022 15:33:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Mar 2022 15:33:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 15:33:16 +0800
Message-ID: <094d261cf7621b2e68e53a0aaef8e7eaa9965a7e.camel@mediatek.com>
Subject: Re: [PATCH v12 2/3] dt-bindings: mmc: mtk-sd: increase reg maxItems
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Date:   Wed, 30 Mar 2022 15:33:16 +0800
In-Reply-To: <32931f81-5615-8156-4c67-bb4260488185@gmail.com>
References: <20220329114540.17140-1-tinghan.shen@mediatek.com>
         <20220329114540.17140-3-tinghan.shen@mediatek.com>
         <32931f81-5615-8156-4c67-bb4260488185@gmail.com>
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

Hi Matthias,

On Tue, 2022-03-29 at 16:27 +0200, Matthias Brugger wrote:
> 
> On 29/03/2022 13:45, Tinghan Shen wrote:
> > Add optional host top register base for the reg binding description.
> > 
> 
> Is this based a on a new version of the IP? Shall we make the second reg 
> mandatory for the new HW? If I remember correctly the reg needs to be restored 
> after power save event. So I suppose mmc won't work if that's not done. So 
> optional wouldn't be the right approach.
> 
> Can you please clarify if that's the case.

Yes. This change is introduced since mt8183, and the host top register 
is required for mt8183. 

We'll try to describe this change clearly in bindings in next version.


Best regards,
Tinghan

> 
> Thanks,
> Matthias
> 
> > Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 7032f7adf3ca..6d41bcec900f 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -40,7 +40,8 @@ properties:
> >             - const: mediatek,mt8183-mmc
> >   
> >     reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >   
> >     clocks:
> >       description:

