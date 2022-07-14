Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC65574E30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiGNMo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiGNMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:44:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861343E72;
        Thu, 14 Jul 2022 05:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 507B061EB5;
        Thu, 14 Jul 2022 12:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6C5C341F8;
        Thu, 14 Jul 2022 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657802644;
        bh=q7516nLGJqvL48u1D0OTxXEREQ4QbqQWdVf6bIh8Ods=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN89O6C+qGDrMnDXANDghwwbLua79OnaHjqgFS8/Ozokxzab6qMcMG511o69MLy5N
         uLx5DQTtjB8BCyizmUT3Wcoov8h04OX81kNbO5N8yUtiJF6HsvTPlpSjGE2ifsh1LX
         PphflE5KtrCN+bMoHhAeQFxZGa0+G+qs4ym+L5cfjHYxevYpgfjwW7lywEgSlbJ+6F
         B/3GvWqgHH+TrFJ8CF9/H1MOZbRYT1HIfphp0/+1zvlIz/oqqhnqiTbI2rZKVGE9eh
         f3GhND6RFUUcWfshmhLd1TCTjB8HK4MljBW8/IjfslndU/ve91lQNMnkQ8cAf+Meol
         VXr8PpKvxQ+IQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oByCQ-0007Dq-7s; Thu, 14 Jul 2022 14:44:10 +0200
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
Subject: [PATCH v3 17/30] dt-bindings: phy: qcom,qmp-ufs: add missing SM8150 power domain
Date:   Thu, 14 Jul 2022 14:43:20 +0200
Message-Id: <20220714124333.27643-18-johan+linaro@kernel.org>
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

Add the missing optional power-domains property used by the SM8150 UFS
QMP PHY to the binding.

Fixes: fe75b0c4a691 ("arm64: dts: qcom: sm8150: Add ufs power-domain entries")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index 7a1f80e2cf23..0e76256e5636 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -48,6 +48,9 @@ properties:
     minItems: 1
     maxItems: 3
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.35.1

