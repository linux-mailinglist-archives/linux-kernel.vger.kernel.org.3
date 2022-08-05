Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B458A8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiHEJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiHEJXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF978209;
        Fri,  5 Aug 2022 02:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9F75B82844;
        Fri,  5 Aug 2022 09:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E666C433B5;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691399;
        bh=DpARAXXarzdQ4KGx9KSj09JvLrXb5B+bMCaD9TXDhJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bp45lNAzAOs2DtycJYkTFkb5IemWQfaIpt2tgFJ2f780xgY3Hf/zDCbVa2WDyUJD4
         lCda3OSOX36VEn2FP1dtRhTfIRGPmpgu9OaZYTiC4b06r2Fh8QOgYt2fifOZPMHF3j
         Ze1NmAKcv8GR/KJig525gcK2Ix1CmUyfvFrxh0N3zSBjlz4GijPIgYAR+nNJvFrsJJ
         tRl4Hln3IoV4VZWGyceow22u+llRchff4ULk9r5HkgFz7PdRUXCtTBlu1xZa+QBlVc
         w0fZTKasvXQZG16ZHjtzta98IUQSpAEvLPCW83CrBo7GthIEmYmdJHUII8S5QH0XCc
         7Mtqnsu5gs4gQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYV-0001JD-Pe; Fri, 05 Aug 2022 11:23:43 +0200
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
Subject: [PATCH 2/7] arm64: dts: qcom: sc8280xp-crd: move HID pin config
Date:   Fri,  5 Aug 2022 11:23:12 +0200
Message-Id: <20220805092317.4985-3-johan+linaro@kernel.org>
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
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 47192e9cf7a4..ae8be1b743ce 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -194,16 +194,20 @@ &qup0_i2c4 {
 	clock-frequency = <400000>;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
+	pinctrl-0 = <&qup0_i2c4_default>;
 
 	status = "okay";
 
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
 
@@ -219,24 +223,32 @@ &qup2_i2c5 {
 	clock-frequency = <400000>;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
+	pinctrl-0 = <&qup2_i2c5_default>;
 
 	status = "okay";
 
 	touchpad@15 {
 		compatible = "hid-over-i2c";
 		reg = <0x15>;
+
 		hid-descr-addr = <0x1>;
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

