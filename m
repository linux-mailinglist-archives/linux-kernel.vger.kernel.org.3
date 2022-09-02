Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE125AA7E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIBGPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiIBGPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:15:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7A22B04;
        Thu,  1 Sep 2022 23:15:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u22so877055plq.12;
        Thu, 01 Sep 2022 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CiDlBhpuMBNmAQC1ai9qNlSZhkcYYAFSX1KVGVWvAXc=;
        b=BrGayX5fEW9Pzlt9Mkjk1PdC6cW/e5APqL0VkpQRvBFQJi+wQEjUk7cBFrNfH3nz6O
         9U6OCVZb++rj7hu6vr9IYUcUaWT+MvMtloeACbYShuid3z1scJHiEVfqcuPBMagIFByg
         5a9T9nRxf8Tmixa9AGfgaOfPwCTOvLdaHw3v99g8tBfHn0dAeQTrwVyjOJzXxyR0XjN8
         M5llx3msZwK2RUTf6tZfRqKl0IYpXgAp9Mjl/s6eF5B+YngcfbQzsivYBxtFResn+s2C
         CgEI0gDtia1cwKoXJSrjd6NuVCL9Ko1EcALt2f8tsPfPnldeoTO5+4aRahBxyh5PfFsB
         4qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CiDlBhpuMBNmAQC1ai9qNlSZhkcYYAFSX1KVGVWvAXc=;
        b=ObqpUUZQNO8wbYSndrqA+wQpzL7j5ewfISA36Yjo/z+F8bRqb7PxDZV05xPYpt1Ehv
         UYOF6QdthR2JJEA8YrBlYZbBSMnWRstVB28In63G6X90HvDbcwgFd0Q3KVNyJaIn4iJ2
         JzZPyBVQUIbuLUjDqShNsNsCa8pNNVz8NZo1dv2Ugr1iVNYeXr2IG4R8A3kO+HDDWVHw
         5vwY9s4vkK5U75VYHaSDoiegZYLpdBtZZjbOxfJHK73J/r7sZg5Mk3YCfEvhm9Hg2Noe
         /vnfv/8gnpCSpV5QP9A8/RTnbdoq/dws10Fb2KaDG363uyyHDggzNd5P9zSjSCTn7El7
         9d3g==
X-Gm-Message-State: ACgBeo0+GQW3Hf1Y+nldL3AmzLfbCCl9/8FbBYxYVD69uPtrWoEh7kPr
        VKOz4w1AMyg26Sgtx72y4M8=
X-Google-Smtp-Source: AA6agR66OfWP0uR8EuBwMN6Iknfi0DZCDEdFpTv2UhT9XEhJEBM/qAtGCTwzfdZamS/hFbs9IZF3Rg==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:5250:7b44 with SMTP id oo14-20020a17090b1c8e00b001f752507b44mr3150524pjb.212.1662099309457;
        Thu, 01 Sep 2022 23:15:09 -0700 (PDT)
Received: from harry-home.bne.opengear.com (115-64-237-221.tpgi.com.au. [115.64.237.221])
        by smtp.gmail.com with ESMTPSA id l4-20020a622504000000b00537eacc8fa6sm736018pfl.40.2022.09.01.23.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:15:09 -0700 (PDT)
From:   Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To:     andy.shevchenko@gmail.com
Cc:     Qingtao Cao <qingtao.cao@digi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/1] gpio: exar: access MPIO registers on cascaded chips
Date:   Fri,  2 Sep 2022 16:14:34 +1000
Message-Id: <20220902061434.46995-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
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

When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
(part of the Device Configuration Registers) of the secondary chips, an offset
needs to be applied based on the number of primary chip's UART channels.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/gpio/gpio-exar.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index d37de78247a6..482f678c893e 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -21,6 +21,12 @@
 #define EXAR_OFFSET_MPIOLVL_HI 0x96
 #define EXAR_OFFSET_MPIOSEL_HI 0x99
 
+/*
+ * The Device Configuration and UART Configuration Registers
+ * for each UART channel take 1KB of memory address space.
+ */
+#define EXAR_UART_CHANNEL_SIZE 0x400
+
 #define DRIVER_NAME "gpio_exar"
 
 static DEFINE_IDA(ida_index);
@@ -31,26 +37,39 @@ struct exar_gpio_chip {
 	int index;
 	char name[20];
 	unsigned int first_pin;
+	/*
+	 * The offset to the cascaded device's (if existing)
+	 * Device Configuration Registers.
+	 */
+	unsigned int cascaded_offset;
 };
 
 static unsigned int
 exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
-						   : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+	unsigned int cascaded = offset / 16;
+	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+
+	return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
 }
 
 static unsigned int
 exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
-						   : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+	unsigned int cascaded = offset / 16;
+	unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+
+	return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
 }
 
 static unsigned int
 exar_offset_to_bit(struct exar_gpio_chip *exar_gpio, unsigned int offset)
 {
-	return (offset + exar_gpio->first_pin) % 8;
+	unsigned int pin = exar_gpio->first_pin + (offset % 16);
+
+	return pin % 8;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -153,6 +172,17 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!exar_gpio)
 		return -ENOMEM;
 
+	/*
+	 * If cascaded, secondary xr17v354 or xr17v358 have the same amount
+	 * of MPIOs as their primaries and the last 4 bits of the primary's
+	 * PCI Device ID is the number of its UART channels.
+	 */
+	if (pcidev->device & GENMASK(15, 12)) {
+		ngpios += ngpios;
+		exar_gpio->cascaded_offset = (pcidev->device & GENMASK(3, 0)) *
+				EXAR_UART_CHANNEL_SIZE;
+	}
+
 	/*
 	 * We don't need to check the return values of mmio regmap operations (unless
 	 * the regmap has a clock attached which is not the case here).
-- 
2.34.1

