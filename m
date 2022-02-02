Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9204A6F78
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbiBBLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbiBBLD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:58 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB6CC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:57 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id c7so27807709ljr.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT95iXzR6dpzPFKNDISp4lTVmaXmzkxChM4JvbaJZPc=;
        b=iE4mdeqPfE1Mph/jaMT/zW+hVNWX5q/8onyC5syYIgeK/cdmF9RU0lwItEMI1zaCIg
         PpuKogF9p3TxVtsIua5w6lL7kTZtfwDawFsem54t2Fa0m6lUbyh31bYIxUV1qqQZmDDx
         BOeR/QsI/W+gHzgAUVPBUlncB8cATRj6/sHukQ3jAGK2HAPX1CxaeSw5X1XNvHiJiq1k
         1RNsoO0GFROkqc82G6k1/RQHTdXwONWkootRGqtdGnlDGRWyEqJtkM7Ou0OKzAOK/cqk
         RGKyTjBJAi6hefkUfLCKokGBv+3R3BJAPwA07DW5jKaK5HFNInUBcfGbfEXfT2sRhM26
         K5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT95iXzR6dpzPFKNDISp4lTVmaXmzkxChM4JvbaJZPc=;
        b=nWmNODl09flfxuAbtByjR8sa3u6M8qEfHRAvQPPQKhgOXHYhOKa8UMPzwMbJt1qQmt
         KXEutLlLARUKgtleg0YuFhNCNqBRAH+Ag0+p4r9mHljjlOW4FOYSQF0sY5EaJShu7+I6
         cY4H26Pt5cWUrMT4m+wvpd8P1MPcq4mgV6QyNi2+M1ldfZs6/SSQH8kPwJyliaS/orV1
         t0+LNa8rucOSoldmUWX0Cl91GjttAR7mJ7fasr0BWFJMwu6wbYiuUJOGNm+6JEec916j
         kRg5iuGuu4wwMaAENGWajUWYZ50uUCqki7uD2Rqb6pgtXpncMj6U1KkRhtSnZ+ova0uo
         /qjQ==
X-Gm-Message-State: AOAM533qLSB9uL7+52qgV4yeHdlGkcAis201kDvuCovthswzF4wplPuc
        TQ1Gmr22OO12GLKdOkEzFYI=
X-Google-Smtp-Source: ABdhPJzgBZbfgR9GawWUkwNaS8vMZNF0FJJGJ4e8v5IYrgP+TAk9VPoIPqWHSgiJkWxwsncnYTwUBg==
X-Received: by 2002:a05:651c:a0f:: with SMTP id k15mr16823902ljq.80.1643799836226;
        Wed, 02 Feb 2022 03:03:56 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:55 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 07/16] tools/include: Add io.h stub
Date:   Wed,  2 Feb 2022 12:03:06 +0100
Message-Id: <3e8d42cbd01382d956d393cf3bb2a6d639dfdd97.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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

