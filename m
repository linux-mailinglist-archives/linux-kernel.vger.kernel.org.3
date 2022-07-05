Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E75666D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiGEJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290725C3;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE1E61931;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA357C53FCF;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=9GXGSYtsWSG+8jc9OQeAMpIATOnmAAaERp119+1qcAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSBDruXmW8fAtKjDDHoHGbMlaTrHI5h9tOT9ef+h0/9nQGK+Xm/6urZK1k/ToG8Pz
         NlYC7K7h0Uvsdorl/ZrgCm6ASUJn49AvJnYAE93d4p0hkh8GUiqI+MzXDUqhh/O6Ac
         B+IEPw0z9MSQ4IYNeofy5GZDzE+ISl1B4/IeNH3ndrpZ8xb2deFzzd/Y9EEZe+fCuB
         vin+5+UX8NMQgTPJDBuB+Fi2cPi0T+uVMc7zxyZlDMoT32uWibqgncRkYEghNgi6+J
         vi0za58i06BL2E3XAUqDWIjTb9l+Qn5DGg9A2NfQhDlpNRM1pDVbrryq5LHmHlVtdZ
         GFsahs9k++41g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Y2-Oy; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 25/43] dt-bindings: phy: qcom,qmp-ufs: add missing SM8450 clock
Date:   Tue,  5 Jul 2022 11:42:21 +0200
Message-Id: <20220705094239.17174-26-johan+linaro@kernel.org>
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

Add the missing "qref" clock used by the SM8450 UFS QMP PHY to the
binding.

Fixes: e04121ba1b08 ("dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible")
Fixes: 07fa917a335e ("arm64: dts: qcom: sm8450: add ufs nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-ufs-phy.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index af3ed5601d21..d04cdb85f005 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -43,11 +43,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   resets:
     items:
@@ -129,3 +129,22 @@ allOf:
           items:
             - const: ref
             - const: ref_aux
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-qmp-ufs-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: 19.2 MHz ref clock.
+            - description: PHY reference aux clock.
+            - description: qref clock.
+        clock-names:
+          items:
+            - const: ref
+            - const: ref_aux
+            - const: qref
-- 
2.35.1

