Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A46566708
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiGEJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiGEJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A35FD3E;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2053C618F2;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACDEC341D3;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=CSIhE4qibW7M+quZjw+ixus1xzmNavFM5ZRwlurXMxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1onH2qP5smWWkwJgCwbPePhxlqCGk4pSAfyUaeN+ivRccr2Vav3nNif7ydVjnLxG
         98rlmhO8Czl+x6/VjxGPVFYHee6/uluFT2bmiipPGxeCRWQevwQP8aKoueti53gIdb
         XFtja7QomX+53oVDA4qUQCqJdBccdhfMmsesMInut5r+CSliIdzCdhnWL79xWf8bfS
         gF+bHeBz755XRHxJwjGJz4BzLSa9xCZps2DwjEqjNRL3X13fouqT1sTuL39kN96/N1
         L5j+o2SELLkibYBjDM/aZTmNSkwKrPbu29Ys3kz9H3R335z6y+DSsCAyfyEXXYjc5L
         Ira7Op8PPT5sg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YB-0K; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 28/43] dt-bindings: phy: qcom,qmp-ufs: add example node
Date:   Tue,  5 Jul 2022 11:42:24 +0200
Message-Id: <20220705094239.17174-29-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
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

Add an example node based on a cleaned up version of sc8280xp.dtsi.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index 9124b60eb9a7..24272cdde9a1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -217,3 +217,33 @@ allOf:
             properties:
               reg:
                 minItems: 4
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    phy-wrapper@1d87000 {
+        compatible = "qcom,sc8280xp-qmp-ufs-phy";
+        reg = <0x01d87000 0xe10>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x01d87000 0x1000>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+        clock-names = "ref", "ref_aux";
+
+        resets = <&ufs_mem_hc 0>;
+        reset-names = "ufsphy";
+
+        vdda-phy-supply = <&vreg_l6b>;
+        vdda-pll-supply = <&vreg_l3b>;
+
+        phy@400 {
+            reg = <0x400 0x108>,
+                  <0x600 0x1e0>,
+                  <0xc00 0x1dc>,
+                  <0x800 0x108>,
+                  <0xa00 0x1e0>;
+            #phy-cells = <0>;
+        };
+    };
-- 
2.35.1

