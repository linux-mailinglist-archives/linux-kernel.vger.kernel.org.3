Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3149B5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386996AbiAYOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385713AbiAYODV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:03:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C361FC061753
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:03:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n8so25394934wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJrQ9ObzNlNozSIKWvdHvhQL2KbmeMWXNOVyepscZoU=;
        b=uk3M1RCXBTWUdrrRAHUzNJ8CKFsVVN0hhoVPaMae8S2ApdbeKVVAccs0m+wRZx0pyO
         E3XvpOBk193CoEFlB2BQSdJZUVVPfjfDX1UOkbWLhHO55xKhQcnF/BWxaw5ei2oeibwP
         Q1C7aioUvBSRgL78TlCZV1lfjjim6aDegCP5y6njccvXFKeIeY5uTU6LhIOXV8XMFDRJ
         sw3vhc6xgSFgLDJB7vVFW7wBaQj2DeKipmV7E711TqCj7dLA2CVX7wPJJrbYaaQE3n1g
         NsjQGxLP+okw6xRt9hEO5oeMS9pDy68aO9MyOxDyqxhhChiHB4uJdUpzeJDQFfDMFM8Q
         4i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OJrQ9ObzNlNozSIKWvdHvhQL2KbmeMWXNOVyepscZoU=;
        b=6CXfkyoht/IdCoUHzyJmqfag9Dy1cksraf3FTcNhqsGiRWvpR/FbCpwanXI92xx7hM
         49YurSQrxXXkTOUB5i3n2hGU7yFYnMH061GnM9kKkuIN6doEQuZB3xIxakTDLER4UJij
         r26+aFHhPD5h2NcGWI9Bl6yDkUUJVAXqaMM2GcXFoIi92unnSWbdxuAuipy6vGhWV4gP
         5AGq1NyN260mSlOk3SJg6gs6B8xfHHrkWRsfxy7aYUHBaFFh0pesLniAPTTeLm//fQQd
         NOEJ4/qoUBVDzTWiZqNjjIvN07PHp/I8pwfw9hnZiB82/tzhje7ndl4DqFCYDEfdqiz6
         iKoA==
X-Gm-Message-State: AOAM533h1m0AjA/nEcxGQvP1gv8R9T0oPkpChgAqB/wx7Jd30qPm9b6y
        NYEIF63nZIhbyRTEyyPajuxBgsGJZXFkwg==
X-Google-Smtp-Source: ABdhPJwHpmjb2qYXif/OsOg/To0gQCQz+kE5P8sis36QRCZ/5mTp4L6vQkW2ZAO5ytfKolW6heO63A==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr3150534wme.3.1643119398321;
        Tue, 25 Jan 2022 06:03:18 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j15sm598178wmq.19.2022.01.25.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:03:17 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, clemens@ladisch.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] hpet: fix style issue about braces and alignment
Date:   Tue, 25 Jan 2022 14:03:11 +0000
Message-Id: <20220125140311.4084998-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix all style issue for braces and alignment

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/char/hpet.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 55bd63c97d00..ee71376f174b 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -253,9 +253,9 @@ static int hpet_open(struct inode *inode, struct file *file)
 
 	for (devp = NULL, hpetp = hpets; hpetp && !devp; hpetp = hpetp->hp_next)
 		for (i = 0; i < hpetp->hp_ntimer; i++)
-			if (hpetp->hp_dev[i].hd_flags & HPET_OPEN)
+			if (hpetp->hp_dev[i].hd_flags & HPET_OPEN) {
 				continue;
-			else {
+			} else {
 				devp = &hpetp->hp_dev[i];
 				break;
 			}
@@ -302,9 +302,9 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		devp->hd_irqdata = 0;
 		spin_unlock_irq(&hpet_lock);
 
-		if (data)
+		if (data) {
 			break;
-		else if (file->f_flags & O_NONBLOCK) {
+		} else if (file->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		} else if (signal_pending(current)) {
@@ -967,7 +967,8 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 				break;
 
 			irq = acpi_register_gsi(NULL, irqp->interrupts[i],
-				      irqp->triggering, irqp->polarity);
+						irqp->triggering,
+						irqp->polarity);
 			if (irq < 0)
 				return AE_ERROR;
 
-- 
2.34.1

