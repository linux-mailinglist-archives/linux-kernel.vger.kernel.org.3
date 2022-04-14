Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD850057E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 07:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiDNFfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 01:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiDNFe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 01:34:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5D53728;
        Wed, 13 Apr 2022 22:32:25 -0700 (PDT)
X-UUID: 348bd1053b1e43c4af8881e4ebd77f47-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fee4f7ff-be03-423f-90a4-e42cf19ff383,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:bd235778-0afa-4dca-bdec-ca54c998425a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 348bd1053b1e43c4af8881e4ebd77f47-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2092133149; Thu, 14 Apr 2022 13:32:20 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 14 Apr 2022 13:32:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Apr
 2022 13:32:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 13:32:18 +0800
Message-ID: <0be3f1af884ba219d3f42286e0307d68406d90e5.camel@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mt8186 svs
 dt-bindings
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Thu, 14 Apr 2022 13:32:18 +0800
In-Reply-To: <215584ce-da8f-d4a1-a557-4cd2abc35e49@linaro.org>
References: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
         <20220412112127.21570-2-jia-wei.chang@mediatek.com>
         <215584ce-da8f-d4a1-a557-4cd2abc35e49@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 14:08 +0200, Krzysztof Kozlowski wrote:
> On 12/04/2022 13:21, Tim Chang wrote:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > Add mt8186 svs compatible in dt-bindings.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-
> > svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-
> > svs.yaml
> > index eecfec13ee8b..122ffabb2be4 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> > @@ -10,6 +10,7 @@ maintainers:
> >    - Roger Lu <roger.lu@mediatek.com>
> >    - Matthias Brugger <matthias.bgg@gmail.com>
> >    - Kevin Hilman <khilman@kernel.org>
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> It's perfectly fine with me, but it's not mentioned in the commit msg
> and some acks from other folks might be useful.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

I missed the commit msg to mention adding myself to svs maintainer
list.
I will update it and ask Roger Lu for his ack in the next version.

Thanks.

