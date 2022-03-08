Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5B4D0DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiCHBwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiCHBwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:52:42 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9633D497;
        Mon,  7 Mar 2022 17:51:43 -0800 (PST)
X-UUID: e46f70f6212d44398384e46c7dcb109b-20220308
X-UUID: e46f70f6212d44398384e46c7dcb109b-20220308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1271742935; Tue, 08 Mar 2022 09:51:39 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 8 Mar 2022 09:51:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Mar
 2022 09:51:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 09:51:37 +0800
Message-ID: <7ae469a94ad51be85f0731c4c42088d65b241581.camel@mediatek.com>
Subject: Re: [PATCH V3 2/7] dt-bindings: spi: Add compatible for MT7986 with
 single mode
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        "Rob Herring" <robh@kernel.org>
Date:   Tue, 8 Mar 2022 09:51:36 +0800
In-Reply-To: <b3950b6b-bfbe-da80-90cc-1a836958f931@collabora.com>
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
         <20220307065230.12655-3-leilk.liu@mediatek.com>
         <b3950b6b-bfbe-da80-90cc-1a836958f931@collabora.com>
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

On Mon, 2022-03-07 at 11:32 +0100, AngeloGioacchino Del Regno wrote:
> Il 07/03/22 07:52, Leilk Liu ha scritto:
> > This patch adds dt-binding documentation for MT7986 with single
> > mode.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >   Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml |
> > 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index bfa44acb1bdd..48024b98408a 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -41,6 +41,7 @@ properties:
> >                 - mediatek,mt8135-spi
> >                 - mediatek,mt8173-spi
> >                 - mediatek,mt8183-spi
> > +              - mediatek,mt7986-spi-single
> >   
> >     reg:
> >       maxItems: 1
> 
> I think that the best way to do this is to better organize the
> compatibles
> per-hardware, here... or the compatibles list will eventually grow
> out of
> control for little reason.
> 
> Since "IPM" is a new SPI controller IP, I would expect more and more
> MediaTek
> SoCs using it in the future, so here's my proposal:
Yes, we plan to use this IP with new ICs.

> 
> - Add a generic (const) compatible "mediatek,spi-ipm" to describe the
> hardware
> - Add an enumeration with "mediatek,mt7986-spi-ipm" as the only
> member, as to
>    prepare this binding for the future.
> - Single and quad mode can be expressed with generic SPI bindings!
> 
> Specifically, you can express that with "spi-rx-bus-width" for
> SPI_RX_{....}
> and "spi-tx-bus-width" for SPI_TX_{....}, so you don't need different
> compatibles
> for "mediatek,mt7986-spi-single" and "mediatek,mt7896-spi-quad".
> 
> Fast example:
> 
> spi@12345678 {
>      compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
>      reg = <....>
>      /* Quad mode */
>      spi-rx-bus-width = <4>;
>      spi-tx-bus-width = <4>;
> 
>      .... etc ....
> }
> 
OK, thanks for your advice.

> Regards,
> Angelo
> 
> 

