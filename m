Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1003D54C5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiFOKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbiFOKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:15:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E7A36E06;
        Wed, 15 Jun 2022 03:15:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gd1so10826135pjb.2;
        Wed, 15 Jun 2022 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Mg3IddV8fqKnhInS4vCQZ7ljmMvEGOBjmrWbtncoys=;
        b=WTtyjNYuNz6SGgDX2yLb6Uvj+evRZIUmEenoCBK+pENsEY7L4jsgZjdcTtZxn81qVi
         3IJoUMLv23y7iWQ33KIIHpMtjx+XCs1v+v07f0dT0DP6VauEJz0faMdRXtuA7U/CzWb3
         i4Zqvzn27MxDdWRf7qIAH6BSGhBx1rRgj2i+8yeptixfQUpJZEOZ7Dm1UnTI7UHAquoz
         5qw2N83+Z03CuPVIr4hY+i9Xmfk16y1DMZOB5v6FP0upL38IDpdl4Lzy3uHvk2mGe8wY
         YYdCzRWJzqcm9f1gHIyfe6RwrxydVBO5nmQLtkNsxLoUOryIVIWMJw6sx2z8RAtR8OYB
         HI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Mg3IddV8fqKnhInS4vCQZ7ljmMvEGOBjmrWbtncoys=;
        b=6eKpCZbLLdITFzulTjNEwFo+EBxihwSVUDEUhW9noHw+3Dik1iZudiHI+A9ghjFsc4
         dXpskYFkcYl0Kq+LB0M4nZA/QzYqMs1J3L91F6DZKCjKr42APnzMnLcF/BaELSm2IOhr
         VEDys40Xl1BwmeVVdbcAavTHRM6/3y/c6zLUpZwBRDlJlGCIj9Lf1Qgnhh2ZnTrIQEtF
         5GO2VEMrYZhDfZO/AB7SGcE8WYH5bCuMOi592h+jMU2xIHUqw4nwUWcsyoSEtHE5wpPe
         h0Ni7o9pYSgR8an89Oh/bIgvTp87n+1ri45Nn8+0RJfALAGPCGqlMJ5CAFhrvmw+Iklj
         bLkg==
X-Gm-Message-State: AJIora9nJdVRZ09Fo1zdkAkoAN4bDYG7ArhhVH7KbjI86CF3mlCX36Dv
        0DTaxH//dWhwsS0MPIvgt8AYFnnNhQw=
X-Google-Smtp-Source: AGRyM1sVvh6CZslExlcC7HTPkanuprVYxIw70h7LqP+R229D/XyNr22C/tSMN72XTlGthIsT60N03g==
X-Received: by 2002:a17:90a:c7d7:b0:1e8:3d2d:dd67 with SMTP id gf23-20020a17090ac7d700b001e83d2ddd67mr9452119pjb.89.1655288135315;
        Wed, 15 Jun 2022 03:15:35 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id m26-20020a63941a000000b003fc5b1db26fsm9502035pge.52.2022.06.15.03.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:15:34 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Documentation: highmem: Use literal block for *kmap_local_folio() example
Date:   Wed, 15 Jun 2022 17:15:10 +0700
Message-Id: <20220615101509.516520-1-bagasdotme@gmail.com>
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
kmap_atomic() inside kernel-doc comment of *kmap_local_folio() are enclosed
by double dash (--) instead of prefixed with C comment symbol (//).

Fix these warnings by indenting the code example with literal block
indentation and prefixing comments inside the example with C comment
symbol.

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
 Changes since v1 [1]:
   - Point that the code example is for kmap_atomic() (suggested by
     Matthew Wilcox)
   - Use C comments instead of Unix shell comments prefix (suggested by
     Ira Weiny)

 [1]: https://lore.kernel.org/linux-doc/20220614123115.522131-1-bagasdotme@gmail.com/
 
 include/linux/highmem.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330cb..56d6a019653489 100644
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
+ *   // Find the page of interest.
+ *   struct page *page = find_get_page(mapping, offset);
  *
- * -- Gain access to the contents of that page. --
- * void *vaddr = kmap_atomic(page);
+ *   // Gain access to the contents of that page.
+ *   void *vaddr = kmap_atomic(page);
  *
- * -- Do something to the contents of that page. --
- * memset(vaddr, 0, PAGE_SIZE);
+ *   // Do something to the contents of that page.
+ *   memset(vaddr, 0, PAGE_SIZE);
  *
- * -- Unmap that page. --
- * kunmap_atomic(vaddr);
+ *   // Unmap that page.
+ *   kunmap_atomic(vaddr);
  *
  * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
  * call, not the argument.

base-commit: 018ab4fabddd94f1c96f3b59e180691b9e88d5d8
-- 
An old man doll... just what I always wanted! - Clara

