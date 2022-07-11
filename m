Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A1570C05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiGKUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGKUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A83C8C4;
        Mon, 11 Jul 2022 13:34:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w12so6945638edd.13;
        Mon, 11 Jul 2022 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDQxB7Fy3SfPJmcU/nMuUlTiaBaKupFDi/Um612kFO8=;
        b=PGZ08dqQdqT0D7UjGQVD8rg1g2s0xhDZ5JiCghEqz36SC4vje7LlgpQW3RmW4aP/49
         3NdmQ8ChR3iTUD+aG9DTwMchYlRnNDmZoq9I874gKq/KXoSe51StMYPIGHQfA+LKL3Y4
         +UDwE8D0Y617g+teBdDNlMt261Inwqs8SrpyAvDiQmNgT3rmAzjtUqFGrymtIbixgLnj
         GHPeaOnPYSOkg7u9QiUSmxY3SFDauY4GHh5pzpMiscPaeidPZm7SYZ7S4sRbGeAVRLz3
         XreTwKBvVrsk826rIFdTaQmvt3++6YRXaU1xmOcD6aadTK7O4O2I848HZnWjBhps+lJz
         H4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDQxB7Fy3SfPJmcU/nMuUlTiaBaKupFDi/Um612kFO8=;
        b=Hjo4UpP4udAoAxwf8Ks2leqU06pt7fZ0o5xQHSFMYrQM664pPmCiRAW5wjflz6tl92
         9riIbPvOql0OrsG5szIrlc2AksD0jdPhyVZxbwu/kujCFnni0X5SL2JhukHQ/FMivg7I
         ggK6aiCQFjH6mz/nDd+r1uxiH36bVLenLWjFgkOHCqHjaHhsWuDNm5k6SoJ1YkvAZKP1
         wHjbf4sGh5FP0CQvzQ3tHriKuIHhd0400URgWhTflFXYLrEpQZeT/nr6Rl44GrWsqDX+
         sTswko24QdsGdO+EZuQSJWJsPuSUOIPSXREXx+nuu5UNDuUPo0YCZrCrNxIJuW710fQS
         ptZA==
X-Gm-Message-State: AJIora8ikjUotQyuaIi0ImIEoeacff+yy9WHge76d6ro3jVs3MnalilF
        yAFQSBX7dSZE9nlm7Zy6ViE=
X-Google-Smtp-Source: AGRyM1vViudCrmCKrLpRhM+18/huarjlJ+ZDf97bk75H+R5h+jnSRW/RJv3vr94tkT2jdN+EWeBeSg==
X-Received: by 2002:a05:6402:5418:b0:435:5a48:daa9 with SMTP id ev24-20020a056402541800b004355a48daa9mr27535122edb.304.1657571659967;
        Mon, 11 Jul 2022 13:34:19 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 7/7] arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
Date:   Mon, 11 Jul 2022 22:34:08 +0200
Message-Id: <20220711203408.2949888-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711203408.2949888-1-robimarko@gmail.com>
References: <20220711203408.2949888-1-robimarko@gmail.com>
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

Since now we have control over the PMP8074 PMIC providing various system
voltages including L11 which provides the SDIO/eMMC I/O voltage set it as
the SDHCI VQMMC supply.

This allows SDHCI controller to switch to 1.8V I/O mode and support high
speed modes like HS200 and HS400.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index de20cb98acd3..a73909a24935 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -3,6 +3,7 @@
 /* Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
 #include "ipq8074.dtsi"
+#include "pmp8074.dtsi"
 
 / {
 	#address-cells = <0x2>;
@@ -87,6 +88,7 @@ nand@0 {
 
 &sdhc_1 {
 	status = "okay";
+	vqmmc-supply = <&l11>;
 };
 
 &qusb_phy_0 {
-- 
2.36.1

