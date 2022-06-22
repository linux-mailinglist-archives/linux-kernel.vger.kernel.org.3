Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BB554763
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbiFVIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiFVIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:48:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5677125E1;
        Wed, 22 Jun 2022 01:48:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso15263123pjd.3;
        Wed, 22 Jun 2022 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs9pVTpUBi42eMdaATCBVLHpAcP7Nw426zvueY8ZwZI=;
        b=Lw0reKp119fQgW191FyyK0jxb52gIGmRolrrEJan5fK67WbHe6KIeUNsg7pgDoqjtT
         RzO3qPtfgxrYlG/fRm0u8QBkiO/igrt4hSQwVNHETFmkLoMkwJwaTT7mpeooVbsiN9fL
         8I2KrBsqduyUa+VSUxarzQxWslOLClxg5whYaXKY5ZXnOuK8gMQsLEa1DKU8/SxqlH8n
         JDIBbuDtZGUR1qz4pUDcY0uXn6Pnfk+jzwUo8vRF+Ni0gZrppyu5+G7IElQJbAJFbwn0
         NqXSmHspY8OWIBFYtfgkweYjzXgs0aK/59uJPuDKoM/hHkfGSay0c1bnYIx4JIInMCOP
         4hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs9pVTpUBi42eMdaATCBVLHpAcP7Nw426zvueY8ZwZI=;
        b=LpslrHezcQCyHm+VEVOTMSRLxERozF5drOOxNliCDm+PvFI48R5ewUZFZDvUfOlHXB
         CiS42FKzNGekZu4/SFcMTCZ8t6nV6h8VsPZIN1MmiyDZrS62RhnuhLnzfVftanH/w7Xb
         fD1/ELS69tDMN38UysZJc2BcHHv/TJLbdRvrN57nXuPka5xn6WTrgy0yD3yNvzea5bRH
         OYk+IQU5rn9TYIblw1yzOTq/mRXy9dlxW1kAASrx0egwfY3/IM14eIKIdq42sMUZcMce
         w0pw3vxeIHNbJ3DwglR1aticwaxd3dmd+OBEKZMQySuUm0/fLKuVounTlz1N4/esGpEy
         ALoA==
X-Gm-Message-State: AJIora8D/KuQauig3+F3RJvHYeFYHw6u13wM0xxeVyn/WxwdhrC5/1Dx
        vLjTykhbpAh4TUfxsWKhek9+7vNE31s=
X-Google-Smtp-Source: AGRyM1shJvjitaGBPWgz/pdx6BV2OQUPOBwCHk3mBN4tYOSIhFIxvffRnNlgoVtOp/xm7tZgDMdKLQ==
X-Received: by 2002:a17:902:d509:b0:167:6ed8:afb5 with SMTP id b9-20020a170902d50900b001676ed8afb5mr33549819plg.137.1655887679517;
        Wed, 22 Jun 2022 01:47:59 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001677fa34a4fsm8199930plh.72.2022.06.22.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:47:58 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Documentation: highmem: Use literal block for code example in highmem.h comment
Date:   Wed, 22 Jun 2022 15:45:46 +0700
Message-Id: <20220622084546.17745-1-bagasdotme@gmail.com>
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

These warnings above are due to comments in code example at the
mentioned lines above are enclosed by double dash (--), which confuses
Sphinx as inline markup delimiters instead.

Fix these warnings by indenting the code example with literal block
indentation and making the comments C comments.

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
 Changes since v3 [1]:
   - Say "C comments" rephrase (suggested by Ira)

 [1]: https://lore.kernel.org/linux-doc/20220620083649.18172-1-bagasdotme@gmail.com/

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

base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
-- 
An old man doll... just what I always wanted! - Clara

