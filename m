Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD35162B4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbiEAIaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiEAIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:30:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658447AE8;
        Sun,  1 May 2022 01:26:32 -0700 (PDT)
X-UUID: a83b454ccbf141ffa42a9d87bf204e54-20220501
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b70f64c9-9c98-4667-af2f-5d6cf96ea4e5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:1ae418c7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a83b454ccbf141ffa42a9d87bf204e54-20220501
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1546646647; Sun, 01 May 2022 16:26:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 1 May 2022 16:26:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 1 May 2022 16:26:24 +0800
Message-ID: <cf3062c9ebc69642bdc16ce32ed3260486969b04.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: refine power and
 gce properties
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Fabien Parent <fparent@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Cellopoint <cellopoint.kai@gmail.com>
Date:   Sun, 1 May 2022 16:26:24 +0800
In-Reply-To: <c9239316-40af-724b-cace-7da5bf7e8e21@linaro.org>
References: <20220429083051.11260-1-jason-jh.lin@mediatek.com>
         <c9239316-40af-724b-cace-7da5bf7e8e21@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=0.8 required=5.0 tests=APP_DEVELOPMENT_NORDNS,
        BAYES_00,RDNS_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the reviews.

On Fri, 2022-04-29 at 22:58 +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 10:30, Jason-JH.Lin wrote:
> > Power:
> >   Refine description and add item number for power-domains
> > property.
> > 
> > GCE:
> >   Refine description and add item number for mboxes property and
> >   mediatek,gce-client-reg property.
> > 
> > Fixes: 1da90b8a7bae ("dt-bindings: arm: mediatek: mmsys: add power
> > and gce properties")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[snip]
 
> >    mboxes:
> > +    minItems: 1
> > +    maxItems: 24
> 
> Wait, no, I wrote it should be 16 for one device and 24 for other,
> not
> 24 for all...
> 

Ok, I thought maxItems: 24 contained 16, but it's not clear enough.


I'm not sure how to describe different maxItems for different
platforms. Does it come like this?

1. Remove the maxItems in mboxes property.
2. Add the allOf condition before the line "additionalProperties:
false". E.g.

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: mediatek,mt8173-mmsys
    then:
      properties:
        mboxes:
          maxItems: 16
    else:
      properties:
        mboxes:
          maxItems: 24

additionalProperties: false
...


Regards,
Jason-JH.Lin

> Best regards,
> Krzysztof
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

