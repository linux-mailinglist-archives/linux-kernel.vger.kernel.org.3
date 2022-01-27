Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F0949E353
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiA0NXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiA0NWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:22:42 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D40C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c7so3762964ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8R8u/y1SMQUrHN6xG6XUjC1eIHn79OeaNWZhotIs0E=;
        b=fSYUxbVKRSvwPkl4pNB1gwAS5LgowfbuqJ3JrlRsxkfpXDrTP0UBI//31a2rA0Q3tk
         UXyuaVKDoLuTozxIPyM51x7fnvbrO/tExwh9G3B+R9B5iNMtfwUOMDx5sCrZxp/O80Ir
         3PwCTus2Yl6xK03laCBfoo5JWrkSeWrcTuSwG1pNypIBTlWH45KBZedlzmlZBiwdyxAM
         tP57QMSjCZ/iA5zgJlUROnleuOWhN+yIpUYfpQWhvi54TWZWiUcJVFe1GFtQ+t3Npcnv
         UGVoeAZwuT8Ra/kQjRR2Yob2i0zBSaLiD7bh+yePLPALXOcpGaU6byCq+0l4gOSIQpEP
         1eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8R8u/y1SMQUrHN6xG6XUjC1eIHn79OeaNWZhotIs0E=;
        b=5d7JpmWbJ5uiuZU32KtF4/84WYyQXRz7y/BLXOpMeAAZRFhPb1cYlyiKotTdxxWO+t
         M8u+J8dBNAIziiUN+gbhflclhyU0t9ZEaFi5oIfgpBBt0ZY3bugZTufSCK5My1obYUk/
         LA91gh6aOuFfP4z5wl49stxHeiew2+CaotpfDsuDdWFrExzPqkk0B+/Pf09nCclEvQqG
         PTCc9/sUvcx/ikw7CjmB29NKb2ZxnYbJxoas8nyBSQjqvpoFyA9aNxjud9W1pZDkDAKp
         Jn20EOXTF0mCEFPlp+Wrfyb7UTbxlhBmthxjB8EeMGZPyh0grN+vUMpKVpUPpt/cMlNv
         cuxA==
X-Gm-Message-State: AOAM531DP5DIV/Ii7chdsd3REOfYmZ73WGQFhCAaHHQ37xs7ijl2t9l/
        bMw+oPI4F3BKK+FbdFvTJIQ=
X-Google-Smtp-Source: ABdhPJxxR6hh92eR2oORQboC+bVMbj54WKUsdTR2rFidNqQWLEJ/4r5Om8UG7xkPh9pjotcZdAgd5g==
X-Received: by 2002:a05:651c:19ac:: with SMTP id bx44mr2701574ljb.528.1643289759993;
        Thu, 27 Jan 2022 05:22:39 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:39 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 04/16] tools/include: Update atomic.h header
Date:   Thu, 27 Jan 2022 14:21:22 +0100
Message-Id: <bbd768fa794c68cda7888182f464411aebb65b7f.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_long_t typedef and atomic_long_set function so they
 can be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/atomic.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 00a6c4ca562b..5d2431889606 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -4,6 +4,10 @@
 
 #include <asm/atomic.h>
 
+typedef atomic_t atomic_long_t;
+
+void atomic_long_set(atomic_long_t *v, long i);
+
 /* atomic_cmpxchg_relaxed */
 #ifndef atomic_cmpxchg_relaxed
 #define  atomic_cmpxchg_relaxed		atomic_cmpxchg
-- 
2.30.2

