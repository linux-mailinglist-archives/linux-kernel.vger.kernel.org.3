Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4916749139E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbiARBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiARBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D0BC061748;
        Mon, 17 Jan 2022 17:38:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z22so72914704edd.12;
        Mon, 17 Jan 2022 17:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edJsOhrgm9HIZp5+3GRACpTuHG3K0zpTiYemM14Um+8=;
        b=lh9lQiHB10MMb62y6e3Ow/KepDFvQZRvtjy0t9qWGCeWPnauPjUY1lCO6nEiPmNORZ
         g1jR2kSOvtGYmuq3XUh9lCcMKmCw9mijHuagsNzn8YhytGOr/aBhfq+TDDbkRPVIZjAg
         /xwx4WOgqsfWC8tXdbq9IaRyHrmb+DCuXDNCuBQd6eSpARYY52WSJlD2fzU6spvLb9v7
         1n9mi7eyh+SCue43tA3sMa5E4X2GNc/OojTmj5o89L6NA4ZQKG1ps5XYsDv50+jrxdyI
         rMabTK1LrPnplSAzxVmX2dWyCVZCGdLSq/G5mFaN/DFtJUcXFiFze9BnrvYUhDXsVBbn
         PXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edJsOhrgm9HIZp5+3GRACpTuHG3K0zpTiYemM14Um+8=;
        b=CpSBNs7XKGUlaQQNog3ahmAelDvWo7pBZ+QyKzKzeSkPK1NU0mLfxrh7bKzmnVwI7i
         G8yHVaz1M+fZM/UvroZWuxxw8MpcIhdpkLoE2dqNSoeh6NqtE73KysOg4MdV/kTufjU8
         YN2pcYT2T3VXFI9NGp3eRuOSWK5gRBMqv+zLK+StdGMz7G6MZtKvAsrftLwKqKzoegrR
         2DOucKMtbKV5v10Za92l28ccZPN+3wNcc9r1p1DnjE9L4Dyp2GTdJCosy2MvE1zfZDM/
         v//an/AiMvbNrO/ubMMtkunAzhjAmpdhFIQnn17bzt8XV74/NSbFod6Yn4wqWsaPYrA0
         LSqw==
X-Gm-Message-State: AOAM531FRy+Gs8looiiTNHAk/VcwZHUiY4SOM2ExnnI8wwyiaX4Wuq+w
        ZWNeTMvmfexgFd2z1QltJNQd/f/jb4I=
X-Google-Smtp-Source: ABdhPJwXgdvRlmx9Y0lfJqv3JsQo384p8eFhmVaCkHC4Fx14HwEUM/Wu6OVDZvWLCCasuCI3WPdFxw==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr18458051eju.173.1642469897671;
        Mon, 17 Jan 2022 17:38:17 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:17 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 09/17] ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
Date:   Tue, 18 Jan 2022 02:20:39 +0100
Message-Id: <20220118012051.21691-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add saw compatible for l2 cache and kraitcc node for ipq8064 dtsi.
Also declare clock-output-names for acc0 and acc1.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 8c2d4dac0ebd..a45e4c799b27 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -504,11 +504,13 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -532,17 +534,23 @@ adm_dma: dma-controller@18300000 {
 		};
 
 		saw0: regulator@2089000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
 		saw1: regulator@2099000 {
-			compatible = "qcom,saw2";
+			compatible = "qcom,saw2", "qcom,apq8064-saw2-v1.1-cpu", "syscon";
 			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 			regulator;
 		};
 
+		saw_l2: regulator@02012000 {
+			compatible = "qcom,saw2", "syscon";
+			reg = <0x02012000 0x1000>;
+			regulator;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
@@ -885,6 +893,11 @@ l2cc: clock-controller@2011000 {
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.33.1

