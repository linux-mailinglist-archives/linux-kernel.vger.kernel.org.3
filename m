Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205215A254B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiHZKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiHZKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:31 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F40BB02B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id D03A8323834
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508088;
        bh=IWqwVsdazSfv41xKDS9xL+X3jJ1zkSqWxIzmy0IJtU0=;
        h=From:To:Cc:Subject:Date;
        b=FpIWwnQtmokiZ9JDbJvGH5XdgsI/4qXwmyndsHzkfiilkGzLYFxXZBD8Hw2dCGVob
         Q8WrwlAf1k5qEBQKaW2c3Ad6Or9d0Rc+bjrwVsCUKCOdLc44+EsQ0AKR0t67HCGRcL
         DOZIYtinPQ8aU9v5WWK80PkzC53BcbGbt/PkMCFo=
Received: from fx409 (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 683A73238BF;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <62b1.630899f5.6646e.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx409.security-mail.net (Postfix) with ESMTPS id 67E98323834;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 1F6F527E0396;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 08E8927E0392;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 08E8927E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508085;
        bh=zs73o10H7uL434cqdBywD/xopWvN+dDf0lK4XbaWJlA=;
        h=From:To:Date:Message-Id;
        b=MelV7xl6I+ru/XdI5FyAnGvO+LJei5N3ueyNNaWngRm+8JpYHdcrEkFLnyT/5ERTf
         xzZVrgymf0UjQAtQEhV/am55p8of1oD3GPO+LzqVEWaOE6PrhyErijLAVgQiGjBMvT
         Ge1rwRFS1Ef8zB2xZVb/PTuLTS/IaY0eGuUFk2vc=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Eq5uE6gaEYWi; Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id EC92527E02FA;
        Fri, 26 Aug 2022 12:01:24 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: pci: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:48 +0200
Message-Id: <20220826100052.22945-20-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Andy Walls <awalls@md.metrocast.net>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/pci/cx88/cx88-dsp.c        | 2 +-
 drivers/media/pci/ivtv/ivtv-yuv.c        | 2 +-
 drivers/media/pci/saa7164/saa7164-core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-dsp.c b/drivers/media/pci/cx88/cx88-dsp.c
index f1e1fc1cb4bd..e378f3b215c7 100644
--- a/drivers/media/pci/cx88/cx88-dsp.c
+++ b/drivers/media/pci/cx88/cx88-dsp.c
@@ -24,7 +24,7 @@
 
 /*
  * We calculate the baseband frequencies of the carrier and the pilot tones
- * based on the the sampling rate of the audio rds fifo.
+ * based on the sampling rate of the audio rds fifo.
  */
 
 #define FREQ_A2_CARRIER         baseband_freq(54687.5, 2689.36, 0.0)
diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index e79e8a5a744a..4ba10c34a16a 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -538,7 +538,7 @@ static void ivtv_yuv_handle_vertical(struct ivtv *itv, struct yuv_frame_info *f)
 	reg_2964 = (reg_2964 << 16) + reg_2964 + (reg_2964 * 46 / 94);
 
 	/* Okay, we've wasted time working out the correct value,
-	   but if we use it, it fouls the the window alignment.
+	   but if we use it, it fouls the window alignment.
 	   Fudge it to what we want... */
 	reg_2964 = 0x00010001 + ((reg_2964 & 0x0000FFFF) - (reg_2964 >> 16));
 	reg_2968 = 0x00010001 + ((reg_2968 & 0x0000FFFF) - (reg_2968 >> 16));
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 7973ae42873a..d5f32e3ff544 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -626,7 +626,7 @@ static irqreturn_t saa7164_irq(int irq, void *dev_id)
 	portf = &dev->ports[SAA7164_PORT_VBI2];
 
 	/* Check that the hardware is accessible. If the status bytes are
-	 * 0xFF then the device is not accessible, the the IRQ belongs
+	 * 0xFF then the device is not accessible, the IRQ belongs
 	 * to another driver.
 	 * 4 x u32 interrupt registers.
 	 */
-- 
2.17.1

