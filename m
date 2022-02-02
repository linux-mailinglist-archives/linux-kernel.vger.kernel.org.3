Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF84A6F7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbiBBLEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbiBBLEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E1FC061744
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i34so19513577lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpVlgTajQnqvJqRBDECMdTOPT5OH4VewpY+I2k89SJw=;
        b=KTxXcoTi64NY8Y934prTF0adkrL4z14Y61yYIWmmshg5rY5ZxuO2xIFvQ8lOlGpw4q
         9tLIcsukBa9zEqHAc46MsKkrJQLX9XTu34RwLZiqRa/EGd4Y7zJzJD1MC48CrPHo+D8L
         Y8zLmsXCMVmg2umgooaXOpE2XAdkNXWUVJdYZxQxNJp/wm1RddxmwFxS5xdxyoLmjWii
         yCPdTONhC6k5jqoYwcwwpypqJnA0ZnMU18AQz1SWcl7ghtTlonR98/Uvl/I8cENkU8Nk
         MNxYMEApYhLWB+dVJqkb6IILbYNMVM0gm31ma2dM1ivAaadptq9uEQ3SLLbAOX0IAn8w
         ctxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpVlgTajQnqvJqRBDECMdTOPT5OH4VewpY+I2k89SJw=;
        b=B63Lcq093yG57emrONVzj7TtBkhBaX7TToEwTPkuyJX35gKtJ6I9XJuvR+NDeTnznJ
         q56kGCrNd/xkFCSpkocLd22mIYgn7nLEwBrgisolCNqeMHL+qZH0Z1KihnucfoPkAuXx
         baj8/NxKAPTwg1OArGVEqyfF7u3K0RdNuxheSl3YbCvHSuVsMG6PH854BQh7QsSTGQvI
         3BLIeQo6M0MVKNKVCZ3oZ6PlUoUtlnJnZlGTf+YE0+qz844WRtHtt+NNEPOt+B5Ri3EL
         Cifr26rY8YvpwwmCg5slTW+FQjv+3pk8KciKubXYYuBHvOciOApzHAjd+xBSvCfX6wu6
         sgnw==
X-Gm-Message-State: AOAM532XGNZ0xGve+llzhw4tXgeGM05ECHzRoqwWLKzBM4to1YtKddrq
        IHrEPT873RWMn3l65AgUdBQ=
X-Google-Smtp-Source: ABdhPJyzQYQ1cX6D53RlAyOvCuRYgn0WsOWnSNuQhfJ8XHfT6mWbulgsMfUd+7chrt0cHcYisD7xCQ==
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr21907306lfk.182.1643799839573;
        Wed, 02 Feb 2022 03:03:59 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:58 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 09/16] tools/include: Add debugfs.h stub
Date:   Wed,  2 Feb 2022 12:03:08 +0100
Message-Id: <80fceff27934094873cc3f0656d22e802dfcce78.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy debugfs.h header.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/debugfs.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tools/include/linux/debugfs.h

diff --git a/tools/include/linux/debugfs.h b/tools/include/linux/debugfs.h
new file mode 100644
index 000000000000..4ba06140b1be
--- /dev/null
+++ b/tools/include/linux/debugfs.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DEBUGFS_H
+#define _TOOLS_DEBUGFS_H
+
+#endif
-- 
2.30.2

