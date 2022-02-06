Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835AE4AB231
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiBFVGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiBFVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:06:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D44C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:06:44 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id j10so9884687pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=su79yK5PjW7+pNzvbyvigH1Rm7iVRwIedAHcLPkHlXo=;
        b=WL/h0XEU/FQBVU/6TSAIaMBIqxlXMHmR/cjzq9O6IODRjNP/QcVDCjWpQkxJO5szaY
         VDajaBWRprXdq0tzTxHUD0m80BlcKovgf30Vy6gp7fz15n1LJW75jaJZ9R2K7Bgw1zb0
         gOMP6VouAetxryE0XBSzyHFT5qfpnQPx0+JZ1mrIw4hV8ALNI77xuO7VHuzss8ATM+vr
         vQhhZTky3zWBL/eIqMLH3IXdO8BYMh/Lk/D1CJdmSyY+KvrHY1rxMxQsUrrUqCJFEuUw
         1ctDFUfZyKT6F/TsaaI2Xm+Ycy0a6MA7D02ihfBhnP1CPo88C37wbxR2kT6JaorWH5s5
         3sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=su79yK5PjW7+pNzvbyvigH1Rm7iVRwIedAHcLPkHlXo=;
        b=gUbhvSgjGwSpL4Mden2T/dc9NrqUplze285eoj2RAl08fP2XEus/LmQ4MtGiimClc7
         CL2LhbRfnZ9fmnWd6XbWt7suJmGyNTQDTuJcyyHT1aYo1xD7mG3+YZL+5FYRxO/OLU1/
         n7aDqh6P6PdCTtY2nxGdtwyZ9z5q6989XZjbb463webu4sD/3NBOiRGD+g8e4MtiL9ij
         na17Y/FLK44raPew0K4DKtjLtSiIXDSAEPDlY9Q23XDa0HnpIlGttwv/Hu9XTTc1ie7k
         0bC4yY6R6hBgR68fIccyNQFprVzsloblXNjYUe08Vt/PqU9ntwq6NJ88ZCKUE3UlLU8t
         MWqQ==
X-Gm-Message-State: AOAM533SzFEmk9+poFZxxWB8j3p/xempkXLqJPGtoKDsG6Ul74QzuUxr
        0BVADhFZm3Z8EPRI3chO+fw=
X-Google-Smtp-Source: ABdhPJw8rzO6wntMCJ+EAbfoCeoAM2IbVZtHM+HdXLCICLOfxcwE/vez4/iDN2KLFKBACRoan0bmPw==
X-Received: by 2002:a05:6a00:1a53:: with SMTP id h19mr12806016pfv.65.1644181603029;
        Sun, 06 Feb 2022 13:06:43 -0800 (PST)
Received: from mail.google.com ([124.157.67.163])
        by smtp.gmail.com with ESMTPSA id pi9sm8836778pjb.46.2022.02.06.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:06:42 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:06:36 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: standardize use of line escape chars in
 dev_dbg stmts
Message-ID: <YgA4XHU4uf6YkOk5@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver there are strings ending with of both '\n' and ''
(without '\n') when using dev_dbg function. While it doesn't affect
drivers functionality, it would be good to keep it consistent across the
driver's source code.

This patch add '\n' characters where it's missing to make it consistent
with the other dev_dbg instances.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:
- Originally I proposed removing '\n' chars in the patch below, however
  Dan Carpenter explained to me that '\n'-ending strings would be a
  better option giving that this is defined by consensus in this
  particular case. Given that the patch changed it's original purpose,
  I'm not submitting it as 'v2' of the original patch.
  https://lore.kernel.org/lkml/YfYtsiKbOXghIN+5@mail.google.com/

Patch dependency:
- This patch needs to be applied after the patch below is applied since
  both of them tweak the same files.
  https://lore.kernel.org/lkml/Yf9ivRB5qpmA5rY2@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 54 ++++++++++++++++----------------
 drivers/staging/pi433/rf69.c     | 51 +++++++++++++++---------------
 2 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 4fbac3ccef74..069255f023c8 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -414,7 +414,7 @@ static int pi433_receive(void *data)
 	dev->interrupt_rx_allowed = false;
 
 	/* wait for any tx to finish */
