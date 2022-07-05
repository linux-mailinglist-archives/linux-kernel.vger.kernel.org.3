Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1165A566704
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiGEJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGEJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADFC25C3;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E331CB8171E;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A04C341EC;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=aA6pajJ5L/dtpPo1Rt6dHR4KQMCmecjywy0+jWwynWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaAvgydX5jn9wkq3FKkJcT0kQdHTL0XkAvTfGY3NPO27XtIfm/Y60Van1YWO/shz3
         cmfHUnAJ/Pf9VFP5remsO3MvCop2ijhCR7KIQ0z0UBpDEpSvvzI+Dsx7ITLTFrVnno
         dwVNiqoUYVeAtnjQAwABUCdQ+mSnVX33E2s1IhDtRt4Q2vAedvYWKLilUJLTp2PkTy
         I+rgL2qjhZm26ZtXgY3+oOZgp7e9VGfFEsu+jFMI8Qtf2llFollqwHa8RKD+VQ5X9U
         5gRmnUskCpbkHZCr9Si+CLgGkLZYiR1SoB/NgvhgQJT9z3+BWQ/vDGCXBhjoDlEgX0
         yI+uexoDLFU7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004XL-Gn; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 11/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate reset names
Date:   Tue,  5 Jul 2022 11:42:07 +0200
Message-Id: <20220705094239.17174-12-johan+linaro@kernel.org>
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

Drop the unnecessary "lane" suffix from the PHY reset names and mark the
old names as deprecated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index 7931b1fd1476..0bea8270b37e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -94,11 +94,15 @@ patternProperties:
           - description: PHY (lane) reset
 
       reset-names:
-        items:
-          - enum:
-              - lane0
-              - lane1
-              - lane2
+        oneOf:
+          - items:
+              - const: lane
+          - items:
+              - enum:
+                  - lane0
+                  - lane1
+                  - lane2
+            deprecated: true
 
       "#clock-cells":
         const: 0
@@ -166,7 +170,7 @@ examples:
             clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
             clock-names = "pipe";
             resets = <&gcc GCC_PCIE_0_PHY_BCR>;
-            reset-names = "lane0";
+            reset-names = "lane";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_0_pipe_clk_src";
@@ -182,7 +186,7 @@ examples:
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
             clock-names = "pipe";
             resets = <&gcc GCC_PCIE_1_PHY_BCR>;
-            reset-names = "lane1";
+            reset-names = "lane";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_1_pipe_clk_src";
@@ -198,7 +202,7 @@ examples:
             clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
             clock-names = "pipe";
             resets = <&gcc GCC_PCIE_2_PHY_BCR>;
-            reset-names = "lane2";
+            reset-names = "lane";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_2_pipe_clk_src";
-- 
2.35.1

