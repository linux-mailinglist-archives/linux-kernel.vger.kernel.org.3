Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879150A607
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiDUQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiDUQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:44:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EE24092B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:41:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i14so4065043qvk.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5WdxBeCwr7yWr24VSHWDcf8wyvAsFr/MM915gyMIhiM=;
        b=j5DhMYrO28AU/q7GsllWdjjd+oC/driq5h6cR49pe1r1nHwiz/z3fSns9ugyqW/0dp
         SQ67DPZfOprTBagvgUMkLrVHAFe2t1UawG7GVtRRFCKTfak0FHoTjnmwoOvre//RuWdZ
         Zt0JnHXG8q+cYeyzKGhZ6p+9XbkPos2PWNn8DBJRXSPrv9CDlHUn3u7XyWQc4Zf2rmfx
         T8LiUIH7/EDt4jOkSKP5dv/1tCso5tuTrkDKQy0FjrxICTqFROjVOLh0GejcsabX8vu0
         e8Nfz7qqnz92sLjnwGmw5aSCjJRRRVqWezThXXaNHtBq89LZbYaiL/tdQGImgQplPnEP
         3fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5WdxBeCwr7yWr24VSHWDcf8wyvAsFr/MM915gyMIhiM=;
        b=FHpEA5sDjsNezXNgFVcYFxV3c8yRmr52cLSy6OulzGioO2gSxeEFgjycJ44NY35FFc
         GiVpci1hfeOAxJHiOM0iTLWoJlFdPNRXjAvpN/xMpt6wG4DhXgmL/QuHON7SK4LqdhWa
         anR9uTXJW2o1G43dCokLjo+NENX93zOagM3EccJHX+ZZhu9wAQjGgWViCpSAn/uUZgaZ
         P2M3CBE/01WGlKOl8MOPzuC3/ITikXCBpXBpBf3SwvWfhb6G4J2bafQZUQH6SdJLei2U
         9nfKDUg05TaMD9/kjbqW2a+NkQpVdv1ODDVTH/iHlvIsuErdIj1NSfSbG+X5RhZIlJBL
         sLlg==
X-Gm-Message-State: AOAM530Rs2ccLQUB/6OWXgddAJg2lvCrM2lQz4leUm+Ns557fYrbyn4C
        AplcMxrPpMihF9j4ngNeCIFd0UhNDtQ=
X-Google-Smtp-Source: ABdhPJyxrvAKwvHsapW8gWXHoRup3aA7MKKHaEFpAK35cssSbi9zxgR3wqo9kQ+ys3aZunxwEF8Cbg==
X-Received: by 2002:a05:6214:e66:b0:446:3c84:a172 with SMTP id jz6-20020a0562140e6600b004463c84a172mr268161qvb.35.1650559301727;
        Thu, 21 Apr 2022 09:41:41 -0700 (PDT)
Received: from localhost ([2601:c4:c432:7a1:dbb0:23b:8a79:595c])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a099600b0069e5db6be55sm3128909qkx.36.2022.04.21.09.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:41:40 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: 
Date:   Thu, 21 Apr 2022 09:41:38 -0700
Message-Id: <20220421164138.1250943-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] mm/gup: fix comments to pin_user_pages_*()

pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
API requires struct page **pages to be provided (not NULL). However,
the comment to pin_user_pages() says:

    * @pages:      array that receives pointers to the pages pinned.
    *              Should be at least nr_pages long. Or NULL, if caller
    *              only intends to ensure the pages are faulted in.

This patch fixes comments along the pin_user_pages code, and also adds
WARN_ON(!pages), so that API users will have better understanding
on how to use it.

It has been independently spotted by Minchan Kim and confirmed with
John Hubbard:

https://lore.kernel.org/all/YgWA0ghrrzHONehH@google.com/

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 mm/gup.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..559626457585 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2871,6 +2871,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	/* FOLL_PIN requires pages != NULL */
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -2893,6 +2897,10 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
 	 */
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return 0;
+
+	/* FOLL_PIN requires pages != NULL */
+	if (WARN_ON_ONCE(!pages))
+		return 0;
 	/*
 	 * FOLL_FAST_ONLY is required in order to match the API description of
 	 * this routine: no fall back to regular ("slow") GUP.
@@ -2920,8 +2928,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
  * @nr_pages:	number of pages from start to pin
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long. Or NULL, if caller
- *		only intends to ensure the pages are faulted in.
+ *		Should be at least nr_pages long.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
@@ -2944,6 +2951,10 @@ long pin_user_pages_remote(struct mm_struct *mm,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	/* FOLL_PIN requires pages != NULL */
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
 				       pages, vmas, locked);
@@ -2957,8 +2968,7 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  * @nr_pages:	number of pages from start to pin
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long. Or NULL, if caller
- *		only intends to ensure the pages are faulted in.
+ *		Should be at least nr_pages long.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
  *
@@ -2976,6 +2986,10 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	/* FOLL_PIN requires pages != NULL */
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return __gup_longterm_locked(current->mm, start, nr_pages,
 				     pages, vmas, gup_flags);
@@ -2994,6 +3008,10 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	/* FOLL_PIN requires pages != NULL */
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
-- 
2.32.0