-	dev_dbg(dev->dev, "rx: going to wait for any tx to finish");
+	dev_dbg(dev->dev, "rx: going to wait for any tx to finish\n");
 	retval = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
 	if (retval) {
 		/* wait was interrupted */
@@ -440,7 +440,7 @@ static int pi433_receive(void *data)
 		wake_up_interruptible(&dev->tx_wait_queue);
 
 		/* wait for RSSI level to become high */
-		dev_dbg(dev->dev, "rx: going to wait for high RSSI level");
+		dev_dbg(dev->dev, "rx: going to wait for high RSSI level\n");
 		retval = wait_event_interruptible(dev->rx_wait_queue,
 						  rf69_get_flag(dev->spi,
 								rssi_exceeded_threshold));
@@ -467,11 +467,11 @@ static int pi433_receive(void *data)
 			goto abort;
 		}
 		bytes_total = dev->rx_cfg.fixed_message_length;
-		dev_dbg(dev->dev, "rx: msg len set to %d by fixed length",
+		dev_dbg(dev->dev, "rx: msg len set to %d by fixed length\n",
 			bytes_total);
 	} else {
 		bytes_total = dev->rx_buffer_size;
-		dev_dbg(dev->dev, "rx: msg len set to %d as requested by read",
+		dev_dbg(dev->dev, "rx: msg len set to %d as requested by read\n",
 			bytes_total);
 	}
 
@@ -488,7 +488,7 @@ static int pi433_receive(void *data)
 			goto abort;
 		}
 		dev->free_in_fifo++;
-		dev_dbg(dev->dev, "rx: msg len reset to %d due to length byte",
+		dev_dbg(dev->dev, "rx: msg len reset to %d due to length byte\n",
 			bytes_total);
 	}
 
@@ -505,7 +505,7 @@ static int pi433_receive(void *data)
 
 		rf69_read_fifo(spi, &dummy, 1);
 		dev->free_in_fifo++;
-		dev_dbg(dev->dev, "rx: address byte stripped off");
+		dev_dbg(dev->dev, "rx: address byte stripped off\n");
 	}
 
 	/* get payload */
@@ -567,7 +567,7 @@ static int pi433_tx_thread(void *data)
 
 	while (1) {
 		/* wait for fifo to be populated or for request to terminate*/
-		dev_dbg(device->dev, "thread: going to wait for new messages");
+		dev_dbg(device->dev, "thread: going to wait for new messages\n");
 		wait_event_interruptible(device->tx_wait_queue,
 					 (!kfifo_is_empty(&device->tx_fifo) ||
 					  kthread_should_stop()));
@@ -583,7 +583,7 @@ static int pi433_tx_thread(void *data)
 		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
 			dev_dbg(device->dev,
-				"reading tx_cfg from fifo failed: got %d byte(s), expected %d",
+				"reading tx_cfg from fifo failed: got %d byte(s), expected %d\n",
 				retval, (unsigned int)sizeof(tx_cfg));
 			continue;
 		}
@@ -591,7 +591,7 @@ static int pi433_tx_thread(void *data)
 		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
 		if (retval != sizeof(size_t)) {
 			dev_dbg(device->dev,
-				"reading msg size from fifo failed: got %d, expected %d",
+				"reading msg size from fifo failed: got %d, expected %d\n",
 				retval, (unsigned int)sizeof(size_t));
 			continue;
 		}
@@ -628,7 +628,7 @@ static int pi433_tx_thread(void *data)
 		retval = kfifo_out(&device->tx_fifo, &device->buffer[position],
 				   sizeof(device->buffer) - position);
 		dev_dbg(device->dev,
-			"read %d message byte(s) from fifo queue.", retval);
+			"read %d message byte(s) from fifo queue.\n", retval);
 
 		/*
 		 * if rx is active, we need to interrupt the waiting for
@@ -733,7 +733,7 @@ static int pi433_tx_thread(void *data)
 
 		/* we are done. Wait for packet to get sent */
 		dev_dbg(device->dev,
-			"thread: wait for packet to get sent/fifo to be empty");
+			"thread: wait for packet to get sent/fifo to be empty\n");
 		wait_event_interruptible(device->fifo_wait_queue,
 					 device->free_in_fifo == FIFO_SIZE ||
 					 kthread_should_stop());
