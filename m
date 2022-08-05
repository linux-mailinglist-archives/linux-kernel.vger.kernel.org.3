Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1FE58A8BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiHEJXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiHEJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:23:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866E78206;
        Fri,  5 Aug 2022 02:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1B3DCE299E;
        Fri,  5 Aug 2022 09:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBCDC43152;
        Fri,  5 Aug 2022 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659691400;
        bh=+jrbsnZp5g5cBhtVRPraJopq2jNO8OVSWOuAvexfeLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/ouyJvqUbiHSXDG0HOoHHd3m1yvVPWYPGk+sT2dmNu9lK17XcWI7rHwz0nFNDxMZ
         NkTTOzOL+jHZX0U7hPtWVU465wj1KtRNpE+qYJzibGAZoLTkTOFL0mQHQ1NPjrD0+x
         CQ75aT+yXo95tWi/F3ZeEXhb2YFF7fnyDSIiS+LY6oJtEXAO+y7KrI9aNoxg01p8xb
         E+3pJx2/CTDkFRmarU3Kcxp6oT/+ipYYkrfHxI0SudAHPweFvQR1WYyYwHz5cFw+/d
         9AtOm5yPYc6zVP5UprYwUA+Yj81JtQAyxB/HXxctDKD5J6+L0FhL8a7Gcs9UnXKZMk
         tOSivNbh+yyBA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJtYW-0001JR-9G; Fri, 05 Aug 2022 11:23:44 +0200
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
Subject: [PATCH 7/7] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate touchpad
Date:   Fri,  5 Aug 2022 11:23:17 +0200
Message-Id: <20220805092317.4985-8-johan+linaro@kernel.org>
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

Add support for the alternate (second-source) touchpad found on some
X13s laptops.

Note that alternate touchpad is kept disabled for now. The boot firmware
should determine which device is actually populated and enable only the
corresponding node.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 1ca72f6ba55a..bdeb2d05aaa1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -211,6 +211,22 @@ &qup2_i2c5 {
 
 	status = "okay";
 
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+
+		hid-descr-addr = <0x1>;
+		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&vreg_misc_3p3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tpad_default>;
+
+		wakeup-source;
+
+		status = "disabled";
+	};
+
 	touchpad@2c {
 		compatible = "hid-over-i2c";
 		reg = <0x2c>;
-- 
2.35.1

