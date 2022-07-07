Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24356A46F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiGGNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiGGNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB427B20;
        Thu,  7 Jul 2022 06:47:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 672D3B82228;
        Thu,  7 Jul 2022 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB47C53FC7;
        Thu,  7 Jul 2022 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201660;
        bh=boTqnhrrai2ijoY0lbc9OfpsU2lJU7ALSG8HtXGg5yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmNCa/fSfvhSeZVOUTo5MoKIebcREIeYOd+oDUy9vg9RHsHlMD/sSLjQCJuPQji2B
         xJS+nsm0kHAVsnENRX9fkMa66NmCEeTYFWj/FdB3SMN0giT0WAZTiAwcZNQvHXFykR
         iMeW86Ch1YcjiVEFyy9K/p+IosNG8A1zq+HMrQP2eH/ErKaTGRy50ObvDn6XG5e/vw
         aFnL2wi+xWx89v52VXQFf0eNGrLhJ5bFfagllm69vywEy2WDvLpAV6iXyJ04qPKy+0
         T4h/WO2N8QMWC2yXI9+9/rWAyC6B79oQhwfB83DCbvv97WaUQ/D3nKBea3z+4DR9bc
         3ZLF0xhJuVrsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr5-0000yD-Ie; Thu, 07 Jul 2022 15:47:43 +0200
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
Subject: [PATCH v2 22/30] dt-bindings: phy: qcom,qmp-usb: add missing qcom,sc7180-qmp-usb3-phy schema
Date:   Thu,  7 Jul 2022 15:47:17 +0200
Message-Id: <20220707134725.3512-23-johan+linaro@kernel.org>
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

The "qcom,sc7180-qmp-usb3-phy" compatible is apparently used to describe
a combo PHY where only the USB part is used. Specifically, only a single
reset is used.

4ad7d7eeed3a ("dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7180")
94c34600b617 ("dt-bindings: phy: qcom,qmp-usb3-dp-phy: move usb3 compatibles back to qcom,qmp-phy.yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/phy/qcom,qmp-usb-phy.yaml        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 174f96d53d6b..65e8e4ec656b 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -123,6 +123,28 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7180-qmp-usb3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: ref
+            - const: com_aux
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: phy
+
   - if:
       properties:
         compatible:
-- 
2.35.1

