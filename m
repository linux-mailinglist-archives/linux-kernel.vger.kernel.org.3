Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5F4784F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhLQGcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhLQGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:32:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD9C06173E;
        Thu, 16 Dec 2021 22:32:53 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z29so3954206edl.7;
        Thu, 16 Dec 2021 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsAjCk9qQhY+pBaGcqz3KvnxpttrERJajnH3RPfyHpM=;
        b=OGrRb2gStGK/8I6F49ek+EI08w23eVGZIVGEkDIc88k5jSnWDFkpLKjwhQG6/sZhuk
         wBVkfxgAplb15wtDWFCcvHLZJOFYIC3oLZw6tgANwOgcxggEPOdOtT2WJ7/lj2PW9V0a
         fWS3gDJzi8rE8XCtvUWQGzj71fS1ZHP6vNBZ8nFNhvDpNqMSeBMAGQmimpz4MQQH9abI
         AhnpalwQ+p0qlqzmaosR/Or2U30qRG1MW2ZIQmGbjq1qSpwiTRG5WcRCIWE3ETvujsYO
         onDTZ6Ze7TYxBtACwxw3C61awM6EmmFZoyPBaoX6jMQdKMpNr+iJJs7JKpTcZlHrghU7
         ewwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsAjCk9qQhY+pBaGcqz3KvnxpttrERJajnH3RPfyHpM=;
        b=elY3P+QXY8l7SkxeoO2LPWMIn3ui3J+gxoYeCbnVYeih78x379C/GmXXI5S4xX/3qa
         MULPoLl+oit/hqcjtIlMMABac7KWSCIJRTMsX3HCKbglllkuH8+lqQJdrPNcLRLnxECD
         XtwgYLEsZaqpPbdYfKUAu+JQB6Gvy7J6v1y95OTdz2B5anowGbDQmJBZgzqqMfrz5nVv
         17F5gOfOy17uzH5d4HoLClP0JVJLBUuT5OfxIWCLp8GFKcKueRW9FCAX5vYFrKBvP0sk
         F3UquSzi1tp79j6mqWd1TimzgwZoABcxD0ShFNk881xV1Qr7Zi8+4v5OoJ/dEm5CGxzd
         Kn5Q==
X-Gm-Message-State: AOAM531g4JjS6x1yPvFkNhh/Cw3PH05VhDBW9m21jvceLzbpVLpAByi/
        zglKzajluoildEdFHX4Z35o=
X-Google-Smtp-Source: ABdhPJw7fgsg/IktzkoDmmBR2UV8LnmiKRCN1WduIQHlg0zi3BS9phz3xj+ApCyZ/L/M/EegqIpC+Q==
X-Received: by 2002:a17:907:1117:: with SMTP id qu23mr1401185ejb.404.1639722772450;
        Thu, 16 Dec 2021 22:32:52 -0800 (PST)
Received: from zenorus.myxoz.lan (81-224-108-56-no2390.tbcn.telia.com. [81.224.108.56])
        by smtp.gmail.com with ESMTPSA id e20sm2490148ejl.189.2021.12.16.22.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 22:32:52 -0800 (PST)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, hch@infradead.org
Subject: [PATCH v2 1/2] zram: zram_drv: add SPDX license identifiers
Date:   Fri, 17 Dec 2021 07:32:23 +0100
Message-Id: <20211217063224.3474-2-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217063224.3474-1-mikoxyzzz@gmail.com>
References: <20211217063224.3474-1-mikoxyzzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zram_drv lacks an SPDX license identifier in both its source and in its
header, so we should add license identifiers based on the copyright info
provided by the initial comment block.

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 drivers/block/zram/zram_drv.c | 9 ++-------
 drivers/block/zram/zram_drv.h | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 25071126995b..4de6fe13edaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1,15 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
 /*
  * Compressed RAM block device
  *
  * Copyright (C) 2008, 2009, 2010  Nitin Gupta
  *               2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the licence that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
- *
  */
 
 #define KMSG_COMPONENT "zram"
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43b4828..29e75e094a9d 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -1,15 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+
 /*
  * Compressed RAM block device
  *
  * Copyright (C) 2008, 2009, 2010  Nitin Gupta
  *               2012, 2013 Minchan Kim
- *
- * This code is released using a dual license strategy: BSD/GPL
- * You can choose the licence that better fits your requirements.
- *
- * Released under the terms of 3-clause BSD License
- * Released under the terms of GNU General Public License Version 2.0
- *
  */
 
 #ifndef _ZRAM_DRV_H_
-- 
2.34.1

