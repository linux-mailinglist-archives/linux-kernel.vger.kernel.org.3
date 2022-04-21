Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025E509F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382244AbiDUL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378690AbiDUL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AC252B2;
        Thu, 21 Apr 2022 04:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8960661BEF;
        Thu, 21 Apr 2022 11:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65614C385AB;
        Thu, 21 Apr 2022 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650542141;
        bh=PByTpc0kanYHEF51ZVObewQsG4VYGCa8G5OAuwNtMrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5ekYDKCCERsTj+Vt3BgkJiHuVAJDBTb97VPGRbKdnpD/jVK3a8CWktXNXXJkE3u6
         GBygem+jxhYFsR87/iEddNMA1BDPkljWarbo7xupNAAbrAgcmge98fN6i4YIOz6tii
         hfIJjOLMnEIRf3k3Le0QcKE7Xw4QjaOv8+B5j+Zl8fWvUktSHJr9tA4d6TcgKcVm0G
         CT6veMnK/JUoI+CEKCpJM5rNLGlhSQrdMXbXUqkgIME/oHvtgd9kdIxp5DYfwdomDY
         le0q9uxFxSIuiH2VbirGk1jyyHeuMaDEnoHwlR+Uogv1zEqTIzxtxcbqI0V1EfwioZ
         RA2iyalIx3ASQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sc7280-idp: Enable GPI DMAs
Date:   Thu, 21 Apr 2022 17:25:26 +0530
Message-Id: <20220421115526.1828659-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220421115526.1828659-1-vkoul@kernel.org>
References: <20220421115526.1828659-1-vkoul@kernel.org>
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

Some versions of the firmware for the sc7280-idp  board FIFO mode
disabled and must thus use GPI DMA. Enable gpi_dma0 and gpi_dma1 to
allow this.

Co-developed-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b89d896..00f7ef197be7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -233,6 +233,14 @@ vreg_bob: bob {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &ipa {
 	status = "okay";
 	modem-init;
-- 
2.34.1

