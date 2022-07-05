Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B184B5666E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiGEJtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA611C06;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7FA06192F;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B5C341D2;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=NMdG3JQTVZQsmBPHe3nFjQ3nKf9PlrIsuO3XSeSbWNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV7OLkbQdT6Ro/Fo2D/UxQpfbNQVNh9IUhZXxtF8aYC0t3s+0iBr8AjYIXoZUHJYf
         73i6jzRiDlqSWt4BUZbvbd+IkVFI8awE0mU77vfxHBrUNkr4R8GuvCExnVX1L7YcRq
         VGAiOn0tpg4hwfotXATUW1L774+r4ycWBntv1pb9vZ36YsdHBCSgSWezYHMxz0Tmq3
         6ai/mrxU5mLuOQKAh5GojmkYZmK4zELgJwv43ZiHUrlhkm9ktZWteye/0iqMu/0GGm
         jQ7A6W0bdyRMFxpZyKm3K4/SNTRUqovnnavOAibaKnWmk6gGYYBwz0NI2kdY52eg2q
         fhUb5gKG64zLw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YE-3D; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 29/43] dt-bindings: phy: qcom,qmp: split out USB binding
Date:   Tue,  5 Jul 2022 11:42:25 +0200
Message-Id: <20220705094239.17174-30-johan+linaro@kernel.org>
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

The QMP PHY DT schema is getting unwieldy. Break out the USB PHY
binding in a separate file.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/{qcom,qmp-phy.yaml => qcom,qmp-usb-phy.yaml}     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-phy.yaml => qcom,qmp-usb-phy.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
rename to Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 04c24f8e4526..8343e24b669a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -2,10 +2,10 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
+$id: "http://devicetree.org/schemas/phy/qcom,qmp-usb-phy.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Qualcomm QMP PHY controller
+title: Qualcomm QMP PHY controller (USB)
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
@@ -130,6 +130,7 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -160,6 +161,7 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -191,6 +193,7 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -225,6 +228,7 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
+
   - if:
       properties:
         compatible:
@@ -255,6 +259,7 @@ allOf:
       required:
         - vdda-phy-supply
         - vdda-pll-supply
+
   - if:
       properties:
         compatible:
-- 
2.35.1

