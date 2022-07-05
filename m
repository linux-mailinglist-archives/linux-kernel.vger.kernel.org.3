Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E985666E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGEJtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGEJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779BCDFEF;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27D46191C;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576A3C36B1C;
        Tue,  5 Jul 2022 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014543;
        bh=73Ko1hdObvK4P8nQePVdDkrJQMSlxC4Gjr2GN4baZCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAqys4M36Jle5JGDW9ZjZ4TJrAFyTgnRhGow44MPh9K7hUqKHr8KE7Nk+bY24gKln
         IiyQEkoO+oB40OStFsWCg7RWCmdzvRif1B14yqAx0JTg4T7A98do1ExeYK0ST7X/uM
         +h7Tz1Qse+6C7BMyxjgQueU/3rjr1FCODioVfIKdmidnDJla5KhcaZyzs0/BhIQ1rn
         WVe/YzNEkOV94BSWHT0hRCLTonM1YKTLx81MGoB+Zo4tRdqaML2/UOx7S/3wmVa2ep
         l/N9hZd3pUYrwmn2+RJTgBkh3hWkmsbtA9M6eawC0sh4/T31DW+4DZ7FLHVDlPbv1M
         ewDrEMFGnU9tA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB2-0004Xp-CK; Tue, 05 Jul 2022 11:49:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 21/43] dt-bindings: phy: qcom,qmp-ufs: clean up supplies
Date:   Tue,  5 Jul 2022 11:42:17 +0200
Message-Id: <20220705094239.17174-22-johan+linaro@kernel.org>
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

The UFS PHY binding requires the vdda-phy and vdd-pll supplies.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml         | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
index 4471f1b4fb7a..c4458d90d8b7 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-ufs-phy.yaml
@@ -88,6 +88,8 @@ required:
   - clock-names
   - resets
   - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -112,9 +114,6 @@ allOf:
         reset-names:
           items:
             - const: ufsphy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
 
   - if:
       properties:
@@ -144,6 +143,3 @@ allOf:
         reset-names:
           items:
             - const: ufsphy
-      required:
-        - vdda-phy-supply
-        - vdda-pll-supply
-- 
2.35.1

