Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35165666F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGEJuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGEJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D6C38A1;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 124F86192C;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E32C341CF;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=eIr/QiwdfHR3bGr/CfGRxxEsPkmmFmBqkyN0cb2r2go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLXWfSuRRmkPEShhbmW6ADTTGuRWjP+vrn8cPOlB2OXF2REy8BzB3zwPuL9dhgtZH
         Lw/m34jJUdFEHqu3VAvK96/fZF6UEmbBs1vNDP+29wsaVMOHbIU6n8OBjKo4GTRwsO
         gEiHzO04C3Izw9lc3iqBUijCACrJ1qF/xMDPm56g6w2C3BP0dPrG1wul6qEzcX9xuX
         PJP6AoqpZYO3oEpKv/ayX2t8ShRloXHdp0eY3dYPxO8I9V712Mm2nw3s01i4PSmTPc
         lmQ1tW+/5zqZ/e8KjogSSMD7seLtdrHytYjkhrrzCO019QamO5AWKEWS2Hz7hmjZ13
         uIq8kpU7XXldA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004Yc-Qg; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 37/43] dt-bindings: phy: qcom,qmp-usb3-dp: deprecate USB PIPE clock name
Date:   Tue,  5 Jul 2022 11:42:33 +0200
Message-Id: <20220705094239.17174-38-johan+linaro@kernel.org>
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

Drop the bogus "lane" suffix from the USB PHY PIPE clock name and mark
the old name as deprecated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml  | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 86d64c61bca3..09d7708158bb 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -96,8 +96,12 @@ patternProperties:
           - description: pipe clock
 
       clock-names:
-        items:
-          - const: pipe0
+        oneOf:
+          - items:
+              - const: pipe
+          - items:
+              - const: pipe0
+            deprecated: true
 
       clock-output-names:
         items:
@@ -192,7 +196,7 @@ examples:
             #clock-cells = <0>;
             #phy-cells = <0>;
             clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-            clock-names = "pipe0";
+            clock-names = "pipe";
             clock-output-names = "usb3_phy_pipe_clk_src";
         };
 
-- 
2.35.1

