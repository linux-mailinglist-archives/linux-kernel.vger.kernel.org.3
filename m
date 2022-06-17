Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145454F0A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380129AbiFQFid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380111AbiFQFi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:38:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42863BF8;
        Thu, 16 Jun 2022 22:38:27 -0700 (PDT)
X-UUID: 9c60530ada6a41a0adfc0f9e9ae758f0-20220617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:3d496b69-7c90-45ff-8a99-3c0b8a399582,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:fb68db48-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9c60530ada6a41a0adfc0f9e9ae758f0-20220617
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 621481764; Fri, 17 Jun 2022 13:38:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 17 Jun 2022 13:38:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 17 Jun 2022 13:38:21 +0800
Message-ID: <df498cc98c02a580a50ff7aa5b06cb74f502e1e4.camel@mediatek.com>
Subject: Re: [PATCH 2/7] dt-bindings: display: mediatek: dpi: add binding
 for MT8365
From:   CK Hu <ck.hu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>, <matthias.bgg@gmail.com>,
        <jitao.shi@mediatek.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 17 Jun 2022 13:38:21 +0800
In-Reply-To: <20220530201436.902505-2-fparent@baylibre.com>
References: <20220530201436.902505-1-fparent@baylibre.com>
         <20220530201436.902505-2-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

On Mon, 2022-05-30 at 22:14 +0200, Fabien Parent wrote:
> DPI for MT8365 is compatible with MT8192 but requires an additional
> clock. Modify the documentation to requires this clock only on MT8365
> SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../display/mediatek/mediatek,dpi.yaml        | 44 ++++++++++++++++-
> --
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> index caf4c88708f4..c9c9f4d5ebe7 100644
> ---
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> +++
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> @@ -17,13 +17,18 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt2701-dpi
> -      - mediatek,mt7623-dpi
> -      - mediatek,mt8173-dpi
> -      - mediatek,mt8183-dpi
> -      - mediatek,mt8186-dpi
> -      - mediatek,mt8192-dpi
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-dpi
> +          - mediatek,mt7623-dpi
> +          - mediatek,mt8173-dpi
> +          - mediatek,mt8183-dpi
> +          - mediatek,mt8186-dpi
> +          - mediatek,mt8192-dpi
> +      - items:
> +          - enum:
> +              - mediatek,mt8365-dpi
> +          - const: mediatek,mt8192-dpi
>  
>    reg:
>      maxItems: 1
> @@ -32,16 +37,20 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 3
>      items:
>        - description: Pixel Clock
>        - description: Engine Clock
>        - description: DPI PLL
> +      - description: DPI Clock

Why MT8365 has this additional clock? What is the new hardware block
(compared with other SoC) need this clock? Why this is different than
other SoC?

Is this case the same as [1]? If so, I think you should not add this
clock.

[1] 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220613064841.10481-2-rex-bc.chen@mediatek.com/

Regards,
CK

>  
>    clock-names:
> +    minItems: 3
>      items:
>        - const: pixel
>        - const: engine
>        - const: pll
> +      - const: dpi
>  
>    pinctrl-0: true
>    pinctrl-1: true
> @@ -71,6 +80,27 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8365-dpi
> +
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          maxItems: 4
> +
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          maxItems: 3
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>

