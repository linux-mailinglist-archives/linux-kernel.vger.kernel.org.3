Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA235512EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiFTIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbiFTIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:37:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401A12ABD;
        Mon, 20 Jun 2022 01:37:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m2so1861998plx.3;
        Mon, 20 Jun 2022 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yVoQ0SxXSvnuAGacC2kdFONdFFTdfJJAv2a0z5/PO0=;
        b=dhw8MT0S+vtcLI7BXU81rHgRCqHaG1FDHc+OxIonEzZ2aCHN/rxNcaD84xAI7ZahNf
         8GZqmP6Y0RluwS+4LowO1bL2altpW0RUTaVuvJAnivogsoHqiWptymz8LwgT0aiUaqPS
         CS+uj3qKguRR/zb64GBnNWsY6/hva3KWkhkXf3on/F+ujnHiC+193ib6Spj7BJGHRPgy
         Lm79Bk0jjXBAoj8ZK1iXADJjYKaklfKLu/idDJXyvDd+VHQrEYfhJ23gzC77jSDol3y0
         u7o0zSDjIPWHVs6R2Eqdmbw0SDjqQ1XOtJ2h5bm0kFsQmQV2AeB4m+ugwBdmjKBhVAao
         hsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yVoQ0SxXSvnuAGacC2kdFONdFFTdfJJAv2a0z5/PO0=;
        b=q1+kv2gjGw6rVewUodzjbN6i/E093H3i3VJQYvr//KwI/0ma/KNQfcyfbyZrftxeFW
         FjmZHNwqeleH28X5qLtSoxGp7cVP3ImOIWw0qDdPh+NElErW7preTNbjOQ2GNlyArDC3
         YI4q/1WTrlSdoFMlUVDTNtVvFwYXxsvP33gElZ5LT0hqTxMTaF/MPVDRrY3jJ4/X02jb
         JBWvwawGa1+i51BkuNsis2KhMBQ/y3oWd05JhNDLsiU3ge5mfhasPW3ONIXoioTMEu1I
         dFuBaq8iGnrnBgZ6kdjT/NTUZCGATmAmCyUU5exfyLLW6Jgqtn4JN2QX2rtqYgEEecKJ
         4OzA==
X-Gm-Message-State: AJIora9X1HX93E9R7jcMYzahHjXhYfAUNIOQ6ETW0AIU5oThhBZ5fHBC
        gYnqVHMbuQXxyIxWwD6qY0IebikBq98=
X-Google-Smtp-Source: AGRyM1sRBbaktKY2lcchpbjnRC7DWal2IsF8bIXeouU3CCZeyJvcoY2hquO+2BAGrLwE8l9OqR9+dQ==
X-Received: by 2002:a17:902:c951:b0:163:ed13:7acd with SMTP id i17-20020a170902c95100b00163ed137acdmr22886995pla.51.1655714231053;
        Mon, 20 Jun 2022 01:37:11 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-21.three.co.id. [116.206.28.21])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a9a8700b001eab99a42efsm5594002pjp.31.2022.06.20.01.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 01:37:10 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Documentation: highmem: Use literal block for code example in highmem.h comment
Date:   Mon, 20 Jun 2022 15:36:49 +0700
Message-Id: <20220620083649.18172-1-bagasdotme@gmail.com>
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
indentation and prefixing comments inside the example with C comment
symbol (#).

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
 Changes since v2 [1]:
   - Rebase on v5.19-rc3
   - Don't mention any functions

 [1]: https://lore.kernel.org/linux-doc/20220615101509.516520-1-bagasdotme@gmail.com/
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

