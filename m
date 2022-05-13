Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B135265A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381740AbiEMPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381706AbiEMPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:06:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708DA2E095;
        Fri, 13 May 2022 08:06:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 644E11F461FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652454400;
        bh=67EnZKy5K5mDCLThDhmr9nLxfLMQyeNafBIln7pk/sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9XxoQiP4LWE/ZR+dGAf0IplgjAdDcsT97XBoakzOryHvYx+fdFJ16H0jtUQfqk+T
         AjpiAlzS1csQZKT++F+ffrLCiVsk/veP/inAwIox2p0kKwZqkRY1HpDguYk2xmIqyb
         cLZi7A6Ke2oRq/yYShrehuJveuy3a4Je7zJmJxPvko7X8hKBgSqjb4qSRVMWO3F+Sj
         G9wOG9AZn3aRweBddmLeSWx2AW404I0Fi5SyWc1W2E2qoSzw1zZouNlc5MIJXnCQvY
         a4lADtFKw4eC+nFgBCtDh9rq4dnfJ8sCy+D9oaZGUMoppYfLDA/UDNkXvJB3WZNrXN
         TsDwCcuEAgyrg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/2] dt-bindings: memory: mtk-smi: Add MT6795 Helio X10 bindings
Date:   Fri, 13 May 2022 17:06:32 +0200
Message-Id: <20220513150633.387200-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
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

Add SMI bindings for the MediaTek Helio X10 (MT6795) SoC

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/memory-controllers/mediatek,smi-common.yaml         | 1 +
 .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index a98b359bf909..71bc5cefb49c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -32,6 +32,7 @@ properties:
           - mediatek,mt2701-smi-common
           - mediatek,mt2712-smi-common
           - mediatek,mt6779-smi-common
+          - mediatek,mt6795-smi-common
           - mediatek,mt8167-smi-common
           - mediatek,mt8173-smi-common
           - mediatek,mt8183-smi-common
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index c886681f62a7..59dcd163668f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -20,6 +20,7 @@ properties:
           - mediatek,mt2701-smi-larb
           - mediatek,mt2712-smi-larb
           - mediatek,mt6779-smi-larb
+          - mediatek,mt6795-smi-larb
           - mediatek,mt8167-smi-larb
           - mediatek,mt8173-smi-larb
           - mediatek,mt8183-smi-larb
-- 
2.35.1

