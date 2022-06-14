Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E154B0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiFNMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbiFNMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:35:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8264D27B;
        Tue, 14 Jun 2022 05:32:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so8446699pfj.5;
        Tue, 14 Jun 2022 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bWhyj9+Innd6VBvVBk86q4KgboPFIEsoGvupeRdYFM=;
        b=eFPzFERHaQ3hu76kP/FeGfFvMx+Y+9glglTmjGMriMFNUtCL4MVyyRte8/oPlwTSXV
         Vm/OXIfmlv4N0Z1qxMO7KsBEeKabN4R/myJwFyfy7uSec2t7LjQ5qskH5kpfQx6DzV6K
         s1pmDp3DZLm1Y6/gI4XcvuYfUy7z0+KD51B/oYJANJ4wXbmvN4v9bKxOnID8hYKAK7xZ
         sI61N7VRGcrnpJ44/imB5hFUezPjRMZ1TEJHRxwS20qdTuPWGgxe2Z0+WSFb4YFN12wp
         OfAna8fs140EQK6qn0ve8ps/Wna5SmhMzUeprtMC8CU4QqhuA18Y4mcly46iviHuBgGp
         GkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6bWhyj9+Innd6VBvVBk86q4KgboPFIEsoGvupeRdYFM=;
        b=IM+piKZDMKp21eLgFUtmolW8/4bBBF1FuVEDWP4LA938lOzGcUxfDnpdCdlYNLsv9z
         WomRFF9osmaBNlxgp9tFO3iaCVM2EMB6xLzK2n+Xlkhot7ssppRgCrFCENS0Rs2Pftv5
         ORwgxws5K4kOma7MkZGP0YrMuVNkOKcaj3SRvP44S0FFjZTWa/nH2VkCeB0Sl2Vjob+s
         8cgkslWUd1Z5ImfO7CVFZfIq+CqPDCv9yOCbT/cHh24eRhHnW9SrLx/WJlaq5rNWqV9G
         EeA3HV1RYHRdDzBYo2P6/6/c0UGHSD57Aql9KZb93fr+zxDGCnsAk3JEJeLEGaWOdsJw
         1Dfw==
X-Gm-Message-State: AOAM532HTkMu//9TcXl2Xos6EPaJoWv5yYevtEJIfI4CkSM/cY9/FMj6
        wQu4Q8t3sP2BrhA1vIIOw1L6xXzl+Qs=
X-Google-Smtp-Source: ABdhPJwrYy7YJmSFGc1DKopsg3STNIPBTHxc3xMt6QTBGTSlvr94Yd5EHAOEGrP8+RLUeRp1W4J5Ag==
X-Received: by 2002:a63:894a:0:b0:3fc:a724:578c with SMTP id v71-20020a63894a000000b003fca724578cmr4402325pgd.499.1655209925358;
        Tue, 14 Jun 2022 05:32:05 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-21.three.co.id. [180.214.232.21])
        by smtp.gmail.com with ESMTPSA id w1-20020a62c701000000b0050dc7628148sm7403979pfg.34.2022.06.14.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:32:04 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: highmem: Use literal block for *kmap_local_folio() example
Date:   Tue, 14 Jun 2022 19:31:16 +0700
Message-Id: <20220614123115.522131-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building htmldocs on Linus' tree, there are inline emphasis warnings
on include/linux/highmem.h:

Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.

These warnings above are due to comments in code example of
*kmap_local_folio() are enclosed by double dash (--) instead of prefixed
with comment symbol (#).

Fix these warnings by indenting the code example with literal block
indentation and prefixing comments inside the example with #.

Fixes: 85a85e7601263f ("Documentation/vm: move "Using kmap-atomic" to highmem.h")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/highmem.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330cb..a244e0345c87ca 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -149,19 +149,19 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * It is used in atomic context when code wants to access the contents of a
  * page that might be allocated from high memory (see __GFP_HIGHMEM), for
  * example a page in the pagecache.  The API has two functions, and they
- * can be used in a manner similar to the following:
+ * can be used in a manner similar to the following::
  *
- * -- Find the page of interest. --
- * struct page *page = find_get_page(mapping, offset);
+ *   # Find the page of interest.
+ *   struct page *page = find_get_page(mapping, offset);
  *
- * -- Gain access to the contents of that page. --
- * void *vaddr = kmap_atomic(page);
+ *   # Gain access to the contents of that page.
+ *   void *vaddr = kmap_atomic(page);
  *
- * -- Do something to the contents of that page. --
- * memset(vaddr, 0, PAGE_SIZE);
+ *   # Do something to the contents of that page.
+ *   memset(vaddr, 0, PAGE_SIZE);
  *
- * -- Unmap that page. --
- * kunmap_atomic(vaddr);
+ *   # Unmap that page.
+ *   kunmap_atomic(vaddr);
  *
  * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
  * call, not the argument.

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
-- 
An old man doll... just what I always wanted! - Clara

