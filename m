Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1956A461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiGGNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiGGNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4D2251A;
        Thu,  7 Jul 2022 06:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E033B82222;
        Thu,  7 Jul 2022 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B6EC341E4;
        Thu,  7 Jul 2022 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=/G961bIHsqvM18T2+pLeKjiHascL9V+Rmbh5mQi0vu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EZfl5ehh1KxBJxzHoj6ZUnQzNSPbLB4LxVKP/xnLX1Rl3q6J86rl1KEycNhHrGGd9
         EWXUU6lfKISTWkYhXg5CEyMPQZHf52aRXQNKeu0ZeFkytJEKlIaSsVKl6gd9lFqORk
         DuLR0lRs6slplKD7rFgE2kV1n2mu1I9phVYvBOGLIw5Urpger/1eRHCWZMK9K256A9
         5IMl2MnBQh7ZPf267Bx9/vbbSwP1p4dzt+FdOvbv5FdrXmuEVpeXMv7iJLs5DDSNXb
         fd850BZGSy6DS7mP2XB571cjws9zN2jf4ZJUt3a5RZ89kPJedUxiA90BSNyM709GPX
         IztM7aTARwgLw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr4-0000wL-Ba; Thu, 07 Jul 2022 15:47:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/30] dt-bindings: phy: qcom,msm8996-qmp-pcie: add missing child node schema
Date:   Thu,  7 Jul 2022 15:47:04 +0200
Message-Id: <20220707134725.3512-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134725.3512-1-johan+linaro@kernel.org>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
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

Add the missing the description of the PHY-provider child nodes which
were ignored when converting to DT schema.

Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index accbcb8b5c6f..8125a91a3591 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -57,6 +57,55 @@ patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
     description: one child node per PHY provided by this block
+    properties:
+      reg:
+        items:
+          - description: TX
+          - description: RX
+          - description: PCS
+
+      clocks:
+        items:
+          - description: PIPE clock
+
+      clock-names:
+        items:
+          - enum:
+              - pipe0
+              - pipe1
+              - pipe2
+
+      resets:
+        items:
+          - description: PHY (lane) reset
+
+      reset-names:
+        items:
+          - enum:
+              - lane0
+              - lane1
+              - lane2
+
+      "#clock-cells":
+        const: 0
+
+      clock-output-names:
+        maxItems: 1
+
+      "#phy-cells":
+        const: 0
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+      - resets
+      - reset-names
+      - "#clock-cells"
+      - clock-output-names
+      - "#phy-cells"
+
+    additionalProperties: false
 
 required:
   - compatible
-- 
2.35.1

