Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEC53548D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiEZUhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346805AbiEZUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:37:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200DAE15FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rq11so5139175ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhybYx5n0lO5V9grC1jVsxMhR7Znm1yB5MDSykYKKbY=;
        b=hcrwQQccoF9BLU7lFaEXA2VBlVmSFfnvxxRcZQC0KstBa5wa+kSVkFZgm1WpGV6Ghp
         DqqiaQVCv65hEHbJbT7qXrNSKeBcNVnZ0m8ozTjXJUHne2CU8A3SaoSX6T4r6MQF/Fbh
         4JNU9pTX7epd2E99kCoIbiMzU76EwhQMLA/026LyfwaF4I2gyK6/G2Xn4TY7CDdMxf/R
         hqMXPBXJYRaoVOoJkm7fiFQsP3cOKHiPLti54Xxk0eU4ahSDQZUVHnA+4tZw2OeRuMAd
         5bLNZuoXKpr8bbphypeC8GzFH7cUuq1CXgHZrQM4SympK7RqCMkL1S+EU4FsrP7H5fXc
         Ut5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yhybYx5n0lO5V9grC1jVsxMhR7Znm1yB5MDSykYKKbY=;
        b=0+T2FasTHAYU8zbl3vWenIrx1jqNamnpcjB9Qx/+avjl/dav1SG9T1TpjKj2vqk4qH
         d4HtIZSV+gTmFJJpqBeliNMuaHb7CjdonG3N59FfGTEdC/yC0oFrHe97fE0E0FcKuatz
         28Q+FvHEu9Jt71Zzhs+QB7eZv9KfZCetp2Yyc4UUCfK8d+ob4ubhImBK6C8TuJE0QeZi
         Kv3G9FcZGZS/wninCqZ+LrNrgQmMpWsIrBDW/SqVzrmyZjjRX59JttPXsaLKDTE2jzcG
         Iw1s3i/V7qQiBp81iPkJok+gINnU52WOtLhbPYIQvdUusQv2ylion4Zc1gZzFWPOI22Y
         +Mng==
X-Gm-Message-State: AOAM532pUx57MvAfC551crpKuT4+gs3ICIn16Pw1fVQLRGh0hGdwKiv3
        Ra2FAePy7KUG6SH7OnjqVMFiCg==
X-Google-Smtp-Source: ABdhPJz1Y1iWVyjDOS3CTvMsvJoXbj0SMfD4rqv4llBMql5dDKcijlp4Crtc+9p3ETbnZwJYdr8nHw==
X-Received: by 2002:a17:907:7d86:b0:6ff:1598:b049 with SMTP id oz6-20020a1709077d8600b006ff1598b049mr8313316ejc.637.1653597419655;
        Thu, 26 May 2022 13:36:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bq8-20020a170906d0c800b006feb71acbb3sm813727ejb.105.2022.05.26.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:36:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ste: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:36:56 +0200
Message-Id: <20220526203656.831126-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/ste-ab8500.dtsi      | 6 +++---
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 35137c6e52ee..dd30d08ccb9b 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -195,7 +195,7 @@ ab8500_charger {
 							  "CH_WD_EXP",
 							  "VBUS_CH_DROP_END";
 					monitored-battery = <&battery>;
-					vddadc-supply	= <&ab8500_ldo_tvout_reg>;
+					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 					io-channels = <&gpadc 0x03>,
 						      <&gpadc 0x0a>,
 						      <&gpadc 0x09>,
@@ -207,8 +207,8 @@ ab8500_charger {
 				};
 
 				ab8500_chargalg {
-					compatible	= "stericsson,ab8500-chargalg";
-					monitored-battery	= <&battery>;
+					compatible = "stericsson,ab8500-chargalg";
+					monitored-battery = <&battery>;
 				};
 
 				ab8500_usb: phy {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 8f504edefd3f..e66fa59c2de6 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -353,11 +353,11 @@ lcd_hrefv60_mode: lcd_hrefv60 {
 					 * Drive DISP1 reset high (not reset), driver DISP2 reset low (reset)
 					 */
 					hrefv60_cfg1 {
-						pins ="GPIO65_F1";
+						pins = "GPIO65_F1";
 						ste,config = <&gpio_out_hi>;
 					};
 					hrefv60_cfg2 {
-						pins ="GPIO66_G3";
+						pins = "GPIO66_G3";
 						ste,config = <&gpio_out_lo>;
 					};
 				};
-- 
2.34.1

