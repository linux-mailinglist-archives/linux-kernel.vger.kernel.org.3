Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0F49E346
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbiA0NW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiA0NWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:50 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e17so4295432ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNs/YC3QiYenr3GANxWYR7pSc71WK+SMMsFAwX5F+fg=;
        b=bo5jfQso9TY3UU96h2gnRTXgYv/XKjYblbfYnmqLkmzAihU16AsudndNYWsjC6mK50
         GgeVDjKpSqb3OMwdukhaQw9zPl/+ahmPt1wir3eqgiLoamT1jTWK/2H2TrDFVUGgG/Ud
         G70wtPfe29t3I/NDPgKUDRdXkfTKLQ+TDYeFCCMSolNlhNDvaKLRmRxQT9AR+0saiCti
         2YP7JVQZiJ/tidivMdkD3Wq9U8YnHygxwCrvybKy4/xA4XzTLcska4TsSV61XUcb2I7T
         pZ3Am+2sR5a4bZ688u99NDGkvcv9QBI8dhYamJakKyQ4GGVNl6vz4b3b/3fo7sLp8XKc
         UF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNs/YC3QiYenr3GANxWYR7pSc71WK+SMMsFAwX5F+fg=;
        b=PqJaPHsw8ariqf6PIkF+eG2XLV2hD5RH+qDsEVd+lPD2J9DNM+t2hxus42APNrX6HQ
         W1MTVswP15Cl9SCxQHK9ky9LkOhw+7HYcgcEOr0biAtEfJmrY9CrJANXStGFAw2pJkAc
         /M1n4CgH67is2pU/j1e01/cpVsXHRlH3ztmGnsKOlEYN41mw8veOM8oiuslyPbthjY2x
         qpDYmT1BViL+/z5iX+NKFjcr6hfCSW/ZrL9AR3pApxuhRHErTB591Xzz1i9yM4/9lr5+
         nHNxGZmWYHBkcu9UBGTFC1ZumbwY0GERPzEX1pqlroYE7AMD953CRDmH6ssKHy/Nh6H/
         4FTQ==
X-Gm-Message-State: AOAM531nxHNVDqGFAurs0Y/yiXZ6WjtCMlWF8m9R2rHbFwnrFbC8yYjT
        BVWPBdsxrhF2xvcqGxErPIg=
X-Google-Smtp-Source: ABdhPJxy6RE/jb21DtuvNjU+DrPHz0yY5OTVBMOvY6qI1VkkJ67hh4MQHRIeGU+WNnEjyN960wd5xQ==
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr2771938ljj.246.1643289768611;
        Thu, 27 Jan 2022 05:22:48 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:48 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 08/16] tools/include: Add pfn.h stub
Date:   Thu, 27 Jan 2022 14:21:26 +0100
Message-Id: <62d0484f651bde15938c6faa9cc1b95388cfd329.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a stubbed pfn header with definitions used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/pfn.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/include/linux/pfn.h

diff --git a/tools/include/linux/pfn.h b/tools/include/linux/pfn.h
new file mode 100644
index 000000000000..7512a58189eb
--- /dev/null
+++ b/tools/include/linux/pfn.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_PFN_H_
+#define _TOOLS_LINUX_PFN_H_
+
+#include <linux/mm.h>
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((phys_addr_t)(x) << PAGE_SHIFT)
+#endif
-- 
2.30.2

