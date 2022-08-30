Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B15A6202
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiH3LcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiH3LaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767D24BD6;
        Tue, 30 Aug 2022 04:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C114B81A66;
        Tue, 30 Aug 2022 11:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A856C4FF17;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859000;
        bh=q7516nLGJqvL48u1D0OTxXEREQ4QbqQWdVf6bIh8Ods=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncQ2umLD75ttmTCG7Qvyb/R3ca19EXfTC4tkDd1Z1gYDq7BI1DtyTzHlNbwe08w1a
         mtMYaRZpJVLBt4Uhg0a+yresA1ZgrVRJmnRZnEtxjVwDkF9A33tmZ9iuPfmumgGVZE
         c0CFTX07XIZON4ErIn6AMu4Xoi9e93M9PXMnlfYDxxkLJ+e2+isekCKH2ac+D0KS8z
         1B0Ze9FI2IMxyJ7r+zW5quR/eeXBSerio2fgDwN9L322aFUmu1QxS25XDkF/NIZRk0
         IUox0hA628+IWBdQLPce191gEUnJoAe1HDNnhAd8Qzvge3EDTVH4Gimctmr+p5Cv9u
         0NYfQKk06Wmxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010d-An; Tue, 30 Aug 2022 13:29:58 +0200
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
Subject: [PATCH v4 17/30] dt-bindings: phy: qcom,qmp-ufs: add missing SM8150 power domain
Date:   Tue, 30 Aug 2022 13:29:10 +0200
Message-Id: <20220830112923.3725-18-johan+linaro@kernel.org>
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

