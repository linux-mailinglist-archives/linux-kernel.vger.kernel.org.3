Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAF4D0DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiCHBtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiCHBtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:49:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98D3B3CC;
        Mon,  7 Mar 2022 17:48:26 -0800 (PST)
X-UUID: b69a8870f8dc42a8a5b3adc680e94c98-20220308
X-UUID: b69a8870f8dc42a8a5b3adc680e94c98-20220308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 667501494; Tue, 08 Mar 2022 09:48:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 09:48:18 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 09:48:17 +0800
Message-ID: <31d61f3b8d9ba206d25555dd48bdb4bf323edf6b.camel@mediatek.com>
Subject: Re: [PATCH V3 6/7] dt-bindings: spi: support spi-hclk
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Tue, 8 Mar 2022 09:48:17 +0800
In-Reply-To: <YiaYXwj0C8NeWjzz@robh.at.kernel.org>
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
         <20220307065230.12655-7-leilk.liu@mediatek.com>
         <YiaYXwj0C8NeWjzz@robh.at.kernel.org>
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

On Mon, 2022-03-07 at 17:42 -0600, Rob Herring wrote:
> On Mon, Mar 07, 2022 at 02:52:29PM +0800, Leilk Liu wrote:
> > this patch support spi-hclk.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4
> > ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index a8a15a9a6c46..195793aa79b7 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -51,16 +51,20 @@ properties:
> >      maxItems: 1
> >  
> >    clocks:
> > +    minItems: 3
> >      items:
> >        - description: clock used for the parent clock
> >        - description: clock used for the muxes clock
> >        - description: clock used for the clock gate
> > +      - description: clock used for the AHB bus, this clock is
> > optional
> >  
> >    clock-names:
> > +    minItems: 3
> >      items:
> >        - const: parent-clk
> >        - const: sel-clk
> >        - const: spi-clk
> > +      - const: spi-hclk
> 
> 'spi' is redundant. Just 'hclk'.
> 
OK, I'll fix it,thanks

> >  
> >    mediatek,pad-select:
> >      $ref: /schemas/types.yaml#/definitions/uint32-array
> > -- 
> > 2.25.1
> > 
> > 

