Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A245AA981
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiIBIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiIBIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:08:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B00B729D;
        Fri,  2 Sep 2022 01:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81B9FB82A02;
        Fri,  2 Sep 2022 08:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A0AC433C1;
        Fri,  2 Sep 2022 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662106093;
        bh=khqeET1+0nkt6ch7LpgBOBM9lI7y0AVI0urjOk7+sQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ikl6okLZWqKD2GB03i24PeKzFeqIRmVElCRsdaa6Nldot7w0A90Toox91tCce+rKS
         UJruhGvAPC54RQIW5kDKwaJAhilarrJw7tSdtq0FazqQ+i0vaq26/ZPt8E5OVAcjsk
         v7lk5HXIuzTiHYeNwMDLEhf0Mf4c345sUig5a8WJMNQ9Uccq4EbQUvagvjjTNi6MjS
         CmsnNIYLji4HV89yDfW6ltnek9PAVpZ3xf43VondzFn+YDvucwo7GAFKI5/jHfKrML
         o/RzwXIi17ymijT2b9TbS3je1SxuxYKsamCzeBmeFM3byvj4dZqMiE+LvppbhT0E6C
         4s86kofUu3E0w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oU1iq-000399-NV; Fri, 02 Sep 2022 10:08:16 +0200
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
Subject: [PATCH 1/2] dt-bindings: phy: qcom,qmp-usb: add missing power-domains property
Date:   Fri,  2 Sep 2022 10:07:04 +0200
Message-Id: <20220902080705.12050-2-johan+linaro@kernel.org>
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

At least the "sc8280xp-qmp-usb3-uni-phy" binding requires a power domain
to be specified.

Fixes: aa27597e594c ("dt-bindings: phy: qcom,qmp: Add compatible for SC8280XP USB phys")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-usb-phy.yaml   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 25e01ec4799d..7acb4b7de7f9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -58,6 +58,9 @@ properties:
     minItems: 3
     maxItems: 4
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 2
 
@@ -265,6 +268,16 @@ allOf:
             - const: phy_phy
             - const: phy
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-qmp-usb3-uni-phy
+    then:
+      required:
+        - power-domains
+
   - if:
       properties:
         compatible:
-- 
2.35.1

