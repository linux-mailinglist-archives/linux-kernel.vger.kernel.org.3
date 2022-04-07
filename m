Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC54F7B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiDGJ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbiDGJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:29:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39115C85A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:27:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so4149814ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvjrnyli3QMelnewMZziigqajOZNR5QEHUsi4Mp0djY=;
        b=p3ULPi0cyERr1Dv8VmKELpnBQL2ebtWgryo2YH3BSV+Mrugzv3ntjAoxGg6bqVEL2b
         PTmJlzRGvWf1xHDsRyBrzptISXqbsn24BccoQEbLClGI21RqMmVJjTl1DydbyyCmp6ew
         s1GnXEOrLJ1iKPQyS/VfhzAZl4KHVR+3za3q09u4/f1TNntxdZfWr8lm+E330dGlCfha
         DFTCSHqkvCAYWKzh8U61GldznUdgmnhV6NupS5CJzxidX5o0J18askUIOG06ByIBxwph
         w34f9K3DzbpWdnmTOPv0G8RM0gKwTJ+6jXV63zPPjFOBl7mSo6S5YP5rry3jiulJW8zO
         AxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvjrnyli3QMelnewMZziigqajOZNR5QEHUsi4Mp0djY=;
        b=wBZWIcOt5CfulIiafNmi8KiDRI4sLLjaGi11vq5TalKrf1MZVBkJdW/t0XSu/QZTUr
         aEN53JoAt3tAkpDA/zAqQVll61nsgOqGShVLq2fEOnQ/jYWLjFG4KFSJ6cdV1xNgD4sV
         JFSuO3ARZ0HkuPeSjbeCQhiRfZhocLJu7+abU38PCYdH9mirSugGP5r7pmLMhxEO0pu3
         NC2o/WU+BEEmxzwG52fcRlyIsYrwKOpDZLWhLO0Re9Fxnh9SC1PhkDPBIjsvINl4bt/G
         OhVPaW9WbEKJW/Zf9vr9xpanvy0VOtmfTFxbCYvijFPPHpQ4wNnrRykLElsgQ+lxk/0c
         OuFg==
X-Gm-Message-State: AOAM531D3XLN+1C18CoQSm8tTUMM8Hue0vP/nrj4KcuYrOgtwnC2PRgC
        KzNEXmkZ8W2yOp5NJFHwdpUqBw==
X-Google-Smtp-Source: ABdhPJy/4Gx1gqe8CTqLfxNWBysJvQLIBo0Zs3aHFrJ4Lak2QmDQE4w3xnChxDtygXQx3u0BuTmdbA==
X-Received: by 2002:a17:907:3c81:b0:6e6:9387:3d74 with SMTP id gl1-20020a1709073c8100b006e693873d74mr12489705ejc.589.1649323652182;
        Thu, 07 Apr 2022 02:27:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm8649435edt.92.2022.04.07.02.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:27:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3 3/3] arm64: dts: qcom: sm8350: drop duplicated ref_clk in UFS
Date:   Thu,  7 Apr 2022 11:27:25 +0200
Message-Id: <20220407092725.232463-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407092725.232463-1-krzysztof.kozlowski@linaro.org>
References: <20220407092725.232463-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ref_clk clock in UFS node is already there with a <0 0> frequency, which
matches other DTSI files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 20f850b94158..e70687d6c2da 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1916,7 +1916,6 @@ ufs_mem_hc: ufshc@1d84000 {
 			iommus = <&apps_smmu 0xe0 0x0>;
 
 			clock-names =
-				"ref_clk",
 				"core_clk",
 				"bus_aggr_clk",
 				"iface_clk",
@@ -1926,7 +1925,6 @@ ufs_mem_hc: ufshc@1d84000 {
 				"rx_lane0_sync_clk",
 				"rx_lane1_sync_clk";
 			clocks =
-				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -1936,7 +1934,6 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table-hz =
-				<75000000 300000000>,
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-- 
2.32.0

