Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AF5A9037
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiIAH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiIAHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C12BCB8;
        Thu,  1 Sep 2022 00:24:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so866823wmb.4;
        Thu, 01 Sep 2022 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Po8E7/OIBjbSJpNPSFcYw7gzbRFnsYc7RcCzMnBQZCE=;
        b=d+ZAEadifEtEK0I36qrNTGwR7qCxMEj/G5oudE0uUNdcMRZV1nVWyBCNE42U/e55ct
         JKDq5ldbWlHu2wi98fEKGTr+x3ciyq8FW2PNel3/7hbcUtYdVWeRVjSSUaTHQn/vwgyc
         RvQlgCUOe6WYi1K6Z7FGFQJWQ8sx4/177P9Q5c5MCRMdWRhPSUPjRjOCk+xVIhLM3eIu
         EdBM2b70gynfcr0lDaDOA2v7ASVG5jwbB7M+RBlYfKcjcvZmifEMfT+okI1e3Np6f9CU
         9zeAZXyvvLfh8cb4hxHqPdHl0YQGfsoQNSkEJvUBRe+GuCRywu+yvR/sXPwKriYMzEW8
         /VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Po8E7/OIBjbSJpNPSFcYw7gzbRFnsYc7RcCzMnBQZCE=;
        b=ppN7dyPG/OnD4ivAWkHClR5pA4bb2M1D8v9TwYZSZF+RxP6zQQpmERitIsrlSmO7p6
         YTSX/omyimqamT+7ZfbV8y4zM6FkXoQW/2m46E/ayQKdkXqEHSCLyxCVHyk05zKYuGPQ
         dvG6MMBYJOzgAtTcZCMXPqNc5US0/yTg6Hkj0BBReiuWrBVeGMmaFV0PCR6U0U+EuyYl
         bdxG1LKf3DAChSK5ZmP5wd3ElxTHHvIpdo8UgybZbl+wmI8zHCq5/h4Tx5UQ+aCCpMpB
         yOdSsIwLMvMn8uQ6Hw/kNcBXUS3+rK0kw265oxjDJH0U1rnQUO1IEX8FysMfKeVW4vTu
         LXHQ==
X-Gm-Message-State: ACgBeo2AvP9Hd6x73Ek2Ec4rSdft1CTMaC+9JpKZDsnQljoM7p+p3Q1M
        4F2UYNjEtGj4964CIDx75Ps=
X-Google-Smtp-Source: AA6agR4X3Xg49JGgo5+uiWIgYlxOk2IfYPYs3HN+jSnL2bjj3B9lNMNRvLsokdg2o7KqvVvcJ8PMAA==
X-Received: by 2002:a05:600c:22ca:b0:3a5:c30d:ca9f with SMTP id 10-20020a05600c22ca00b003a5c30dca9fmr4172325wmg.25.1662017091310;
        Thu, 01 Sep 2022 00:24:51 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003a5dbdea6a8sm5515967wmq.27.2022.09.01.00.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:50 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] arm64: dts: qcom: sm6115: Add SPMI bus node
Date:   Thu,  1 Sep 2022 10:24:09 +0300
Message-Id: <20220901072414.1923075-11-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SPMI bus on the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 491fffff8aa1..d578f8425e36 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -543,6 +543,25 @@ qusb2_hstx_trim: hstx_trim@25b {
 			};
 		};
 
+		spmi_bus: qcom,spmi@1c40000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x1c40000 0x1100>,
+			      <0x1e00000 0x2000000>,
+			      <0x3e00000 0x100000>,
+			      <0x3f00000 0xa0000>,
+			      <0x1c0a000 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x340000 0x20000>;
-- 
2.37.2

