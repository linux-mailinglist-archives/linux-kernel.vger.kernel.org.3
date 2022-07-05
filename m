Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7F5669F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiGELla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGELlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384A167D8;
        Tue,  5 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EE56B81676;
        Tue,  5 Jul 2022 11:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C457C341D2;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=/9XHZo8XHWmW1t+jSkDjHLDjP8E6+1rCI6KFMxMPUw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKWbgwm9VdjI6c176XANaOgqurZgaYKt82B1aQZO4Sic0cWlP/D6k5F97aIfBHgj7
         p3wcuDE+lLJtDIs7HrMXftx5kkDrQwtDPdEUdvrjEKwmVltlU9h9CFWkR/Uwfwwpz8
         UKRQRfIGMK8YCuqFjPRYD8A/WwzkoYhLTL/LEvYBXUk9tSHCv0d6STogAE1QGLW7Na
         Bl10Vz3eVknloLkWLgAd44f/nXI5evyPZ3pzndcOiRWPr2x9cNe/F81D9vrri/dtt4
         Si1nU8as3+Spn2JFm9FWVBfeFx8d+y94FGBFslrbjPryI5xDlWFOsOteHyW1Z4oEUR
         k2mW52p7FNdDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xf-IB; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/14] arm64: dts: qcom: msm8998: drop USB PHY clock index
Date:   Tue,  5 Jul 2022 13:40:24 +0200
Message-Id: <20220705114032.22787-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
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

The QMP USB PHY provides a single clock so drop the redundant clock
index.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 758c45bbbe78..2511e70d66ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2080,7 +2080,7 @@ usb1_ssphy: phy@c010200 {
 				      <0xc010600 0x128>,
 				      <0xc010800 0x200>;
 				#phy-cells = <0>;
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
-- 
2.35.1

