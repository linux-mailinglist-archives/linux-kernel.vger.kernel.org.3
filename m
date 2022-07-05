Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24645666BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiGEJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiGEJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6964DFB9;
        Tue,  5 Jul 2022 02:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F74C618EC;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE74FC341CD;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=+lRInMhIruR0OwlIKudAUTFxtNBmuvC62exzVnl3McY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dpg6vMEnC5XGbzAdFslHv9GqI4rkDpB9t9km9Sq15c3FAi22kc8bD8J5WOPZs2eD7
         sVzOiun8ja3vYhhjRiSi3d6I7FQF/0qnAckrFK11OxWk7uBWeUIKFDFO/oQvEZdam8
         m65k1M7th3K3pvepFmu8ow+4a0rfN/hqf3LVWMx88cg2AL/KWPPwTNQAhnftstVGGI
         xszRwIkiFd8mC88JbnHDqxWKvBMmPDL7thrtPBw9fFihdCYW5lhcAJiPEPunVROXjT
         sQOhyCv9HI4HXo7s/VQh1JOFT94V5GleFBV/StkbZ1bOR0pkDWFKfLuhMfwXDGjdbB
         bQMBE6LHBsuXw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB1-0004XW-Ry; Tue, 05 Jul 2022 11:49:03 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 15/43] dt-bindings: phy: qcom,qmp-pcie: clean up reset constraints
Date:   Tue,  5 Jul 2022 11:42:11 +0200
Message-Id: <20220705094239.17174-16-johan+linaro@kernel.org>
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

The PCIe PHY binding requires one or two resets.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
index 0486b2b48d72..557cccc8f4dd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
@@ -52,11 +52,11 @@ properties:
 
   resets:
     minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   reset-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   vdda-phy-supply:
     description:
-- 
2.35.1

