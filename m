Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C324D6F86
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 15:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiCLOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 09:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCLOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 09:21:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9260A9E;
        Sat, 12 Mar 2022 06:20:28 -0800 (PST)
X-UUID: 3f792280c01248ee9e0fd8e9dcc7048b-20220312
X-UUID: 3f792280c01248ee9e0fd8e9dcc7048b-20220312
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 891404891; Sat, 12 Mar 2022 22:20:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 12 Mar 2022 22:20:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Mar 2022 22:20:21 +0800
Message-ID: <fc3c76ab274c12bea9be9e17823fcb4f80ddf764.camel@mediatek.com>
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: mt8195: add
 mt8195-mt6359-max98390-rt5682 document
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Date:   Sat, 12 Mar 2022 22:20:21 +0800
In-Reply-To: <Yip5O3t0Ymyc2h+p@robh.at.kernel.org>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
         <20220308072435.22460-6-trevor.wu@mediatek.com>
         <Yip5O3t0Ymyc2h+p@robh.at.kernel.org>
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

On Thu, 2022-03-10 at 16:18 -0600, Rob Herring wrote:
> On Tue, Mar 08, 2022 at 03:24:35PM +0800, Trevor Wu wrote:
> > This patch adds document for mt8195 board with mt6359, max98390 and
> > rt5682.
> > 
> > Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> > ---
> >  .../sound/mt8195-mt6359-max98390-rt5682.yaml  | 61
> > +++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-
> > mt6359-max98390-rt5682.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > max98390-rt5682.yaml
> > b/Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-
> > rt5682.yaml
> > new file mode 100644
> > index 000000000000..7ec14d61b109
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-
> > max98390-rt5682.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/sound/mt8195-mt6359-max98390-rt5682.yaml*__;Iw!!CTRNKA9wMg0ARbw!zb7eaqdAQfuyPpP5m31L3Q5pdCulclJgnygkkMgYh2M6segUZedd-cYz51-5Q2XDCA$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zb7eaqdAQfuyPpP5m31L3Q5pdCulclJgnygkkMgYh2M6segUZedd-cYz5187C1ArQA$
> >  
> > +
> > +title: Mediatek MT8195 with MT6359, MAX98390 and RT5682 ASoC sound
> > card driver
> > +
> > +maintainers:
> > +  - Trevor Wu <trevor.wu@mediatek.com>
> > +
> > +description:
> > +  This binding describes the MT8195 sound card.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8195_mt6359_max98390_rt5682
> 
> You have nodes for each of these components, why do we need new 
> compatible string for each combination. You can figure out the 
> combination by looking at each of those nodes.
> 
> Second, why does each combination need a new schema doc?
> 
> Rob

Hi Rob,

I'm not sure whether I can reuse the old schema doc because of the doc
name and compatible string seems to be specifically for the codec
combination.
If I want to reuse the old schema doc, should I change the doc name or
compatible string? Make the naming more general.

Thanks,
Trevor   


