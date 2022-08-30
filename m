Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5AC5A6204
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiH3Lcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiH3LaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C292250C;
        Tue, 30 Aug 2022 04:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C168E61569;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEA3C4FF86;
        Tue, 30 Aug 2022 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859001;
        bh=Pv8Z5nFehfkYoWXpSKjausYgRFbe7Dy5KlCi2l4pu0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDIpwEQXpU77+4zVabPJ0+ZbOss1edC7/3iVDntN+h9tLX955hIBMIx7CMx2SfiHS
         Tcj8sCdJ6tSnRDjOI4cWhlMJ+Whx34h6SeegKCl2VWlS1INaRHqZmgpzqlX0Us3d0k
         MSeXy8t/e0J7x7IAJ2v2YkN0c3xcQQjG4xsXtC5xYUIQ3Nyulu8hoHqSrEq0q8/UbO
         d/jqxtzCcEr9l+7EUvayabrX+hxZcH1VZ3WJDg0F86npuDXqoH2Ezkekn/lqS8mdU8
         fVR80IRnPrQt1G0J+QUrIICfx/m58CCkLaqpPu1cabwNKEOXWLXJSZjXvt6LIpNLm9
         cZ9rmcR1M+cEw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010y-WB; Tue, 30 Aug 2022 13:29:59 +0200
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
Subject: [PATCH v4 24/30] dt-bindings: phy: qcom,qmp-usb3-dp: deprecate USB PIPE clock name
Date:   Tue, 30 Aug 2022 13:29:17 +0200
Message-Id: <20220830112923.3725-25-johan+linaro@kernel.org>
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

Deprecate the USB PHY node 'clock-names' property which specified that
the PIPE clock name should have a bogus "lane" suffix.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml          | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index da7d8dfc631c..abc29686dff6 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -98,6 +98,7 @@ patternProperties:
           - description: pipe clock
 
       clock-names:
+        deprecated: true
         items:
           - const: pipe0
 
@@ -114,7 +115,6 @@ patternProperties:
     required:
       - reg
       - clocks
-      - clock-names
       - '#clock-cells'
       - '#phy-cells'
 
@@ -195,7 +195,6 @@ examples:
             #clock-cells = <0>;
             #phy-cells = <0>;
             clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-            clock-names = "pipe0";
             clock-output-names = "usb3_phy_pipe_clk_src";
         };
 
-- 
2.35.1

