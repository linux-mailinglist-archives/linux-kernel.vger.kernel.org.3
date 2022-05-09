Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6064351F9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiEIKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiEIKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:25:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B506201EA8;
        Mon,  9 May 2022 03:21:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C5C011F4376E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652091669;
        bh=olbInTBcsJ7OBs0Az64gQWO87DN9MjbVGnMzsKIcrgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lvi3SIcfXeRf4XU7UFmELdSoDYNvwzyS+GodMXAeztXY501u1tqhVvhHK5ok97XaR
         NJTLdS9FxXSHmbeoOkHfxfGyRROOOLGktuQYN6qL4XGPYFVyW4mNkDEvpfAfAN5hDE
         YsQ8jVB+BdjEQphUehmPmxRibikOUzaBKYAWOtYulS1KGWQdQCh5uTRIcXFcm8k2AQ
         SUEa5i1SzrSJWrJ8sx6nmcaa8bHcl9y2+oLResDfgece6cPW9nFdo17gtwFD8ehmzU
         hwJgL3Wld7ukzwGviCsC9GcU4uIkX6RQmUFx7okjDOy8Yp6QqxXCBOZDegZ9mppqxQ
         3s/kCoV9quA6w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795 compatible
Date:   Mon,  9 May 2022 12:20:57 +0200
Message-Id: <20220509102058.3064215-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509102058.3064215-1-angelogioacchino.delregno@collabora.com>
References: <20220509102058.3064215-1-angelogioacchino.delregno@collabora.com>
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

Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
System Timer on MediaTek platforms and add the MT6795 compatible for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index fbd76a8e023b..2d139d24e535 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -2,6 +2,7 @@ MediaTek Timers
 ---------------
 
 MediaTek SoCs have two different timers on different platforms,
+- CPUX (ARM/ARM64 System Timer)
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -28,6 +29,9 @@ Required properties:
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
 	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
 
+	For those SoCs that use CPUX
+	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
2.35.1

