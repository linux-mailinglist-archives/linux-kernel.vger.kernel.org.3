Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96A549E345
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiA0NWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiA0NWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:49 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1AC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e17so4295261ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT95iXzR6dpzPFKNDISp4lTVmaXmzkxChM4JvbaJZPc=;
        b=l3x6b8iRrWCQ8gKFWVBWoWc5uvelzzEri/BmCVuHLaBZAr2TgNdXinohv62fA8viIb
         MTOT9kzcRJBLLELVAB1AbyJLAqzq0I4T8i2ZnThFbFD1YSIWtb8Hyt+RyCx5dSvzhxuO
         k8/+aLI2f+U9vsdK0LMTJ3Sd7oEnYMfFZsTwpMmU0kjqAWuB0vlho/ccg5xqEJYQot/O
         9dIuFrgJHnok6sJ7BRIt2mHAwYLKOGnrCc2C5sDCdgExX6ev6fZDxaSOJPkKeMjIaoWy
         KOhfG3AfydNsshsHDQ0LNbevdWjRgrCSdwQePRPMMp9rUiNcI59umvshf0Lll4tyXjvp
         1ZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT95iXzR6dpzPFKNDISp4lTVmaXmzkxChM4JvbaJZPc=;
        b=U/Ngb0yeiViiRk/pC+t8RuSabISFqDCnzHLmF8pOmymGvZKqbkRAnbs4sabv/Qnt7n
         E+SokosC7sTBniDF6yoJyD2E5AYpsX5/Kwbsw8adgVh8OJUSxi7btBNo7h34Qf7cRmtZ
         eUMujkFmITLG54N/ZyQd5fwwKdWKagpq2B5CKg/Qx9ZvcFK5oguCE7eb+IsrCqrz1Ewp
         BcamJ4d16lktTUJAHvvHl5gJ7Yx4RuflFrXH+ObVEi9ewVrJYwIYfbdmA03JT6CNSS3f
         gFVe1sYEjGS7RaZwbluLZLnQ7PAXlqaEL7G9Pbn6XqCu78JtEwwR9+UY7xC0LlcdcFJQ
         1VbA==
X-Gm-Message-State: AOAM532rZAk6tCMh5ilXKgg5bR+B+uVIw8GDdpeaMCujsHrChM0GBk8F
        hPZYpspurHXQtpj5E7kRLjU=
X-Google-Smtp-Source: ABdhPJyihm0hkJ2ppnMAbeewpve4xm0MzXpLFvYL2OMFS4t93zSc/rcbDcVP8gUJOX3HOgjuujjnEQ==
X-Received: by 2002:a05:651c:104e:: with SMTP id x14mr2764415ljm.23.1643289766913;
        Thu, 27 Jan 2022 05:22:46 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:46 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 07/16] tools/include: Add io.h stub
Date:   Thu, 27 Jan 2022 14:21:25 +0100
Message-Id: <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy io.h header.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/io.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/include/linux/io.h

diff --git a/tools/include/linux/io.h b/tools/include/linux/io.h
new file mode 100644
index 000000000000..e129871fe661
--- /dev/null
+++ b/tools/include/linux/io.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_IO_H
+#define _TOOLS_IO_H
+
+#endif
-- 
2.30.2

