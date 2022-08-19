Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382BA5994AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiHSFkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345612AbiHSFkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:40:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183A2DCFC6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:40:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a22so3449593pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=EU0Xpdjq4gzaluDqvt8ZL9f0MKE2Ug7x6hJlEuzy25o=;
        b=q4TKVBG83qbSyPTszbB4aqGThUjTg4VCA8TG0lifPnwmoeJpzmxN02EwXm/URAULnX
         685FFTeli+9sePzO5uMNh1f8wEFs3bL9Bf13qixko8qkfhquVwaVe0/d8eb9Umgl35iL
         EMJEzUhrfm3UPBZfAoe/lT6g56rL8ukKYEXMnxcUsqKI+7Ncpdg5FHtsruV9ljflQ9Wp
         nvKw/ZpOcuQ6Tzd6O5wGBopJIfqgteoukXz9wXIYb0Sg7kZyKj1+tK2Koy2vAzXcz4vK
         CeTvEErv+s9rg/1EhdEkvCadezhC0zPjptVivPdutRDd6sDCQOLMcByIWqBbRx2fDS6i
         +v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=EU0Xpdjq4gzaluDqvt8ZL9f0MKE2Ug7x6hJlEuzy25o=;
        b=ri7roveVbT/d3PEWElBz8s8f8OROwu2SBJbaxPqS6QVWlE4tN3+gGu8anQRMuDM7+m
         oRP27fP/9QsfiTbqEhd8C/KT47hT+myATo9rOK+RHExo1WAJQ5x5EXOitiCqXeyqkxv6
         Gsg96iWJz/z9oMWrYA4rwC0jc3TLrO3vUkh+55umcJ4SsS/xyFmtFcvQHDHGA6dy9BiV
         4rJSR0cRKY4q6h0FdeZy+Cgh1RaUXNdZ2PheF0XbnV1TA8zDLB//xuSI7wkpOReDoVXn
         0AVWzgV9Zaw1voXaPqJA8XQILg5nePXVOhi9jSp8BMTtkCg4xOOpGe2jZkBRC8J9gTr4
         K7+w==
X-Gm-Message-State: ACgBeo3WUH98EvMzcR3fBVSQJOTyIcVP+yVzhQ8A9LNzoMKXmc60LNLw
        tk+sM0nOzK489TQJGmrNwOttAkvNW2ZboQ==
X-Google-Smtp-Source: AA6agR5rqHkJsevaWHqGKd15w/iKH002kBpV1qP/T8uNcF71eJMIX1DT1/jdedfMtw2NS/LvYRmcFg==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr6224068pfu.18.1660887601337;
        Thu, 18 Aug 2022 22:40:01 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:9cc1:8f6b:abdb:fb8f:1a1b])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b0053617cbe2d2sm233429pfj.168.2022.08.18.22.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:40:00 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: Fix sm8150 fastrpc node - use correct iommu values
Date:   Fri, 19 Aug 2022 11:09:45 +0530
Message-Id: <20220819053945.4114430-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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

Fix the 'memory access' relaetd crash seen while running Hexagon
SDK example applications on the cdsp dsp available on sm8150 SoC
based boards:

  qcom_q6v5_pas 8300000.remoteproc: fatal error received:
    EX:kernel:0x0:frpck_0_0:0xf5:PC=0xc020ceb0

This crash is caused by incorrect IOMMU SID values being used
in the fastrpc node.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 7d509ecd44da..916f12b799b7 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3394,57 +3394,49 @@ fastrpc {
 					compute-cb@1 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <1>;
-						iommus = <&apps_smmu 0x1401 0x2040>,
-							 <&apps_smmu 0x1421 0x0>,
-							 <&apps_smmu 0x2001 0x420>,
-							 <&apps_smmu 0x2041 0x0>;
+						iommus = <&apps_smmu 0x1001 0x0460>;
 					};
 
 					compute-cb@2 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <2>;
-						iommus = <&apps_smmu 0x2 0x3440>,
-							 <&apps_smmu 0x22 0x3400>;
+						iommus = <&apps_smmu 0x1002 0x0460>;
 					};
 
 					compute-cb@3 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <3>;
-						iommus = <&apps_smmu 0x3 0x3440>,
-							 <&apps_smmu 0x1423 0x0>,
-							 <&apps_smmu 0x2023 0x0>;
+						iommus = <&apps_smmu 0x1003 0x0460>;
 					};
 
 					compute-cb@4 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <4>;
-						iommus = <&apps_smmu 0x4 0x3440>,
-							 <&apps_smmu 0x24 0x3400>;
+						iommus = <&apps_smmu 0x1004 0x0460>;
 					};
 
 					compute-cb@5 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <5>;
-						iommus = <&apps_smmu 0x5 0x3440>,
-							 <&apps_smmu 0x25 0x3400>;
+						iommus = <&apps_smmu 0x1005 0x0460>;
 					};
 
 					compute-cb@6 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <6>;
-						iommus = <&apps_smmu 0x6 0x3460>;
+						iommus = <&apps_smmu 0x1006 0x0460>;
 					};
 
 					compute-cb@7 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <7>;
-						iommus = <&apps_smmu 0x7 0x3460>;
+						iommus = <&apps_smmu 0x1007 0x0460>;
 					};
 
 					compute-cb@8 {
 						compatible = "qcom,fastrpc-compute-cb";
 						reg = <8>;
-						iommus = <&apps_smmu 0x8 0x3460>;
+						iommus = <&apps_smmu 0x1008 0x0460>;
 					};
 
 					/* note: secure cb9 in downstream */
-- 
2.35.3

