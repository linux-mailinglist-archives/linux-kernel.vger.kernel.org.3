Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A51A4CE264
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 04:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiCEDPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 22:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiCEDPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 22:15:24 -0500
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E552E4C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 19:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646450067;
        bh=MoRWkBCGHh6uj/3DTU7PAocT9mJ5UpfhoQY8dYgmb7M=;
        h=From:To:Cc:Subject:Date;
        b=f0A71MDi8knuhSzPyzjjhfL5Suxj4gVqYePPaqmJPqXb+HpUUQWwf3r57YyGs1Xrt
         d19SVOVYd9yu0C3ifoTauhq1NExgEYv9CdbHDcxSXtncpV5Xda+Rg0wu1XZyDDkbDB
         AbVI7qosVHbkhJJ4S3zM06ykzFRNOTTtuhZDqNo0=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id 398186FF; Sat, 05 Mar 2022 11:14:24 +0800
X-QQ-mid: xmsmtpt1646450064tj6nqdwyo
Message-ID: <tencent_C920CFCC33B9CC1C63141FE1334A39FF8508@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCCGP4N5Q8XMBzTgW1bB6sAyaLNEOLz0Riv5fxR4iYWaAkIr7YYT
         MKghDj0A7G68NVGVzv9hGqsUPnQKDjj3fqk1VWPFmonI4n56fsmUYGokbSJZcB/G5FiO9yT3ZAMO
         lmsN/loqfL7ZR1/kfXWUeeD9Pz2s0A2TQbyzSVZnITwuDdhvyJvcbJPR+VwrfuV8jH8Q7XzKmtyn
         YsFgyDtpVArt9aufcOni5iQ/MMkQUwSrOduGkQq9U1iVuisPKA68xdkNNyOpJqwySxEuq//wrNlv
         QCiPut/KbKYyugn4nwMYxreSNXC+SrU5T+6zi2D4jGXcSxeq88gcxP7lK2w/c5VtQ2EYO7YN0zg5
         ZHkf601MiexSbb9hl31xIbOpv8FViXwj8UASwTj3exO4BV0W97NOYB6/y+Tq7HXMnmS/e0HMsICv
         g7UGPYpvLpiN3AGCQgEQR7b/Whoh9hbVXNszZpuquNNE59wpJTh+j9ER12s+JQuuKzvHTan14bfC
         fjEANgduU1srY2ljIEq/GbHizI+VmbMRHA/PxuZV1IJIXJOtTo2soqn8Vk+0mmlm/KKa0mdaYeqt
         Fux2zw15GRnwCFwAaYOLMdSpaHpUITRS8eRLcRlKCNNj9Wjcsw5YVGTA3Sxiy4n0Bmqay3aIiCwX
         RWoXr2utfvKltiqd5rWWpp2TrkoAC3IaYNyrDrgV52jYwZ5Z29tgD546f7DL1bL8ZACFCd22R7nq
         hK1gyUlbTTSC5sa583zup17/44oaYNk8zGfM+XHLMleRDcgewKVkwTL0ljYMv6Cy+jw7tReZw4hO
         HDq+Xsi1aCt/b/rNMqag5bM/PhgDn3Opq7gHcRvW6gsTAKdvZ509z8a353iHUt0LzWYzP0WZ6fYd
         ReW0CeLNKFg/rCr3DMxVW3ECFFIO8jkZh6VzFEnwnz+E7T/J7LDZRzvskrKgw904YZscqWl/JnfX
         dyPFHDNMXm4/+VpJNfY2RS3yKZUC6uHQYvSC4/Rnw=
From:   xkernel.wang@foxmail.com
To:     jic23@kernel.org, jic23@jic23.retrosnub.co.uk
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] iio: dummy: iio_simple_dummy: check the return value of kstrdup()
Date:   Sat,  5 Mar 2022 11:14:05 +0800
X-OQ-MSGID: <20220305031405.5735-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kstrdup() is also a memory allocation-related function, it returns NULL
when some memory errors happen. So it is better to check the return
value of it so to catch the memory error in time. Besides, there should
have a kfree() to clear up the allocation if we get a failure later in
this function to prevent memory leak.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
I am sorry that I forgot to send this.
Changelogs:
v1->v2 add kfree() on the error path.
v2->v3 change the err lable.
 drivers/iio/dummy/iio_simple_dummy.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index c0b7ef9..99e7731 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -575,10 +575,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 */
 
 	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
-	if (!swd) {
-		ret = -ENOMEM;
-		goto error_kzalloc;
-	}
+	if (!swd)
+		return ERR_PTR(-ENOMEM);
+
 	/*
 	 * Allocate an IIO device.
 	 *
@@ -590,7 +589,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	indio_dev = iio_device_alloc(parent, sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
-		goto error_ret;
+		goto error_free_swd;
 	}
 
 	st = iio_priv(indio_dev);
@@ -616,6 +615,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
 	indio_dev->name = kstrdup(name, GFP_KERNEL);
+	if (!indio_dev->name) {
+		ret = -ENOMEM;
+		goto error_free_device;
+	}
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -650,10 +653,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 error_unregister_events:
 	iio_simple_dummy_events_unregister(indio_dev);
 error_free_device:
+	kfree(indio_dev->name);
 	iio_device_free(indio_dev);
-error_ret:
+error_free_swd:
 	kfree(swd);
-error_kzalloc:
 	return ERR_PTR(ret);
 }
 
-- 
