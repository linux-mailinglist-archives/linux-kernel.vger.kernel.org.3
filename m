Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9771C58A8B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiHEJX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiHEJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3978206;
        Fri,  5 Aug 2022 02:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC9EB827EA;
        Fri,  5 Aug 2022 09:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF3C4314A;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=XVTrUBrv0fIUcd2JC3KYyO5kRWwJUrH30DUHjZKyJ2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Het0nAq/GqKS7BGad66e2VmsCXXtEUlgtjUDm6WviBSwD9AT0JfXb0m7mm4k1UpFN
         d92VSQ70ueI5PJbyfYVMveHL7FRoWNoIcBHpRAFBsE1nHfSGHZjJdxo/L/qj22J35m
         WyoOTQbpG5EDyOYyiQX88lUnrXbYnQBWF3pcZ1hDfehoYzTXVSb45SfC8JIS9F5UJz
         Q8jEr/AHoAAOTWpentMWperevQtUs3iZQdLuWSDy6Vqx/U5jEjob52Ims5pudZWWAC
         y56Mm170F7pE1kq7qZ4Gn6K73S+3YsRTmcLtuVWVaMC9NFNPEN+606wQKcbMjB5tPD
         gu1dOl340T0gA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYW-0001JL-2m; Fri, 05 Aug 2022 11:23:44 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: move HID pin config
Date:   Fri,  5 Aug 2022 11:23:15 +0200
Message-Id: <20220805092317.4985-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805092317.4985-1-johan+linaro@kernel.org>
References: <20220805092317.4985-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HID pin configurations belong in the HID nodes rather than i2c bus
node.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 85efce641a4e..76ba2d5fa17e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -177,7 +177,7 @@ &qup0_i2c4 {
 	clock-frequency = <400000>;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
+	pinctrl-0 = <&qup0_i2c4_default>;
 
 	status = "okay";
 
@@ -185,9 +185,13 @@ &qup0_i2c4 {
 	touchscreen@10 {
 		compatible = "hid-over-i2c";
 		reg = <0x10>;
+
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts0_default>;
 	};
 };
 
@@ -203,24 +207,32 @@ &qup2_i2c5 {
 	clock-frequency = <400000>;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
+	pinctrl-0 = <&qup2_i2c5_default>;
 
 	status = "okay";
 
 	touchpad@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
+
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
 	};
 
 	keyboard@68 {
 		compatible = "hid-over-i2c";
 		reg = <0x68>;
+
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&kybd_default>;
 	};
 };
 
-- 
2.35.1

