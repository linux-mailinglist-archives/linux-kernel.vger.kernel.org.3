Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879FE527721
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiEOKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiEOKta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:49:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06247140AF
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:49:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso6603258wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8DJTPE3mkzI/piGEgq+ZgV9Tn8rXucT6hxx4Y+0548=;
        b=brfFMUT8ZA9fONQ4fAAg0//gZoGYwLz8pTnPJ+zgqZnRCifaB6S1eCl5pt4RwEKPEQ
         1rS59KdDo6qNUfBt4VnQAGlGUJuOdB9puAExtduhYHcumJ+eqTReQXREx8bNy/xJ/Qoy
         DfMfemgoZlannOj5KwJaMT4QLxF1wQmhwE9ULkx47bv94dmA7OoSCbjXWVsrwza6+f7e
         zhYrOt3TenLXxkmbwN1ERXamReNWEGcW72x1kRTW1YFQLpvZRYimr38XzgI7r5NcNK3U
         KRMF0Y1q31ZFsxExPwWfINfeFZqhZSEt4WwQyvy7APCX5rEFBp+E0v/w/e2FmOt92890
         CwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8DJTPE3mkzI/piGEgq+ZgV9Tn8rXucT6hxx4Y+0548=;
        b=IdkVcLAzF4bFYi9HWd0c/S8D2nFx4Y8RFhE+iJIoMn94LkmnT911G1ngbGxt+n8iDm
         yGeiBgbi2uVjvLTvVj4gUKC3PEaKSxm58PsJASOKXGA9LkD7pGCIEKi//DTqrhQxCzKB
         k6qtGSrf5yktHJdSyJvVWb0NrprjJixj0LTdQDZpAb/okYN2C5qKMIL7hLCW54OTXcGP
         8C3utQI9l+H5xwEH8B+CjT13ys83U+Z+eNzJJUSBAQuzme8TEe/AOk5H33QOutIYUROO
         7NiiKHC0xZgE8MnUVzZ5ZbKLiUOwNQVLK6IprGXLBwPn+0Wh6l5AmFgEg88Vf3OJycPh
         K3xQ==
X-Gm-Message-State: AOAM532yEG1iYGwSIKvbZJ0eqyXKdJaIQorhgsy1hivU552upY3J7gMJ
        uHtP0CllGQWJTV3IWqFtRMBawE3M3HQ5ZA==
X-Google-Smtp-Source: ABdhPJx3RiXG3f1aAh1G9zId5ilOjHFDNRgdWwch+DExHemvpgkIGRFpTg/3GdoruGll8enhFwFzxA==
X-Received: by 2002:a05:600c:ad3:b0:394:46ae:549b with SMTP id c19-20020a05600c0ad300b0039446ae549bmr22760589wmr.113.1652611767542;
        Sun, 15 May 2022 03:49:27 -0700 (PDT)
Received: from localhost.localdomain ([78.187.39.231])
        by smtp.gmail.com with ESMTPSA id c65-20020a1c3544000000b003949dbc3790sm7282462wma.18.2022.05.15.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 03:49:27 -0700 (PDT)
From:   =?UTF-8?q?Ya=C5=9Far=20Arabac=C4=B1?= <yasar11732@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     paulo.miguel.almeida.rodenas@gmail.com, dan.carpenter@oracle.com,
        alexandre.belloni@bootlin.com, realwakka@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ya=C5=9Far=20Arabac=C4=B1?= <yasar11732@gmail.com>
Subject: [PATCH] Staging: pi433: Don't use ioctl for per-client configuration
Date:   Sun, 15 May 2022 13:47:11 +0300
Message-Id: <20220515104711.94567-1-yasar11732@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently this driver uses ioctl for reading/writing per-device and
per-client configuration. Per-client configuration can be handled by
usespace and sent to driver with each write() call. Doing so does not
introduce extra overhead because we copy tx config to fifo for each
transmit anyway. This way, we don't have to introduce new ioctl's.

This has not been tested as I don't have access to hardware.

