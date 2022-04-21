Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327650995F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385837AbiDUHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbiDUHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1FC10BE;
        Thu, 21 Apr 2022 00:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE37C61ABC;
        Thu, 21 Apr 2022 07:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E6AC385A1;
        Thu, 21 Apr 2022 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650526512;
        bh=iodwjoJYbXPmx/V6513BVUqEJ60wYeP08zRJ3UhqYuo=;
        h=From:To:Cc:Subject:Date:From;
        b=cxdRuyc6FKKbQ5sx++8H0dU+ckG/jI1H3qJI2ovV2IysiC8gvMIXAWnxRQoXH43PE
         sNtgrkPOju1iBu9tceFnu8Er4s33zYmmCL9FOqGLBF0OLMvtjOWD3+0jy/UJ5CbH2O
         k/+8sqlhAEfHmBf05TCexRJYNa4OJQ5nhkTJQLWPSFt0DvCM+lO8ou/2bGZryc/cxg
         l1xpri7y0ETETdt4tgpphCyqY2me6pHXetn7xFAMJ1jmDP+eioJi9sLjcwHZL6B1hY
         uE7RTNQPhdW7bdGJ/ilQ/mD8cl8HJGVIasBFo2T40k6EEUeKcx0x4+8EZs6VLBE77y
         u+vV4z8YyxZwA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] arm64: dts: qcom: qrb5165-rb5: Fix can-clock node name
Date:   Thu, 21 Apr 2022 13:05:02 +0530
Message-Id: <20220421073502.1824089-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per DT spec node names should not have underscores (_) in them, so
change can_clock to can-clock.

Fixes: 5c44c564e449 ("arm64: dts: qcom: qrb5165-rb5: Add support for MCP2518FD")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 845eb7a6bf92..0e63f707b911 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -29,7 +29,7 @@ chosen {
 	};
 
 	/* Fixed crystal oscillator dedicated to MCP2518FD */
-	clk40M: can_clock {
+	clk40M: can-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <40000000>;
-- 
2.34.1

