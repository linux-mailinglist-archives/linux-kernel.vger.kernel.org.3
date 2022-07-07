Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2856A41B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiGGNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiGGNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E861F1A056;
        Thu,  7 Jul 2022 06:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FBB9B8222B;
        Thu,  7 Jul 2022 13:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0BC341D7;
        Thu,  7 Jul 2022 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201660;
        bh=Mvv8Aqi+95oauNmn8C15c2rWwBpuwdIMgo3pQP+PeBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNDBpVqd4/vp8ImVTlFjCTirk5d6ClOLCN63tyFurOxMZy0CTjNiSHBLeHI1ULBvW
         LU3Qkgv1oaMPsoSb+fgQzF2TYPLCe3WL9v9cMCVRVEsNR8EG7EO7tLG5hOjDitvZ+q
         ZqNu2O3W5I/mDrHaUFhxfvkGdA9H59+bZMlCayoAcV6AG8GAhGu394iai08zBP5ptP
         8UHDVF1suM3W8kgYMR8EJa9k8daVeHG1WPz9X95GLHHbDHd676XcNwl+jNkzicxEQj
         H9BW8+6kGagVE3iv7PdyKCAh++Lt2HOzXFqTJz0/odIaafYIyhdNzO3gj/wOIvw84o
         QoiNkQO/XIR9Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr5-0000xW-FR; Thu, 07 Jul 2022 15:47:43 +0200
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
Subject: [PATCH v2 21/30] dt-bindings: phy: qcom,qmp-usb: deprecate PIPE clock name
Date:   Thu,  7 Jul 2022 15:47:16 +0200
Message-Id: <20220707134725.3512-22-johan+linaro@kernel.org>
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
 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 0e9f909ccb82..174f96d53d6b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -85,6 +85,7 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
+        deprecated: true
         items:
           - const: pipe0
 
@@ -100,7 +101,6 @@ patternProperties:
     required:
       - reg
       - clocks
-      - clock-names
       - "#clock-cells"
       - clock-output-names
       - "#phy-cells"
@@ -356,7 +356,6 @@ examples:
                       <0x600 0x70>;
 
                 clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
-                clock-names = "pipe0";
 
                 #clock-cells = <0>;
                 clock-output-names = "usb3_uni_phy_pipe_clk_src";
-- 
2.35.1

