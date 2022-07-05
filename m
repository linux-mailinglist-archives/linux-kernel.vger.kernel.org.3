Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BBD566705
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiGEJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiGEJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491010FD3;
        Tue,  5 Jul 2022 02:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FF42B81729;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D495C36B1D;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=wTKx6W4Z5/SzoW6B7e1sclkQeLott98hZJzN8+cbLRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1UDkjhpJ1LiiTnUQPuLSaqHWqYQFRlsJGrzkibKBYJ4jCreF8eurpVYBJjp3nTv2
         W75AZYLhkemjAHPBqoDHSiFkCNiWyq6jpB2+9KYWXC9VWd1oOBW1ieA0SbOYOa2OaM
         5eGBgE45DC2Y+B1I4X4XNPZhtiQEOso3CPRUSI/txEWXQiZ5752KB4+xnJ78Spove5
         pZpUDaKBDPA2/HRzgYQTF9JNl96Stzrlc1nzYe0Ww1HzSiBUjHoBH4YH2jChjg6VLV
         trwQFK8BszFRFovHoIg3DBS9QP5ZyeM7YPw5qzlB+wQ7lVdrXyy31arMbk+ceHriVh
         DT/JFSbh3mhNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Xj-7H; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 19/43] dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
Date:   Tue,  5 Jul 2022 11:42:15 +0200
Message-Id: <20220705094239.17174-20-johan+linaro@kernel.org>
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

Drop the bogus "lane" suffix from the PHY PIPE clock name and mark the
old name as deprecated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
index 3fc08af41144..32f872de8f4b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
@@ -80,8 +80,12 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
-        items:
-          - const: pipe0
+        oneOf:
+          - items:
+              - const: pipe
+          - items:
+              - const: pipe0
+            deprecated: true
 
       "#clock-cells":
         const: 0
@@ -295,7 +299,7 @@ examples:
                   <0xe00 0xf4>;
 
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-            clock-names = "pipe0";
+            clock-names = "pipe";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_1_pipe_clk";
-- 
2.35.1

