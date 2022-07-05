Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5C5666A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiGEJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiGEJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49167FD3E;
        Tue,  5 Jul 2022 02:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D085B61926;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969DAC341CE;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=6PIq6E5IaCm16IQAMjZXZR5xejvClm6y5jWgrc0y/xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3awIUsbzmwLD6QRDlPOJcqT6OrDahzk0Vn6MaJ97hWJlBQ7SKd+ZRpS0mWhWrmJI
         mdZPyVYcW/omzwhYAFJ0dWiCo/AgWRqX3+QR2eF7xq6z0qmmKfHpCCuKlFga6uL/Nq
         /dLEODfwmoWqY99TEDLAh7DVgdEr87HxzQzNC5GRAXSkM6bxBzHOLxfT+3/HCrel1s
         ALScvVzCltHuwEXgP5MFEqEDLEUJVZhRDuqlN8IzKSEhrQmobP/8t7bYiYdtL5Wv8u
         wKVPQjFnmP3uJnRChsF30O6UsrjuLl52r7M5Qk9TOpTW5E432q8AlYPShwxq2jRgDl
         54ZdtQIz/i1Jw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004XJ-Dt; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: deprecate PIPE clock names
Date:   Tue,  5 Jul 2022 11:42:06 +0200
Message-Id: <20220705094239.17174-11-johan+linaro@kernel.org>
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

Drop the unnecessary "lane" suffix from the PHY PIPE clock names and
mark the old names as deprecated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qcom,msm8996-qmp-pcie-phy.yaml        | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
index 45f7bb7a632a..7931b1fd1476 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-pcie-phy.yaml
@@ -79,11 +79,15 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
-        items:
-          - enum:
-              - pipe0
-              - pipe1
-              - pipe2
+        oneOf:
+          - items:
+              - const: pipe
+          - items:
+              - enum:
+                  - pipe0
+                  - pipe1
+                  - pipe2
+            deprecated: true
 
       resets:
         items:
@@ -160,7 +164,7 @@ examples:
                   <0x1400 0x1dc>;
 
             clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
-            clock-names = "pipe0";
+            clock-names = "pipe";
             resets = <&gcc GCC_PCIE_0_PHY_BCR>;
             reset-names = "lane0";
 
@@ -176,7 +180,7 @@ examples:
                   <0x2400 0x1dc>;
 
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-            clock-names = "pipe1";
+            clock-names = "pipe";
             resets = <&gcc GCC_PCIE_1_PHY_BCR>;
             reset-names = "lane1";
 
@@ -192,7 +196,7 @@ examples:
                   <0x3400 0x1dc>;
 
             clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
-            clock-names = "pipe2";
+            clock-names = "pipe";
             resets = <&gcc GCC_PCIE_2_PHY_BCR>;
             reset-names = "lane2";
 
-- 
2.35.1

