Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8245A743E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiHaDEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiHaDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:03:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64161B0B17;
        Tue, 30 Aug 2022 20:03:46 -0700 (PDT)
X-UUID: 1098c322613046dfa9cbe8e796440dd2-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PEdXpcWRw+A+QutbjbtjgcTym0ecB1EdaaG/G32Mcxo=;
        b=TH3sLwgr5c0CDrxgk3cXvX1HgaEUoB3T6eC5cq41TkDKvg+lmFvRodZ4JW/tkQdgUAvvZOuz2EqQrAY8UUgYd03LxUQPvVM6v21BIapLtpa7C42kmThRXzRNgYT3rBBkv79ttXF1sML0Zvhw66b6lNEyEQc1gQ/OL/YzoqVBo9I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:e780a1e9-85dc-4e71-929a-e2363f31ca26,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:d95d20d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1098c322613046dfa9cbe8e796440dd2-20220831
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 774427402; Wed, 31 Aug 2022 11:03:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 11:03:41 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 31 Aug 2022 11:03:40 +0800
Message-ID: <b77553ac2c9c934abcf3b5e5b5083ad695584c42.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] dt-binding: serial: mediatek,uart: update
 bingding for MT8188
From:   Kewei Xu <kewei.xu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <caiyu.chen@mediatek.com>, <david-yh.chiu@mediatek.com>
Date:   Wed, 31 Aug 2022 11:03:37 +0800
In-Reply-To: <f8a391de-dd47-1eb9-0e15-e6a651517a6f@gmail.com>
References: <20220809084457.31381-1-kewei.xu@mediatek.com>
         <f8a391de-dd47-1eb9-0e15-e6a651517a6f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-24 at 15:59 +0200, Matthias Brugger wrote:
> 
> On 09/08/2022 10:44, kewei.xu@mediatek.com wrote:
> > From: Kewei Xu <kewei.xu@mediatek.com>
> > 
> > Add a DT binding documentation for the MT8188 soc.
> > 
> > Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> > ---
> > v2: Resumbit the patch based on the linux-next branch.
> > ---
> >   Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > index 4ff27d6d4d5b..fe098d98af6e 100644
> > --- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
> > @@ -42,6 +42,7 @@ properties:
> >                 - mediatek,mt8173-uart
> >                 - mediatek,mt8183-uart
> >                 - mediatek,mt8186-uart
> > +              - mediatek,mt8188-uart
> >                 - mediatek,mt8192-uart
> >                 - mediatek,mt8195-uart
> >                 - mediatek,mt8516-uart

Hi gregkh,

Just a gentle ping on this.
Could you please give me some suggestion on this patch?

Thank you very much~

BRs,
Kewei Xu


