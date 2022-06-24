Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C3558D28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiFXCNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXCNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:13:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5CE50B15;
        Thu, 23 Jun 2022 19:13:39 -0700 (PDT)
X-UUID: 34b04833fb34470db8bcbd642ac9da1b-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c9ce167b-c3af-4a21-b541-de503d456e63,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:66b2e82d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 34b04833fb34470db8bcbd642ac9da1b-20220624
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1807525243; Fri, 24 Jun 2022 10:13:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 10:13:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 24 Jun 2022 10:13:32 +0800
Message-ID: <e34b886c276805f4778d8eb5cd2fe7314efc08f9.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: mtk-sd: Set clocks based on
 compatible
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>
Date:   Fri, 24 Jun 2022 10:13:31 +0800
In-Reply-To: <20220623154038.771874-1-nfraprado@collabora.com>
References: <20220623154038.771874-1-nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-23 at 11:40 -0400, Nícolas F. R. A. Prado wrote:
> The binding was describing a single clock list for all platforms, but
> that's not really suitable: mt2712 requires an extra 'bus_clk' on
> some
> of its controllers, while mt8192 requires four different extra
> clocks.
> The rest of the platforms can share the same 3 clocks, with the third
> being optional as it's not present on all platforms.
> 
> Move the clock definitions inside if blocks that match on the
> compatibles. In practice this gets rid of dtbs_check warnings on
> mt8192,
> since the 'bus_clk' clock from mt2712 is no longer expected on this
> platform.
> 
> Fixes: 59a23395d8aa ("dt-bindings: mmc: Add support for MT8192 SoC")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: Wenbin Mei <wenbin.mei@mediatek.com>

> ---
> v1: 
> https://lore.kernel.org/all/20220617230114.2438875-1-nfraprado@collabora.com
> 
> Changes in v2:
> - Kept widest minItems/maxItems outside the if blocks
> 
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 111 +++++++++++++---
> --
>  1 file changed, 81 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..5e73218d2e6e 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -10,9 +10,6 @@ maintainers:
>    - Chaotian Jing <chaotian.jing@mediatek.com>
>    - Wenbin Mei <wenbin.mei@mediatek.com>
>  
> -allOf:
> -  - $ref: mmc-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -49,27 +46,11 @@ properties:
>      description:
>        Should contain phandle for the clock feeding the MMC
> controller.
>      minItems: 2
> -    items:
> -      - description: source clock (required).
> -      - description: HCLK which used for host (required).
> -      - description: independent source clock gate (required for
> MT2712).
> -      - description: bus clock used for internal register access
> (required for MT2712 MSDC0/3).
> -      - description: msdc subsys clock gate (required for MT8192).
> -      - description: peripheral bus clock gate (required for
> MT8192).
> -      - description: AXI bus clock gate (required for MT8192).
> -      - description: AHB bus clock gate (required for MT8192).
> +    maxItems: 7
>  
>    clock-names:
>      minItems: 2
> -    items:
> -      - const: source
> -      - const: hclk
> -      - const: source_cg
> -      - const: bus_clk
> -      - const: sys_cg
> -      - const: pclk_cg
> -      - const: axi_cg
> -      - const: ahb_cg
> +    maxItems: 7
>  
>    interrupts:
>      maxItems: 1
> @@ -171,15 +152,85 @@ required:
>    - vmmc-supply
>    - vqmmc-supply
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: mediatek,mt8183-mmc
> -then:
> -  properties:
> -    reg:
> -      minItems: 2
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mmc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8192-mmc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: msdc subsys clock gate
> +            - description: peripheral bus clock gate
> +            - description: AXI bus clock gate
> +            - description: AHB bus clock gate
> +        clock-names:
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
> +            - const: sys_cg
> +            - const: pclk_cg
> +            - const: axi_cg
> +            - const: ahb_cg
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt2712-mmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +            - description: bus clock used for internal register
> access (required for MSDC0/3).
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
> +            - const: bus_clk
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - mediatek,mt2712-mmc
> +                - mediatek,mt8192-mmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: independent source clock gate
> +        clock-names:
> +          minItems: 2
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: source_cg
>  
>  unevaluatedProperties: false
>  

