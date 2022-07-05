Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77556670D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiGEJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiGEJtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640B13D6B;
        Tue,  5 Jul 2022 02:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0816B8172E;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A89C341DB;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=tuoEnZLbKbLZ+g2dIuP0Vqx9Bsaroi5FmYSfg9SAq5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5hOA2wdu3ATaSbt8tsgCkVgPJCHome5X3T3x8JfKjPNJnrvXw4ggO/m8pEeDhVmo
         iolqHCVYQc/cEzItSL8Z9Y/e13T9s/0r6wZWJiDHV7+VBizGf8ysGehUhVtx9kc4bl
         ym/jTPZfQ81nWHPZ7Cd4uA/YNLrq0TlTjUUPFR8blJYR7ymJXYUiEz/9d9Lwh2G/gA
         uK++S7KDVwvevVCixyt24gjOt56kxv8HNDT4h/Il2ws2+SMXLYcm49eLM1bv+JEqxV
         DhIkqjN7q2ZKGbAtDikr889euW34FOQ+FHmqmPLAgcerbHcDzzyThyf8nCo8UHdnbF
         KfzN5NdE4GulQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YN-Cd; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 32/43] dt-bindings: phy: qcom,qmp-usb: drop unused vddp-ref-clk supply
Date:   Tue,  5 Jul 2022 11:42:28 +0200
Message-Id: <20220705094239.17174-33-johan+linaro@kernel.org>
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

Only UFS PHY nodes in mainline have a vddp-ref-clk supply. Drop it from
the USB PHY binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 3404ad7fc6db..76979aff086f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -74,10 +74,6 @@ properties:
     description:
       Phandle to 1.8V regulator supply to PHY refclk pll block.
 
-  vddp-ref-clk-supply:
-    description:
-      Phandle to a regulator supply to any specific refclk pll block.
-
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-- 
2.35.1

