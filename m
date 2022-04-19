Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D2507B92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357882AbiDSVBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355145AbiDSVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:01:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4AB4132B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:59:06 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so3016182pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ETDPx0UexpMdL4JaVIwnmwwSk5TOGi0t/0oH1NiIks=;
        b=Ou72ds/PMkguxSaaJuyaAXO8qfYGBAYEYhCOCdACo3QLflSWruXiHjOAkIaao9zrsk
         dARfC65+kt2tPxLzjE/Gj5e7Lgp8atpyoQpNmsmH2fPep0VttZ17xq5vzeLb61l/7LUP
         50J5HMFLSO52Dsyw4lcVLLpbBFyC5gSRh5bdDyFzDI/g51tchX7BCvi4qk/zKi6Y5bOD
         kFaIGQRyYSePyCrdUTbYiXmfu7IOx8+hc0WDB00U2dXMpmyANPsPnoTGQrtIbi9kzdfh
         NMo109iMrH4Av/PBJdb2ju0JRz7plh+VoWT4L1IxA52bueKTZQdQeGDpng325Zz1Y+AP
         WjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ETDPx0UexpMdL4JaVIwnmwwSk5TOGi0t/0oH1NiIks=;
        b=LNvcb8ej2ImkYDbvp8r4+ah6OkuIqb2fW4hxB7lTGwByZi8+HFREipR5kjhxApR+Jc
         JFIh7K6wQqGqos6i2Poep6sYHxpeSWRJB8JnWuAhYlMIUfZU9GFo/ITZ7RShxsptYBWt
         veYxdl7dn1TKuu9NMSZ0to7pLOqOFt21IewZTDvDxXcGFd/qQbWmzIXMZgOrWY0Lja0O
         pZdEvMmUTjZrOTJ1nqI5mnD6oTK6dq8oMoxUa+WHj3oisHATOVMgGjO3gNlnL1xhCn5u
         pJJq/APAsZDKTRgV+jdPhbX70hOAFsg9tC909sYxrp8XfBDaIN5GnIdXlhQbjoCJ3c8u
         IFYg==
X-Gm-Message-State: AOAM5320Ex6tHZbS7iHc/unqcLXmQGi79DiGCilBdoIxDHHv48iIrQ8s
        QLubVRH5sQ9ANWCfJyPBBN/e6w==
X-Google-Smtp-Source: ABdhPJxjpKJo7gVFsLStPnTDzbXVPLwFGFvz90IgUgstbZsBWFBckrDw6TwgH8hIkp7aUjaR3SsXaA==
X-Received: by 2002:a17:90a:db16:b0:1cb:9ba8:5707 with SMTP id g22-20020a17090adb1600b001cb9ba85707mr551671pjv.32.1650401945806;
        Tue, 19 Apr 2022 13:59:05 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm17215938pfh.46.2022.04.19.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:59:05 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v2 1/1] arm64: dts: qcom: sm8350-sagami: usb qmp phy node - add 'vdda-pll-supply' & 'vdda-phy-supply'
Date:   Wed, 20 Apr 2022 02:28:54 +0530
Message-Id: <20220419205854.1269922-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Bjorn during review of [1], the 'vdda-pll-supply' &
'vdda-phy-supply' supplies denote the power for the bus and the
clock of the usb qmp phy and are used by the qcom qmp phy driver.

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
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
Changes since v1:
-----------------
- v1 can be found here: https://www.spinics.net/lists/linux-arm-msm/msg108467.html
- Fixed the commit message to read usb qmp phy instead of ufs phy (which
  was introduced erroraneously in the commit log).

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

