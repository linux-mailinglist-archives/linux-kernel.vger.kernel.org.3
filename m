Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A946149496A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359199AbiATI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbiATI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:28:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52386C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:28:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e8so4589567plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzTttx13ei9Jo9Pm3/hsfv4HCjAkodc9jMnwdUcQbE8=;
        b=jki9XfMQTNnNgiJnZD8GeYOLFcjgMnXibyXqByT3L3wiZn38BQh4b14dTMCze3NClX
         1S9+ma3sdubh87Vay23XsiwT1uGsKVkmkRvHCDHCMg0LRPPkXE2dEQspTwa/uZkXik1T
         YlBCySrS242zjWm/caK+HaMOX3gxyC0qmdAOJKlVhfIyHwqtblqQFLitJ0U00veMl4Iv
         29N8rLlZjMMK3MNgsvt3R4eVvbZ1pra/W64KkgJJ4/r5BSQYjVkx32BPnQFQCz83UZVr
         BHduUO+WjY2WbDIQ7gkmnbX0Fk0qScJJZDfQvlzLtzj2DqxXj2BszRGzDLHpgq9/7agQ
         4uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mzTttx13ei9Jo9Pm3/hsfv4HCjAkodc9jMnwdUcQbE8=;
        b=Kd+HJ4ZK7gogQnDDJIXXrzc63heNgnSck8+Hb2T09bR3bOLxI6BZUXx16I7wbfveiM
         vYX647FnvpSuv44PTXa/7Gh9M/A+lSEw69BmrIc3OC8mCAXDshfEsldsaeLMTtXaeHA3
         gN0NjfiL0XsGEq+dZoiNsqb5B5ry5HrlMhLCtaBCxre2hj30SUC5GI5wTtGxnCqEMwVH
         wCC423RwydDvNPBK9vUng3H6MGSp4/7dLBkwJn9WjzG5j+1GTa/MMOq1FkT4yvLT+5jo
         hK5wktVUPALFvcYYsJpWbM8l8m8Y75pQjqYUjqyp8+KL7T7jgcftDKJRLCWlpTpxoBp6
         k2Bw==
X-Gm-Message-State: AOAM531PYdrQbrDdGnEzwMgvoG1LFhuvGEP+SRcDMnYUshRX3Zbb4W0e
        8C+PU0EMhK1N/2UI7bEIxhUoGQ==
X-Google-Smtp-Source: ABdhPJx/AwYGnP1h2N1sy+WoR8VNSbBYfEY/nn3r4tTfvdJbDDWEwX03JhS+iqjJc1gnVT0BC6l/Zg==
X-Received: by 2002:a17:90b:3510:: with SMTP id ls16mr9236840pjb.229.1642667297725;
        Thu, 20 Jan 2022 00:28:17 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3a:47e5:8bff:a3f8:a494:acd0])
        by smtp.gmail.com with ESMTPSA id s17sm2263639pfk.174.2022.01.20.00.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 00:28:17 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sm8150: Add ufs power-domain entries
Date:   Thu, 20 Jan 2022 13:58:03 +0530
Message-Id: <20220120082803.15535-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power-domain entries for UFS controller & phy nodes
in sm8150 dts.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 6012322a5984..7aa879eb24d7 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1637,6 +1637,8 @@ ufs_mem_hc: ufshc@1d84000 {
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
 			resets = <&gcc GCC_UFS_PHY_BCR>;
 			reset-names = "rst";
 
@@ -1687,6 +1689,9 @@ ufs_mem_phy: phy@1d87000 {
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			power-domains = <&gcc UFS_CARD_GDSC>,
+					<&gcc UFS_PHY_GDSC>;
+			power-domain-names = "ufs_card_gdsc", "ufs_phy_gdsc";
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
 			status = "disabled";
-- 
2.34.1