Signed-off-by: Yaşar Arabacı <yasar11732@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 63 ++++++--------------------------
 drivers/staging/pi433/pi433_if.h |  7 +---
 2 files changed, 13 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 941aaa7eab2e..07cd9054560a 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -109,10 +109,6 @@ struct pi433_device {
 
 struct pi433_instance {
 	struct pi433_device	*device;
-	struct pi433_tx_cfg	tx_cfg;
-
-	/* control flags */
-	bool			tx_cfg_initialized;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -574,12 +570,6 @@ static int pi433_tx_thread(void *data)
 		if (kthread_should_stop())
 			return 0;
 
-		/*
-		 * get data from fifo in the following order:
-		 * - tx_cfg
-		 * - size of message
-		 * - message
-		 */
 		retval = kfifo_out(&device->tx_fifo, &tx_cfg, sizeof(tx_cfg));
 		if (retval != sizeof(tx_cfg)) {
 			dev_dbg(device->dev,
@@ -588,13 +578,7 @@ static int pi433_tx_thread(void *data)
 			continue;
 		}
 
-		retval = kfifo_out(&device->tx_fifo, &size, sizeof(size_t));
-		if (retval != sizeof(size_t)) {
-			dev_dbg(device->dev,
-				"reading msg size from fifo failed: got %d, expected %d\n",
-				retval, (unsigned int)sizeof(size_t));
-			continue;
-		}
+		size = tx_cfg.payload_size;
 
 		/* use fixed message length, if requested */
 		if (tx_cfg.fixed_message_length != 0)
@@ -811,6 +795,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	    size_t count, loff_t *f_pos)
 {
 	struct pi433_instance	*instance;
+	struct pi433_tx_cfg *tx_cfg;
 	struct pi433_device	*device;
 	int                     retval;
 	unsigned int		required, available, copied;
@@ -822,18 +807,16 @@ pi433_write(struct file *filp, const char __user *buf,
 	 * check, whether internal buffer (tx thread) is big enough
 	 * for requested size
 	 */
-	if (count > MAX_MSG_SIZE)
+	if (unlikely(count > MAX_MSG_SIZE))
 		return -EMSGSIZE;
 
-	/*
-	 * check if tx_cfg has been initialized otherwise we won't be able to
-	 * config the RF trasmitter correctly due to invalid settings
-	 */
-	if (!instance->tx_cfg_initialized) {
-		dev_notice_once(device->dev,
-				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)\n");
-		return -EINVAL;
-	}
+	if (unlikely(count < sizeof(struct pi433_tx_cfg)))
+		return -EMSGSIZE;
+
+	tx_cfg = (struct pi433_tx_cfg *)buf;
+
+	if (unlikely(count != sizeof(struct pi433_tx_cfg)) + tx_cfg->payload_size)
+		return -EMSGSIZE;
 
 	/*
 	 * write the following sequence into fifo:
@@ -843,24 +826,14 @@ pi433_write(struct file *filp, const char __user *buf,
 	 */
 	mutex_lock(&device->tx_fifo_lock);
 
-	required = sizeof(instance->tx_cfg) + sizeof(size_t) + count;
 	available = kfifo_avail(&device->tx_fifo);
-	if (required > available) {
+	if (count > available) {
 		dev_dbg(device->dev, "write to fifo failed: %d bytes required but %d available\n",
 			required, available);
 		mutex_unlock(&device->tx_fifo_lock);
 		return -EAGAIN;
 	}
 
-	retval = kfifo_in(&device->tx_fifo, &instance->tx_cfg,
-			  sizeof(instance->tx_cfg));
-	if (retval != sizeof(instance->tx_cfg))
-		goto abort;
-
-	retval = kfifo_in(&device->tx_fifo, &count, sizeof(size_t));
-	if (retval != sizeof(size_t))
-		goto abort;
-
 	retval = kfifo_from_user(&device->tx_fifo, buf, count, &copied);
 	if (retval || copied != count)
 		goto abort;
@@ -884,7 +857,6 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
-	struct pi433_tx_cfg	tx_cfg;
 	void __user *argp = (void __user *)arg;
 
 	/* Check type and command number */
@@ -898,19 +870,6 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ESHUTDOWN;
 
 	switch (cmd) {
-	case PI433_IOC_RD_TX_CFG:
-		if (copy_to_user(argp, &instance->tx_cfg,
-				 sizeof(struct pi433_tx_cfg)))
-			return -EFAULT;
-		break;
-	case PI433_IOC_WR_TX_CFG:
-		if (copy_from_user(&tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
-			return -EFAULT;
-		mutex_lock(&device->tx_fifo_lock);
-		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
-		instance->tx_cfg_initialized = true;
-		mutex_unlock(&device->tx_fifo_lock);
-		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
 				 sizeof(struct pi433_rx_cfg)))
diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 25ee0b77a32c..5dd2a3c6e661 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -75,6 +75,8 @@ struct pi433_tx_cfg {
 
 	__u8			sync_pattern[8];
 	__u8			address_byte;
+	__u32			payload_size;
+	__u8			payload[];
 };
 
 /**
@@ -135,11 +137,6 @@ struct pi433_rx_cfg {
 
 #define PI433_IOC_MAGIC	'r'
 
-#define PI433_IOC_RD_TX_CFG                                             \
-	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
-#define PI433_IOC_WR_TX_CFG                                             \
-	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
-
 #define PI433_IOC_RD_RX_CFG                                             \
 	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
 #define PI433_IOC_WR_RX_CFG                                             \
-- 
2.36.1

