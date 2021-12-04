Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41544687C8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 22:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379614AbhLDVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379424AbhLDVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 16:54:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C1C0611F7
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 13:50:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i12so5159034wmq.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68SA4R0NxLIr37Da5nfLfh6Rq6kJdXUgL0ant2P/Sj4=;
        b=DfQH/J3lFsJL/4doc0DHJyFgiG3tiIT0umEEr7A3zlof5Zq6UT/vmsg4AFlAVdOrff
         HO4eDSGhUaxJKCUJSJu5oWEIhODphofDUFYX2LZaY3o9r4syF6kf2yZyxrT6kY1fREqw
         2m7ZZodHelhkBQH3Ubx33XZo4i3YkuvUjMP2qwfMLR93BcPMjXajsbiFfPcJNrLy3/mZ
         hBqaMCXzpIBIXgtKxup5Oa0WywuhdUGG1M8DruurLCvfBpqC1Vq2Tdqtz9IPjdrjTcQ9
         e4g9Ou68nCZVdhJOLsysk1SRV2HjcoA2i8+xe6/mXR90nn0R03i8HRIF5+56ovFml+x1
         Jd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68SA4R0NxLIr37Da5nfLfh6Rq6kJdXUgL0ant2P/Sj4=;
        b=GeBPNTQXDbDcjVxMfIUQbZ1URDB91TJc9cPm8vyMP+RqN7FkAZgS3myMOW0Fd2Rk24
         OXwYm5FtUKx0uJ7kwn4vi469iBCZheaOaaqn0LEdotULariM2a3RYkrWwwy3/OB1wQs8
         AY+0UwuuHWK7fS4u3Erapq3ntpLQxI3fno+oAx6tHTd10McqyWRRW709vP1ZuMPY9vlv
         toQgJ8sJuV6igL/GVtQv7bQNhMSJo0QJR4+rEc+f/G3DMnfCq2bDrqXQRmIGBQeHe4uG
         M8cfTaJlAZ1aNM78Pa6vq50BO24Ypnt2ibI6KSsjCIN/rp/bjHktOOaZDSDLYeMRadp3
         2nKg==
X-Gm-Message-State: AOAM531UyyLFj7arh4cqK3jYuzV5PzNbq+MJBNFbmhJ6nDu891uiT9MH
        uFWdYeG5OzdUT115aLZEqg8Nnw==
X-Google-Smtp-Source: ABdhPJxg6zYHX/wn2h11gWbATGIfIOzg77VcmmUb7U9+Dht0OhnO402P6b76UA+S4iJShOKRrtakrg==
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr26102478wmq.109.1638654645242;
        Sat, 04 Dec 2021 13:50:45 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id f7sm11250303wmg.6.2021.12.04.13.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 13:50:44 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 7/8] arm: dts: exynos: Rename hsi2c nodes to i2c for Exynos5260
Date:   Sat,  4 Dec 2021 23:50:32 +0200
Message-Id: <20211204215033.5134-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211204215033.5134-1-semen.protsenko@linaro.org>
References: <20211204215033.5134-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Device Tree specification it's recommended to use "i2c" name for I2C
nodes. Now that i2c-exynos5 dt-schema binding was added, it shows some
warnings like this when validating HS-I2C nodes:

    hsi2c@xxxxxxxxx: $nodename:0: 'hsi2c@xxxxxxxx' does not match
                                  '^i2c(@.*)?'
    From schema: Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml

Rename hsi2c@* to i2c@* to fix those warnings.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - This patch was added in v2

 arch/arm/boot/dts/exynos5260.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 52fa211525ce..524d244050e0 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -368,7 +368,7 @@ mmc_2: mmc@12160000 {
 			status = "disabled";
 		};
 
-		hsi2c_0: hsi2c@12da0000 {
+		hsi2c_0: i2c@12da0000 {
 			compatible = "samsung,exynos5260-hsi2c";
 			reg = <0x12DA0000 0x1000>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -381,7 +381,7 @@ hsi2c_0: hsi2c@12da0000 {
 			status = "disabled";
 		};
 
-		hsi2c_1: hsi2c@12db0000 {
+		hsi2c_1: i2c@12db0000 {
 			compatible = "samsung,exynos5260-hsi2c";
 			reg = <0x12DB0000 0x1000>;
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -394,7 +394,7 @@ hsi2c_1: hsi2c@12db0000 {
 			status = "disabled";
 		};
 
-		hsi2c_2: hsi2c@12dc0000 {
+		hsi2c_2: i2c@12dc0000 {
 			compatible = "samsung,exynos5260-hsi2c";
 			reg = <0x12DC0000 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -407,7 +407,7 @@ hsi2c_2: hsi2c@12dc0000 {
 			status = "disabled";
 		};
 
-		hsi2c_3: hsi2c@12dd0000 {
+		hsi2c_3: i2c@12dd0000 {
 			compatible = "samsung,exynos5260-hsi2c";
 			reg = <0x12DD0000 0x1000>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.30.2

