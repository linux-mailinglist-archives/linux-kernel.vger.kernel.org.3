Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9748851D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiAHRzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:55:16 -0500
Received: from ixit.cz ([94.230.151.217]:51044 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbiAHRzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:55:15 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 394E52243C;
        Sat,  8 Jan 2022 18:55:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641664513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eoCjj7+HR4fQDUjIGrYwHS+tJEZ1XmSyNtZpViK/xe8=;
        b=BFTu8BDrU7JD3DMReUk9dA//MtPRZoKOgO2KtdAJ67qrUZvVQEjvmJzi0cfUktkzM/Wc3l
        mFZxe9yB+CKH7J1tMc0CI0hSXw5qWqwo/pAPjyrW7jeIJKzhJ7apsLH/TWYjEj0258GMxk
        WIgosjTDp1fOlElDhjInfRDTQKAzZMk=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: add KPSS GCC compatible to clock nodes
Date:   Sat,  8 Jan 2022 18:55:09 +0100
Message-Id: <20220108175509.62804-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of nodes missing additional compatible.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 25b0d35446c9..8d7ae3b41b3a 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -867,7 +867,7 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "syscon";
+			compatible	= "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 8b58f80093e8..13e0f6f1c376 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -150,7 +150,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "syscon";
+			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index b16060b65593..f144f76b4558 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -389,7 +389,7 @@ vibrator@4a {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible	= "syscon";
+			compatible	= "qcom,kpss-gcc", "syscon";
 			reg		= <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 5baa47d51fec..ea6156b35554 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -136,7 +136,7 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible	= "syscon";
+			compatible	= "qcom,kpss-gcc", "syscon";
 			reg		= <0x2011000 0x1000>;
 		};
 
-- 
2.34.1

