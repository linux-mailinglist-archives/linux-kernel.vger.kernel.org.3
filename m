Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E361F56A458
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiGGNsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiGGNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B521260;
        Thu,  7 Jul 2022 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71F6621DF;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C2C341F7;
        Thu,  7 Jul 2022 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=Zc7WW48mxwZcfafnZTw80uO919+NnDtTV+LRipLoSOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnqECd6HCUmE8TOSBVGj/Vv4rQzPPqlSiBwmTNvoJJeol8LlNftsTvYJbg33lC7GV
         xegfwcXdmsdWmrYABgl/d1yeJsgGgXMo6XhUIGnFYdSiFEqDmeVJqxQrnd34LKZbKw
         1jTWBk0X5MtyDjSh10KLWPsxgTgsXzY9DncjhdWM06pJiufncc22UIz9aP9BRBV2YF
         MGn5CbTmSup5SepdClqOknGqviRiU1h0jMPqWna8/7iH1FxKqL8BHHHSsO+LbtTT2z
         iIK2pziFJ1X3A5u0kqNnbHVUEMEgaDG3on/GNRz7Ybmaa9hYOOkoqq00US25z4Tm5J
         t2beWfY73H0iQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr4-0000wa-Q1; Thu, 07 Jul 2022 15:47:42 +0200
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
Subject: [PATCH v2 14/30] dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
Date:   Thu,  7 Jul 2022 15:47:09 +0200
Message-Id: <20220707134725.3512-15-johan+linaro@kernel.org>
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

Deprecate the PHY node 'clock-names' property which specified that the
PIPE clock name should have a bogus "lane" suffix.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
index 801222403bcc..f4e84c1ad0c1 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
@@ -77,6 +77,7 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
+        deprecated: true
         items:
           - const: pipe0
 
@@ -92,7 +93,6 @@ patternProperties:
     required:
       - reg
       - clocks
-      - clock-names
       - "#clock-cells"
       - clock-output-names
       - "#phy-cells"
@@ -285,7 +285,6 @@ examples:
                   <0xe00 0xf4>;
 
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-            clock-names = "pipe0";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_1_pipe_clk";
-- 
2.35.1

