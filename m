Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DB5182B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiECK6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiECK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:58:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4993879A;
        Tue,  3 May 2022 03:54:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 93C6F1F43E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575283;
        bh=QL7sXkZwTx0DxEfhh1OMvj81EaDnQLFFNnnmk9jh5s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRe4gvCF/yTxtL4FUeAcdBLhgY0bxHFnGH0k0ohBAZeY1QdNvyNx8vzJTxEDB57+7
         hHv1B8gqGxjI/X+HEKemL4yHsiqFHFuabvVZIOMqUV0IEA18VRxPyF1QD+g69Hkw//
         KFuTFsqp6Vy7UP51tmM5YrkdCyZd46hH1aEHCEykW/46ceTH7vl9fytTj+SWuRYGhp
         rK/MYHXKPAevNOSJvheaRU2UlzbjQ5OSO2VaItb8RD6brVvpLSIc7BdQ+7+/bWi36L
         T5zPRqX6Ce8KFuqKiFm951XDR89liFAzDBXwIvONEq/8Irrj1pUvy24UsoCE57orIQ
         d5v/nHGrJa0dA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795 power domains
Date:   Tue,  3 May 2022 12:54:35 +0200
Message-Id: <20220503105436.54901-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
References: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
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

Add power domains dt-bindings for MediaTek Helio X10 (MT6795).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml         |  2 ++
 include/dt-bindings/power/mt6795-power.h         | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/power/mt6795-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 135c6f722091..b448101fac43 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -23,6 +23,7 @@ properties:
 
   compatible:
     enum:
+      - mediatek,mt6795-power-controller
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
@@ -62,6 +63,7 @@ patternProperties:
       reg:
         description: |
           Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt6795-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8167-power.h" - for MT8167 type power domain.
               "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
               "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
diff --git a/include/dt-bindings/power/mt6795-power.h b/include/dt-bindings/power/mt6795-power.h
new file mode 100644
index 000000000000..0e27bc7fa748
--- /dev/null
+++ b/include/dt-bindings/power/mt6795-power.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DT_BINDINGS_POWER_MT6795_POWER_H
+#define _DT_BINDINGS_POWER_MT6795_POWER_H
+
+#define MT6795_POWER_DOMAIN_MM		0
+#define MT6795_POWER_DOMAIN_VDEC	1
+#define MT6795_POWER_DOMAIN_VENC	2
+#define MT6795_POWER_DOMAIN_ISP		3
+#define MT6795_POWER_DOMAIN_MJC		4
+#define MT6795_POWER_DOMAIN_AUDIO	5
+#define MT6795_POWER_DOMAIN_MFG_ASYNC	6
+#define MT6795_POWER_DOMAIN_MFG_2D	7
+#define MT6795_POWER_DOMAIN_MFG		8
+#define MT6795_POWER_DOMAIN_MODEM	9
+
+#endif /* _DT_BINDINGS_POWER_MT6795_POWER_H */
-- 
2.35.1

