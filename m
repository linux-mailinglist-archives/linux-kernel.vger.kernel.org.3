Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B504E27A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbiCUNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347932AbiCUNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:35:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF793CA62
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:33:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x34so16680825ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6BxZch4uZImMxpopzhj/TV44ApdnEVZrzFIJlaiPFA=;
        b=wzYxgeoIax8d+We0XG2f4nTSOUImN5EoFfh9Lu1qqqg/T/M8YkqCuBEsZGLyy6EngN
         pioZEioorYT3x1q2CPJOzLdyGd2iCCL1fWngRY7DYq5XrwqGrsyq90nG9t3qSKUvrh9h
         dmwYa+6TaIqbMqA7Bs/6YfF71FnfzVbfAWH3VOiJDLpoIX58jAnAOICYNn57piHWaY9f
         rV0dikn5CkZyqWMZwJH5nsGOsdp/LQk/JYPJit8kVNd2/j4nXGu40k8piBqnnRTs1LoZ
         FC+SPX0SEqGv9W/lDx3vNYzq9wy7vNsU+p+Z50lyIcKVrNJvubKAkwbYoPBYPMc8QZjR
         lBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6BxZch4uZImMxpopzhj/TV44ApdnEVZrzFIJlaiPFA=;
        b=jajTnFZYSFRtdc42SEnwV1NcgIpPhmPekuKBtOd9WFQAciGZpzjKtBS1tuA+HRei4+
         1OM29R4UDKxI+IvNz+0nW41/Av766ms0kg42zakTjMBfaOE/B3+JqxBEg4EIPJGXbrF5
         5VniRV11U9kOEMNqeSYs/38b+NSzsF8VIPiP8XUj1z3pfA5BFjPC7j5Jx6BNjPtGIHc0
         /hYfiJk1QV64F3eU9RQ3DSt1bJ1OKbQqoCwCe6lJuR/I1/eN/YanBmNCjioczgJg8P8X
         dGDZFnrEM9wTIJz0VhdKcAwEdA18yafo/tDx+nt6/Io/qKko7937P5rRTfysZQE/xn8t
         Eg9g==
X-Gm-Message-State: AOAM530oD8uC6c5IeIz6Q3BKKXF8wjE4f+6EVsGAWJfecVDTX1PB+AvO
        y7qE8wBHzExfGuNh4mM9NHbI5A==
X-Google-Smtp-Source: ABdhPJy5wcFMSxqYF9z9tT1TTrf1HxYWEDeD8UzOptL563RO6bUoh84uqACrFycVwHbxAjuXq70lkw==
X-Received: by 2002:a05:6402:13d6:b0:419:2eab:d21 with SMTP id a22-20020a05640213d600b004192eab0d21mr7959137edx.78.1647869635192;
        Mon, 21 Mar 2022 06:33:55 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm6862154ejd.133.2022.03.21.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:33:54 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm7225-fairphone-fp4: Enable UFS
Date:   Mon, 21 Mar 2022 14:33:18 +0100
Message-Id: <20220321133318.99406-7-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321133318.99406-1-luca.weiss@fairphone.com>
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
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

Configure and enable the nodes for UFS that are used for internal
storage on FP4.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- nothing

 .../boot/dts/qcom/sm7225-fairphone-fp4.dts     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index adb6ca2be2a5..533a1c88040f 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -336,6 +336,24 @@ &uart2 {
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 156 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7e>;
+	vcc-max-microamp = <800000>;
+	vccq2-supply = <&vreg_l12a>;
+	vccq2-max-microamp = <800000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l18a>;
+	vdda-pll-supply = <&vreg_l22a>;
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.35.1

