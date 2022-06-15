Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0054C7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348320AbiFOLwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347290AbiFOLvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D5517FA;
        Wed, 15 Jun 2022 04:51:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so22704033ejq.6;
        Wed, 15 Jun 2022 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSTuZ2t7hCCrfuAfUAIkWHaObpQDE2fE3zF2HruldLs=;
        b=ln5FWn0385Z1emtIsEMSvzyPVQj600V8Xddp7sktlEE2o0X5IHEEJe+zZcziBxAeaI
         L079l5X5V8ABLgSAXShBMGIzRZTiZuo00hC+3agDHrNUITGdlo9DCBHbiLswo4IbNTTo
         W5pYechsn0C/VJHhuN1tsacXFrakv968FofRMYMl5lCkTHroC7wUi44O16uwCWLLmaTn
         8++7kO4iu2SIgSwXgFhY8SrbLKho9wIEVsAnW+hUZ8UqPYOTfZDbW6tbIN0Afn5zatrL
         ioD5wWGvfonA3lLir+iFYUffgxw0LnsctVE634zARgMy4K+YjY4iWUQ3CV+OcIdy6A8j
         vsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSTuZ2t7hCCrfuAfUAIkWHaObpQDE2fE3zF2HruldLs=;
        b=VNYxX4638yJu2LCtqG5qfTDJ5DGddbOyi2aDgg0LUgBNT+6jTcJ5EvkJtg1hgBLpOk
         GRZp606sDyERm5xDQ8ZCOLLLKW7czQxalDFeuOqrTcjCy5Kn6+brG97h9wekJVQE1d/W
         Jp0WAUO6BkiJIIOAVoDw7mxprmFlFJzzGi6AubNHCWGQ3WDNcnAY82E456ne4apsUe4z
         +RyMFaHJN3RKW605hjmVcVuUwRf/xPnpLHb8drcxs7XMXMaV7MsfvM1/KCj+9XfbGD5O
         +yCxpXOERheSv8KxJWUndTXqvt7GS46LpyfgKHOBArVRerq+S8svg7/vkVLi2yfp9Bmt
         mMUw==
X-Gm-Message-State: AOAM530XrOsWzVho8ENb6w+zoyKjjK6xvTVajRSp7Z1RtJX8pP5JP4XJ
        aV4A+Bm21R1WRf+m8ipTJyw=
X-Google-Smtp-Source: ABdhPJw7wppeArZ3rP5GRFzy41nguU3d/FX10LZVO5qLp4RlXIHWhjbGmzhHxVTVml/slX4PPyi8nA==
X-Received: by 2002:a17:907:3e82:b0:6ff:1e04:a365 with SMTP id hs2-20020a1709073e8200b006ff1e04a365mr8581673ejc.617.1655293863270;
        Wed, 15 Jun 2022 04:51:03 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:51:02 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/18] ARM: dts: imx6q-apalis: backlight pwm: Simplify inverted backlight
Date:   Wed, 15 Jun 2022 13:50:04 +0200
Message-Id: <20220615115006.45672-17-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Set #pwm-cells to the default 3 to gain access to the parameter
which allows inverting the PWM signal. This is useful to specify
a backlight which has its highest brightness at 0.

With the change to use the PWM with inverted polarity the PWM signal
is inverted to how it was before this patch.
This changes the meaning of the values in the brightness-levels
property. I.e. the duty-cycle changes from x/255 to (255-x)/255.
Keeping the brightness-levels will then have a big brightness
jump from 0 to 127 duty cycle, the other 6 steps will then be
barely noticeable.

Change the brightness-levels to provide the same brightness-levels
as before.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 4ff46ffd2300..c134e71f2a09 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Toradex Apalis iMX6Q/D Module";
@@ -19,13 +20,13 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		brightness-levels = <0 127 191 223 239 247 251 255>;
-		default-brightness-level = <1>;
-		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		power-supply = <&reg_module_3v3>;
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 PWM_POLARITY_INVERTED>;
 		status = "disabled";
 	};
 
@@ -776,7 +777,6 @@
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "disabled";
-- 
2.20.1

