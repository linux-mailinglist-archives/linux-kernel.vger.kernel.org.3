Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48346E06A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhLIBxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhLIBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:53:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50ABC061746;
        Wed,  8 Dec 2021 17:50:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r130so4071634pfc.1;
        Wed, 08 Dec 2021 17:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kAuDSD+w3sTkKTlbYSdBEEprFYW9+pYkzbg13xwXJls=;
        b=dUAL9AkSUh3LpBe4LKcpksliFNO7JUGW1Ecaqt9ZHQyiajq8mNYFjAdCrAKMLkS0LS
         vTVVy7hTyfTU9m69Ysy0IN5slKH/qvzuCuiI0YpHwFhk+PU08ecZgq2Zjd2LTlx1gEZZ
         yoGdSSkSutTZ4L6BeW7HKf2ahtcQznn53rN61Jb8XbFG740N3vVaGDpBfOJsjaqCYlNJ
         eZ3UF2lo6bn5MIhEgE34gDTJCKS03WEIjoZQM/qVTeoyZj2A9UzPjmlSVHpIMmHKY5A2
         BnKYYg/BC1rtY4ZCFJgJvzvQn86ocwhaxVmd4zsNl4jTxy8A63G63TmHEOiJtAZKzvaH
         p4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kAuDSD+w3sTkKTlbYSdBEEprFYW9+pYkzbg13xwXJls=;
        b=QkYdzR8VwLuu4h5HPQeO3F1kPOl/0AwEk2Olq9y6BDV8b9O3wRMXkT6V7kaBuiLWmn
         hHeCMZNrRFch/UKBw7qrFF8GnDM/TEy3TP4dSA+6zyt5bVsVNzlAM4Qx9mA1b3V/CG62
         iUGcDmwsOlD+j4blrpo3siXWMoTg6O/zyP9HQ3Wl67ThJWlq59WGJ6wCMzdoLPhWg4MJ
         Lem6h98Lb6sW5+8Aqss8rLv3EgmyZZnf+O9JLyeiZ9EWNXoFHuJwj/HtC/NfsV0+lIKQ
         +SLWKsvIqdY+2qAVOUDCTKRZzgWSX4GzeHiFSeKKvMdyqk4/diuN6n/ZlI/WEgxdcbZ0
         3v0w==
X-Gm-Message-State: AOAM530a5GbUcsWUEtAXaY1QleY4e6o+05cZNQNBD2g0XTFjzkQDUOK0
        oMHUiijpt5igZ85ksrCjR+k=
X-Google-Smtp-Source: ABdhPJz5pFExYym/XR69VtAaL40/RnJo068mdQGPY5gVLQR4P34x3yhcHAbf2zB7Sd9QzDVm7uB++g==
X-Received: by 2002:a63:8ac8:: with SMTP id y191mr32067907pgd.438.1639014617532;
        Wed, 08 Dec 2021 17:50:17 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g189sm3709081pgc.3.2021.12.08.17.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:50:16 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     erik.andren@gmail.com
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] drivers:usb:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:50:09 +0000
Message-Id: <20211209015009.409428-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 drivers/media/usb/gspca/m5602/m5602_s5k83a.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/gspca/m5602/m5602_s5k83a.c b/drivers/media/usb/gspca/m5602/m5602_s5k83a.c
index bc4008d5d116..6b8f157f0a7d 100644
--- a/drivers/media/usb/gspca/m5602/m5602_s5k83a.c
+++ b/drivers/media/usb/gspca/m5602/m5602_s5k83a.c
@@ -408,25 +408,21 @@ static int s5k83a_set_gain(struct gspca_dev *gspca_dev, __s32 val)
 
 static int s5k83a_set_brightness(struct gspca_dev *gspca_dev, __s32 val)
 {
-	int err;
 	u8 data[1];
 	struct sd *sd = (struct sd *) gspca_dev;
 
 	data[0] = val;
-	err = m5602_write_sensor(sd, S5K83A_BRIGHTNESS, data, 1);
-	return err;
+	return m5602_write_sensor(sd, S5K83A_BRIGHTNESS, data, 1);
 }
 
 static int s5k83a_set_exposure(struct gspca_dev *gspca_dev, __s32 val)
 {
-	int err;
 	u8 data[2];
 	struct sd *sd = (struct sd *) gspca_dev;
 
 	data[0] = 0;
 	data[1] = val;
-	err = m5602_write_sensor(sd, S5K83A_EXPOSURE, data, 2);
-	return err;
+	return m5602_write_sensor(sd, S5K83A_EXPOSURE, data, 2);
 }
 
 static int s5k83a_set_flip_real(struct gspca_dev *gspca_dev,
-- 
2.25.1

