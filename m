Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464734B3F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiBNBxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:53:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBNBxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:53:48 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF81532C6;
        Sun, 13 Feb 2022 17:53:40 -0800 (PST)
X-UUID: d7e596a3c3344383af0722dd68d4d0bd-20220214
X-UUID: d7e596a3c3344383af0722dd68d4d0bd-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1325086774; Mon, 14 Feb 2022 09:53:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 09:53:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 09:53:34 +0800
Message-ID: <cf97cd654fc2549065cbfc78e9c45ecb06232059.camel@mediatek.com>
Subject: Re: [PATCH 5/6] dt-bindings: spi: support mediatek,need_ahb_clk flag
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 14 Feb 2022 09:53:35 +0800
In-Reply-To: <YgaV6w1ooAzTpYNz@robh.at.kernel.org>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
         <20220209111938.16137-6-leilk.liu@mediatek.com>
         <YgaV6w1ooAzTpYNz@robh.at.kernel.org>
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

On Fri, 2022-02-11 at 10:59 -0600, Rob Herring wrote:
> On Wed, Feb 09, 2022 at 07:19:37PM +0800, Leilk Liu wrote:
> > this patch support mediatek,need_ahb_clk flag.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml         | 5
> > +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index 241c0f5880d3..af12c1711182 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -71,6 +71,11 @@ properties:
> >        specify which pins group(ck/mi/mo/cs) spi controller used.
> >        This is an array.
> >  
> > +  mediatek,need_ahb_clk:
> 
> s/_/-/
> 
> But really, this should be implied by the compatible string or
> presence 
> of the clock in 'clocks'.
so I can only add "spi-hclk" in clocks' and don't need
"mediatek,need_ahb_clk" again? thanks

> 
> Rob