@@ -741,7 +741,7 @@ static int pi433_tx_thread(void *data)
 			return 0;
 
 		/* STOP_TRANSMISSION */
-		dev_dbg(device->dev, "thread: Packet sent. Set mode to stby.");
+		dev_dbg(device->dev, "thread: Packet sent. Set mode to stby.\n");
 		retval = rf69_set_mode(spi, standby);
 		if (retval < 0)
 			goto abort;
@@ -831,7 +831,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	 */
 	if (!instance->tx_cfg_initialized) {
 		dev_notice_once(device->dev,
-				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)");
+				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)\n");
 		return -EINVAL;
 	}
 
@@ -846,7 +846,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
 	available = kfifo_avail(&device->tx_fifo);
 	if (required > available) {
-		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available",
+		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available\n",
 			required, available);
 		mutex_unlock(&device->tx_fifo_lock);
 		return -EAGAIN;
@@ -869,13 +869,13 @@ pi433_write(struct file *filp, const char __user *buf,
 
 	/* start transfer */
 	wake_up_interruptible(&device->tx_wait_queue);
-	dev_dbg(device->dev, "write: generated new msg with %d bytes.", copied);
+	dev_dbg(device->dev, "write: generated new msg with %d bytes.\n", copied);
 
 	return copied;
 
 abort:
 	dev_warn(device->dev,
-		 "write to fifo failed, non recoverable: 0x%x", retval);
+		 "write to fifo failed, non recoverable: 0x%x\n", retval);
 	mutex_unlock(&device->tx_fifo_lock);
 	return -EAGAIN;
 }
@@ -1000,12 +1000,12 @@ static int setup_gpio(struct pi433_device *device)
 
 		if (device->gpiod[i] == ERR_PTR(-ENOENT)) {
 			dev_dbg(&device->spi->dev,
-				"Could not find entry for %s. Ignoring.", name);
+				"Could not find entry for %s. Ignoring.\n", name);
 			continue;
 		}
 
 		if (device->gpiod[i] == ERR_PTR(-EBUSY))
-			dev_dbg(&device->spi->dev, "%s is busy.", name);
+			dev_dbg(&device->spi->dev, "%s is busy.\n", name);
 
 		if (IS_ERR(device->gpiod[i])) {
 			retval = PTR_ERR(device->gpiod[i]);
@@ -1038,7 +1038,7 @@ static int setup_gpio(struct pi433_device *device)
 		if (retval)
 			return retval;
 
-		dev_dbg(&device->spi->dev, "%s successfully configured", name);
+		dev_dbg(&device->spi->dev, "%s successfully configured\n", name);
 	}
 
 	return 0;
