Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB92C518100
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiECJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiECJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:30:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E334641
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 02:26:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so14881735ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUOtlbGVsYih4mc6eQpV5OoGIdZjeLrioJqeo3NGpEU=;
        b=HoP+fdqdEi/S/Nlnq2/b62HpRadWITtZg2Xp4xwINxyhNYrmzEjQxRaYsm9KqK2FJ3
         TFzvJ3nrkSqKSB9r/s0QFJicqbiM6Cp8Hmt74PhBohMtM+/V8rJVfcQtL7DDA1CN2TA/
         2wAixifczmYb9Bt0pxyvhFbU8gAagEW7Qm7yXM395BZ2PAoyHm8U5dW3/WD1f1uAXwgu
         XmtDC48WoF+JfUwhAfqco2eTtWmWFXMag3RtgXfWON83+eqterxUMY0bRCk0tcnvGYnK
         gHHEbMJzIDh36lbnJhT3iLLbuKi2Eq+uY0WYU6xE2buR7ZfJEL6xA5EX1SKlb9EptMoB
         zgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUOtlbGVsYih4mc6eQpV5OoGIdZjeLrioJqeo3NGpEU=;
        b=oUlv92q8JnlL5x7q29mQmjPexIFXnYB7j+k8Bx1dVieqmL01MfjbGe551G7yQR4gfB
         LcvsfnVRTmz0iPErNzAPzauyspCd5u6Wqo0Kq3gUWOQFSKXwwfKOqx07zdksHCX2tXB6
         4WSavJuYjg5ALR/QXkvIQmjKJxU07/d7gSlPqIHbAuPljV7yE2LEy1Oip3YJPtbK1UBm
         2GtVT/7q/fIofkypWSJFFiqHfi9JNaQtIirqD9hlIGtS31vE0rmTDYsXz708HCOuL3nY
         EAYVDGPsKAl+InazZXLkHFJFK7MFGAe4oG2islU8qqBRL3rDa9RdsXV2ryJkvbw4krCL
         M3Hw==
X-Gm-Message-State: AOAM5301rQnIXt5PuRp0zhwWR6dYICKvmP1s4xWb2zL4rOROleWO9C0h
        54YDGGeiR+Iq63HNRe2f498kJw==
X-Google-Smtp-Source: ABdhPJwe3rmhvyYQ9yly28q1qZ4Sfx+S8eowB6YZIkuiRGyD2d9LMQilECpX/TWVcond5jGZPMPpNg==
X-Received: by 2002:a17:906:5793:b0:6f3:d546:1764 with SMTP id k19-20020a170906579300b006f3d5461764mr15390330ejq.247.1651569996868;
        Tue, 03 May 2022 02:26:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906844400b006f3ef214da4sm4493685ejy.10.2022.05.03.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:26:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos: move XTCXO clock frequency to board in Exynos Auto v9
Date:   Tue,  3 May 2022 11:26:31 +0200
Message-Id: <20220503092631.174713-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external oscillator - XTCXO - is an input to the SoC.  It is defined
in the Exynos Auto v9 SoC DTSI, because all boards will provide it and
clock controller bindings expect it, however the actual frequency of the
clock should be determined by the board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts | 4 ++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index 57518cb5e8c4..17e568853eb6 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -58,3 +58,7 @@ &ufs_0 {
 &usi_0 {
 	status = "okay";
 };
+
+&xtcxo {
+	clock-frequency = <26000000>;
+};
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 807d500d6022..68d087ed0459 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -153,7 +153,6 @@ fixed-rate-clocks {
 		xtcxo: clock {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <26000000>;
 			clock-output-names = "oscclk";
 		};
 
-- 
2.32.0

