Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F252E0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbiESXnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbiESXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:43:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEF11905C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:43:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so6505498pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=KonITGC8b24pPGJKeGVvyl7Yn0hzGwQOqRY+o+LJZsk=;
        b=RpxpIDLapZJZlhiqATdf8DiIf+nLRAEvQCq+++X1vi2A9tl7Q8grx12Vza0qIKE58z
         mi3nSfhxtd+AVX45Y/FQ7bLv+2i7mUd8RIOxaNsMWck9OQRJnEeJCI3MXrgQB6IQVSUS
         qNgCdNp/X8mDGmQnjgNyYbouExpm/K9Q565gtU1631bOa3oP1rOCqeKTIafBtAKubxge
         ujTlHShXkLDtbOcN490iUi1QcuDLwGQyy0tPnFrjn8+teLzDzclxWhGceFCZ4hMiaJMm
         LFBdYQC7GK2L+RRC45DD4E6ar4Gv4YAsNQSbTyxogCWkOEgs31aCXA9hfD1aPfh1dGim
         H3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=KonITGC8b24pPGJKeGVvyl7Yn0hzGwQOqRY+o+LJZsk=;
        b=yrUQjyHV/N612ss1hSmtoeEFhaH9hVA0eTGxcFYFHmrXm182GPEgHNcaA9Sz3jWi3s
         WVVEBYyyELMWxmejGtH+a/X/0B4jylc876TsNsHwuZoKtgseUiZutWCrJN0UZANJQKnN
         ira3o9gxj8RMFpS3AneqTgz39oGlz1a3sQNmBOPgom1fDe0aZDrpiQ0ieaVRRAI5gGTm
         TfMPwcdw3i4JVrc5eM+gd3xDZkTumR7F3uvP/qtUUmV8qeaAjxmHdmfbtgLCjVR5TFqY
         Q15sinyJ7OoyN2a9QxDpadNUvrdVWpiu77xFj04eXSyOX5qYkMkFZVNCPONv/th6tL+X
         1Anw==
X-Gm-Message-State: AOAM531Grxg5xPfYI2CC5JruAbeY9lLyIz28GX+rkkZTNMvMSOHn+ZVq
        F+dt3B1gG88wo0FzKOHC7WkS74h3C52/pg==
X-Google-Smtp-Source: ABdhPJzhHFe9lJvBKafFKUAY1pRa6T+CtSrKokdXVOQr0cLt53/hZc/fXU1CHWvrIHdmP0hJxcqsQg==
X-Received: by 2002:a17:902:f78d:b0:14f:ce61:eaf2 with SMTP id q13-20020a170902f78d00b0014fce61eaf2mr7148968pln.124.1653003797430;
        Thu, 19 May 2022 16:43:17 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id cp25-20020a056a00349900b0050dc76281c0sm220975pfb.154.2022.05.19.16.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:43:16 -0700 (PDT)
Message-ID: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
Date:   Thu, 19 May 2022 17:43:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] random: convert to using fops->write_iter()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the read side has been converted to fix a regression with
splice, convert the write side as well to have some symmetry in the
interface used (and help deprecate ->write()).

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Jason, this has only been booted. I did verify that it seems to take a
write just fine, but I would appreciate if you could vet this one with
your testing. Thanks!

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 41ca5966aa4f..3da04068c225 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1283,20 +1283,20 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return crng_ready() ? EPOLLIN | EPOLLRDNORM : EPOLLOUT | EPOLLWRNORM;
 }
 
-static int write_pool(const char __user *ubuf, size_t len)
+static size_t write_pool(struct iov_iter *iter)
 {
 	size_t block_len;
 	int ret = 0;
 	u8 block[BLAKE2S_BLOCK_SIZE];
 
-	while (len) {
-		block_len = min(len, sizeof(block));
-		if (copy_from_user(block, ubuf, block_len)) {
-			ret = -EFAULT;
+	while (iov_iter_count(iter)) {
+		block_len = min(iov_iter_count(iter), sizeof(block));
+		if (!copy_from_iter(block, block_len, iter)) {
+			if (!ret)
+				ret = -EFAULT;
 			goto out;
 		}
-		len -= block_len;
-		ubuf += block_len;
+		ret += block_len;
 		mix_pool_bytes(block, block_len);
 		cond_resched();
 	}
@@ -1306,16 +1306,9 @@ static int write_pool(const char __user *ubuf, size_t len)
 	return ret;
 }
 
-static ssize_t random_write(struct file *file, const char __user *ubuf,
-			    size_t len, loff_t *ppos)
+static ssize_t random_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 {
-	int ret;
-
-	ret = write_pool(ubuf, len);
-	if (ret)
-		return ret;
-
-	return (ssize_t)len;
+	return write_pool(from);
 }
 
 static ssize_t urandom_read_iter(struct kiocb *kiocb, struct iov_iter *to)
@@ -1373,7 +1366,10 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		credit_init_bits(ent_count);
 		return 0;
-	case RNDADDENTROPY:
+	case RNDADDENTROPY: {
+		struct iov_iter iter;
+		struct iovec iov;
+
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		if (get_user(ent_count, p++))
@@ -1382,11 +1378,16 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(size, p++))
 			return -EFAULT;
-		retval = write_pool((const char __user *)p, size);
+
+		iov.iov_base = p;
+		iov.iov_len = size;
+		iov_iter_init(&iter, WRITE, &iov, 1, size);
+		retval = write_pool(&iter);
 		if (retval < 0)
 			return retval;
 		credit_init_bits(ent_count);
 		return 0;
+		}
 	case RNDZAPENTCNT:
 	case RNDCLEARPOOL:
 		/* No longer has any effect. */
@@ -1412,7 +1413,7 @@ static int random_fasync(int fd, struct file *filp, int on)
 
 const struct file_operations random_fops = {
 	.read_iter = random_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -1423,7 +1424,7 @@ const struct file_operations random_fops = {
 
 const struct file_operations urandom_fops = {
 	.read_iter = urandom_read_iter,
-	.write = random_write,
+	.write_iter = random_write_iter,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,

-- 
Jens Axboe

