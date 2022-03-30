Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59F54EB9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiC3FOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbiC3FOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:14:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368889BAED;
        Tue, 29 Mar 2022 22:12:11 -0700 (PDT)
X-UUID: 7195f69139614ad9b38bddfa96b19033-20220330
X-UUID: 7195f69139614ad9b38bddfa96b19033-20220330
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1647154087; Wed, 30 Mar 2022 13:11:40 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 30 Mar 2022 13:11:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Mar
 2022 13:11:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Mar 2022 13:11:38 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <granquet@baylibre.com>
CC:     <airlied@linux.ie>, <angelogioacchino.delregno@collabora.com>,
        <chunfeng.yun@mediatek.com>, <chunkuang.hu@kernel.org>,
        <ck.hu@mediatek.com>, <daniel@ffwll.ch>, <deller@gmx.de>,
        <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <jitao.shi@mediatek.com>, <kishon@ti.com>, <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        <maarten.lankhorst@linux.intel.com>, <markyacoub@google.com>,
        <matthias.bgg@gmail.com>, <mripard@kernel.org>, <msp@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <robh@kernel.org>,
        <tzimmermann@suse.de>, <vkoul@kernel.org>
Subject: Re: [PATCH v9 01/22] dt-bindings: mediatek,dpi: Add DP_INTF compatible
Date:   Wed, 30 Mar 2022 13:11:38 +0800
Message-ID: <20220330051138.19264-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220327223927.20848-2-granquet@baylibre.com>
References: <20220327223927.20848-2-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

>DP_INTF is similar to DPI but does not have the exact same feature set
>or register layouts.
>
>DP_INTF is the sink of the display pipeline that is connected to the
>DisplayPort controller and encoder unit. It takes the same clocks as
>DPI.
>
>Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>Reviewed-by: Rob Herring <robh@kernel.org>
>---
> .../bindings/display/mediatek/mediatek,dpi.yaml       | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>index dd2896a40ff0..2dba80ad3b18 100644
>--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>@@ -4,16 +4,16 @@
> $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
> $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
>-title: mediatek DPI Controller Device Tree Bindings
>+title: mediatek DPI/DP_INTF Controller
         ^^^^^^^^
Would you mind changing this 'mediatek' to 'MediaTek'?

> 
> maintainers:
>   - CK Hu <ck.hu@mediatek.com>
>   - Jitao shi <jitao.shi@mediatek.com>
> 
> description: |
>-  The Mediatek DPI function block is a sink of the display subsystem and
>

s/Mediatek/MediaTek/

Could you replace all 'Mediatek' with 'MediaTek' of this series, please?
We have set up a chcker inside our organization to capture this case,
hopefully we will see less 'Mediatek' in the future.

>-  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parallel
>-  output bus.
>+  The Mediatek DPI and DP_INTF function blocks are a sink of the display

s/Mediatek/MediaTek/

thanks,
Miles

>+  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a
>+  parallel output bus.
> 
> properties:
>   compatible:
>@@ -23,6 +23,7 @@ properties:
>       - mediatek,mt8173-dpi
>       - mediatek,mt8183-dpi
>       - mediatek,mt8192-dpi
>+      - mediatek,mt8195-dpintf
> 
>   reg:
>     maxItems: 1
>@@ -54,7 +55,7 @@ properties:
>     $ref: /schemas/graph.yaml#/properties/port
>     description:
>       Output port node. This port should be connected to the input port of an
>-      attached HDMI or LVDS encoder chip.
>+      attached HDMI, LVDS or DisplayPort encoder chip.
> 
> required:
>   - compatible
>-- 
>2.34.1
>
>
