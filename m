Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574335666FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiGEJuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiGEJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466212D16;
        Tue,  5 Jul 2022 02:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24AC26193E;
        Tue,  5 Jul 2022 09:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339CCC341F9;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014544;
        bh=TyTxeiPGGyT7aa4zhB7OAEq1HFM+F+bckgKphFzdOcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOoiKt80Qz1yiEY3O2Kcama7//cxkl0TtxvTSncJUKJx//fy60H1HAllfTjKRew4L
         P17r/awIv1GuNBevQqBAvh07t8N5DnaJscD95RwVFJRFOFIuUJ6WkH3GUrCelk1tYL
         T39jLQ5xExltq6LZVmWjWG0g+TKW77CmUOHdDpDlLneMk4mcr7OA+dMtogwSyJhuB+
         +OerusRlehiUdw0zMuM160LyLaWnREpkFFijFMMA8nejoG12wCA8s3o2as7GfZq7/0
         BJwwrqsx23+e8ti5Zdu+ON6ehNL4z6zA+hwYlKQU30GJHdc/waHrDbKi+dgukZDY2z
         AUX+aCxMKooeA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB3-0004YH-6S; Tue, 05 Jul 2022 11:49:05 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 30/43] dt-bindings: phy: qcom,qmp-usb: clean up clock constraints
Date:   Tue,  5 Jul 2022 11:42:26 +0200
Message-Id: <20220705094239.17174-31-johan+linaro@kernel.org>
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

The USB PHY binding uses three or four clocks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
index 8343e24b669a..2f7043503ca0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb-phy.yaml
@@ -51,11 +51,11 @@ properties:
   ranges: true
 
   clocks:
-    minItems: 1
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    minItems: 1
+    minItems: 3
     maxItems: 4
 
   resets:
-- 
2.35.1

