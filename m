Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB70956A480
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiGGNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiGGNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88F27B20;
        Thu,  7 Jul 2022 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECEAFB8221A;
        Thu,  7 Jul 2022 13:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31927C341CE;
        Thu,  7 Jul 2022 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657201659;
        bh=t37NNwLh8MwSux7U3ureG58oP/xr5nX9uYzRDQ0W8Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ipp8H3Cz2npmAH3g3htm83GAkhbejAdjQdZlM++d9T00FQGCgVj+U5t26ntJSwVJF
         aYIDCMfv7RnKuVU9rwQGrpQ7XxcJad+0SwwnJ0YCJuFpmv53ePaFmiCiV5lS5PAATB
         9ShS0QFk44sY+wSkFNxxVQ6v7kVXZkhbHYaftn+RtS/5REH4dfJAOMv/SOKM4NePrd
         lz7p4zhAi2U+nW4mH9/REyavTxbxdND+G0Jtn06btjA3panEnRfw5DXHBmWq6Bftkr
         zuF+kdtScya0QepF5Zf9Modudjaoe4llx+dKhPvdtulAB1va0S2d9PqcQQCM1tgzM0
         q3KR0tkiBVrQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9Rr3-0000vx-TR; Thu, 07 Jul 2022 15:47:41 +0200
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
Subject: [PATCH v2 04/30] dt-bindings: phy: qcom,qmp: fix child node description
Date:   Thu,  7 Jul 2022 15:46:59 +0200
Message-Id: <20220707134725.3512-5-johan+linaro@kernel.org>
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

Fix the incorrect description of the child nodes which claimed that one
node is required per lane rather than per PHY.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index ea028bad961d..f7b8898fd95d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -100,9 +100,7 @@ properties:
 patternProperties:
   "^phy@[0-9a-f]+$":
     type: object
-    description:
-      Each device node of QMP phy is required to have as many child nodes as
-      the number of lanes the PHY has.
+    description: one child node per PHY provided by this block
 
 required:
   - compatible
-- 
2.35.1

