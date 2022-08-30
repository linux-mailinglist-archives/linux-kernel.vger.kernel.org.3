Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9185A5EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiH3JL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiH3JL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145598364;
        Tue, 30 Aug 2022 02:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F917615B8;
        Tue, 30 Aug 2022 09:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C1BC433D6;
        Tue, 30 Aug 2022 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661850683;
        bh=6mH6KAOzeUMtuElAC5LgYu+P+CwsGf8BlEkNtVomIv0=;
        h=From:To:Cc:Subject:Date:From;
        b=mtTDSFldT9ZlYtL11lxVm1EUf04IxYhU3aEwp5ywLJX417Pcw1VEXZhViY/lYnGC3
         wAL7UaOmu2PQ6u09KsQM0p9usAiG51KluFsfDG3EtZXsikuCjd0O9p1QD4fWhYVaIB
         bIHSbsPPMYvlQ5ath/M56s3ZWWfv0TRAdqMmxY3Qx/6wAe5iZ2WMxRtAX5fDYVglhy
         bVFQ5p643QbWT5MNf6zhzYaFZpim/f7R+9ZyBrxDnjyjREPfjeWhpmIf/SmkJ8ceoN
         hTL86eEuv6OvTFL1wWuLjNwg7RxJRjzUKWVkvgVGIXKaNJC7UOzDjRYiVghXKc6tcY
         g1ozAAkxFebKg==
From:   matthias.bgg@kernel.org
To:     matthias.bgg@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Date:   Tue, 30 Aug 2022 11:11:10 +0200
Message-Id: <20220830091110.27857-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The file describes the scpsys node for all SoCs and not only the mt8195.
Rename it to reflect this fact.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Fix id

 .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (96%)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
rename to Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
index 3737207d8504..1a5901ca90f5 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
+$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek System Control Processor System
-- 
2.37.2

