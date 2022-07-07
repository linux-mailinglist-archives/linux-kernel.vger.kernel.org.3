Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FEE56A47D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbiGGNtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiGGNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D63190D;
        Thu,  7 Jul 2022 06:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2126B82223;
        Thu,  7 Jul 2022 13:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DCC36AE5;
        Thu,  7 Jul 2022 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=2V9aRAC2X1UCZ0ZViRkEIRSPpsay+FjbvSHDFWbB+HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fLgUXgdah3nbMnvAbNWI6gZKJtBQq0YUmCQjw8V6krIbgIOKoYTE3zolh6I+M9hRH
         RtB39r51U7dsLy0WqkzH+YbIgNp1X5wKPbXM/a3ZN6vqOeQGysjlJzUOVkjkd2/Xly
         4Tiqctx1VY2gqhrNUzN4CVqhhtCA2z2Ryi6JYDqhbSjUazsPXuxGe8Ma0xPF0f9/Fz
         4i1a3L4I1z48rkcutP4BbKeH15npLDwLFnnjoxWgvnSEFlFTPF55lpn/E453hxctam
         43wDnGrEyU1vZElwepfUmLkzwPxTzKDslR2z7bSjF/0z+bFn9yjkulnyK27Qa1mlvM
         QdkXPfs6ddRHA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr4-0000w4-58; Thu, 07 Jul 2022 15:47:42 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 07/30] dt-bindings: phy: qcom,qmp: drop child-node comment
Date:   Thu,  7 Jul 2022 15:47:02 +0200
Message-Id: <20220707134725.3512-8-johan+linaro@kernel.org>
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

Drop the redundant comment about child nodes being required that was
copied from the old binding documentation.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 7e0f798632f4..08a84af711ce 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -96,7 +96,6 @@ properties:
 
   vddp-ref-clk-supply: true
 
-#Required nodes:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-- 
2.35.1

