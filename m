Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497D56B383
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiGHH0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiGHH0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF9A1B6;
        Fri,  8 Jul 2022 00:26:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A176F62570;
        Fri,  8 Jul 2022 07:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09013C341C0;
        Fri,  8 Jul 2022 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657265160;
        bh=HgjugEAjKnXuiWUzDEFoDZIQxIti3cWoD34a5DDDhRc=;
        h=From:To:Cc:Subject:Date:From;
        b=m1vanb1pyvTZm2lekW6U9uNKmjaXe0kzYg9evNz4yhX0XCNQ3NgeU29Gu5OLHkLvf
         xjCWYvorx1gO+lBtH5p0xSOuysRLpCFr9vxi6Myx8+ABCuuImANgpK+joXw1VSlFaW
         q7iywrjmB84km7YVfBmhcAAESLH3XjIzykdKOxdqG/S6dv5Yr/RxJHsrqBOUFKovNX
         OXQJ64gxQPOmUg+g7PZTapzsr9FOcolGJhS41OV8x/KzbX4e+Axl/1mToCKNfz4WVk
         Zw9xNeW/Qedu5loEoOrD+JAwxiVcCDU+gqzN/4mz06gIWQ2shHHNzTPYYoV9idlzWS
         UaGWoRJk/NpDw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o9iNG-0001Dm-OJ; Fri, 08 Jul 2022 09:26:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix DP PHY node unit addresses
Date:   Fri,  8 Jul 2022 09:25:56 +0200
Message-Id: <20220708072556.4687-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Fix up the DP PHY node which had the wrong unit address.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 9de6dedb102f..3542bcc34080 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1252,7 +1252,7 @@ usb_1_ssphy: usb3-phy@8903400 {
 				clock-output-names = "usb1_phy_pipe_clk_src";
 			};
 
-			usb_1_dpphy: dp-phy@88ed200 {
+			usb_1_dpphy: dp-phy@8904200 {
 				reg = <0 0x08904200 0 0x200>,
 				      <0 0x08904400 0 0x200>,
 				      <0 0x08904a00 0 0x200>,
-- 
2.35.1

