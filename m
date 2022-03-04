Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E54CD1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiCDJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiCDJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:55:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBF3B034;
        Fri,  4 Mar 2022 01:55:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3924D1F46486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646387706;
        bh=e4C8wnAcuL8k5FwceR/IW4yZe9+rSJuGVPXQwJtpD1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUR/YCFlNX2e6vMy8tlrinUWThnwSawU1hOBQWS4mR9lrCsnEdKiPotxuyZSznHoW
         CuxSxQ+db6rQ/SknV8SZF4B3iV0XwDiQ7VKqxVuimOTDAJJRV5uJqj7oJHy/typqbs
         qpx0Sm0URGHzD99/nutjEt2AYZ+C+5/7Fx2C+EHp5+2Tbvo6kGuF3qeLb0rOhmHpe2
         VC1LRjx5/4DaxeSzPCai0uD5191p6KeXqNX7SEkK9ilbpTBR93J2YtkmYUVWUdHFWi
         mNNw6yzpAgEawpwBqgjcOp6pwzn+NgIfg3vjuZ7S+mec55/ePOaFn6I9Jh5C6wNXX3
         bCMDOHNO63iMw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        jason-jh.lin@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/3] dt-bindings: display: mediatek,ovl: Fix 'iommu' required property typo
Date:   Fri,  4 Mar 2022 10:54:57 +0100
Message-Id: <20220304095458.12409-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property is called 'iommus' and not 'iommu'. Fix this typo.

Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 93d5c68a2dbd..fc691d00c60e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -75,7 +75,7 @@ required:
   - interrupts
   - power-domains
   - clocks
-  - iommu
+  - iommus
 
 additionalProperties: false
 
-- 
2.35.1

