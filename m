Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A74B3EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiBNBoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:44:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:44:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30951E54;
        Sun, 13 Feb 2022 17:43:56 -0800 (PST)
X-UUID: 8365399bdc784f59b01435c258af29c2-20220214
X-UUID: 8365399bdc784f59b01435c258af29c2-20220214
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1281677688; Mon, 14 Feb 2022 09:43:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 09:43:52 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 09:43:50 +0800
Message-ID: <8039ba062ec9408c773292f21d5604f6ddb86d1b.camel@mediatek.com>
Subject: Re: [PATCH 3/6] dt-bindings: spi: Add compatible for Mediatek IPM
 IP with quad mode
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Mon, 14 Feb 2022 09:43:50 +0800
In-Reply-To: <bed10d2e-a3eb-ddcb-8b84-9b5ba7f138f1@canonical.com>
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
         <20220209111938.16137-4-leilk.liu@mediatek.com>
         <bed10d2e-a3eb-ddcb-8b84-9b5ba7f138f1@canonical.com>
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

On Fri, 2022-02-11 at 12:44 +0100, Krzysztof Kozlowski wrote:
> On 09/02/2022 12:19, Leilk Liu wrote:
> > This commit adds dt-binding documentation for
> > Mediatek SPI IPM IP with quad mode.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1
> > +
> >  1 file changed, 1 insertion(+)
> 
> Same comments as for patch 1 apply.
> 
OK, I'll fix it.thanks
> 
> Best regards,
> Krzysztof

