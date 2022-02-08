Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C94AD6CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiBHL3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349562AbiBHKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:48:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B149DC03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:48:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s10so27333730wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2RBuPF7+jk2MYvMHxs5hnonCSVzKHGmgHGdw6RmjUw=;
        b=sQFJBX4baIYK2pjY/ZO+xZa+qQkxXw9powlty3Jf1N0CfZeTZtd7HC8IhDGC7O5T/M
         WmTxEq/8TUuucTHTbPwYT+90OuklOByN+vKWA5Sd6w4Z/m0lcocl8Z3pYDEMWteddmsp
         9LIUSr8WUP+A+BTTOB/gbAdBTEcyWiXiAN0HG623DBAa7lKkwqDIzJ0RpvII1pkWB2id
         qIe3+FPEfI5pH0Q2m+p3U64s7BPLvD3L0FljVq5q7BVcvlNUJv7VnbdDVvQU9/wwPon/
         il3YnafTLqmoz1Y/Td7w6mK5akWQnjkpDhN4F62WY5+PEl1BOHXNTuZy7NannOhtxcck
         1VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/2RBuPF7+jk2MYvMHxs5hnonCSVzKHGmgHGdw6RmjUw=;
        b=7TEp5bSMcNI4Ual2GNDYHWCAHGcc0mq+m4Pe9HGO8Eg0PI0dHgHQPi8AteTZKzzLsl
         gCoapfFYdHZObNqOp9nV9ts5m0xI02yDi9a/xLvb5FMas5lFyZT++kWMy1Mi4RNOCHeg
         RObp/ZpGs8TzjCR5Y4Xcx4qJ3mcG7po4PwBAhFd6kPYEQTeBJJkVhEbLdmKobNPmhW2i
         Txz0KL43dyT24j42wdZHypqt0SUlh6mvCEkESbedZN+JRFrzue6OVNCtj0RVHmlJjG7W
         pfW6dkZlb14Og20dLWK0wQnl/bDyN7rvAE4OB5Jwp7q+SGtG5wXa1wmyl4yODXw/jXlI
         g8pQ==
X-Gm-Message-State: AOAM5320yq6FyGXT3SouAcLP7m6Qru8xAl1bJNLOnjQuvDUqPGx6UMLF
        utjFRaUMTzzlMn5609NEOyE9uQ==
X-Google-Smtp-Source: ABdhPJxDCxikA1SstIBbpMtLo5nW/gSC8VSlKDkxUudzUI8SMijILsbLQCeWnNnIFRCt/IY99rQ/NA==
X-Received: by 2002:a5d:6c64:: with SMTP id r4mr3068321wrz.659.1644317313206;
        Tue, 08 Feb 2022 02:48:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id a13sm3971wmq.28.2022.02.08.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:48:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2] gpiolib: make struct comments into real kernel docs
Date:   Tue,  8 Feb 2022 11:48:31 +0100
Message-Id: <20220208104831.308722-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have several comments that start with '/**' but don't conform to the
kernel doc standard. Add proper detailed descriptions for the affected
definitions and move the docs from the forward declarations to the
struct definitions where applicable.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1 -> v2:
- described fields not yet documented
- added missing '@'
- made using periods consistent
- fixed struct references

 drivers/gpio/gpiolib.h        | 34 ++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h | 35 ++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..40723a179902 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -37,6 +37,9 @@
  * or name of the IP component in a System on Chip.
  * @data: per-instance data assigned by the driver
  * @list: links gpio_device:s together for traversal
+ * @notifier: used to notify subscribers about lines being requested, released
+ *            or reconfigured
+ * @pin_ranges: range of pins served by the GPIO driver
  *
  * This state container holds most of the runtime variable data
  * for a GPIO device and can hold references and live on after the
@@ -72,6 +75,20 @@ struct gpio_device {
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
+/**
+ * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
+ *
+ * @desc:		Array of pointers to the GPIO descriptors
+ * @size:		Number of elements in desc
+ * @chip:		Parent GPIO chip
+ * @get_mask:		Get mask used in fastpath
+ * @set_mask:		Set mask used in fastpath
+ * @invert_mask:	Invert mask used in fastpath
+ *
+ * This structure is attached to struct gpiod_descs obtained from
+ * gpiod_get_array() and can be passed back to get/set array functions in order
+ * to activate fast processing path if applicable.
+ */
 struct gpio_array {
 	struct gpio_desc	**desc;
 	unsigned int		size;
@@ -96,6 +113,23 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 extern spinlock_t gpio_lock;
 extern struct list_head gpio_devices;
 
+
+/**
+ * struct gpio_desc - Opaque descriptor for a GPIO
+ *
+ * @gdev:		Pointer to the parent GPIO device
+ * @flags:		Binary descriptor flags
+ * @label:		Name of the consumer
+ * @name:		Line name
+ * @hog:		Pointer to the device node that hogs this line (if any)
+ * @debounce_period_us:	Debounce period in microseconds
+ *
+ * These are obtained using gpiod_get() and are preferable to the old
+ * integer-based handles.
+ *
+ * Contrary to integers, a pointer to a &struct gpio_desc is guaranteed to be
+ * valid until the GPIO is released.
+ */
 struct gpio_desc {
 	struct gpio_device	*gdev;
 	unsigned long		flags;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3ad67b4a72be..c3aa8b330e1c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -8,27 +8,16 @@
 #include <linux/err.h>
 
 struct device;
-
-/**
- * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
- * preferable to the old integer-based handles.
- *
- * Contrary to integers, a pointer to a gpio_desc is guaranteed to be valid
- * until the GPIO is released.
- */
 struct gpio_desc;
-
-/**
- * Opaque descriptor for a structure of GPIO array attributes.  This structure
- * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
- * passed back to get/set array functions in order to activate fast processing
- * path if applicable.
- */
 struct gpio_array;
 
 /**
- * Struct containing an array of descriptors that can be obtained using
- * gpiod_get_array().
+ * struct gpio_descs - Struct containing an array of descriptors that can be
+ *                     obtained using gpiod_get_array()
+ *
+ * @info:	Pointer to the opaque gpio_array structure
+ * @ndescs:	Number of held descriptors
+ * @desc:	Array of pointers to GPIO descriptors
  */
 struct gpio_descs {
 	struct gpio_array *info;
@@ -43,8 +32,16 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
 
 /**
- * Optional flags that can be passed to one of gpiod_* to configure direction
- * and output value. These values cannot be OR'd.
+ * enum gpiod_flags - Optional flags that can be passed to one of gpiod_* to
+ *                    configure direction and output value. These values
+ *                    cannot be OR'd.
+ *
+ * @GPIOD_ASIS:			Don't change anything
+ * @GPIOD_IN:			Set lines to input mode
+ * @GPIOD_OUT_LOW:		Set lines to output and drive them low
+ * @GPIOD_OUT_HIGH:		Set lines to output and drive them high
+ * @GPIOD_OUT_LOW_OPEN_DRAIN:	Set lines to open-drain output and drive them low
+ * @GPIOD_OUT_HIGH_OPEN_DRAIN:	Set lines to open-drain output and drive them high
  */
 enum gpiod_flags {
 	GPIOD_ASIS	= 0,
-- 
2.30.1

