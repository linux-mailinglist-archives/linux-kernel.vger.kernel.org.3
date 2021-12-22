Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4517D47D507
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbhLVQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbhLVQTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:19:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D3BC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:19:50 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bk14so4668923oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsMTQnn2hVgwCV9VL0XIlVRgqcd6Mo49QGleKB40N5s=;
        b=cQVNdfsOqPCgMRnpZ0vVEr7mTW/MTssqV1D9ipzpq53tZlNfHfiR2jQX9ATxWwO57B
         ug4flrFT5GFR7ZOAQRLcNl/p+vJ0bDvacacR+cpdbhiJUT7pwlpkjlZfWwKntvy3EzLo
         FlunzdW5Uibrs1BYdkHDJ3Q0Oa9xAlYMRywQUdJpETp98GWMz+StCV+72xm8D6+LaWDK
         uGApUA8b49e8Gm6ba4GjF+A9Y2YBVYcHAEIWrBhxT9Tpqtl41N6LXhsw0qUT9EiUBjs5
         BNLnOHdObbi53/3r3VkNSgik4FZCz/LtftdqvSJSvmxhlhHMZFLdnZykIUhGcIGgxxEh
         BH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KsMTQnn2hVgwCV9VL0XIlVRgqcd6Mo49QGleKB40N5s=;
        b=hoTuOXdFz6cFjnWZQ9SDeSjCCF4H6pEji40E1SYo/O3aA5PHy2FR1wI779uZBfdq+I
         +ESscGKfqcgoXZGgPgwWkV4s/hVjErDJ+X6hUbSBBI5Ppj63aeKk2+GYHO1ZDehFliJQ
         2foPyZFjTcQyv7rHAeGRIZImvOR/28xdoi6FwTk6dcGeuUHtg8mN3MzNbvyKeuT8Y9UL
         ueeReBmKP+Kqa7b6m7J3qMdCfQGM+CnGBwvj+LziyvVoQaiEQBAnVNn/xAcClf+pz4Xb
         LFxVjOkErPeNDF5ZDNGc43BEIxW9pvYPjvQsmCxmoAsCUB1+KClESAWcGHbX1QZXArK6
         wTCA==
X-Gm-Message-State: AOAM531ae3cv78a4vih/GsLNQWamLnG4uMbBF16RJgPNlt3ldlbpVTd/
        nKxVgS0Ki7WiKqxVLBP5MuEQYA==
X-Google-Smtp-Source: ABdhPJwPyqUJva4dUMwe/PvgCVq/e0xZr9cuEL+q1BiOzdSMfIV5QbD689pDIUyrxX1aZxfvwmMaqA==
X-Received: by 2002:a05:6808:a84:: with SMTP id q4mr1296759oij.28.1640189989523;
        Wed, 22 Dec 2021 08:19:49 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h1sm433376oog.26.2021.12.22.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 08:19:49 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
Date:   Wed, 22 Dec 2021 08:20:58 -0800
Message-Id: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
clock lookup")' broke UFS support on SM8350.

The cause for this is that the symbol clocks have a specified rate in
the "freq-table-hz" table in the UFS node, which causes the UFS code to
request a rate change, for which the "bi_tcxo" happens to provide the
closest rate.  Prior to the change in regmap-mux it was determined
(incorrectly) that no change was needed and everything worked.

The rates of 75 and 300MHz matches the documentation for the symbol
clocks, but we don't represent the parent clocks today. So let's mimic
the configuration found in other platforms, by omitting the rate for the
symbol clocks as well to avoid the rate change.

While at it also fill in the dummy symbol clocks that was dropped from
the GCC driver as it was upstreamed.

Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Updated commit message to clarify that the removed numbers are correct.

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index bc176c252bca..ceb064a83038 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -38,6 +38,24 @@ sleep_clk: sleep-clk {
 			clock-frequency = <32000>;
 			#clock-cells = <0>;
 		};
+
+		ufs_phy_rx_symbol_0_clk: ufs-phy-rx-symbol-0 {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			#clock-cells = <0>;
+		};
+
+		ufs_phy_rx_symbol_1_clk: ufs-phy-rx-symbol-1 {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			#clock-cells = <0>;
+		};
+
+		ufs_phy_tx_symbol_0_clk: ufs-phy-tx-symbol-0 {
+			compatible = "fixed-clock";
+			clock-frequency = <1000>;
+			#clock-cells = <0>;
+		};
 	};
 
 	cpus {
@@ -606,9 +624,9 @@ gcc: clock-controller@100000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
+				 <&ufs_phy_rx_symbol_0_clk>,
+				 <&ufs_phy_rx_symbol_1_clk>,
+				 <&ufs_phy_tx_symbol_0_clk>,
 				 <0>,
 				 <0>;
 		};
@@ -2079,8 +2097,8 @@ ufs_mem_hc: ufshc@1d84000 {
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-				<75000000 300000000>,
-				<75000000 300000000>;
+				<0 0>,
+				<0 0>;
 			status = "disabled";
 		};
 
-- 
2.33.1

