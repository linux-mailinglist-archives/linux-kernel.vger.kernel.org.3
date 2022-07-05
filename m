Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33E5666E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiGEJtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DFFD3E;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB59761927;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D617CC5831C;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=j0qtr/Xaydd2eOG004qp/hks1Cdng+e5jtPGk71O+6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSsVyuXPio1/0k4red7oBCNyopZN4Vojhb+GGJ0puPV3snUDKbnndLDX0nePqqPod
         TU12HS+2tCVpDVS9utJWbyaGIvWW8WkmGlLhjzGqTPa7qqagh6SLOdrKEBZ1u+blZe
         7kmgJR2lLIB6fjBqqJCKGZ2+++84697W214yopz6s+pf/2PbffCvsFUTLem2uhFsVG
         7AtEm8yWgb3ws1VZ2u9uQtImbHpbjCWsreTRB4GelTQkaaXQzZ6di7qHihr3rFWW/e
         ICJUfK/9t5l90GkL8GpeSXlSBM5NwngGsxI+2vyHXOSOqC9GOWi270axCy6ynJDlVw
         S6pywKDp4P5Mw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Y8-U6; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 27/43] dt-bindings: phy: qcom,qmp-ufs: add missing child node schema
Date:   Tue,  5 Jul 2022 11:42:23 +0200
Message-Id: <20220705094239.17174-28-johan+linaro@kernel.org>
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

Add the missing the description of the PHY-provider child node which was
ignored when converting to DT schema.

Also fix up the incorrect description that claimed that one child node
per lane was required.

Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 72 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index f1e3d70eb73d..9124b60eb9a7 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -75,9 +75,20 @@ properties:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-    description:
-      Each device node of QMP PHY is required to have as many child nodes as
-      the number of lanes the PHY has.
+    description: Single PHY-provider child node.
+    properties:
+      reg:
+        minItems: 3
+        maxItems: 6
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - "#phy-cells"
+
+    additionalProperties: false
 
 required:
   - compatible
@@ -151,3 +162,58 @@ allOf:
             - const: ref
             - const: ref_aux
             - const: qref
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc8280xp-qmp-ufs-phy
+              - qcom,sdm845-qmp-ufs-phy
+              - qcom,sm6350-qmp-ufs-phy
+              - qcom,sm8150-qmp-ufs-phy
+              - qcom,sm8250-qmp-ufs-phy
+              - qcom,sm8350-qmp-ufs-phy
+              - qcom,sm8450-qmp-ufs-phy
+    then:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              items:
+                - description: TX lane 1
+                - description: RX lane 1
+                - description: PCS
+                - description: TX lane 2
+                - description: RX lane 2
+    else:
+      patternProperties:
+        "^phy@[0-9a-f]+$":
+          properties:
+            reg:
+              minItems: 3
+              maxItems: 4
+              items:
+                - description: TX
+                - description: RX
+                - description: PCS
+                - description: PCS_MISC
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,msm8996-qmp-ufs-phy
+      then:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                maxItems: 3
+      else:
+        patternProperties:
+          "^phy@[0-9a-f]+$":
+            properties:
+              reg:
+                minItems: 4
-- 
2.35.1

