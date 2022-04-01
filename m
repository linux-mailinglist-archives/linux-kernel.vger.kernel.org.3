Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281A14EE5FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiDACUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiDACUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:20:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5F192BA;
        Thu, 31 Mar 2022 19:18:19 -0700 (PDT)
X-UUID: b491eb1115b14c9188e725920ef79dbd-20220401
X-UUID: b491eb1115b14c9188e725920ef79dbd-20220401
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1063335137; Fri, 01 Apr 2022 10:18:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 1 Apr 2022 10:18:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 10:18:08 +0800
Message-ID: <53cb53b8614aa39e0785b99f46b708ad201c3dd8.camel@mediatek.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
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
Date:   Fri, 1 Apr 2022 10:18:08 +0800
In-Reply-To: <aebbb5c8-1d27-5e66-e18a-e2b647bc8cb4@gmail.com>
References: <20220330094532.21721-1-tinghan.shen@mediatek.com>
         <20220330094532.21721-2-tinghan.shen@mediatek.com>
         <aebbb5c8-1d27-5e66-e18a-e2b647bc8cb4@gmail.com>
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

On Thu, 2022-03-31 at 12:54 +0200, Matthias Brugger wrote:
> 
> On 30/03/2022 11:45, Tinghan Shen wrote:
> > MediaTek has a new version of mmc IP since mt8183. Some IO registers
> > are moved to top to improve hardware design and named as "host top
> > registers".
> > 
> > Add host top register in the reg binding description for mt8183 and
> > successors.
> > 
> > Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 297ada03e3de..2a2e9fa8c188 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -40,7 +40,10 @@ properties:
> >             - const: mediatek,mt8183-mmc
> >   
> >     reg:
> > -    maxItems: 1
> > +    minItems: 1
> 
>  From my understanding adding minItems is correct, but you need to add also 
> maxItems: 2 as there can't be more then two register entries.
> 
> Regards,
> Matthias
> 

After add "maxItems: 2", I get following message when doing dt_binding_check.
from this message, it looks like that maxItems is not necessary.

/proj/mtk15399/2cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: 
properties:reg: {'minItems': 1, 'maxItems': 2, 'items': [{'description': 'base register
(required).'}, {'description': 'top base register (required for MT8183).'}]} should not be valid
under {'required': ['maxItems']}
        hint: "maxItems" is not needed with an "items" list
        from schema $id: http://devicetree.org/meta-schemas/items.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json

Best regards,
Tinghan

> > +    items:
> > +      - description: base register (required).
> > +      - description: top base register (required for MT8183).
> >   
> >     clocks:
> >       description:
> > @@ -168,6 +171,16 @@ required:
> >     - vmmc-supply
> >     - vqmmc-supply
> >   
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: mediatek,mt8183-mmc
> > +then:
> > +  properties:
> > +    reg:
> > +      minItems: 2
> > +
> >   unevaluatedProperties: false
> >   
> >   examples:

