Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B74FA69C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiDIJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiDIJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:54:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9A11165;
        Sat,  9 Apr 2022 02:52:29 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.94]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MmCyE-1oLIHi1dGi-00iBEv; Sat, 09 Apr 2022 11:52:10 +0200
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
Subject: [PATCH 1/2] gpiolib: of: Introduce hook for missing gpio-ranges
Date:   Sat,  9 Apr 2022 11:51:28 +0200
Message-Id: <20220409095129.45786-2-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409095129.45786-1-stefan.wahren@i2se.com>
References: <20220409095129.45786-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CB02EKvvYydZC5du8AH3IAtLs1fKTmze7x6PqWzMFj9x2Xcd7BX
 DR+H15vbZSkfGzXjc8/tPJndsZk+GZlKFGP+LiQnHoQYy8Er0bANYgFfsUb7NYDU6kHSkcF
 HYR4Gv7TpReJCf2bH2UtDaWIpVcdhoLVsci82KxBAvMgBpCy/ZGjx/11Xzom4PcPS+ttYXc
 hObbjupwVjHxXTfxZjDJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1wUrPbMJhgY=:qii99htR46ZMXophlALDu0
 2FIx4j10br7+X4bpuAeH1ggCmPk6s93xNaqPiUHKisP/bwR6g/yoUN4Rc5MGLvbIAHGhAaIpi
 HzeWdlYZVkc4Wwd93ImTmRp4QSYj2MFhlD9mBNe/1uzEotfpdrYufNDp8cqzNaHhAEUCgr/jI
 YLA6HoSCpIBuzcy3AjoR54TGpFmdioBlvheXXiVsIsDhpj2YpPRlu1hjfTXy3uuphJYnhm9bw
 RYXGCY+kbn7RdPOuQ7Ht0OgS4uQ1nFVh/BhJnCmtZRzel4oZGyUUeAQyD0HqE83pSV3q9xNDZ
 lc7Rkm+pL5awl7EYi6LJqoH4TRPYRrUcRUEBqVHKxcq95grJubj33UNN9uyQD20Uq+66HsI8w
 qEfWCFbwQ0yg9z4D75rbovFHh97VOuX+9aPYtMs3tFGT0/I8bI7UpKgM51g1huzgS2+4WqDF7
 SaGv9ucDwj+Vjm1f4HJbdkjlo0bIbegP8BRnXSv1s9H+mx6smnyVoTHO8Y+iDBTLFc5Rdy3xx
 T4pihvDAkGil44Y9xokUbaV+aflxu9VTzaoML8U0l1lNKQ7R9xqgZQOAE7cxd5reX/wVk+8Go
 ERER8s6wNGETt3CSgf2XuAb4j39jLvVuq0APzskfGPF0UC8Ao6mCR+E9UhoZBHoCIdwiQMC1t
 yACjBXZsju4eBRGWtDAaGEySnfe2mX7pd8wMawNfvC5D+cW/3fkvX20AqjtLbQxL/oq7XN5QR
 5Iw4auJINtaJRNXL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2ab73c6d8323 ("gpio: Support GPIO controllers without pin-ranges")
the device tree nodes of GPIO controller need the gpio-ranges property to
handle gpio-hogs. Unfortunately it's impossible to guarantee that every new
kernel is shipped with an updated device tree binary.

In order to provide backward compatibility with those older DTB, we need a
callback within of_gpiochip_add_pin_range() so the relevant platform driver
can handle this case.

Fixes: 2ab73c6d8323 ("gpio: Support GPIO controllers without pin-ranges")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib-of.c   |  5 +++++
 include/linux/gpio/driver.h | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ae1ce319cd78..d9b235c88b54 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -931,6 +931,11 @@ static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	if (!np)
 		return 0;
 
+	if (!of_property_read_bool(np, "gpio-ranges") &&
+	    chip->of_gpio_ranges_fallback) {
+		return chip->of_gpio_ranges_fallback(chip, np);
+	}
+
 	group_names = of_find_property(np, group_names_propname, NULL);
 
 	for (;; index++) {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 98c93510640e..b5d53decea5a 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -492,6 +492,18 @@ struct gpio_chip {
 	 */
 	int (*of_xlate)(struct gpio_chip *gc,
 			const struct of_phandle_args *gpiospec, u32 *flags);
+
+	/**
+	 * @of_gpio_ranges_fallback
+	 *
+	 * Optional hook for the case that no gpio-ranges property is defined
+	 * within the device tree node "np" (usually DT before introduction
+	 * of gpio-ranges). So this callback is helpful to provide the
+	 * necessary backward compatibility for the pin ranges.
+	 */
+	int (*of_gpio_ranges_fallback)(struct gpio_chip *gc,
+				       struct device_node *np);
+
 #endif /* CONFIG_OF_GPIO */
 };
 
-- 
2.25.1

