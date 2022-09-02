Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B725AA97E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiIBIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiIBIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A3BB91F;
        Fri,  2 Sep 2022 01:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B5262097;
        Fri,  2 Sep 2022 08:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55610C433D6;
        Fri,  2 Sep 2022 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662106093;
        bh=qdo258x7GijpGgpulMeQhjQmJ4qALitRxDyhqpeG650=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRByYE5bClPz9d8ZexfQ4LspYAhhYm0K/WFXBQRU+rR8rXRAHkA9s653cr8gcX3wT
         hBxBdYhGx00vQVhAdgnCjgoCGwr/Nu4x6/njXkW5nUhncgDtyItrcZGrCYeYtz/tab
         YHFc89brQ13U750lepFLYvmDj5V1ganJNu/FIJYT9YpKTkpcEEhOvN3kNhnAQsHdM6
         S2gIHiSMuzEN7zkuX+XQI/qqw55VXm4DwW+WCGtc491VTApS2e6z78lQJItZ7ixXIa
         sDv7FP/zZ3dikNboO4R6e8OP1IXiH2bXGmCTg3MrApXG9/iTnn93So6P28KcUvS7QK
         2q0X5/YQq6tAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oU1iq-00039B-QE; Fri, 02 Sep 2022 10:08:16 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] dt-bindings: phy: qcom,qmp-usb3-dp: add missing power-domains property
Date:   Fri,  2 Sep 2022 10:07:05 +0200
Message-Id: <20220902080705.12050-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902080705.12050-1-johan+linaro@kernel.org>
References: <20220902080705.12050-1-johan+linaro@kernel.org>
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

At least the "qcom,sc8280xp-qmp-usb43dp-phy" binding requires a power
domain to be specified.

Fixes: aa27597e594c ("dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index abc29686dff6..97a7ecafbf85 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -53,6 +53,9 @@ properties:
       - const: ref
       - const: com_aux
 
+  power-domains:
+    maxItems: 1
+
   resets:
     items:
       - description: reset of phy block.
@@ -159,6 +162,17 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-usb43dp-phy
+    then:
+      required:
+        - power-domains
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-- 
2.35.1

