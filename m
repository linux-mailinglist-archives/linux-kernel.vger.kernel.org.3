Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108604AC840
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbiBGSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbiBGSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:00:19 -0500
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 10:00:16 PST
Received: from fwd1.porkbun.com (fwd1.porkbun.com [52.10.174.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED9C0401D9;
        Mon,  7 Feb 2022 10:00:16 -0800 (PST)
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id E276741D09; Mon,  7 Feb 2022 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644256477;
        bh=WgWSC1IOBKQNEaPKc/yuujz/f2ZwdXMi8BgaxzlEwSc=;
        h=From:To:Cc:Subject:Date;
        b=bZkiW7qxwSd1k0xDaVddX2Tk+1rI1P9NjCWXzvxS8z2g/f3lS5lCO3TOJ+9QtIKBN
         kcwqYqWWTurFN2sOUNKYbldSCYZrRbTh5mxGeEVPOMLIHMqTrG5IfGibqvkkddsBKm
         YVNto8jd+Qaqk4f6y/3A2p0rqd6qo8GU5VmXBMSc=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from rayyan-pc.broadband (unknown [90.242.138.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id 91D7B43726;
        Mon,  7 Feb 2022 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1644256189;
        bh=WgWSC1IOBKQNEaPKc/yuujz/f2ZwdXMi8BgaxzlEwSc=;
        h=From:To:Cc:Subject:Date;
        b=J14q/+x9mBBTBYPjjvrMpK/SRO55KDxwG+mHiLf7IBPB1URuD9fc3rQdFKSXGcbSx
         7XIkIX18mC4m2VLDQ3AsgjOLxBVgBZ+Vn3v8xvuNtNfnUAfgLj7Q63+/Twn7KYd8os
         MHmO4hCdmqvkA3+Kt1+/twuN6B4aeiqkhsxuEZ5I=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: pm8226: Add VADC node
Date:   Mon,  7 Feb 2022 17:49:33 +0000
Message-Id: <20220207174933.20909-1-rayyan@ansari.sh>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the voltage ADC (VADC) found in PM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index b3d0f7b5874d..a651b4c941b8 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -40,6 +40,39 @@ smbb: charger@1000 {
 			chg_otg: otg-vbus { };
 		};
 
+		pm8226_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			adc-chan@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+			adc-chan@8 {
+				reg = <VADC_DIE_TEMP>;
+				label = "die_temp";
+			};
+			adc-chan@9 {
+				reg = <VADC_REF_625MV>;
+				label = "ref_625mv";
+			};
+			adc-chan@a {
+				reg = <VADC_REF_1250MV>;
+				label = "ref_1250mv";
+			};
+			adc-chan@e {
+				reg = <VADC_GND_REF>;
+			};
+			adc-chan@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+
 		pm8226_mpps: mpps@a000 {
 			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
 			reg = <0xa000>;
-- 
2.34.1

