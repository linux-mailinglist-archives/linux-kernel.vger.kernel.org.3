Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0FE56D450
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGKF3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKF3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:29:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5AFE0CE;
        Sun, 10 Jul 2022 22:29:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j3so3889891pfb.6;
        Sun, 10 Jul 2022 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4Cswd7DArEFc7LfzC/OUTw9Eqd3H62gPLq/FvPkU0w=;
        b=Qv1A47KGLOsSt9vm2LukHohQTBWZRnOfR+4712jyc1Oslwqqy2YlIRLfvzV55YUH87
         fd+VmwO3/E/WhZGjpaJ38wRt/ZjUz6DQ3xRwgLG6o28zoktHkJzOW9MF5b891UW/zWYO
         d6Bdfprh8eC+15Yx8wV24OiXKmNQIkyKZyZ5FFgi0WTXD559yFBMF/DJaJaJhGLuq+kh
         vye+LP/N4qAsSPjWlZ2RAMB8sgsTFPBQQPLFjap7lxe7OvFe5QZVdyorteymzlR2StMC
         fIlE0zfW4QZXuqC13+Q+vRJ8e7GGHvMIF/JXAlXsOCfzR/c95G1ZM6ppTSr/X9JIy4/6
         MPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A4Cswd7DArEFc7LfzC/OUTw9Eqd3H62gPLq/FvPkU0w=;
        b=EplTTJnHQVaFu/ZCKKit0P3msa7qtcOGPZf/Q8oGBbbgnwcbg4fc9n6Pm1LPzh7iU6
         5O8fPoFKC7pwqR3y6P+s/tDgEQNBSUnZj1ramFGrP+KX48Jj+qhAdbx8ngHvbRfkzxAr
         EUVvBY6mtl6QYmVqY/EjUvdnjkhTz4oMBsGTP0pQQAx/cWKE7g0jQgK5IkkHTDEK2VMB
         tv0OHWBW9iL1FsH6FDQWaV8OewPMMWKrjSHLXKVB6DEcr4CqZAbIvIy7kE+yQkKui18W
         u/1pbYiBRWBqdAiBiLDHcfyY8f1LgItt7O/3UYUvmduOu2/Jugszwn2TVJ4Mh4tNKHbw
         RP0Q==
X-Gm-Message-State: AJIora+GuIY0HRsrIWzZR1T9KOhAHNpyWd2b9RBuTTFLGYeQpYY2ZDg0
        KurdcIvW2NvaJAiCSyQZgVEac+VqgJJSyQ==
X-Google-Smtp-Source: AGRyM1tsMXyH05YNuvPTabbte6Ar0TGoyi1YgbXXhXBTgqjzk0MEu/IIY4f2LYooa13NsguRihejKQ==
X-Received: by 2002:a63:da0d:0:b0:412:6f69:8e67 with SMTP id c13-20020a63da0d000000b004126f698e67mr14270386pgh.424.1657517386773;
        Sun, 10 Jul 2022 22:29:46 -0700 (PDT)
Received: from ArtixLinux.localdomain ([116.193.141.74])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902710500b0016a522915e5sm3667744pll.83.2022.07.10.22.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 22:29:46 -0700 (PDT)
From:   Shinyzenith <aakashsensharma@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shinyzenith <aakashsensharma@gmail.com>
Subject: [PATCH] gpio/gpio-lp3943: unsigned to unsigned int cleanup
Date:   Mon, 11 Jul 2022 10:59:35 +0530
Message-Id: <20220711052935.2322-1-aakashsensharma@gmail.com>
X-Mailer: git-send-email 2.37.0
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

Getting rid of checkpatch findings. No functional changes.

Signed-off-by: Shinyzenith <aakashsensharma@gmail.com>
---
 drivers/gpio/gpio-lp3943.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-lp3943.c b/drivers/gpio/gpio-lp3943.c
index 8a30fb185aab..79edd5db49d2 100644
--- a/drivers/gpio/gpio-lp3943.c
+++ b/drivers/gpio/gpio-lp3943.c
@@ -42,7 +42,7 @@ struct lp3943_gpio {
 	u16 input_mask;		/* 1 = GPIO is input direction, 0 = output */
 };
 
-static int lp3943_gpio_request(struct gpio_chip *chip, unsigned offset)
+static int lp3943_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
 	struct lp3943 *lp3943 = lp3943_gpio->lp3943;
@@ -54,7 +54,7 @@ static int lp3943_gpio_request(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
-static void lp3943_gpio_free(struct gpio_chip *chip, unsigned offset)
+static void lp3943_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
 	struct lp3943 *lp3943 = lp3943_gpio->lp3943;
@@ -72,7 +72,7 @@ static int lp3943_gpio_set_mode(struct lp3943_gpio *lp3943_gpio, u8 offset,
 				  val << mux[offset].shift);
 }
 
-static int lp3943_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int lp3943_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
 
@@ -82,7 +82,7 @@ static int lp3943_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int lp3943_get_gpio_in_status(struct lp3943_gpio *lp3943_gpio,
-				     struct gpio_chip *chip, unsigned offset)
+				     struct gpio_chip *chip, unsigned int offset)
 {
 	u8 addr, read;
 	int err;
@@ -107,7 +107,7 @@ static int lp3943_get_gpio_in_status(struct lp3943_gpio *lp3943_gpio,
 }
 
 static int lp3943_get_gpio_out_status(struct lp3943_gpio *lp3943_gpio,
-				      struct gpio_chip *chip, unsigned offset)
+				      struct gpio_chip *chip, unsigned int offset)
 {
 	struct lp3943 *lp3943 = lp3943_gpio->lp3943;
 	const struct lp3943_reg_cfg *mux = lp3943->mux_cfg;
@@ -128,7 +128,7 @@ static int lp3943_get_gpio_out_status(struct lp3943_gpio *lp3943_gpio,
 		return -EINVAL;
 }
 
-static int lp3943_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int lp3943_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
 
@@ -147,7 +147,7 @@ static int lp3943_gpio_get(struct gpio_chip *chip, unsigned offset)
 		return lp3943_get_gpio_out_status(lp3943_gpio, chip, offset);
 }
 
-static void lp3943_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void lp3943_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
 	u8 data;
@@ -160,7 +160,7 @@ static void lp3943_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	lp3943_gpio_set_mode(lp3943_gpio, offset, data);
 }
 
-static int lp3943_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+static int lp3943_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 					int value)
 {
 	struct lp3943_gpio *lp3943_gpio = gpiochip_get_data(chip);
-- 
2.37.0

