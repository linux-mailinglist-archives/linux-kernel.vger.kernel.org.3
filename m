Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B97574E41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiGNMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiGNMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6F474C7;
        Thu, 14 Jul 2022 05:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 141BDB824F3;
        Thu, 14 Jul 2022 12:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AEFC341F6;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=knIBdM6fb5GT4CxHhjk3W96Yxu+TiJemn4fZ7BCYVMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTfP91U953wGZBm/eMMF8j1Mtu7pdAM9aeyqZY8G/Uo0WR06DE9SdosonMb+JwFbp
         4DqjGDXGzHLa9wERO9zTN6Zzsy3bRRW8ThwRm1ZoftVkX7lzUGeg2qsdQqWtrCDhzx
         fYg4F7cEs7G9z+bfG7kSOMa1R/ScKzSVcR3w8ebaKFRYKX3rrcOCfYUbQ/bhjULy5d
         STU4ahZtPoBo8GjS/RLqTEXcKGgzVqTdQLyJVmAIEXZ+dzNoDvv/1nCQRf02q/+KIW
         hzhWzhaisMFArEw33R79dV3ijwsKqAdlM2uUXo8e0f1/DyUp8gJ/Kz8kR2ualskfzw
         pkw5NEsXKAaWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCQ-0007Dn-4n; Thu, 14 Jul 2022 14:44:10 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 16/30] dt-bindings: phy: qcom,qmp-ufs: add missing SM8450 clock
Date:   Thu, 14 Jul 2022 14:43:19 +0200
Message-Id: <20220714124333.27643-17-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714124333.27643-1-johan+linaro@kernel.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing "qref" clock used by the SM8450 UFS QMP PHY to the
binding.

Note that the "qref" clock was added to sm8450.dtsi by commit
07fa917a335e ("arm64: dts: qcom: sm8450: add ufs nodes") but the binding
was never updated to match.

Fixes: e04121ba1b08 ("dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index e9dfed29e996..7a1f80e2cf23 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -42,11 +42,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   resets:
     maxItems: 1
@@ -117,6 +117,22 @@ allOf:
             - const: ref
             - const: ref_aux
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-qmp-ufs-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: ref
+            - const: ref_aux
+            - const: qref
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.35.1

