Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3298A4CB10A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiCBVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbiCBVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88384DEA1E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u10so3110397wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU7CqFvzpVzQFrP6rEr/Bhzc6ZJQDR+Dmhlj5y/OH6I=;
        b=TMtERDMNk0h49/DuSa3frpY0if0OvMgZ0PREwCrp1rvaLH3NAWecqH7EbcJiRNCXOU
         RgEzeLPbWEcp4lG4ZnM57udFNbTd+0IPsH3XxqsbMUWS3YK2k+o8zMcMFUH4ne9Eoz3U
         sGdy9FihjYCkwn6UC+xI6AdwIE1hQyljtN4cAkKQgjki9qoGOaNh8vkRN1Tajd8BAhP2
         dXy0LjokoRjBz6odSQJsFIUEOdKUwtf94XEoH3fJ/+JJnq0ze6fkZ78H4pjSteSt51a0
         /taWhgW61sNbOpia8hPuN8yqXQrp4YPBT0Zph5ymjRPA/FMK11fUyu//Sfq9B1+bsgns
         O75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU7CqFvzpVzQFrP6rEr/Bhzc6ZJQDR+Dmhlj5y/OH6I=;
        b=wNvsNGNzP+rMo2WNGXuHMrVmxCdAuqEThQVG1VXL5KdzhsuhnshlBLn1rJEtspAeN5
         AgSU5YcREltTzjJLROISCtffiv0lui3+VbVvNIpIxtocvBwGODAe70kc/q0qd/adE3NT
         T+GxvM76tWXN3UzMKdkGpaT82EMPFS8roZyCMQmI9u1c6Btpo6s/1mCrRkBC2vKiTs46
         V7uDnEwPZmlsSIEeATcDIsKXOe6r7oV73o8CfQPvYVl7c1+Z3jasW4zR4QuGJsDUGw0G
         8h17MrOup3PoOB0zTRqboKFpdHrGRnOk8A+dEHNH9X4kovPkh+XCoL7pSWB/Ndibrk6S
         8AcQ==
X-Gm-Message-State: AOAM530Zqs45F2zOqBwWck6aPCyeZO3MlQhDHSDlNfE68qZGa4tdlew5
        ydEgcph0ud6mzAjIe89pHYc0NA==
X-Google-Smtp-Source: ABdhPJxFTOh58gQ2ndNAUkR0yVFJwyeB7NYgvg3saDQPoU8XkYmSDEmJ7uSqfjrhka3jzj9BoGoUAQ==
X-Received: by 2002:a05:6000:18a4:b0:1ef:f017:98f0 with SMTP id b4-20020a05600018a400b001eff01798f0mr10184765wri.39.1646255495146;
        Wed, 02 Mar 2022 13:11:35 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:34 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 16/18] arm64: dts: rockchip: add rk3328 crypto node
Date:   Wed,  2 Mar 2022 21:11:11 +0000
Message-Id: <20220302211113.4003816-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3328 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc7f1..1cff94e6ee10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1007,6 +1007,17 @@ gic: interrupt-controller@ff811000 {
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3288-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+		reset-names = "crypto-rst";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.34.1

