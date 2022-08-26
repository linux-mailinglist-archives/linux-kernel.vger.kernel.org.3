Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE145A254A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbiHZKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245414AbiHZKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:33 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE096F25A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id ADE29323842
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508088;
        bh=jH9u55xoEl5fjJm0ZnYiHwhOtEMoREMp1lLHQ6qSoZQ=;
        h=From:To:Cc:Subject:Date;
        b=uE1kNmcxaFrGW/dcDxPM7Ui8HDZm8K0g9CRg4AzS3YXiUK1pwsi0SAQkRAs6KScaG
         PvRCkrk7FdnSCRq3wp2YQ3gv/DzMaYPYuzOrOgxa73Pbcx8C5MMvPgssyKBchg8uFn
         tVDkhfgLpJStkAhjuLXtSNnYk5rXkWURrEfbQqAI=
Received: from fx405 (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 2BBFC32382C;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <97eb.630899f6.1d19a.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx405.security-mail.net (Postfix) with ESMTPS id 1F3B132383D;
        Fri, 26 Aug 2022 12:01:26 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id DC80727E02FA;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id C634327E0392;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu C634327E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508085;
        bh=vabnn3dBTh05+XFUF+tEvTaFAN/F2mML7V7liWpEnYs=;
        h=From:To:Date:Message-Id;
        b=TRLlJm7ow6Auz8F47GQIy2Qm/SRiiyXJJIrfmZ8f9aRtVRZKJphQqSae6AEgaYRil
         vwEX6y1wAUh1NVk3pWcVjdJJDa7+w4qhjU0rAiCrHiBXSVpxVIsvfzWXSE/HFfDNe+
         68VrJVFwXECcXo7s/cIBSE7GRweX/aX8/5ZTMwj4=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QDtUcm_SRFBG; Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id AC21527E02FA;
        Fri, 26 Aug 2022 12:01:25 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: usb: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:49 +0200
Message-Id: <20220826100052.22945-21-jmaselbas@kalray.eu>
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

Remove redundant words `the` and `by`.

CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/usb/gspca/finepix.c       | 2 +-
 drivers/media/usb/gspca/ov519.c         | 2 +-
 drivers/media/usb/tm6000/tm6000-cards.c | 2 +-
 drivers/media/usb/uvc/uvc_video.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/gspca/finepix.c b/drivers/media/usb/gspca/finepix.c
index 66c8e5122a0a..bc6133b525e3 100644
--- a/drivers/media/usb/gspca/finepix.c
+++ b/drivers/media/usb/gspca/finepix.c
@@ -129,7 +129,7 @@ static void dostream(struct work_struct *work)
 				 * for, then it's the end of the
 				 * frame. Sometimes the jpeg is not complete,
 				 * but there's nothing we can do. We also end
-				 * here if the the jpeg ends right at the end
+				 * here if the jpeg ends right at the end
 				 * of the frame. */
 				gspca_frame_add(gspca_dev, LAST_PACKET,
 						data, len);
diff --git a/drivers/media/usb/gspca/ov519.c b/drivers/media/usb/gspca/ov519.c
index bffa94e76da5..57219a738c73 100644
--- a/drivers/media/usb/gspca/ov519.c
+++ b/drivers/media/usb/gspca/ov519.c
@@ -13,7 +13,7 @@
  * Copyright (c) 1999-2006 Mark W. McClelland
  * Support for OV519, OV8610 Copyright (c) 2003 Joerg Heckenbach
  * Many improvements by Bret Wallach <bwallac1@san.rr.com>
- * Color fixes by by Orion Sky Lawlor <olawlor@acm.org> (2/26/2000)
+ * Color fixes by Orion Sky Lawlor <olawlor@acm.org> (2/26/2000)
  * OV7620 fixes by Charl P. Botha <cpbotha@ieee.org>
  * Changes by Claudio Matsuoka <claudio@conectiva.com>
  *
diff --git a/drivers/media/usb/tm6000/tm6000-cards.c b/drivers/media/usb/tm6000/tm6000-cards.c
index 98f4a63adc2a..b7842cd6f9af 100644
--- a/drivers/media/usb/tm6000/tm6000-cards.c
+++ b/drivers/media/usb/tm6000/tm6000-cards.c
@@ -1297,7 +1297,7 @@ static int tm6000_usb_probe(struct usb_interface *interface,
 		le16_to_cpu(dev->udev->descriptor.idProduct),
 		interface->altsetting->desc.bInterfaceNumber);
 
-/* check if the the device has the iso in endpoint at the correct place */
+/* check if the device has the iso in endpoint at the correct place */
 	if (!dev->isoc_in.endp) {
 		printk(KERN_ERR "tm6000: probing error: no IN ISOC endpoint!\n");
 		rc = -ENODEV;
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..d2eb9066e4dc 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1095,7 +1095,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
 	/*
 	 * Synchronize to the input stream by waiting for the FID bit to be
-	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
+	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
 	 * stream->last_fid is initialized to -1, so the first isochronous
 	 * frame will always be in sync.
 	 *
-- 
2.17.1

