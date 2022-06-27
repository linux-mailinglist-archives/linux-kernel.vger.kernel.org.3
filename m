Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAE55C5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiF0H4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiF0H4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:56:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4D60E7;
        Mon, 27 Jun 2022 00:56:02 -0700 (PDT)
X-UUID: 2cdac14ec1bf4d66a921af120172e58a-20220627
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:0ee28835-190a-42a8-9798-4488fbbea4ea,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:a8f698ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 2cdac14ec1bf4d66a921af120172e58a-20220627
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 438266948; Mon, 27 Jun 2022 15:55:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 27 Jun 2022 15:55:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 27 Jun 2022 15:55:57 +0800
Message-ID: <a6163af1980ca55085163e8106d2c49294ecdddf.camel@mediatek.com>
Subject: Re: [PATCH v14 02/15] dt-bindings: mediatek,dpi: Revise mediatek
 strings to correct format
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 27 Jun 2022 15:55:57 +0800
In-Reply-To: <20220624030946.14961-3-rex-bc.chen@mediatek.com>
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
         <20220624030946.14961-3-rex-bc.chen@mediatek.com>
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

Hi, Bo-Chen:

On Fri, 2022-06-24 at 11:09 +0800, Bo-Chen Chen wrote:
> Strings replacement:
> - s/mediatek/MediaTek/ in title.
> - s/Mediatek/MediaTek/ in description.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml    | 4
> ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> index 8e526a4b134e..5bb23e97cf33 100644
> ---
> a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> +++
> b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> l
> @@ -4,14 +4,14 @@
>  $id: 
> http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: mediatek DPI and DP_INTF Controller
> +title: MediaTek DPI and DP_INTF Controller
>  
>  maintainers:
>    - CK Hu <ck.hu@mediatek.com>
>    - Jitao shi <jitao.shi@mediatek.com>
>  
>  description: |
> -  The Mediatek DPI and DP_INTF function blocks are a sink of the
> display
> +  The MediaTek DPI and DP_INTF function blocks are a sink of the
> display
>    subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422
> pixel data on a
>    parallel output bus.
>  

