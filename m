Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB956A478
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiGGNsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiGGNrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D927B01;
        Thu,  7 Jul 2022 06:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE6F621AD;
        Thu,  7 Jul 2022 13:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DDC36AE3;
        Thu,  7 Jul 2022 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=L091Lwo2vL0s0fAkT/tkbwRyMpVuvwvBsfviDWQ21ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0/KbZ9S4BDzwYcbJweszSEEOmiC8sFWJi9fN9SS7ScegTRl0f4M3oE6GuaAkmtUW
         xkEhi7eYlTlLqkv+o3KkDEgjXEDTJ9eD/W2DIfinEH/7EmDY7tshrAw1X1SK1b1eFA
         KKhs3z3jQvraUrjaoE/Tt5fS10KxKpItEdzqG9yVYx71t45b17/LaRyhgHk9WnTs1R
         khmQt+TePtLuSBh5efF4yzfzisHmtoS3zlOD+Co4KrcdxXI4pYXzSWbqXcNXZERnAs
         W24T+PRVmPPJHF2Scr3+j9D/QlGVvAmiAljt37T1w9fPEQ8QEZAVYhj342pturTxZ+
         yUNBjBFGShOSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr3-0000vz-Vw; Thu, 07 Jul 2022 15:47:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 05/30] dt-bindings: phy: qcom,qmp: clean up descriptions
Date:   Thu,  7 Jul 2022 15:47:00 +0200
Message-Id: <20220707134725.3512-6-johan+linaro@kernel.org>
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

Clean up the remaining descriptions by using uppercase "PHY"
consistently and dropping redundant information from the register
descriptions.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index f7b8898fd95d..bcffabf04566 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description:
-  QMP phy controller supports physical layer functionality for a number of
+  QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
 properties:
@@ -63,8 +63,8 @@ properties:
   reg:
     minItems: 1
     items:
-      - description: Address and length of PHY's common serdes block.
-      - description: Address and length of PHY's DP_COM control block.
+      - description: serdes
+      - description: DP_COM
 
   "#address-cells":
     enum: [ 1, 2 ]
-- 
2.35.1

