Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B504A3AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356602AbiA3WbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiA3WbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:31:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB21C061714;
        Sun, 30 Jan 2022 14:31:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e2so21917461wra.2;
        Sun, 30 Jan 2022 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qfnq3r8dUjy2WwJMiSILTPUFk/Rn2N79sVKgYgCfIA8=;
        b=CGrLjjxbIwaiJ0QiDWj4HjawyTXS9SUyVIle+XCoCYYseCvw/4WIpZ7H/Cv3AK+w/e
         iibmB4C3IVTsXAqIv4laompEA61HpuyW07KLJ6iUe9xEd5RYQBHL3mCU1XQO14AuLqK5
         8kSFAEnJa2ZFr9byADJCHRPK1QcbQDM/8tTGTor0mOH5IkIdUQeXZslCcG7euzESIkxU
         ZjP/tAsdMCO7UJO3n2MeyC++CbA4jQrDIu1NNo3ZxiDVQUY9o/ebkE2rSVuBGI74jX/r
         PpMUMa6LUSuaFWXCeQwzv/hIDWHgjHqQD8DuXgwExaF7AwET+/zydvRkKH8pnlzT5ujd
         u+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qfnq3r8dUjy2WwJMiSILTPUFk/Rn2N79sVKgYgCfIA8=;
        b=wuspglm2SojoSW8AUs+dOJwAE6GTt1ydc/TIV8VB1qEKCjZ5SOX733QBcFnjonrOH9
         /y7JDnyUTx9WrjluNFa7FBngm5Zm/m3dwvxb4Zsqv7bMMj3mIySJfbLszKj+DZai0S1T
         tD+VKQGf+Ix/+Jllr/BTNhv09FuVr0VFZZEE7I3sSCRnBumVipRk/HeVh0O/Kmv2D9HH
         rgjRVdvqxDHpB6acts4dRGEhVZBkzZQ8P34Jgtvp4ec/Km89kTB2kGYJldnsf++NXtXx
         dnXM6wfj4waKvOE0ys2bU0D2XM6OYnszmIWNgei+HQUcd/AgqpPaI8Dc9n2F+6a7uIc8
         LmRA==
X-Gm-Message-State: AOAM530eQlosXPGpTPrVlwtdP0CJiaicC/H529pSEGKEOSD+YadhdF8k
        7Hc4mZPyoXJKkzXYvJLbJBc=
X-Google-Smtp-Source: ABdhPJztqKfhsF0N16NIMVCPm96w/hpZCjhyrZZ8DoCY7fiG0BGbxtI+3WycgftZRZW5I73lu0DSaQ==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr15166391wrc.463.1643581865204;
        Sun, 30 Jan 2022 14:31:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a15sm10089489wrp.41.2022.01.30.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:31:04 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: gspca: remove redundant assignment of variable n
Date:   Sun, 30 Jan 2022 22:31:03 +0000
Message-Id: <20220130223103.6754-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable n is being assigned a value that is never read, it is
being reassigned a different value a few statements later. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/usb/gspca/pac7302.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/usb/gspca/pac7302.c b/drivers/media/usb/gspca/pac7302.c
index 2e8c3ef51ca3..608be0d64f94 100644
--- a/drivers/media/usb/gspca/pac7302.c
+++ b/drivers/media/usb/gspca/pac7302.c
@@ -794,7 +794,6 @@ static void sd_pkt_scan(struct gspca_dev *gspca_dev,
 		n = (sof - data) - (footer_length + sizeof pac_sof_marker);
 		if (n < 0) {
 			gspca_dev->image_len += n;
-			n = 0;
 		} else {
 			gspca_frame_add(gspca_dev, INTER_PACKET, data, n);
 		}
-- 
2.34.1

