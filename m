Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356D75669F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGELlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiGELk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4EB140B6;
        Tue,  5 Jul 2022 04:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8475E6146B;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62377C341D1;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=mjxgl4rw9ggFIkwq3+nZ4cvTPFPaWX7xtaE5VM/7aNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qv3KDCVIE8BmoS6JdSd9QZyinU3sMUVvgX7QILhmiHufqGaAX5tquIZ3JFmeS+vdk
         oxkQ8ppJF7xjBp5OD1w5QWv/YbVpLB60Wkzp0qCMDEo29BM+7pSe34MMl5RWYXz5Qg
         PGGYBt+s8h69Vf+/zbkkf3fWX7hqg78+C2ii3IN3dOFTMH1oKTlCR3GX8JjWgKjwr5
         8j3VD/cqDPXrhXgoaXq8LQQLekfi7Q/fJWEyNeeXMKEj3IZkATJvXy1YNu8kknVaj7
         WvpMtCTtLVdZWTgP+8SdsiNrl/WZlywot9/il1eQOCIZE1Yc+p7Xqkqpb7gi/P7Wkj
         qGHKlPmmDWnXQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xc-Fe; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 05/14] arm64: dts: qcom: msm8996: drop USB PHY clock index
Date:   Tue,  5 Jul 2022 13:40:23 +0200
Message-Id: <20220705114032.22787-6-johan+linaro@kernel.org>
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9932186f7ceb..34fd0c68b6e8 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2769,7 +2769,7 @@ ssusb_phy_0: phy@7410200 {
 				      <0x07410600 0x1a8>;
 				#phy-cells = <0>;
 
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clock-output-names = "usb3_phy_pipe_clk_src";
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
-- 
2.35.1

