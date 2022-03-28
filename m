Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F424E99A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiC1OdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbiC1Ocw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617264507E;
        Mon, 28 Mar 2022 07:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B78AB81128;
        Mon, 28 Mar 2022 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE9DC34100;
        Mon, 28 Mar 2022 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477862;
        bh=//n+xEkhJPFZ3pDSmeYVZ+8oCvxqPp7Y/VAsuX6T7Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1QnMx4ho6mODSnFYKL4rdh0Z9lLg2WPpQ+dXzqM+VPJss6yBBqxHwAGf0GQK74d4
         gKj+uUO01acCOVk2+STqTKHbDY7bzzSwQuHiA93NwVuBDphlJCGXT/2nF+3umimHUU
         yMoVm8pyW621YGWBUo/1yPm14Zu+hJmii3UktotUfXUdbR+JMDnIjDTyfXf32ZYRSe
         tSm1VStef2FEWeYu6hkvlHhhel6g06em0+n2oOkjyAsu1oLoTdaH67wPpfSP2G4T3q
         fXPRpqlexzQhQDtZQgA1uezkya8F4g7p8MX4vtuXFf0sbDeECBj3NG7IudSKhcBi5T
         lR7PCJ+o5UNlw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: qcom: sm8250: remove address cells from dsi nodes
Date:   Mon, 28 Mar 2022 20:00:35 +0530
Message-Id: <20220328143035.519909-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328143035.519909-1-vkoul@kernel.org>
References: <20220328143035.519909-1-vkoul@kernel.org>
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

The child of dsi nodes do not have unit address, this causes warnings:

arch/arm64/boot/dts/qcom/sm8250.dtsi:3249.22-3301.6:
	Warning (avoid_unnecessary_addr_size): /soc@0/mdss@ae00000/dsi@ae94000:
	unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

arch/arm64/boot/dts/qcom/sm8250.dtsi:3322.22-3374.6:
	Warning (avoid_unnecessary_addr_size): /soc@0/mdss@ae00000/dsi@ae96000:
	unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

So remove #address-cells/#size-cells for dsi nodes.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fb94b342f2d1..a76089ebf9ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3275,9 +3275,6 @@ dsi0: dsi@ae94000 {
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -3348,9 +3345,6 @@ dsi1: dsi@ae96000 {
 
 				status = "disabled";
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.34.1

