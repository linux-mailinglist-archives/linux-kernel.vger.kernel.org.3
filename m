Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B14F5AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiDFJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiDFJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:46:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D3334123;
        Tue,  5 Apr 2022 20:29:12 -0700 (PDT)
X-UUID: 5086c79da67943cfa6bcfb5a68627ddb-20220406
X-UUID: 5086c79da67943cfa6bcfb5a68627ddb-20220406
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 456243619; Wed, 06 Apr 2022 11:29:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 11:29:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 11:29:04 +0800
Message-ID: <751374a287a70831c09da51daef1ee286285359b.camel@mediatek.com>
Subject: Re: [PATCH v10 2/4] dt-bindings: display: mediatek: change to use
 enum for mutex
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <airlied@linux.ie>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <yongqiang.niu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fparent@baylibre.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 6 Apr 2022 11:29:04 +0800
In-Reply-To: <20220406030009.2357-3-rex-bc.chen@mediatek.com>
References: <20220406030009.2357-1-rex-bc.chen@mediatek.com>
         <20220406030009.2357-3-rex-bc.chen@mediatek.com>
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

Hi, Rex:

On Wed, 2022-04-06 at 11:00 +0800, Rex-BC Chen wrote:
> All single entry cases in mutex can be merged as a single enum.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,mutex.yaml      | 24 +++++++--------
> ----
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y
> aml
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y
> aml
> index 00e6a1041a9b..b470fbb1b40a 100644
> ---
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y
> aml
> +++
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y
> aml
> @@ -23,21 +23,15 @@ description: |
>  
>  properties:
>    compatible:
> -    oneOf:
> -      - items:
> -          - const: mediatek,mt2701-disp-mutex
> -      - items:
> -          - const: mediatek,mt2712-disp-mutex
> -      - items:
> -          - const: mediatek,mt8167-disp-mutex
> -      - items:
> -          - const: mediatek,mt8173-disp-mutex
> -      - items:
> -          - const: mediatek,mt8183-disp-mutex
> -      - items:
> -          - const: mediatek,mt8192-disp-mutex
> -      - items:
> -          - const: mediatek,mt8195-disp-mutex
> +    enum:
> +      - mediatek,mt2701-disp-mutex
> +      - mediatek,mt2712-disp-mutex
> +      - mediatek,mt8167-disp-mutex
> +      - mediatek,mt8173-disp-mutex
> +      - mediatek,mt8183-disp-mutex
> +      - mediatek,mt8192-disp-mutex
> +      - mediatek,mt8195-disp-mutex
> +
>    reg:
>      maxItems: 1
>  

