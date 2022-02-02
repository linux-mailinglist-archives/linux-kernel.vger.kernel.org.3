Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500F34A7A60
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347643AbiBBVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347615AbiBBVY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:57 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DBCC061772
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:31 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n32so395713pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgg1dp8iZIsd+ETCYJ0M68uoTZDyXRB08KQ/Cr5C+0g=;
        b=jJil91MNL66Di0WHLj5CZNOwHdFxsSluO5E2F76en2J92DKcCVE9eSiNnZTyJjBLJ2
         rqt1E3ICHhc1AnwXYaaCrT052qPsQFd8w5bHGHl/2hnDi/s7ktwW3J9yk20yObSyyaaw
         KaiWU5gzVtjMtFjcuE1EFyv0BqYV14X6UsDeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgg1dp8iZIsd+ETCYJ0M68uoTZDyXRB08KQ/Cr5C+0g=;
        b=SlR0adSKJuxGY8/w8pQp7C+pK/8X2rOwMqZMh391PetJJVDjbcuAKMIQVXgg1of1sF
         PH6IB9mKtxqSBIlhx8EhNAY+2jlC3SCuZymEUbSRXZXIP4pQMSWWQm0SsMBN3sFOKnuO
         psiBdXxzw4UvCaRns4068GaerkGrVkMo8auNoAL0uaaHJHwJ4JaxbHzgu+B3kDc2e+Nr
         VNo/GuG+N5C3jsFzUra9AaU59BsElOAWrOoxIPDwjDxIVbU2EDIRk04NARptvQsQ3lj6
         AWGND5q8QsGWcE620tgiSmzdQLYblD/+70u6zxSpnNtCiQhCGugmqNCyEbvYjNposXQP
         vOpQ==
X-Gm-Message-State: AOAM533tp26vt1+8de/vRxvoQqgKdex8TnHZjGcjPsfjnRFnhUlL21xA
        xu2sRjL4vxOrSVmN/0MoVwiIWw==
X-Google-Smtp-Source: ABdhPJw4qyyEfRlRvLGjf9dyeGJMDo9ZYtO0cDt9GMuJ6Cyv7WVK/16uYQ73EEBPLrg91h0K/xFs6g==
X-Received: by 2002:a05:6a00:179d:: with SMTP id s29mr520866pfg.16.1643837071050;
        Wed, 02 Feb 2022 13:24:31 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f1c4:10b6:b4ef:16e5])
        by smtp.gmail.com with ESMTPSA id on9sm7627983pjb.16.2022.02.02.13.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:24:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] arm64: dts: qcom: sc7280: Remove "qcom,sc7280" from top-level of boards
Date:   Wed,  2 Feb 2022 13:23:48 -0800
Message-Id: <20220202132301.v3.14.I4ebe7533f00324213d224efc7267ebd16fd6f253@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202212348.1391534-1-dianders@chromium.org>
References: <20220202212348.1391534-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a proposal to take the SoC name out of the top-level
compatible and move it under the "soc@0" node. Building on the patch
("arm64: dts: qcom: sc7280: Add the CPU compatible to the soc@0
node"), which added this to the soc@0 node, this removes it from the
top-level node.

NOTE: while the previous patch could land at any time without any
compatibility issues, this patch will cause problems without a code
change to the cpufreq driver [1].

[1] https://lore.kernel.org/r/CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not for commiting right now since we'd need the corresponding code
change.

Changes in v3:
- ("Remove "qcom,sc7280" from top-level") patch new for v3.

 arch/arm64/boot/dts/qcom/sc7280-crd.dts                    | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts                    | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts                   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdde53a3..f02cda91675c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform";
-	compatible = "qcom,sc7280-crd", "google,hoglin", "qcom,sc7280";
+	compatible = "qcom,sc7280-crd", "google,hoglin";
 
 	aliases {
 		serial0 = &uart5;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index f7d4adeae90c..c40ccb1dc429 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -25,7 +25,7 @@
 
 / {
 	model = "Google Herobrine (rev0)";
-	compatible = "google,herobrine-rev0", "qcom,sc7280";
+	compatible = "google,herobrine-rev0";
 };
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index f95273052da0..8d993bba4389 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "Google Herobrine (rev1+)";
-	compatible = "google,herobrine", "qcom,sc7280";
+	compatible = "google,herobrine";
 };
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index a7be133a782f..7f3c8189555e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
-	compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
+	compatible = "qcom,sc7280-idp", "google,senor";
 
 	aliases {
 		serial0 = &uart5;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 73b9911dd802..004925fd896e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 IDP SKU2 platform";
-	compatible = "qcom,sc7280-idp2", "google,piglin", "qcom,sc7280";
+	compatible = "qcom,sc7280-idp2", "google,piglin";
 
 	aliases {
 		serial0 = &uart5;
-- 
2.35.0.rc2.247.g8bbb082509-goog

