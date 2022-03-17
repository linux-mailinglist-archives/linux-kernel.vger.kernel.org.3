Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACAB4DBE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiCQFfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCQFfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:35:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD619F459;
        Wed, 16 Mar 2022 22:03:49 -0700 (PDT)
X-UUID: 6598972e8a0f4dbf97b2b84afa919fb9-20220317
X-UUID: 6598972e8a0f4dbf97b2b84afa919fb9-20220317
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1676542577; Thu, 17 Mar 2022 12:48:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 12:48:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 12:48:07 +0800
Message-ID: <2f3c1f4461267644ab8e2b45e21c61591d245b01.camel@mediatek.com>
Subject: Re: [PATCH V8 1/5] dt-bindings: display: mediatek: add aal binding
 for MT8183
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jassisinghbrar@gmail.com>, <fparent@baylibre.com>,
        <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 17 Mar 2022 12:48:07 +0800
In-Reply-To: <cf765199-30c3-f963-4d9b-8f225efd5b32@canonical.com>
References: <20220316115155.17834-1-rex-bc.chen@mediatek.com>
         <20220316115155.17834-2-rex-bc.chen@mediatek.com>
         <cf765199-30c3-f963-4d9b-8f225efd5b32@canonical.com>
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

On Wed, 2022-03-16 at 16:18 +0100, Krzysztof Kozlowski wrote:
> On 16/03/2022 12:51, Rex-BC Chen wrote:
> > Add aal binding for MT8183.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4
> > +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > aml
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > aml
> > index 61f0ed1e388f..eb0299b80522 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > aml
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.y
> > aml
> > @@ -22,7 +22,9 @@ properties:
> >    compatible:
> >      oneOf:
> >        - items:
> > -          - const: mediatek,mt8173-disp-aal
> > +          - enum:
> > +              - mediatek,mt8173-disp-aal
> > +              - mediatek,mt8183-disp-aal
> 
> This should not be under items. You have just one element here, so
> directly "enum" under oneOf.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

OK, I will do this in next version.
Thanks!

BRs,
Rex