@@ -1186,7 +1186,7 @@ static int pi433_probe(struct spi_device *spi)
 	}
 
 	dev_dbg(&spi->dev,
-		"spi interface setup: mode 0x%2x, %d bits per word, %dhz max speed",
+		"spi interface setup: mode 0x%2x, %d bits per word, %dhz max speed\n",
 		spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
 	/* read chip version */
@@ -1196,10 +1196,10 @@ static int pi433_probe(struct spi_device *spi)
 
 	switch (retval) {
 	case 0x24:
-		dev_dbg(&spi->dev, "found pi433 (ver. 0x%x)", retval);
+		dev_dbg(&spi->dev, "found pi433 (ver. 0x%x)\n", retval);
 		break;
 	default:
-		dev_dbg(&spi->dev, "unknown chip version: 0x%x", retval);
+		dev_dbg(&spi->dev, "unknown chip version: 0x%x\n", retval);
 		return -ENODEV;
 	}
 
@@ -1236,7 +1236,7 @@ static int pi433_probe(struct spi_device *spi)
 	/* setup GPIO (including irq_handler) for the different DIOs */
 	retval = setup_gpio(device);
 	if (retval) {
-		dev_dbg(&spi->dev, "setup of GPIOs failed");
+		dev_dbg(&spi->dev, "setup of GPIOs failed\n");
 		goto GPIO_failed;
 	}
 
@@ -1266,7 +1266,7 @@ static int pi433_probe(struct spi_device *spi)
 	/* determ minor number */
 	retval = pi433_get_minor(device);
 	if (retval) {
-		dev_dbg(&spi->dev, "get of minor number failed");
+		dev_dbg(&spi->dev, "get of minor number failed\n");
 		goto minor_failed;
 	}
 
@@ -1295,7 +1295,7 @@ static int pi433_probe(struct spi_device *spi)
 					     "pi433.%d_tx_task",
 					     device->minor);
 	if (IS_ERR(device->tx_task_struct)) {
-		dev_dbg(device->dev, "start of send thread failed");
+		dev_dbg(device->dev, "start of send thread failed\n");
 		retval = PTR_ERR(device->tx_task_struct);
 		goto send_thread_failed;
 	}
@@ -1303,7 +1303,7 @@ static int pi433_probe(struct spi_device *spi)
 	/* create cdev */
 	device->cdev = cdev_alloc();
 	if (!device->cdev) {
-		dev_dbg(device->dev, "allocation of cdev failed");
+		dev_dbg(device->dev, "allocation of cdev failed\n");
 		retval = -ENOMEM;
 		goto cdev_failed;
 	}
@@ -1311,7 +1311,7 @@ static int pi433_probe(struct spi_device *spi)
 	cdev_init(device->cdev, &pi433_fops);
 	retval = cdev_add(device->cdev, device->devt, 1);
 	if (retval) {
-		dev_dbg(device->dev, "register of cdev failed");
+		dev_dbg(device->dev, "register of cdev failed\n");
 		goto del_cdev;
 	}
 
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index bf26aef69daa..a8def70808d6 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -85,7 +85,7 @@ int rf69_set_mode(struct spi_device *spi, enum mode mode)
 	};
 
 	if (unlikely(mode >= ARRAY_SIZE(mode_map))) {
-		dev_dbg(&spi->dev, "set: illegal mode %u", mode);
+		dev_dbg(&spi->dev, "set: illegal mode %u\n", mode);
 		return -EINVAL;
 	}
 
@@ -115,7 +115,7 @@ int rf69_set_modulation(struct spi_device *spi, enum modulation modulation)
 	};
 
 	if (unlikely(modulation >= ARRAY_SIZE(modulation_map))) {
-		dev_dbg(&spi->dev, "set: illegal modulation %u", modulation);
+		dev_dbg(&spi->dev, "set: illegal modulation %u\n", modulation);
 		return -EINVAL;
 	}
 
@@ -163,7 +163,7 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 						   MASK_DATAMODUL_MODULATION_SHAPE,
 						   DATAMODUL_MODULATION_SHAPE_0_3);
 		default:
-			dev_dbg(&spi->dev, "set: illegal mod shaping for FSK %u", mod_shaping);
+			dev_dbg(&spi->dev, "set: illegal mod shaping for FSK %u\n", mod_shaping);
 			return -EINVAL;
 		}
 	case OOK:
@@ -181,11 +181,11 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 						   MASK_DATAMODUL_MODULATION_SHAPE,
 						   DATAMODUL_MODULATION_SHAPE_2BR);
 		default:
-			dev_dbg(&spi->dev, "set: illegal mod shaping for OOK %u", mod_shaping);
+			dev_dbg(&spi->dev, "set: illegal mod shaping for OOK %u\n", mod_shaping);
 			return -EINVAL;
 		}
 	default:
-		dev_dbg(&spi->dev, "set: modulation undefined");
+		dev_dbg(&spi->dev, "set: modulation undefined\n");
 		return -EINVAL;
 	}
 }
