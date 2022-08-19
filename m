Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4A5992B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiHSBq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:46:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24EBD5EB6;
        Thu, 18 Aug 2022 18:46:18 -0700 (PDT)
X-UUID: 35bb1b4ac6dd43be9a613c19b8f30de9-20220819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IOWVM8voEZOj8QsIgEwHtQL5oZR9puzNe4gdcUCy3PI=;
        b=Gu1gDOBfZARtTpls85okNmzvsIr5wRLxLvDJ3NwWFr4qo3wDHR2qVshLBmsA4tf5dAVTshf4m49yY3tCSTQbhOjOewQTigHC7HLXjQ9Lg4RnNbD0ox/w7+cWzBLJy4IWqPssOTJ0t9hpXVMCXUU6xS+GtiIIs58zsGtYZBuR+6E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:a9501030-8d1a-4f99-a563-8cbdbd44d833,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:c345bcfd-9e71-4a0f-ba6b-417998daea35,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 35bb1b4ac6dd43be9a613c19b8f30de9-20220819
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1547984976; Fri, 19 Aug 2022 09:46:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 19 Aug 2022 09:46:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Aug 2022 09:46:11 +0800
Message-ID: <0fb7809abab73c82f7ab98a80e5e04444381cf8e.camel@mediatek.com>
Subject: Re: [PATCH RESEND] dt-bindings: timer: Add compatible for MediaTek
 MT8188
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <daniel.lezcano@linaro.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 19 Aug 2022 09:46:11 +0800
In-Reply-To: <9947dc76-ab12-f840-3439-ca383c02c598@linaro.org>
References: <20220818124602.20394-1-johnson.wang@mediatek.com>
         <3d91fe87-feed-d083-9eeb-51293aead67a@linaro.org>
         <9947dc76-ab12-f840-3439-ca383c02c598@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-18 at 16:40 +0300, Krzysztof Kozlowski wrote:
> On 18/08/2022 15:51, Krzysztof Kozlowski wrote:
> > On 18/08/2022 15:46, Johnson Wang wrote:
> > > Add dt-binding documentation of timer for MediaTek MT8188 SoC
> > > platform.
> > > 
> > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt |
> > > 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> > > b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> > > index f1c848af91d3..8bbb6e94508b 100644
> > > --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-
> > > timer.txt
> > > +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-
> > > timer.txt
> > > @@ -25,6 +25,7 @@ Required properties:
> > >  	For those SoCs that use SYST
> > >  	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
> > >  	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
> > > +	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
> > 
> > Where is the driver change implementing this?
> 
> Or is there a generic fallback and you just added a specific one (not
> visible on the diff)?
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Yes, MT8188 uses "mediatek,mt6765-timer" as fallback compatible.

BRs,
Johnson Wang

