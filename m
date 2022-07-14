Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705F574E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiGNMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiGNMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418143E6D;
        Thu, 14 Jul 2022 05:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0191B824EB;
        Thu, 14 Jul 2022 12:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4FAC385A5;
        Thu, 14 Jul 2022 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=1lEs817FEx5CwA48EnKrDeW2WIjzBg83Q+nAjMtNlDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4VZICxAg63a/6xqsUdXvr7LJj9b31NSb9pX17ypqb1fiZhTyDi90d3JHm13DsZr/
         t6sbGjpbl6Z5SVhcKHJWbA7Cr+yWNMBSOxB7oKCcf5bfAt4KjG9d9cqTbR09uwX2DL
         A9DMCMZHcabSPgEDexzjhXkfQyU11lrpH1eOmO/XpQ7/FOlqLtIcLRlFO97jIgZE4O
         fhpBPtT96DH2hIrIQDjhJNi6WCOY2SfwQuIaGGJrhocNk7MxoxRsu0M3Ef+vZWmxAo
         P0ikHo4WwidL5fjERaEl65IuKm5zGajGUILkcnwwTN00qgEbaO+t2ix7QhH5z3/Rfw
         B/m05YWjMZyZw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCP-0007DH-88; Thu, 14 Jul 2022 14:44:09 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/30] dt-bindings: phy: qcom,qmp: clean up example
Date:   Thu, 14 Jul 2022 14:43:09 +0200
Message-Id: <20220714124333.27643-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714124333.27643-1-johan+linaro@kernel.org>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the example node somewhat by grouping consumer and provider
properties in the child node.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 189618dedb00..6269a8667a90 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -428,10 +428,13 @@ examples:
                       <0x400 0x1fc>,
                       <0x800 0x218>,
                       <0x600 0x70>;
-                #clock-cells = <0>;
-                #phy-cells = <0>;
+
                 clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
                 clock-names = "pipe0";
+
+                #clock-cells = <0>;
                 clock-output-names = "usb3_uni_phy_pipe_clk_src";
+
+                #phy-cells = <0>;
             };
         };
-- 
2.35.1

