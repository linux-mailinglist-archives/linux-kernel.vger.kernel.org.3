Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECF4A3416
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 06:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiA3FIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 00:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiA3FIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 00:08:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A27C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 21:08:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j16so9712889plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=K+srP5VtjGUVfkF3Gd4z8iDliRUZYWBlpiguTbcMjJ0=;
        b=KN7STkDHGeQZ+/fNT/PQ+6ccsDcfJnLHbvGFF0XJC+T28JDxFH7W55A0ieHnZg5U+C
         K/y9H+pNTIB/Pddn0z6vP/z6k4eUsng+Pz0ooMsO3VQAKq/pIYK+4PcXNR0iBfUJfolu
         Z9kAth7ajWR4RyfDMpMYjJgVobBuY+xKVADMP4S4bp/IWqCHzCnZ5baaE/Q+/lRaE22y
         qE5lFkWNw+Q9uSVntysvwOh5ft/jLQ5wk5TQpO5buEHe/S4v8+RJD/KTFDrLGVbxQQ2E
         jffDFflrXZps3bkFA2xJFQFyWb9vptBOfEeS1QB6rtT64pXfA2AsyHLWN13CIcC9YttJ
         9PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K+srP5VtjGUVfkF3Gd4z8iDliRUZYWBlpiguTbcMjJ0=;
        b=V54hBZmn4r11CHhfveur25y1nT4PvuNwOoCQSEyRGi395twQWE+dwFew1LJ1Mb4ZH3
         zrCmT5scd51bL4kWagtdhpvCeLhqACBuO8FJTLpUKjmGSoyUvdXyGjAdv6HgO/BEa7HL
         eW6mtYqxcqFO5/9aHUREXGYH9uYazebfMMcZiMSO8OzdtuH7HF/Mtb7kxslYIpvWEll9
         yQyhHlE/ZCIvSEH/sCq400g8L+CvRy5EVDnoLcNOE6tdNw2yJCSv6epF+rF6Mpm6Ed3F
         /NluhirS/si1XRIPTnv7iIMp+BIypzR1WKVlze2vqjwzO7gmeqdWRbiCqJWf0UaeUW/A
         cUXA==
X-Gm-Message-State: AOAM532FdVo3Ul0u1gY+l0cWdVsbCziaT3cNgvtgdP8Gh44M26YuRUjh
        G38FiVdWzLBCXQe30k1N2VBn36MhesxbYCOA
X-Google-Smtp-Source: ABdhPJzg5kvfXicnLxOB+7t6a/SutVJjX2J8kjE0aEuyT7W7WExZP2ys9vjwywim6+Pox8l0rSrYkg==
X-Received: by 2002:a17:90a:17a5:: with SMTP id q34mr27892356pja.1.1643519325450;
        Sat, 29 Jan 2022 21:08:45 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id p16sm1081948pgj.79.2022.01.29.21.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 21:08:44 -0800 (PST)
Date:   Sun, 30 Jan 2022 18:08:38 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove coding style item from the TODO file
Message-ID: <YfYdVokxsQ+Adl+T@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After several patches sent by the community along the last couple of
years, it's possible to remove the coding style item from the TODO file
in the driver's folder.

This patch addresses the last code formatting inconsistences and remove
the coding style item from the TODO file.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Patch dependency:

- https://lore.kernel.org/lkml/YfX+llwDWZZMz+NY@mail.google.com/

---
 drivers/staging/pi433/TODO       |  1 -
 drivers/staging/pi433/pi433_if.c | 12 ++++--------
 drivers/staging/pi433/rf69.c     |  3 ++-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index b9e6c01a0..8d0f1b579 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -1,4 +1,3 @@
-* coding style does not fully comply with the kernel style guide.
 * still TODOs, annotated in the code
 * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
   -> Replace this with another interface, hints are welcome!
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 74748d3cd..02d4ccebf 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -364,8 +364,7 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 
 /*-------------------------------------------------------------------------*/
 
-static int
-pi433_start_rx(struct pi433_device *dev)
+static int pi433_start_rx(struct pi433_device *dev)
 {
 	int retval;
 
@@ -405,8 +404,7 @@ pi433_start_rx(struct pi433_device *dev)
 
 /*-------------------------------------------------------------------------*/
 
-static int
-pi433_receive(void *data)
+static int pi433_receive(void *data)
 {
 	struct pi433_device *dev = data;
 	struct spi_device *spi = dev->spi;
@@ -557,8 +555,7 @@ pi433_receive(void *data)
 		return bytes_total;
 }
 
-static int
-pi433_tx_thread(void *data)
+static int pi433_tx_thread(void *data)
 {
 	struct pi433_device *device = data;
 	struct spi_device *spi = device->spi;
@@ -883,8 +880,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	return -EAGAIN;
 }
 
-static long
-pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index b1a3382f4..2ab3bf46e 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -654,7 +654,8 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_CRC_OK);
 	case battery_low:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_LOW_BAT);
-	default:			 return false;
+	default:
+		return false;
 	}
 }
 
-- 
2.34.1

