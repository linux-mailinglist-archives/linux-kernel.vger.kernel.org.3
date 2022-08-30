Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002195A61AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3LaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiH3LaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC617072;
        Tue, 30 Aug 2022 04:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AB2A6154D;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A3EC433B5;
        Tue, 30 Aug 2022 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661858999;
        bh=btBM/lw889YzrV8unkE/SmF0HeMiLG8bwnVYwR4ufYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoNRsFSSFSKBM5i5PD+mBdwPvUTtBH6mwCI4qePjF0jcEnihlZJn2SD15IELKmt9y
         yi9P7O6IUbxSEwrLcUXYJGDyvTRG9hVT6XjsU7vhblL/R0QNGuvx9dOyBNyBn12Z8v
         txqid5PeoAY+fy92rSQnZAVL+33+4Pp0I6uZQy3DAJuk6zfOaOLeKvgVGWWImuALkW
         KMNmR//MDotQRVNYKBrt2idEjFRse6jIAQ3qYUtXzzuklQisLbeRPpuJ1rbv/IegpS
         mwUZw2xy8NJajSDXr88eRveGhkEmrSa5Xq9gR8cpc6zmHdZiXFGsbly1CxK4QEQc4z
         swt4fgF4QWjWA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRN-0000zy-9L; Tue, 30 Aug 2022 13:29:57 +0200
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
Subject: [PATCH v4 05/30] dt-bindings: phy: qcom,qmp: clean up descriptions
Date:   Tue, 30 Aug 2022 13:28:58 +0200
Message-Id: <20220830112923.3725-6-johan+linaro@kernel.org>
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

Clean up the remaining descriptions by using uppercase "PHY"
consistently and dropping redundant information from the register
descriptions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 370a7e55622f..d2b35562b9cb 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Vinod Koul <vkoul@kernel.org>
 
 description:
-  QMP phy controller supports physical layer functionality for a number of
+  QMP PHY controller supports physical layer functionality for a number of
   controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
 
 properties:
@@ -65,8 +65,8 @@ properties:
   reg:
     minItems: 1
     items:
-      - description: Address and length of PHY's common serdes block.
-      - description: Address and length of PHY's DP_COM control block.
+      - description: serdes
+      - description: DP_COM
 
   "#address-cells":
     enum: [ 1, 2 ]
-- 
2.35.1

