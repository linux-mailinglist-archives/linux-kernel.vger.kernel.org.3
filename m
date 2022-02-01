Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C74A5AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiBAKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:55:49 -0500
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:43294 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiBAKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643712949; x=1675248949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N87/Yfcs/eolC23BLtRDzeHlHtMpAA1EhSMYLZCuSgg=;
  b=nDTTu4bWvgvmBsduYz1nSL5BPYfscNpPOTTK0ug5q4CBj03DAww7VPi4
   ocChzSA8hyzV+X/1ShBbzSMv8Z3oNQmyduqlWGMid9yCedFVuG9pXkFuD
   A8JoUW/ujqmaZgHPj6qVJYymmnj7JTypBRt8xib6KuY5fRf3HGc97S+Qd
   GxlyBl4QezZ4BXKGwv91skXZsZezn+L82F9zbEqD7NjWAs1kKSQ+eqXxn
   xvbcPrdLR99Hhp8DVVsGFQ0gUwcZjRZ9YIap4PRJWmG4CF4oUKXCi4Kda
   r3lznZIbeZQRwXQcDXfULKQEHb0bkLY5XexYNfYlqjgvlzTtymqwhquSt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="101508730"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2022 02:55:47 -0800
Received: by mail-pj1-f69.google.com with SMTP id x1-20020a17090ab00100b001b380b8ed35so1425710pjq.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=BwhVCD5gApUnEMgR2x6gnBOuitDGWagg6hwNd5yCWlvrOYE0V3sK17saP7f+Yc16+1
         G3pRKrhlsqIilqa46HHPg5D6XG36N0Z3ALHPq+0c0RxMv7mmY4MZlPZ7W22rw1/XBYOD
         Eu5zRLrWCD44RW63WrPWEyk1zTrRCt+dI8dzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQBU+rnQ5my6cghLd5mHteSqBsmjbcfDnGbLH9g2K+8=;
        b=owLRo/Xh50dQ+vjG8DILxgH++WRdB1yqs2QQyDK/RjRnzYx0hbEhbUjkFAoYWfyNts
         iVc31JXQb+3SrxFs0zZew6np06hJfvXYfxRFeOCAK8lnaRxV1f0+ULRD+pooL4MqjihI
         7eZT7IRA3Db4KJ/6EVfXgZBuQPYAHJXNKnLqSR96Zo26eQdwHYpYWkHh8ujP06i5Yq3d
         BI5QXZthZiw/dzpXi0DgaYS9s3/mMcUQOHSYaLE3/EnXDQpCBHYCn0rJchN4X7CZdXGm
         9Rl8OJPAhxk7x6/tPUsBAw09oKRmoo3n/hcBHeh/OYKYaVqPyqdMPluqBoW/KVYUMOOo
         FKwA==
X-Gm-Message-State: AOAM530h9XFB7rvVcoWvjzfZJMCYfn38s7LOjDnOav/X6AAWJ3nsInMX
        baNvnkvaUCWRVcfjm1BRIIpj5RpTlxHksvMd3qa1lP7uxwzTUdZIfSRGydLn1bB8/vYB/ubddJK
        QNc2LWHwqcVbvyQOWj16qzos0wA==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr1639602pjb.128.1643712946650;
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwR+51ZW666OWygVPyo83ZYuqOoW9d83uUD1rNUB7qxA4cSjb97vUb10lngV7jgl6wSo1FrUg==
X-Received: by 2002:a17:90a:e7d0:: with SMTP id kb16mr1639572pjb.128.1643712946369;
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id b6sm22349723pfl.126.2022.02.01.02.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 02:55:46 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fbdev: fbmem: Fix the implicit type casting
Date:   Tue,  1 Feb 2022 02:56:07 -0800
Message-Id: <20220201105610.2975873-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202202011802.cpmdbzHR-lkp@intel.com>
References: <202202011802.cpmdbzHR-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function do_fb_ioctl(), the "arg" is the type of unsigned long,
and in "case FBIOBLANK:" this argument is casted into an int before
passig to fb_blank(). In fb_blank(), the comparision
if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
"arg" is a large number, which is possible because it comes from
the user input. Fix this by adding the check before the function
call.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..991711bfd647 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN)
+			arg = FB_BLANK_POWERDOWN;
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

