Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98D51495F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359210AbiD2MfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359153AbiD2MfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AB2B9F26;
        Fri, 29 Apr 2022 05:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298D1621D0;
        Fri, 29 Apr 2022 12:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDAC385B2;
        Fri, 29 Apr 2022 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651235505;
        bh=U1fnlH5OyGJ5UIzfEScyxiBRXPgHxk+UHE3ZSX1gPvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISPMvNcSQFkMZIWSHYxdg5JmBcRxJsqOeGCndtVUOHzFSep/BT5TXtbexxYIN9Zzv
         +D9a9cf63EfihTrNLiCSYnSITsZ858oBCjHM9OAyLTHtFm/haWeZ6ioTJtFEM4508X
         W4q4abspHfamRw89c8Qu/vBggzpAMPr5smLkEFCN3X2QRJXSA8oQRWQzbjenxJVFU4
         vVvWes7+RoHQf0M2d4ygN8Fj6V6mJAIK2a401iKT6MLqVWYU6t/sX2ZbKs9zsTqPq2
         9k3JTkOU1u4t9YWJ/E3OWsvCRpUR6bsW1GSxvr48e115hufTW00WQFhXx6qalzVU6F
         IOrrneGjSjqHA==
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
Subject: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of MT8192 clock
Date:   Fri, 29 Apr 2022 14:31:31 +0200
Message-Id: <20220429123133.28869-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429123133.28869-1-matthias.bgg@kernel.org>
References: <20220429123133.28869-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The msdc gate is part of the MMC driver. Delete the binding description
of this node.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

Changes in v2:
- Delete compatible in binding descprition as well

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
2.34.1