@@ -201,13 +201,13 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
 	// check if modulation is configured
 	mod = rf69_get_modulation(spi);
 	if (mod == UNDEF) {
-		dev_dbg(&spi->dev, "setBitRate: modulation is undefined");
+		dev_dbg(&spi->dev, "setBitRate: modulation is undefined\n");
 		return -EINVAL;
 	}
 
 	// check input value
 	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
-		dev_dbg(&spi->dev, "setBitRate: illegal input param");
+		dev_dbg(&spi->dev, "setBitRate: illegal input param\n");
 		return -EINVAL;
 	}
 
@@ -251,7 +251,7 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
 	 */
 	if (deviation < 600 || (deviation + (bit_rate / 2)) > 500000) {
 		dev_dbg(&spi->dev,
-			"set_deviation: illegal input param: %u", deviation);
+			"set_deviation: illegal input param: %u\n", deviation);
 		return -EINVAL;
 	}
 
@@ -268,7 +268,7 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
 
 	// check msb
 	if (msb & ~FDEVMASB_MASK) {
-		dev_dbg(&spi->dev, "set_deviation: err in calc of msb");
+		dev_dbg(&spi->dev, "set_deviation: err in calc of msb\n");
 		return -EINVAL;
 	}
 
@@ -301,7 +301,7 @@ int rf69_set_frequency(struct spi_device *spi, u32 frequency)
 	// check input value
 	f_max = div_u64(f_step * 8388608, factor);
 	if (frequency > f_max) {
-		dev_dbg(&spi->dev, "setFrequency: illegal input param");
+		dev_dbg(&spi->dev, "setFrequency: illegal input param\n");
 		return -EINVAL;
 	}
 
@@ -382,7 +382,7 @@ int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
 	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER,
 				   power_level);
 failed:
-	dev_dbg(&spi->dev, "set: illegal power level %u", power_level);
+	dev_dbg(&spi->dev, "set: illegal power level %u\n", power_level);
 	return -EINVAL;
 }
 
@@ -407,7 +407,7 @@ int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
 	};
 
 	if (unlikely(pa_ramp >= ARRAY_SIZE(pa_ramp_map))) {
-		dev_dbg(&spi->dev, "set: illegal pa_ramp %u", pa_ramp);
+		dev_dbg(&spi->dev, "set: illegal pa_ramp %u\n", pa_ramp);
 		return -EINVAL;
 	}
 
@@ -423,7 +423,7 @@ int rf69_set_antenna_impedance(struct spi_device *spi,
 	case two_hundred_ohm:
 		return rf69_set_bit(spi, REG_LNA, MASK_LNA_ZIN);
 	default:
-		dev_dbg(&spi->dev, "set: illegal antenna impedance %u", antenna_impedance);
+		dev_dbg(&spi->dev, "set: illegal antenna impedance %u\n", antenna_impedance);
 		return -EINVAL;
 	}
 }
@@ -441,7 +441,7 @@ int rf69_set_lna_gain(struct spi_device *spi, enum lna_gain lna_gain)
 	};
 
 	if (unlikely(lna_gain >= ARRAY_SIZE(lna_gain_map))) {
-		dev_dbg(&spi->dev, "set: illegal lna gain %u", lna_gain);
+		dev_dbg(&spi->dev, "set: illegal lna gain %u\n", lna_gain);
 		return -EINVAL;
 	}
 
