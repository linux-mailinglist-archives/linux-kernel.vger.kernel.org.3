Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6345669D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiGELlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiGELk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:40:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF99167D8;
        Tue,  5 Jul 2022 04:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05B361616;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F2EC341CE;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=u8THKk4ajgBBs95c1HTSf/xYHDV++eZ0huzhIB4RiiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juW3U61kxlGnX2cm1PXP4iGP+vrw8nS3YG1frzvJOfrQu5HL9Ck+ztJmlOODoIu5f
         PQb/n3fx+4XamxSsApctYLqH5q28FaGtcC1+83jaNrcS30dUK0yBq6CWxx0jRKB6M1
         0PadT/nrG3xKQd+6IcVuSNxA8W9VHq3/7d85Aw0NONx5oUeFlr9Q26jVcfkCccyZ0t
         XALulk8xQZcfTvMG56mrrRHmiyBDIycc0yNICKgu2Zt/6HyhbAjD2mpaJTheqjNR6z
         uEfD1XlOLQNFmjeIjSPJ3cqaFb+sXrOZcn8f/PvN4Cx3QQo5EZX945OH10eAfKlS42
         XaHGRQu90Ei9A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xW-Ad; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/14] arm64: dts: qcom: ipq6018: drop USB PHY clock index
Date:   Tue,  5 Jul 2022 13:40:21 +0200
Message-Id: <20220705114032.22787-4-johan+linaro@kernel.org>
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
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index c89499e366d3..ef1c5caacad0 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -710,7 +710,7 @@ usb0_ssphy: phy@78200 {
 				      <0x0 0x00078800 0x0 0x1F8>, /* PCS */
 				      <0x0 0x00078600 0x0 0x044>; /* PCS misc */
 				#phy-cells = <0>;
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB0_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "gcc_usb0_pipe_clk_src";
-- 
2.35.1

