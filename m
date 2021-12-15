Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C15476193
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbhLOTVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhLOTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:21:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFDBC061574;
        Wed, 15 Dec 2021 11:21:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z5so79193127edd.3;
        Wed, 15 Dec 2021 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a52zq15vpbe/q6jA/7CfhJp1eVSjrKX60Heccwe2TQs=;
        b=B98v3wgxFCiJcdr1Ly+YLJFrh7y+vq5EWE1XRKEORWyQzgQC+cVZGY/oVhbxMmP4qa
         IrQNiDBhJB7uvgh3nKuRhiMTdGTgwrLQ8G2Z9Snb48jPQ+th8W0HlFjpxcS6Uoup22A1
         KJ5utGaM2rW/2SFpLZFnEtt4anqLsF2i5zPH1YUa+dCQdlIGdXtRl7U4aqOw0Nk9Ux2f
         boPSI4cLZ5E95mwSIp2ZYqpp3Z/Q1IX55JGT9a4lBcjw+SAh+LVfaF9M2qSIlRd8fzb1
         tJWEMaV+cuh6lOetER2OD85Zu5iZlmzySA3U7ydnKrdk59U03Roau2WzglK4FesxKWeQ
         49Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a52zq15vpbe/q6jA/7CfhJp1eVSjrKX60Heccwe2TQs=;
        b=UNvYbFNmRskGJm5Iz9Yy5CQebGsSQcVDPJ1VN77D+/hWWN2nvBa5BEZ69eqCEmADuA
         MPPRTo2vRlSD1+4lD5IuVs9wribzbep9LxPp+3CkccxmHWN5qQcq+u6zQPXfnj1eWzFY
         yzJM+gzD+2zxYP9yt+fSlEIpDk3VNY42F0kWrDTOHeCTNlqkh8lDJtjCQp8upjuuywN9
         rnl47A9nmIDBILtuQrkqBWdtTMdLaxnLvlzKjXrSiaX+6Cr2dtuAhv3VHyar7yrqgrlR
         hYzUCg4ANovKOGnvHnITQKev7Rpdnwtx1rQCn/6Bp/yTo3/6hrVu7xVT1kL4/FtsObKS
         yJcw==
X-Gm-Message-State: AOAM532I59mlCAaWfMfIcoThPAwNognhm6HFzzj/NFA509RqmIcrqbZL
        wITb4+kfQ4LaiM+kLyCxIks=
X-Google-Smtp-Source: ABdhPJwqcSIXnkSQXY6ynvdgZuHHX6yGAZq0rD8knDCqqtR64It6E5IZbjDyyjAPgeb3am+lgiJhkQ==
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr12337690ejc.355.1639596100502;
        Wed, 15 Dec 2021 11:21:40 -0800 (PST)
Received: from zenorus.myxoz.lan (81-232-177-112-no2390.tbcn.telia.com. [81.232.177.112])
        by smtp.gmail.com with ESMTPSA id n10sm1461049edx.3.2021.12.15.11.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:21:40 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>
Subject: [PATCH 1/2] zram: zram_drv: add SPDX license identifiers
Date:   Wed, 15 Dec 2021 20:21:27 +0100
Message-Id: <20211215192128.108967-2-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215192128.108967-1-mikoxyzzz@gmail.com>
References: <20211215192128.108967-1-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zram_drv lacks an SPDX license identifier in both its source and in its
header, so we should add a license identifiers based on the copyright
info provided by the initial comment block.

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 drivers/block/zram/zram_drv.c | 2 ++
 drivers/block/zram/zram_drv.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 25071126995b..464ef53adcbc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
 /*
  * Compressed RAM block device
  *
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43b4828..fa00bbe434fb 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+
 /*
  * Compressed RAM block device
  *
-- 
2.34.1

