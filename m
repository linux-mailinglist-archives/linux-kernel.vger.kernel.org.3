Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14E15A61F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3LbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiH3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7022294;
        Tue, 30 Aug 2022 04:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91DD161557;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BA2C4FF7A;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859001;
        bh=vcL//u9CSuTV0TySG42WR+LqfqgG8yykMY1NC+lI/UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhHBpka0vypQuSReoLE9XM9y+yi0Rcx29KkpBEXTyRfP2J4yDTnG5rsLGL8ex8YOp
         SeswKLpAQ0Zq5dKb8B4+xx0hBOvtZQBDP/tS9IdVYBid/u2efcy97UBxnt4nLgLMlT
         2ncTFoiNzQOur6zFeVZ6la7qiNnAzyeGC9bsg2jRia9HNSX8AE+JLK1xpq2C961con
         intUZVVOua7n+cqnJXM1YhiFpSJX1mBFe+Nx5kNB1ZxomjDpjQ4495Y3YW6EUU696b
         gcm79NLHyVrVP5PxiC4osokiYC2jesYDF9xlxPccMaxKMN5vlaekW8bq/Fluk3w8HL
         ta7vAeGGxItFA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010p-Md; Tue, 30 Aug 2022 13:29:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 21/30] dt-bindings: phy: qcom,qmp-usb: deprecate PIPE clock name
Date:   Tue, 30 Aug 2022 13:29:14 +0200
Message-Id: <20220830112923.3725-22-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
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

Deprecate the PHY node 'clock-names' property which specified that the
PIPE clock name should have a bogus "lane" suffix.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index c8c7483f3f48..17af049e65a9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -84,6 +84,7 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
+        deprecated: true
         items:
           - const: pipe0
 
@@ -99,7 +100,6 @@ patternProperties:
     required:
       - reg
       - clocks
-      - clock-names
       - "#clock-cells"
       - clock-output-names
       - "#phy-cells"
@@ -357,7 +357,6 @@ examples:
                       <0x600 0x70>;
 
                 clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
-                clock-names = "pipe0";
 
                 #clock-cells = <0>;
                 clock-output-names = "usb3_uni_phy_pipe_clk_src";
-- 
2.35.1

