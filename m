Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140EF500D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiDNMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbiDNMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:32:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F0B275E3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:29:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so4964494pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xt0D8PdwDkcpebCcx1HPl0Q4KbEoC2UsIEHF3n/1xF4=;
        b=U1i+AZ4UoiBlr7K35aX5pVCHCozsIYfNUDRqlBviSF968nyqNPfIuFDpVIxJ2WgTcr
         XuxTVHG6CRpn6Ohx4H1ey7/dMkNxDQdokmIRFa4vA3l2jurPR8bMf7mgB8+w9mjFULhr
         6jI4Crw6aKfweg+qwbrtkYbCn1wySV58/cjfKbLQ2txc0U2bKT6c6y4mNJBPvlVPcrc7
         ukAkOu/qzEVbwK1LoaLmVN+3d3ezfVKl+92pcNSpE1to9UH+lWXFDn68OwceOUCRBvNY
         HTJlN3rHRsDu+7+1VP8unpjHzx2lYF+/5Z0BfX58ZPLvL4KMawf+35vUrhB9BW5Yjrgq
         d8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xt0D8PdwDkcpebCcx1HPl0Q4KbEoC2UsIEHF3n/1xF4=;
        b=7wrOvJ9mjhg+GOd1VJM5pu0aGol2xZj9uPIwnmpsW3Ms1U45156d7+a1J8bRtgH0hZ
         JMlOxPP1d/QncwXJqg7FgxBISDPS/EmLwQjUJhbBCOWU2DZ+RJTWIfPWZ3/TAW698nlZ
         IdiUHc4NzanlTv3yoBzFjLCwI0Z+SsaoouWk2fZdRXAORLNvngebBpKbFqACS/0JhP7R
         mMhdEOFQR5a+esYtXH4CRuPL6nEGoHEwHzaZ6I4HxhdyH1hRQNuINJ6UH/BLj+26Rtyd
         +jVlBUiUFyAfGCgvdGOY6KcVE2Dik4Q1mlmJ07iTwP6tqez/Ft8xfagb0cD9fqjKFbqe
         fYQA==
X-Gm-Message-State: AOAM532OaO5tSli5fZC+8yuI1uPdbwk7rsXO3C5Xi62d8x9Di4NVHgTU
        oA9bxZRNFv9i6FT6y06mH9Nhgg==
X-Google-Smtp-Source: ABdhPJz7HIQYNtub3MkdZQX3FLU8Pitga8GUCfvfRLFDPiIUuBHzZVlCQXa4D4Rw4haSCcZ+awqAoQ==
X-Received: by 2002:a17:90a:e7c8:b0:1cb:a81b:19a1 with SMTP id kb8-20020a17090ae7c800b001cba81b19a1mr3474635pjb.25.1649939383666;
        Thu, 14 Apr 2022 05:29:43 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001ce18c551dcsm1681894pjb.19.2022.04.14.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:29:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/1] arm64: dts: qcom: sm8350-sagami: UFS phy - add 'vdda-pll-supply' & 'vdda-phy-supply'
Date:   Thu, 14 Apr 2022 17:59:28 +0530
Message-Id: <20220414122928.349126-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Bjorn during review of [1], the vdda-pll-supply' &
'vdda-phy-supply' supplies denote the power for the bus and the
clock of the UFS PHY.

For pdx215 to have a functional UFS, these two supplies seem mandatory.
So, its safe to assume that the two regulators are the same as on
the MTP. So let's wire them up in the same way as the MTP.

In absence of the same 'make dtbs_check' leads to following warnings:

arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
 phy-wrapper@88e9000: 'vdda-phy-supply' is a required property

arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx215.dt.yaml:
 phy-wrapper@88e9000: 'vdda-pll-supply' is a required property

[1]. https://lore.kernel.org/lkml/20220228123019.382037-9-bhupesh.sharma@linaro.org/

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: konrad.dybcio@somainline.org
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index 90b13cbe2fa6..238ac9380ca2 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
  */
 
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8350.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
@@ -75,6 +76,27 @@ ramoops@ffc00000 {
 	};
 };
 
+&apps_rsc {
+	pm8350-rpmh-regulators {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vreg_l1b_0p88: ldo1 {
+			regulator-name = "vreg_l1b_0p88";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1208000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
 &adsp {
 	status = "okay";
 	firmware-name = "qcom/adsp.mbn";
@@ -256,4 +278,7 @@ &usb_1_hsphy {
 
 &usb_1_qmpphy {
 	status = "okay";
+
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p88>;
 };
-- 
2.35.1

