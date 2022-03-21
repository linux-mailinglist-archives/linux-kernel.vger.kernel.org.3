Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED474E2D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiCUQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350715AbiCUQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:10:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D12983C;
        Mon, 21 Mar 2022 09:08:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso8672494wmr.1;
        Mon, 21 Mar 2022 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=Wq2ZuLhEWV9Oh1GYkPcRjeiUs1VJkKuGaQ7sd9hkFLt0al93PXHrqUFp62gNPBH5fT
         5xT59NYoBmZ5VRNpt+olIdKzsWEKuBdl/E5ikdS/OriFu6+YSgg86wZlF+Fv0EhLMkPH
         7S1j44KxYr5Hr8d2EOYLJ22ZtMSul33sU3FIa0GI6zjFnbKoyGzIC1FK1j0meWWPwVZt
         /1ZGre9N409xgFno3Q9/PWevVFW7ra/ZeNOTs/vKR9VE09Db9fTeHCC53bDzuuAkv3IH
         XIvh0CLWS2fkg6syAxmeUpmxIhPZiLgo9GEtKcSYGqyGyt1q5Z+hsvMpk2q4fnXADVmw
         ubPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF5KajzdUjlsueHw3PGEQrW6QOzbz3BzoTgHX03BJeo=;
        b=4x1LUzn6E32r9Z3QYN2XVQowK+LfPmNSASETYjCGATRBLhgCImzay4lMvOrgbtP+L4
         ssgls0f1yYglzdo9Tf37enYEL5b2xfyEStY7NJb6YMxkM5/+xIdfA2yWWNG4s9oWbIQ/
         v4TxPafhIVVWJdB5NTpObbHuTS+uMj6Fz+3CZc1q13EPzvHNIaKtaPnOgE1o60MGX+m3
         YllvcSyUjrmdm/ykE2wzzR8y6/JKH21+ydokajF/uW6d6ta1cLiS22fnTTtRh6d4L9cv
         Oi/Ea+ws/DsomqjPe+og/KFfl3TD+d3OTPUALJDmHNrX+yLjEFDMbS1ZmmCmT2c8FIZM
         P52Q==
X-Gm-Message-State: AOAM531iAd4+A4Di34gecbqCkxWprUK/bjqWo95An05HA6It6ppj5jJG
        zAD+CgJo09L6OV82/eRZhT9Ggo1Sltk=
X-Google-Smtp-Source: ABdhPJzm8NfywMt+ZvIRkIQgbRFeUCVCYNOZ+QM1nXnq5kVRxBgrVaSbIFINbggsvME62wH+uNgiFg==
X-Received: by 2002:a1c:2744:0:b0:382:a9b7:1c8a with SMTP id n65-20020a1c2744000000b00382a9b71c8amr19776122wmn.187.1647878912369;
        Mon, 21 Mar 2022 09:08:32 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 16/18] ARM: dts: qcom: qcom-ipq8064: add missing krait-cc compatible and clocks
Date:   Mon, 21 Mar 2022 16:38:53 +0100
Message-Id: <20220321153855.12082-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Add missing krait-cc clock-controller and define missing aux clock for
CPUs. Also change phandle for l2cc node to point to pxo_board instead
of gcc PXO_SRC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..888f17d64283 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -468,11 +468,19 @@ IRQ_TYPE_EDGE_RISING)>,
 		acc0: clock-controller@2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu0_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		acc1: clock-controller@2098000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+			clock-output-names = "acpu1_aux";
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		adm_dma: dma-controller@18300000 {
@@ -782,11 +790,21 @@ tcsr: syscon@1a400000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
 		};
 
+		kraitcc: clock-controller {
+			compatible = "qcom,krait-cc-v1";
+			clocks = <&gcc PLL9>, <&gcc PLL10>, <&gcc PLL12>,
+				 <&acc0>, <&acc1>, <&l2cc>, <&qsb>;
+			clock-names = "hfpll0", "hfpll1", "hfpll_l2",
+				      "acpu0_aux", "acpu1_aux", "acpu_l2_aux",
+				      "qsb";
+			#clock-cells = <1>;
+		};
+
 		lcc: clock-controller@28000000 {
 			compatible = "qcom,lcc-ipq8064";
 			reg = <0x28000000 0x1000>;
-- 
2.34.1

