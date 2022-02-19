Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3744BCA24
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiBSSpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:45:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiBSSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:45:18 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61588022B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:44:58 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6CBCC402E6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296297;
        bh=VdBW5eJ0KRtkG5qq7BggPOtnxfiLOHvvLGr1LQKWRHE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=akhBfwYWYcxaTuaVJKkLGa0KA3T6RpEbdSp92OoDFG4qoc66ejveVYBa31dmZRBa2
         eAoemDAOijwL3+NdNYwXWhecq+34woyqSsM8Z7guHtQGHsjt/Rmd0J22tUo2X7/qPi
         kf3Q+qkqqXGDuHC5KmoN9SlCl4c05p9OhJiZQPtqX2sihoug3BNa6UqXFa5vrSozqB
         aD+KK0Zmxg0PmmEbr0UCyCvg+uERg+7nk7g4uphXwa6Kg2OCeNxNeni3T6weeh5938
         9uY7+6KKiZWpUJNvq14ZR9e/KeINyI313zKMO/HBSCMZO3epjPjNRX4i38FA/BpTlc
         87ZqQU+OgFsnw==
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso7589068edh.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VdBW5eJ0KRtkG5qq7BggPOtnxfiLOHvvLGr1LQKWRHE=;
        b=ZXxLeP7wFALsUaM4gWbKYByyMnaCtYNK/vSNBv1CrgCCTq0eFtD5AwJFg7MZyVxXBx
         JWdFVP4bLW6ywzC0aWRc6ODfYPyzTgsYccGdKTtetmRTS44dm0zt7UTRLrI8wt838uUQ
         JcvaqRugbCTkMq/Qys+uKmGZ2P7/LLQmEpt7bGsgu+8sW85qFjh/5l95d65Z70Q+dYXr
         Ele3FqeG7CgMbOGBoTH8btLl/Nxn8X9rjXmGGeuwqFUyMZyXsB7aZimBqdFjB7SjyCuh
         YP8uOTlXIepr0R1zw2P7KYw7k9Rpkp/7X1QTPpVNvCHCFLh3+Y5pN9XBvbBLz8i+mQDs
         uqAg==
X-Gm-Message-State: AOAM533A+gQj7D5Ca9dKMTsaFnFc/fdZKPQZsm4+bpTY0giOQx2kZJKS
        KF8LyaUROk8MbkQvL6pT1W27/flbmKfNr8INq2Og9ayd2gmGe8bU8KUrb/3MbK+VdKmP+uoJUXJ
        +r0rPHRxpSgOb7mG3Pcz6tqog6P8afEBgfrUWzmWn6A==
X-Received: by 2002:a17:906:9bed:b0:6ce:6bbc:dc8b with SMTP id de45-20020a1709069bed00b006ce6bbcdc8bmr11003784ejc.428.1645296296749;
        Sat, 19 Feb 2022 10:44:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5eELNrX+BuAo2fm8/sdIZW7wyUGvlrGjYgJmeUvcZV4dLJloHpIRrlrSDF/y9czaR/IL1Hg==
X-Received: by 2002:a17:906:9bed:b0:6ce:6bbc:dc8b with SMTP id de45-20020a1709069bed00b006ce6bbcdc8bmr11003769ejc.428.1645296296564;
        Sat, 19 Feb 2022 10:44:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v24sm3417780ejf.7.2022.02.19.10.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:44:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 7/8] arm64: dts: qcom: use 'freq-table' in UFS node
Date:   Sat, 19 Feb 2022 19:44:52 +0100
Message-Id: <20220219184453.44689-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'freq-table-hz' property is deprecated by UFS bindings.
The uint32-array requires also element to be passed within one <> block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 23 +++++++++++------------
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 17 ++++++++---------
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 19 +++++++++----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 19 +++++++++----------
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 17 ++++++++---------
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 19 +++++++++----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 17 ++++++++---------
 7 files changed, 62 insertions(+), 69 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c85825ea1623..2d6ad6dfa0dd 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1761,18 +1761,17 @@ ufshc: ufshc@624000 {
 				<&rpmcc RPM_SMD_LN_BB_CLK>,
 				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
-			freq-table-hz =
-				<100000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<150000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			freq-table = <100000000 200000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0
+				      150000000 300000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0
+				      0 0>;
 
 			lanes-per-direction = <1>;
 			#reset-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2fda21e810c9..eee7bc35e468 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -990,15 +990,14 @@ ufshc: ufshc@1da4000 {
 				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			freq-table = <50000000 200000000
+				      0 0
+				      0 0
+				      37500000 150000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0>;
 
 			resets = <&gcc GCC_UFS_BCR>;
 			reset-names = "rst";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0d6286d27dd4..987730032c0b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2274,16 +2274,15 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 300000000>;
+			freq-table = <50000000 200000000
+				      0 0
+				      0 0
+				      37500000 150000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0
+				      0 300000000>;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d15fee495238..3c5acf07337d 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1782,16 +1782,15 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 300000000>;
+			freq-table = <37500000 300000000
+				      0 0
+				      0 0
+				      37500000 300000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0
+				      0 300000000>;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303ba047..308585cde3b0 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2133,15 +2133,14 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			freq-table = <37500000 300000000
+				      0 0
+				      0 0
+				      37500000 300000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0>;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d242bab69c2e..526a328a9b7e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1935,16 +1935,15 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<75000000 300000000>,
-				<75000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			freq-table = <75000000 300000000
+				      75000000 300000000
+				      0 0
+				      0 0
+				      75000000 300000000
+				      0 0
+				      0 0
+				      0 0
+				      0 0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 934e29b9e153..ed72dbdf3435 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1398,15 +1398,14 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<75000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>,
-				<75000000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+			freq-table = <75000000 300000000
+				      0 0
+				      0 0
+				      75000000 300000000
+				      75000000 300000000
+				      0 0
+				      0 0
+				      0 0>;
 			status = "disabled";
 		};
 
-- 
2.32.0

