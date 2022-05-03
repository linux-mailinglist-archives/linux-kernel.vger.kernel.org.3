Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD3518651
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiECOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiECOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:18:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9C1D31D;
        Tue,  3 May 2022 07:14:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 212C21F434F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651587286;
        bh=B/lWFQk3lVUU0hXgygkG1qi0I0fP+5nA3QdY/qxIP3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1HVBvgJXydgovzNB6lsCOGgxwi2iNXDiVfrHuKH0JUlfN8J8kc+InrHrIjuNKjxu
         xRqSX4FSxpZ4Ew45Of5uwtEEebkUIgTw7VBvtlRxb0Hn545Sznaw9jMk5eUANhnmcX
         MAphBWp/B7EjUlNZU44UVBKQcyDP+SgwIAgTQHLYkvehncZ6oynA0hta2VdhOHE/fY
         EsyA+/9L6BwSTDJ9mg1JkifkAyO6KJJgOfLvtrLhyHRBeEjqXS1EaXLZMrj1UTdu7W
         CnlU67kUesL368u/mCuKcAIkYV+WBNRHsNRk2JJztAB+dBOmDl6uBJqRLA7nuEkKWa
         HRJDfbsZ20yVQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH v2 1/2] dt-bindings: power: Add MediaTek Helio X10 MT6795 power domains
Date:   Tue,  3 May 2022 16:14:40 +0200
Message-Id: <20220503141441.125852-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
References: <20220503141441.125852-1-angelogioacchino.delregno@collabora.com>
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
index 000000000000..b0fc26cb1da4
--- /dev/null
+++ b/include/dt-bindings/power/mt6795-power.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
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

