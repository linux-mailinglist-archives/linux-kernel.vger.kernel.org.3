Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08E48C0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbiALJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiALJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:17:27 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B9C06173F;
        Wed, 12 Jan 2022 01:17:26 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id e25so1773782qkl.12;
        Wed, 12 Jan 2022 01:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NFO7YFOhu5N2KIpI5XoTsgg4HKZco8DxgkDsyob4xk=;
        b=B7sUTA+M2I9UMuxHrM840LUe9oBfvMj2/YBE7zbzM0Ej0+pkS6t1CtznD22MEzfLxE
         aLWI9fyF0okNiGKnuO0biBcIZj77rAfbg23XSdrSAwdBoLCHdso9l5urR+Qkzxt5G+Zg
         AnS2MIZaOVa3UeLkY5lkW10L5yWmkqU14ohVcleH73ET322XgIoNbLNTfSQ7cdXVr5f5
         qzdlKj32aUMP+ZII0QiSoytdDu1hPNpxlIo8WFc1mT6mMOmB5eB62Wh9thiWl12ICrqI
         IxvKDnkvEfLyDZgmXjRhXnxtN6eUFhd0dvGaoyVQX6zv2AVcL/wOa00We4PiiGeW0bii
         IVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NFO7YFOhu5N2KIpI5XoTsgg4HKZco8DxgkDsyob4xk=;
        b=VndDjH5aaYqo93Ofvr8peHKHzeOkm5QhUA3DIF15ccYnJ3sqqq8o3/SOah/T2Td6Hs
         tZtur9HrZAVOKiiKPqtn/ARlGifFCFJ0rdmtAsiJ9Y3DEyvEZP1ajfC2NbuUj7lIH7a+
         VGsSmPK3xNsPhKgiFj3Eo0x+XAG4+WcpLL7sLV4ojSwhucgS2+rEIPMRaiVkSETVavI2
         lIBZFTS+VxYUGG228LLw1SstdegYMBu49TK+TM5XfAcLaldUj1h7scp8VZX1dfL0gvQE
         xgLSPn10Ya/AG3LpvRxoPys6r0osV+NJyZZiKQBBBKDhkZNoFEk+6oBq3zcEZ34GXmW6
         16IA==
X-Gm-Message-State: AOAM53160mK4u9HDaTA/ehdBunJRczmVYwr+xVdxrmzV1MZFuDThGd6e
        0nes3tW70K4pJKziH43VcTE=
X-Google-Smtp-Source: ABdhPJwx4z2TJB79mUF7qBiS98SXynKTINHLUqSHAtHhA+1CCgGXGQ0xytwVwpwtCam8uL03gzNpzg==
X-Received: by 2002:a37:9c8:: with SMTP id 191mr1032972qkj.358.1641979046074;
        Wed, 12 Jan 2022 01:17:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f4sm8365315qkp.14.2022.01.12.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 01:17:25 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     djrscally@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] media: i2c: remove unneeded variable
Date:   Wed, 12 Jan 2022 09:17:18 +0000
Message-Id: <20220112091718.668278-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/media/i2c/ov5693.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 2784fcf67f3b..a55910f6283a 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -950,7 +950,6 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
 	unsigned int width, height;
 	unsigned int hblank;
 	int exposure_max;
-	int ret = 0;
 
 	crop = __ov5693_get_pad_crop(ov5693, state, format->pad, format->which);
 
@@ -982,7 +981,7 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
 	format->format = *fmt;
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
-		return ret;
+		return 0;
 
 	mutex_lock(&ov5693->lock);
 
@@ -1012,7 +1011,7 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
 				     exposure_max));
 
 	mutex_unlock(&ov5693->lock);
-	return ret;
+	return 0;
 }
 
 static int ov5693_get_selection(struct v4l2_subdev *sd,
-- 
2.25.1

