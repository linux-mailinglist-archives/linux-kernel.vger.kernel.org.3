Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F069D527DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiEPGce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbiEPGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:32:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7329800
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:32:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so13536958plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXhchf3VZKM2/quDawnPGLqCcD7r9Df6+XHBYX2DLsI=;
        b=er+husaPM6oUMR/bWv0fOcpxSi2F07vVoxYoQRvWEU20qdK+AHjaR824zZ4BBvjdz2
         9juGiROZhRQy45WF2Py9fdiQnSdtVUta1MELqb0a6ZzRpEyttkF4Dzj1C9EgrSH0sD4j
         Qarm+ZmBChiwCacKzgsCYqDpRrlbyNPBwQBgdp0qcSmDZ/qMs6CMQiTIhs9zME5YV2cz
         zdWgJzYVlei+u7i15OjihA4/RvkrR3RMu6BGx0ecJ8HY1cdvwYC23438yH9lSsTUJKz0
         AD0LuTP8wW6SPGQfZXJDP+bMEgFobLChWxDHqw1GiHIYKKLqNF5mrNIMNf+DFVIDkPhu
         rsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXhchf3VZKM2/quDawnPGLqCcD7r9Df6+XHBYX2DLsI=;
        b=tabaiI7eYJ8Ao9haIuSJZJHzccMS/YevDnHH7BfqRijxq2Wt6lCuX0Wle1h52XXjIW
         hqP+UzzVidMROU7stedDFH/A/4d0PfuqM3z3Jw9jpyaGRfvugazSOtTRPYZFdaB+KDZQ
         c5AsWW+1zan4PVLB5ICFbo3kWw8Gg1G283wZAWO6r737ItsjzYiCn9FG2QXoDr6T42L5
         HuE8jOqTIoj9BSLrS1v9pVlypuV1Rm5nXuII68n3X+mOFnjXAAj+Pv1yopN2jRMxGPzv
         zTSqEnMG5xsOlcXcSNAr6O3xXTKfNtFLqUE8M5yPNBgYa4coNyIELSpPqGpmaUUm1mr6
         q2Ow==
X-Gm-Message-State: AOAM533mEIEfJdG0daULtFxcU3ylc+rv1iKpKQu368KnUpCn4cdwb/25
        jBaaYU4f+l/5EauPOwzdbffxrg==
X-Google-Smtp-Source: ABdhPJw4tg2JjTIDpk5FTyBYQIZzrMbZuhGEPyGCIJmecDah5IQiCWbIKNXw1HQrXySzm9W2UOo0lg==
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id l5-20020a170903120500b0015e8cbcfd2bmr16225656plh.99.1652682744269;
        Sun, 15 May 2022 23:32:24 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b0015e8d4eb1e2sm6053647plb.44.2022.05.15.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 23:32:24 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
        konrad.dybcio@somainline.org
Subject: [PATCH v4 4/4] arm64: dts: qcom: Remove unused 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
Date:   Mon, 16 May 2022 12:01:55 +0530
Message-Id: <20220516063155.1332683-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516063155.1332683-1-bhupesh.sharma@linaro.org>
References: <20220516063155.1332683-1-bhupesh.sharma@linaro.org>
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

As Bjorn noted in [1], since the qmp phy driver doesn't
use the 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
currently, let's remove them from the dts files as well.

Otherwise, it leads to the following '$ make dtbs_check'
warning(s):

sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
  'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
   the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+

If later on the driver support is added, we can add these properties
back to the dts files.

[1]. https://lore.kernel.org/linux-arm-msm/YmQhpsmiYJzR99LK@ripper/

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts | 2 --
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 2 --
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts                    | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
index 9a6faa9393dc..9c4cfd995ff2 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-microsoft-surface-duo2.dts
@@ -336,9 +336,7 @@ &ufs_mem_phy {
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l5b_0p88>;
-	vdda-max-microamp = <91600>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
-	vdda-pll-max-microamp = <19000>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 4e51a9d6af98..38ccd44620d0 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -418,8 +418,6 @@ &ufs_mem_phy {
 
 	vdda-phy-supply = <&vreg_l5b_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
-	vdda-max-microamp = <173000>;
-	vdda-pll-max-microamp = <24900>;
 };
 
 &usb_1 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 236e53974fdd..e58fc7399799 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -424,8 +424,6 @@ &ufs_mem_phy {
 
 	vdda-phy-supply = <&vreg_l5b_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
-	vdda-max-microamp = <173000>;
-	vdda-pll-max-microamp = <24900>;
 };
 
 &usb_1 {
-- 
2.35.3

