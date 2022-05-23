Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1954530E23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiEWKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiEWKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:23:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE941F9A;
        Mon, 23 May 2022 03:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D9B8611E4;
        Mon, 23 May 2022 10:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600D8C34119;
        Mon, 23 May 2022 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653301430;
        bh=vUsnPjeIxXkyjg70eNAh8JZuEF/mFk5yfd2/sAihNms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfbsIsSyH3KzxP0Soh/5qiLLMFKa8ZgGOC5rI8NsETXsLEdTXaL5SqgQh0kpdIPJe
         SytazElEMl6XNx95MZY/Df16kjPyY5XuKoAdzXx+RSOqrUxwOK6oGR367FFhdpe6so
         Pdk2VHogUSWRUJcf1zLycF7pwjfb97f4fT5bupP/v1WweXd8iYwvqVMqxdojhpbgz9
         PyukX45GlyPFwOnMJcjSJgTzeAOJ5eg8ACe0bYPJQ6G/pIniM3Xgn5GIziHsHYhGFb
         2/OMJjDpBz16fgWoHqyG0eFWYiLbXR7nzW5nrMxMbIxLeIaDAQaVCXfxdeJI1HdnoZ
         TdGZ9cM8bU7fQ==
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
Date:   Mon, 23 May 2022 12:23:38 +0200
Message-Id: <20220523102339.21927-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220523102339.21927-1-matthias.bgg@kernel.org>
References: <20220523102339.21927-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The code controlling msdc clock gate was moved inthe the consumer, the MMC
driver. This node did never represent a working implementation of any
peripheral. It was just a lonely clock gate that wasn't used. Delete the
binding description of this node.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>

---

Changes in v3:
- Update commit message to explain better why we do ABI breakage here

Changes in v2:
- Delete compatible in binding descprition as well
- Add RvB tags

 .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml      | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
index c8c67c033f8c..b57cc2e69efb 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
@@ -24,7 +24,6 @@ properties:
           - mediatek,mt8192-imp_iic_wrap_w
           - mediatek,mt8192-imp_iic_wrap_n
           - mediatek,mt8192-msdc_top
-          - mediatek,mt8192-msdc
           - mediatek,mt8192-mfgcfg
           - mediatek,mt8192-imgsys
           - mediatek,mt8192-imgsys2
@@ -107,13 +106,6 @@ examples:
         #clock-cells = <1>;
     };
 
-  - |
-    msdc: clock-controller@11f60000 {
-        compatible = "mediatek,mt8192-msdc";
-        reg = <0x11f60000 0x1000>;
-        #clock-cells = <1>;
-    };
-
   - |
     mfgcfg: clock-controller@13fbf000 {
         compatible = "mediatek,mt8192-mfgcfg";
-- 
2.36.0

