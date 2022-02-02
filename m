Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906ED4A6F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbiBBLEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343740AbiBBLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30870C06173E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f10so13331600lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNs/YC3QiYenr3GANxWYR7pSc71WK+SMMsFAwX5F+fg=;
        b=OrUL6R1VdOCyt4DHOzKb3U0lSiUDUjKMkBAOBuO3x/wlkdS+XasKS52HTlCiwCbePU
         Bv7C7ckNehqifsdJKXMbRrwzfrJ5jNemCJR1P0i37Z44SUm0Ep9OXHFOYl4CnPszWM3W
         nZuI+bfx6KmOk8hVgAkvVyjGUfQFqhgZ5Nq1RLylPewKQMRhtGOQrd1vidDBvwFRp2CA
         rDnYzoULpSReuIcaR0dBj52TXlx2oUm5cjewxf0uLXv0gWSU61SZ/yqwIsW9xiRz5cIp
         FDyerRR/c9OkDWmv7zjXuKLw/KETw6JKoHOV65tymsV1HHJEkzj5DTSxiFMELyZwaWq/
         +UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNs/YC3QiYenr3GANxWYR7pSc71WK+SMMsFAwX5F+fg=;
        b=W/5QXiIznqhnnq3JjGmeLqZvrzIQ6aQgiO+mjyUzP7Eop8jX0vgNKcKcSfi8jmaFoB
         aikTjFMreL0m7y1SetCkh0041K9qeaX4+Iuapmx3zcp/N7281+Wo2lU51+mXGQB2vImv
         gWgJB7sCtnlvWDVtkxjtyX2H2+t5KakmUf59an3DE8+6zcllFR30CWSkJnqvJypo0TKi
         i0Q6c8r0oEY/Cfz+Q5naic4YT193Le9dLBJL1x7dIM2k25RJU5tXGfccNBQiU/Em16X3
         gMYc/rhbHRoGIO549u2XB9pCidP/FcGzM4zrCo1BeM88pJK6ZDPuRuGbALm8uzseKOi7
         hLkg==
X-Gm-Message-State: AOAM5311JJCliA4DDCQV0Avr9zwsaVwH9qP3IGUnf1nDui+or10iqP+u
        rhKFrj5ftTAOyA4sSNEsswo=
X-Google-Smtp-Source: ABdhPJySwmroBSIuxOQEqIYwYJUYcouxEo3LAxCYYAts+oUUc6IRw/0BqJd1GNNe0Zgd5wMxe1iN/w==
X-Received: by 2002:a05:6512:3487:: with SMTP id v7mr22242867lfr.310.1643799837592;
        Wed, 02 Feb 2022 03:03:57 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:57 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 08/16] tools/include: Add pfn.h stub
Date:   Wed,  2 Feb 2022 12:03:07 +0100
Message-Id: <1bdc02125963f945bf90dd8cb37c404cc0688af2.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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

