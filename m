Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F22565F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiGDVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiGDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143612096;
        Mon,  4 Jul 2022 14:24:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c65so13049423edf.4;
        Mon, 04 Jul 2022 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDQxB7Fy3SfPJmcU/nMuUlTiaBaKupFDi/Um612kFO8=;
        b=UH0nEw+JDVS5JB6oX+Zir/ZDPriDB2qIkWp3OB9DiL8PcStuZljt2kKBfxZz/8jX6D
         u7YDSxPLoZlxmZVW2P2dFylf644p7ogvHsIkVCv70cRwCakTtt8xdYFAELTMdSM52KT+
         cXxcvyQ528WCJrZ1rYO/BJ9IAf/KKT79kFtLYZRllKMFLfUSnwSD4to8YYmWxWRN1iNW
         AD0UpgYUrz9B1KMpzQQ95XFlruayVWtP9xHEDr+6W8hJhzujT0VT0HaKif3AMyHFB3AK
         7nuifcHrnWWWhB5S/Ev6MsmfVwzaz+DcsmhcbtDa66TaDxMFH6c2/Kp9xxyClJAnKqEA
         U+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDQxB7Fy3SfPJmcU/nMuUlTiaBaKupFDi/Um612kFO8=;
        b=2TdIyE/zt7Pu/9B/0lwxANXszgGj5yPQrcFkBNrpQ9CApYjh6lzPIffeVnYkRKgsXt
         mAswhyRgnkEzl6z2Fn34IZB4pX9kUmQeMkac/n9ZQtMLOuqD1JC/jBHTvd/WSwXzZoKt
         TEHRw+q04cf8VlS2shvUrL//NxOOAaCymOIPFK9lwUl3+30pxkXqQ333ikNL+dMnuweC
         +PoJA8ugiACylsA/dFZarp7BEdd5PabO7jaU+G+yaAOILxmZ4xDFpeqb1JTnbsYjIYmV
         pzd1FyrqlaKyFJrvwFBohi9FfMD/dGqmjWIFvjnijtjIgI9XwqdMKPhOdvDkVRRLSzmE
         ZCBw==
X-Gm-Message-State: AJIora/LCYW2Zf1QodbjQ0wXxgmuh3ij+DPvdD/iUJ2Ap3A2nDWUGdly
        XY7zk3Cf7yWMI29KG8J4iyo=
X-Google-Smtp-Source: AGRyM1tmVI0Dsj6e4UIWi3qajxeF82gbxgVA/AT2jS1VqUufrtB9MP25vkcoNu2lIxrfjYdYZgdfnw==
X-Received: by 2002:aa7:c486:0:b0:435:5d50:ab39 with SMTP id m6-20020aa7c486000000b004355d50ab39mr42209716edq.104.1656969858619;
        Mon, 04 Jul 2022 14:24:18 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 12/12] arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
Date:   Mon,  4 Jul 2022 23:24:02 +0200
Message-Id: <20220704212402.1715182-12-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