@@ -456,14 +456,14 @@ static int rf69_set_bandwidth_intern(struct spi_device *spi, u8 reg,
 
 	// check value for mantisse and exponent
 	if (exponent > 7) {
-		dev_dbg(&spi->dev, "set: illegal bandwidth exponent %u", exponent);
+		dev_dbg(&spi->dev, "set: illegal bandwidth exponent %u\n", exponent);
 		return -EINVAL;
 	}
 
 	if (mantisse != mantisse16 &&
 	    mantisse != mantisse20 &&
 	    mantisse != mantisse24) {
-		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u", mantisse);
+		dev_dbg(&spi->dev, "set: illegal bandwidth mantisse %u\n", mantisse);
 		return -EINVAL;
 	}
 
@@ -521,7 +521,8 @@ int rf69_set_ook_threshold_dec(struct spi_device *spi,
 	};
 
 	if (unlikely(threshold_decrement >= ARRAY_SIZE(td_map))) {
-		dev_dbg(&spi->dev, "set: illegal OOK threshold decrement %u", threshold_decrement);
+		dev_dbg(&spi->dev, "set: illegal OOK threshold decrement %u\n",
+			threshold_decrement);
 		return -EINVAL;
 	}
 
@@ -568,7 +569,7 @@ int rf69_set_dio_mapping(struct spi_device *spi, u8 dio_number, u8 value)
 		dio_addr = REG_DIOMAPPING2;
 		break;
 	default:
-		dev_dbg(&spi->dev, "set: illegal dio number %u", dio_number);
+		dev_dbg(&spi->dev, "set: illegal dio number %u\n", dio_number);
 		return -EINVAL;
 	}
 
@@ -672,7 +673,7 @@ int rf69_set_fifo_fill_condition(struct spi_device *spi,
 		return rf69_clear_bit(spi, REG_SYNC_CONFIG,
 				      MASK_SYNC_CONFIG_FIFO_FILL_CONDITION);
 	default:
-		dev_dbg(&spi->dev, "set: illegal fifo fill condition %u", fifo_fill_condition);
+		dev_dbg(&spi->dev, "set: illegal fifo fill condition %u\n", fifo_fill_condition);
 		return -EINVAL;
 	}
 }
@@ -681,7 +682,7 @@ int rf69_set_sync_size(struct spi_device *spi, u8 sync_size)
 {
 	// check input value
 	if (sync_size > 0x07) {
-		dev_dbg(&spi->dev, "set: illegal sync size %u", sync_size);
+		dev_dbg(&spi->dev, "set: illegal sync size %u\n", sync_size);
 		return -EINVAL;
 	}
 
@@ -718,7 +719,7 @@ int rf69_set_packet_format(struct spi_device *spi,
 		return rf69_clear_bit(spi, REG_PACKETCONFIG1,
 				      MASK_PACKETCONFIG1_PACKET_FORMAT_VARIABLE);
 	default:
-		dev_dbg(&spi->dev, "set: illegal packet format %u", packet_format);
+		dev_dbg(&spi->dev, "set: illegal packet format %u\n", packet_format);
 		return -EINVAL;
 	}
 }
@@ -744,7 +745,7 @@ int rf69_set_address_filtering(struct spi_device *spi,
 	};
 
 	if (unlikely(address_filtering >= ARRAY_SIZE(af_map))) {
-		dev_dbg(&spi->dev, "set: illegal address filtering %u", address_filtering);
+		dev_dbg(&spi->dev, "set: illegal address filtering %u\n", address_filtering);
 		return -EINVAL;
 	}
 
@@ -779,7 +780,7 @@ int rf69_set_tx_start_condition(struct spi_device *spi,
 		return rf69_set_bit(spi, REG_FIFO_THRESH,
 				    MASK_FIFO_THRESH_TXSTART);
 	default:
-		dev_dbg(&spi->dev, "set: illegal tx start condition %u", tx_start_condition);
+		dev_dbg(&spi->dev, "set: illegal tx start condition %u\n", tx_start_condition);
 		return -EINVAL;
 	}
 }
@@ -790,7 +791,7 @@ int rf69_set_fifo_threshold(struct spi_device *spi, u8 threshold)
 
 	/* check input value */
 	if (threshold & 0x80) {
-		dev_dbg(&spi->dev, "set: illegal fifo threshold %u", threshold);
+		dev_dbg(&spi->dev, "set: illegal fifo threshold %u\n", threshold);
 		return -EINVAL;
 	}
 
@@ -817,7 +818,7 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 	};
 
 	if (unlikely(dagc >= ARRAY_SIZE(dagc_map))) {
-		dev_dbg(&spi->dev, "set: illegal dagc %u", dagc);
+		dev_dbg(&spi->dev, "set: illegal dagc %u\n", dagc);
 		return -EINVAL;
 	}
 
-- 
2.34.1

