Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B164B3F01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiBNBtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:49:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBNBtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:49:20 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217A532C3;
        Sun, 13 Feb 2022 17:49:12 -0800 (PST)
X-UUID: e5768eff56124b90b9e827656bbe5dd6-20220214
X-UUID: e5768eff56124b90b9e827656bbe5dd6-20220214
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1363912743; Mon, 14 Feb 2022 09:49:10 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 09:49:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 09:49:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 09:49:06 +0800
Message-ID: <16f9272489ee3cc15a4816825f3537eb5cece31a.camel@mediatek.com>
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add compatible for Mediatek IPM
 IP with single mode
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 14 Feb 2022 09:49:06 +0800
In-Reply-To: <YgaVCmizWJfFMK5I@robh.at.kernel.org>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
         <20220209111938.16137-2-leilk.liu@mediatek.com>
         <YgaVCmizWJfFMK5I@robh.at.kernel.org>
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

On Fri, 2022-02-11 at 10:55 -0600, Rob Herring wrote:
> On Wed, Feb 09, 2022 at 07:19:33PM +0800, Leilk Liu wrote:
> > This commit adds dt-binding documentation for
> > Mediatek SPI IPM IP with single mode.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1
> > +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > index bfa44acb1bdd..0a2fc0404cb3 100644
> > --- a/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-
> > mt65xx.yaml
> > @@ -41,6 +41,7 @@ properties:
> >                - mediatek,mt8135-spi
> >                - mediatek,mt8173-spi
> >                - mediatek,mt8183-spi
> > +              - mediatek,ipm-spi-single
> 
> Is IPM an SoC? Compatible strings should be SoC specific or whatever 
> granularity could have a unique errata.
> 
IPM is an version of SPI ip, we use this IP with ICs now. So I define a
compatible strings "mediatek,ipm-spi-single", then I can reuse this
compatible strings with many ICs.

> Rob

