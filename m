Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD34FA69D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbiDIJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDIJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:54:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF5E0C9;
        Sat,  9 Apr 2022 02:52:27 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBV6n-1npXAT3Sr1-00Cxks; Sat, 09 Apr 2022 11:52:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/2] pinctrl: bcm2835: implement hook for missing gpio-ranges
Date:   Sat,  9 Apr 2022 11:51:29 +0200
Message-Id: <20220409095129.45786-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409095129.45786-1-stefan.wahren@i2se.com>
References: <20220409095129.45786-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cH2GKa+Sesy4auWa0VxnAWA+V7gGDs0vWaXC0MA5wpS30ZmOxNy
 72XkB2bF7mkrbuvbdVznQ2DjMkkDbtkd5KoUAyfITurWA5IOVgYc01mzxVwM79/AsToEgch
 FJjFy8NZrEgxf7wgwdqjQfPBtAZYk59Gremkt00fncwW0AxEygWkhZOas7PfxUnqK0NQNAN
 LYvpzILW+iywikCkVLFPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JqHmuGSbNs8=:FzsvNdzM/oO96oe/XgwyYm
 9JfYEADvpCauvjeo+NvCGThP3aeMYK/nagZMAQTUdjMooygGYCZXZgFCdm8oQRMSdfPAiLYCb
 c0AfFQGgy1af6o4a3AfVzmMEdqdrGeOBp7EKu+zaIGSRPr+VJz8Z/i4H2OCG2FWbVq3EmQwig
 noSiKcLLq797cEgKn1MoC2tM+Jd/rEK1UwRsHuGwn42+zYznyA0bbEKWDgsmEgsddyhHHKwWL
 tEmrJmPyQFeAtiDgbCppliWG2oLcukTCvpsMSXVu37hq0uvpnkosgFP4kEy8X6m/Ksc5o/W7F
 ieOY3PfX2ZxhsyzG7E3IrioIfxMJYIbOF+pSo8EKTUox9FgsZX3m0gthTsq668J0/brX9AOiF
 RhCHg1eQIJCDmaKmy7PleeUIAMQqXgRZRfYfBzcT43vKhxwoOft5BoPh+b2YFZAE/di7QEpIs
 RQDntgYg+5CAqiFmIQqVXdkFznb9lVeYG3nWy3hcqClik1k5XxOzZIUJgD0wLcdqqeimulnVZ
 0j7NTXtfis2UcO79GVps/NvIubauDO/5iR29JEgaYPKVPE2RcVQlP28sIMX+cFDGNp2x6IDLx
 iz2j9Pyr3kHFV+Lv7eP01ElyZGvBMSL2lpd31IflM0IHUIvwBXrfRanYHF77aj6zgoEI/QML/
 i1nt5ZH1gijrPqRvS5avAq2MN2LzCYIj5P12bIZfqtzjvHt2BWGojBdW2kJpY1RtR8L0Y2S/6
 3/cEK/JaoLpQTdLa
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c8013355ead6 ("ARM: dts: gpio-ranges property is now required")
fixed the GPIO probing issues caused by "pinctrl: bcm2835: Change init
order for gpio hogs". This changed only the kernel DTS files. Unfortunately
it isn't guaranteed that these files are shipped to all users.

So implement the necessary backward compatibility for BCM2835 and
BCM2711 platform.

Fixes: 266423e60ea1 ("pinctrl: bcm2835: Change init order for gpio hogs")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 47e433e09c5c..dad453054776 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -358,6 +358,22 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
+					   struct device_node *np)
+{
+	struct pinctrl_dev *pctldev = of_pinctrl_get(np);
+
+	of_node_put(np);
+
+	if (!pctldev)
+		return 0;
+
+	gpiochip_add_pin_range(gc, pinctrl_dev_get_devname(pctldev), 0, 0,
+			       gc->ngpio);
+
+	return 0;
+}
+
 static const struct gpio_chip bcm2835_gpio_chip = {
 	.label = MODULE_NAME,
 	.owner = THIS_MODULE,
@@ -372,6 +388,7 @@ static const struct gpio_chip bcm2835_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2835_NUM_GPIOS,
 	.can_sleep = false,
+	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
 };
 
 static const struct gpio_chip bcm2711_gpio_chip = {
@@ -388,6 +405,7 @@ static const struct gpio_chip bcm2711_gpio_chip = {
 	.base = -1,
 	.ngpio = BCM2711_NUM_GPIOS,
 	.can_sleep = false,
+	.of_gpio_ranges_fallback = bcm2835_of_gpio_ranges_fallback,
 };
 
 static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
-- 
2.25.1

