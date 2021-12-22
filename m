Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E3747CA31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhLVATz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLVATy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:19:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9AC061574;
        Tue, 21 Dec 2021 16:19:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n14so1017458wra.9;
        Tue, 21 Dec 2021 16:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlbQZBJsPzSOb2Y23tqujbAUFdJtMfm8Q+56I71cVy4=;
        b=m+CB35vLyPlIwR+fTfypaoqKqgZcStBl1ZPhkS6DtK+uqI6kwAtVPiJ1mLPSuL4PjH
         /BDL2cdlUz5mdVRfyovHSede+k853Sy2Yze9j51UvVBlGzrs36BHtb+KD/etda9SRcrf
         WATVZ21OhJabe+YObSzQn9jNC3LQSg4Pj6xG1CAhosmiSCPQlwXh7WHGns+YirC+kAh7
         zMX0fw5D+iVmLgaS3V0g1etTFs/iTOl3kPG/k1cBlIQ/IugxXSSrGozPC1ssa2Iau5o9
         Vpkpe6CmfAu+GHXReKwn0/dj2M5ZUqG6cAw1PUPbsd7Z8audslDiv+mhTTBqu39Lavq3
         Qi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DlbQZBJsPzSOb2Y23tqujbAUFdJtMfm8Q+56I71cVy4=;
        b=v9KhmiSCQZ+2AO56lkVTG4u7F1kpROzLJXs2lSrDnqUGPynDIGN16RcYTvX3MDVSY9
         xyt5MbSbLWIx8SxLhaqiLw9R/SegLDR2CC7HwQC8SraBYQdfeZyYnX96DFnDM5RQeCwb
         4KSybIRbaSgKT3nnVMpLXxz34oGdkgcgaWeX7PQ8uwcsjYrHipIY6xCJojMzZJrgeGYK
         wK7Z0qs9NdOF2Qh/0Y3Fpo9LSPRokZz7MwqImhRpM3Fv+HCtYGI64tzb47HTcZwsnFPQ
         kfPTVR+TSkBLMvWAhiz1Nxzn9E29epK+3mZd0U2N87mNsrq8j02IWd5zVPwsKP+qFcow
         irFQ==
X-Gm-Message-State: AOAM531j0+SFZrF3O4u9mBosUTaJeqLMXnxFOiSFyKGM6sjpcabLhol3
        MK0Tj5bwrvqmPTD/ol7LxWQ=
X-Google-Smtp-Source: ABdhPJymn6zZoJjf/QX9oe/9oAy1ALN4QUC/nYo/j93vEP2fYB+qpFpNZ7m0u1ASUKG0052QzFspOw==
X-Received: by 2002:a5d:548a:: with SMTP id h10mr357131wrv.221.1640132392491;
        Tue, 21 Dec 2021 16:19:52 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h4sm399520wrf.93.2021.12.21.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 16:19:52 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: ftdi-elan: remove redundant variable l
Date:   Wed, 22 Dec 2021 00:19:51 +0000
Message-Id: <20211222001951.725632-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable l is being used to summate w, however the value
is never used afterwards. The summation is redundant so
remove variable l.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/misc/ftdi-elan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 6c38c62d29b2..4837def43122 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -1627,7 +1627,6 @@ wait:if (ftdi->disconnected > 0) {
 			char data[30 *3 + 4];
 			char *d = data;
 			int m = (sizeof(data) - 1) / 3 - 1;
-			int l = 0;
 			struct u132_target *target = &ftdi->target[ed];
 			struct u132_command *command = &ftdi->command[
 				COMMAND_MASK & ftdi->command_next];
@@ -1651,7 +1650,6 @@ wait:if (ftdi->disconnected > 0) {
 				} else if (i++ < m) {
 					int w = sprintf(d, " %02X", *b++);
 					d += w;
-					l += w;
 				} else
 					d += sprintf(d, " ..");
 			}
-- 
2.33.1

