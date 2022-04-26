Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200FD51030A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352886AbiDZQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiDZQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:20:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD86F9E0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:17:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a15so18398914pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76ANDOqY59ZR47YfaBH9/PPxLh4wv/KZ4Gd05hmQ0dQ=;
        b=HWcdREyEfpxb2LIABQ91++rPQJYSdOCCKwzPTXdsn88FlNOuyUxHKCozdUF2e4HLcC
         HlJrGoewtonmmCU2lxKR80T9ewPIy3Sym6BIwJ966uP06DAXZcFvuNobY0yf5s7YFRwK
         TPy9kcWV7gdWjnwLqAFg6EK2kGkKpytJFpEtnCgqBKaE1TadN60CtAtbZqoHbRfPnfNi
         oPhasfrMPOr5lva58XgAa2kzqJposn3ALiQ90sE8Ok0MkHR427N7l5iQNT7SAQrYyf17
         /48HfA3BU9RSgzhKeaamepC4ByYhiWkPfsXqry+EGxZ6Doyhw2ZGqYLV91QLVSF4yANq
         8eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=76ANDOqY59ZR47YfaBH9/PPxLh4wv/KZ4Gd05hmQ0dQ=;
        b=5svu7Z+SPkJunpqdVaZk/UvtK6RpJKyYRIPo1OeZ5IrINAvCJdaN5q1KkqrIw8PZ9z
         qJAPZ8rUKz92+CP5HWfgrB3ouvXAaQfm9uqAMVNFF3Mke0bBdlL9A2nAgeZXjSHliEMo
         cdqS1g9l0MmwhbeIo/1FKhIGGzTQrJgVXfArMoPrjUUql1KVdDh7QDSsMd2UPFAz7Wnc
         QLLeWm9nZ0qUB6FZSbBo5xZGB+t2jUSSgoY3Xx/y3P9RSr4eRZu/Y3cTG/TuCh9F4Ra7
         x2vmbPYwrlAwyHddS1RrcHAJFbyAAosZRqWE5wD9twtZRulKl3fJ8AyOs3A0ox4wPvNN
         4jbQ==
X-Gm-Message-State: AOAM530AAMzkNZYSB5+7hPqbn02U2fISX9e6YOAiaSdqpMQtS5V5OUry
        sMVWgJYrv+IS6eqpbghSCBA=
X-Google-Smtp-Source: ABdhPJytYMXwRjIngfhLT+QgSMUZc7HTmHYRnQGAup18AOVWCztsXgjwkeJPDAoVBAb0PtARhLr2Tw==
X-Received: by 2002:a65:418b:0:b0:382:250b:4dda with SMTP id a11-20020a65418b000000b00382250b4ddamr20598765pgq.428.1650989848573;
        Tue, 26 Apr 2022 09:17:28 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm17546844pfk.88.2022.04.26.09.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:17:28 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings by 34% tree-wide
Date:   Wed, 27 Apr 2022 01:16:58 +0900
Message-Id: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_first_bit(), find_first_and_bit(), find_first_and_bit() and
find_first_and_bit() all invokes GENMASK(size - 1, 0).

This triggers below warning when compiled with W=2.

| ./include/linux/find.h: In function 'find_first_bit':
| ./include/linux/bits.h:25:36: warning: comparison of unsigned
| expression in '< 0' is always false [-Wtype-limits]
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                                    ^
| ./include/linux/build_bug.h:16:62: note: in definition of macro
| 'BUILD_BUG_ON_ZERO'
|    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|       |                                                              ^
| ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                 ^~~~~~~~~~~~~~
| ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
|    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|       |          ^~~~~~~~~~~~~~~~~~~
| ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
|   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
|       |                                             ^~~~~~~

linux/find.h being a widely used header file, above warning show up in
thousand of files which include this header (either directly on
indirectly).

Because it is a false positive, we just silence -Wtype-limits flag
locally to remove the spam. clang does not warn about it, so we just
apply the diag_ignore() directive to gcc.

By doing so, the warnings for a W=2 build are reduced by
34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
and after: 340097.

For reference, past proposal to modify GENMASK_INPUT_CHECK() was
rejected in:
https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/find.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5bb6db213bcb..efd4b3f7dd17 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -103,6 +103,10 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 }
 #endif
 
+__diag_push();
+__diag_ignore(GCC, 8, "-Wtype-limits",
+	      "GENMASK(size - 1, 0) yields 'comparison of unsigned expression in < 0 is always false' which is OK");
+
 #ifndef find_first_bit
 /**
  * find_first_bit - find the first set bit in a memory region
@@ -193,6 +197,8 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+__diag_pop(); /* ignore -Wtype-limits */
+
 /**
  * find_next_clump8 - find next 8-bit clump with set bits in a memory region
  * @clump: location to store copy of found clump
-- 
2.35.1

