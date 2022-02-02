Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CF04A6F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiBBLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbiBBLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6851FC06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:56 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t9so28291118lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=100iRySg13jRbyYYPEv3/nn8V1TwHUUo9Gya4DuFw3Y=;
        b=OW2OZc67gckPCB6/EQ8p6tgVM02YOZg/lTlZsdTRvpaIgrmNps/d8ZUlnZ/Qic6fHh
         WIaFU2hVMNAK7ucpbrt2+sJwwGN8mtQScHNLrJIxvYDaWAy91BYIAvnSF1V53/uzknT3
         2wq7kl0Zae3n1/yCcLyHLGQcjaZwV+1qDQfWUjRIUV9GtYWBEOtkuKjtimy2/8dalScz
         McOtuy+0euhNw8DqvyTPJrLp/OzMuaQF3ALyOXUCxL8WHAeb1OYleo+u8aWJG4y5NiVo
         eEpRj8zvxgcWcByAEuOdi1nmKSQmk9gvFRq+rOEVUH86Ctge7zUEuqLnSdOgyTjfzMAi
         DlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=100iRySg13jRbyYYPEv3/nn8V1TwHUUo9Gya4DuFw3Y=;
        b=HJzSc2RvLW7CLPi5d8R4c4v98s2Gdjw69CSD8NSaJcDFXNG6l+tDs4LJxlH88J5Lg6
         h3z1fiGk2EKcll46muD+zsMmM7OMzvsUHdyQq5fColhcsZV2jD84m8fz2K6O8Zu4YbYJ
         LpySANOCUdA7o87vbfA9+JUwq70tXrEGdItpUZobsMBS3ah4L/0SIemo1jckaph6/Fqu
         JqEBBRl/A037cwBTiph+m/UOB24iNwO5eH0I0QSa5g3oeFZrDjYsqldEvzooHh/nuBKT
         QpFoD+6buyhOh2JBX5uSOlapWPqVVnCufnbb0LUj0h8tzJX10Jeb7foWooM4yLRC/3FP
         nEXw==
X-Gm-Message-State: AOAM531lRhKcsvIGLhMRgdK8Cn/Z98RtmQwZUOcD1MuRwpZofUmT7hNA
        8lzGiS+9k/8fnLVsPARgZFc=
X-Google-Smtp-Source: ABdhPJwedQ4oNRP3Zi0OF/J7s0rXaRiHl7TLBC5htK0I4kBF6mFjCrF0jKW1G9qjYdimAlpvWpx5aA==
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr18947294ljm.35.1643799834775;
        Wed, 02 Feb 2022 03:03:54 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:54 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 06/16] tools/include: Add cache.h stub
Date:   Wed,  2 Feb 2022 12:03:05 +0100
Message-Id: <5e02865094aaf56dd30772722799e53f4130ebc8.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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
index 000000000000..9e9d585f0b9d
--- /dev/null
+++ b/tools/include/linux/cache.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_CACHE_H
+#define _TOOLS_LINUX_CACHE_H
+
+#define L1_CACHE_SHIFT		5
+#define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
+
+#define SMP_CACHE_BYTES L1_CACHE_BYTES
+
+#endif
-- 
2.30.2

