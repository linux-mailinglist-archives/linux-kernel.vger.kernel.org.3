Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB749E343
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiA0NWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiA0NWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:46 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F4C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:46 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id e17so4295141ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3WKe5MuRmY4zN4IvItxJ8jznSVtPjz9vO4zFd861RQ=;
        b=T66Injwrec5LwBXZnsP7VFbYqMrxRvYvxH213pyAiI9MatiLYgAXZUG4baoxb9SdoN
         zXRnHcMI3VFWnwAVspqlbxQ/kBbEExqseE3QLYuexEmmxzQyzdIO1mwKcnIU3qFovZRe
         axntKsmgOA6YIiqEnZKi1hdhr9ySsXO+ufvx/UnYYhj0vIlglhCU1fFsPDo9q8bqxZjh
         4XCjhpHFLz24tQWje+FwpBjbdj7keLnECIkrakQRcGMhqU3Ceh8A9O6JRzWAgC9DntlY
         XK/ghA7MXVN/dIdTqSurh+eu1eodFL1aMJMFV1PgoK3CgP2Jl8199aBXVyj5AKL7aYAW
         q6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3WKe5MuRmY4zN4IvItxJ8jznSVtPjz9vO4zFd861RQ=;
        b=51YBW0usiSN+Q6Jq87XKmWS7m0rWNE2AioOP7P4ByAvJcBzWbYVX3S5U8L74IDlxSz
         keejLbAQDefgVr8Vi6zmvTjeVu5V1Jy1jx7riNtzAi7dQD/8yaxrJbUPZ8gnH5wPr8le
         /cnH1dKU9pdPy9/rqwGp9HQ1aHJGycSnIo5fz6oll3EtnYdMby/XHsU0mh6mv9FVPDwc
         SstkDIiY/LXXZ+KI+9HufQIuXrCRCE1hyX7GZvzz0z/38uy0SR3jLhWcJIVQPwXjvY1E
         4cPWXS5ha1GdSSvCoPTeLUZutP470FEiM+8sqTHQ44wgzxqw4+1mE9sHjq2yC6x59h0j
         4bJg==
X-Gm-Message-State: AOAM533DxobExebXYB5N8U8MqPOFxT4tZ72HEOic2DTHTOMz1fydlsY8
        EJzgAs1FK0K4hwgfYuNWgJV8fGGwFdM=
X-Google-Smtp-Source: ABdhPJxy2gXRtc5o8b2nv144G8N91GofksrX0f+NfvkffEZSILog5gQNtT8qgbvgJ5Um3bJMR2RcZg==
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr2753589ljf.364.1643289764862;
        Thu, 27 Jan 2022 05:22:44 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:43 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 06/16] tools/include: Add cache.h stub
Date:   Thu, 27 Jan 2022 14:21:24 +0100
Message-Id: <fa6e6abc6a214f85089c8a10b8df72d0402c6166.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy version of the cache header.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/cache.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/include/linux/cache.h

diff --git a/tools/include/linux/cache.h b/tools/include/linux/cache.h
new file mode 100644
index 000000000000..ff010a11f47d
--- /dev/null
+++ b/tools/include/linux/cache.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_CACHE_H
+#define _TOOLS_LINUX_CACHE_H
+
+#define L1_CACHE_SHIFT		5
+#define L1_CACHE_BYTES		BIT(L1_CACHE_SHIFT)
+
+#define SMP_CACHE_BYTES L1_CACHE_BYTES
+
+#endif
-- 
2.30.2

