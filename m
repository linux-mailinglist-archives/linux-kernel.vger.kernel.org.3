Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA21450B88C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448036AbiDVNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448025AbiDVNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:36:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E4583BA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:22 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w194so9012557oiw.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWWT9S1ut5UtdYn94rrDqYYPxhJGIa0Bw2tNIUfzycc=;
        b=iSjgOmJph0wI9W9moIoXgUb4CbS77tWvK87utauHR+6Ec3lu9iCOjOKrPey6QWPLPS
         6v4qa3wD3p7p2nja/OQAv5gz3LLVHJkfiP0D8EaZM0CXGfEljtRDWp2lQunorYflBFXI
         YVL5+4kIGFtcHehI1OhtkZIx2JL9SKgyAlvdei/ZVfws25BxhpIJdLIA4iSNOjLtoCCG
         Ltqy95QdlkdZ8M+hvBX4kYXIN9/ij1Q7nAJtoLaUMrhY2Tm+nhvinFwjFm1oumz/WxeZ
         v3nVvZMdq6f3z5V14CVLHOylKKafekCo689D1U5wxl0ac6pFVhM6OkTuwq7ZMQHGCV96
         DFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWWT9S1ut5UtdYn94rrDqYYPxhJGIa0Bw2tNIUfzycc=;
        b=saAtYb7HXuKrGVBQmyw9qqtnMlg0j5CWYY5vBRTptxwG/bsJ6ncV+r26dnZcx97P+H
         a5HGBk80yZUg5TDXZ9AZAFY5f3CLmnKijnc2+JaefSQWuG/OAAozoLwxTBd/1IZoh2Me
         uNHcdbupWyqNFi3/NPIMUzzs1cY+wxF1P3kbtz4kY59H1IauFtV0Bis7AcjimFHr3+5X
         8g+EPg0EJsTSP1UpdU1IjoSokbf4QLLWtffl0Ynu8VknXwv6yUsfwYK4e3DoXM3IKasR
         mIaBKNMOovX6Vz4x9TGD2vyjCR6P9IL5OhjX5/UcY8AzhyMK5k3tWGyFc58E1O3eNhgW
         yqJA==
X-Gm-Message-State: AOAM530AsuikDQ0ikuCsrnNx1UNju1guLU2jfgdSmdwCQfxkUnhsyMCe
        j/X8TcF8m13zx6L7uc7PMNE=
X-Google-Smtp-Source: ABdhPJw2WQ/OVm35pqkbglbSshfHt4oKxslDglb4Myr1bVgiekofd0Lj4FByZNNqa1B+FNWl24Fitw==
X-Received: by 2002:a54:4719:0:b0:322:6ce1:6fa7 with SMTP id k25-20020a544719000000b003226ce16fa7mr2092564oik.105.1650634401866;
        Fri, 22 Apr 2022 06:33:21 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id u3-20020a4a9703000000b0033336ab4909sm788777ooi.7.2022.04.22.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:33:21 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 3/5] memblock tests: update style of comments for memblock_remove_*() functions
Date:   Fri, 22 Apr 2022 08:33:00 -0500
Message-Id: <3b83322c070bdd43a33c336d135f485244f107d3.1650633253.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650633253.git.remckee0@gmail.com>
References: <cover.1650633253.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments in memblock_remove_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

If the comment has an extra column of spaces, remove the extra space at
the beginning of each line for consistency and to conform to Linux kernel
coding style.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 101 +++++++++++++++++------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 75cd7479ee54..08847dc5065e 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -550,14 +550,21 @@ static int memblock_reserve_checks(void)
 	return 0;
 }
 
- /*
-  * A simple test that tries to remove the first entry of the array of
-  * available memory regions. By "removing" a region we mean overwriting it
-  * with the next region in memblock.memory. To check this is the case, the
-  * test adds two memory blocks and verifies that the value of the latter
-  * was used to erase r1 region.  It also checks if the region counter and
-  * total size were updated to expected values.
-  */
+/*
+ * A simple test that tries to remove the first entry of the array of
+ * with the next region in memblock.memory:
+ *
+ *  |  ......          +----------------+  |
+ *  |  : r1 :          |       r2       |  |
+ *  +--+----+----------+----------------+--+
+ *                     ^
+ *                     |
+ *                     rgn.base
+ *
+ * Expect to add two memory blocks r1 and r2 and then remove r1 region
+ * so that r2 is the first available region. The region counter and
+ * total size are updated.
+ */
 static int memblock_remove_simple_check(void)
 {
 	struct memblock_region *rgn;
@@ -587,11 +594,22 @@ static int memblock_remove_simple_check(void)
 	return 0;
 }
 
- /*
-  * A test that tries to remove a region that was not registered as available
-  * memory (i.e. has no corresponding entry in memblock.memory). It verifies
-  * that array, regions counter and total size were not modified.
-  */
+/*
+ * A test that tries to remove a region that was not registered as available
+ * memory (i.e. has no corresponding entry in memblock.memory):
+ *
+ *                     +----------------+
+ *                     |       r2       |
+ *                     +----------------+
+ *  |  +----+                              |
+ *  |  | r1 |                              |
+ *  +--+----+------------------------------+
+ *     ^
+ *     |
+ *     rgn.base
+ *
+ * Expect the array, regions counter and total size to not be modified.
+ */
 static int memblock_remove_absent_check(void)
 {
 	struct memblock_region *rgn;
@@ -622,10 +640,21 @@ static int memblock_remove_absent_check(void)
 
 /*
  * A test that tries to remove a region which overlaps with the beginning of
- * the already existing entry r1 (that is r1.base < r2.base + r2.size). It
- * checks if only the intersection of both regions is removed from the available
- * memory pool. The test also checks if the regions counter and total size are
- * updated to expected values.
+ * the already existing entry r1 (that is r1.base < r2.base + r2.size):
+ *
+ *           +-----------------+
+ *           |       r2        |
+ *           +-----------------+
+ *  |                 .........+--------+  |
+ *  |                 :     r1 |  rgn   |  |
+ *  +-----------------+--------+--------+--+
+ *                    ^        ^
+ *                    |        |
+ *                    |        rgn.base
+ *                    r1.base
+ *
+ * Expect that only the intersection of both regions is removed from the
+ * available memory pool. The regions counter and total size are updated.
  */
 static int memblock_remove_overlap_top_check(void)
 {
@@ -662,10 +691,20 @@ static int memblock_remove_overlap_top_check(void)
 
 /*
  * A test that tries to remove a region which overlaps with the end of the
- * first entry (that is r2.base < r1.base + r1.size). It checks if only the
- * intersection of both regions is removed from the available memory pool.
- * The test also checks if the regions counter and total size are updated to
- * expected values.
+ * first entry (that is r2.base < r1.base + r1.size):
+ *
+ *        +--------------------------------+
+ *        |               r2               |
+ *        +--------------------------------+
+ *  | +---+.....                           |
+ *  | |rgn| r1 :                           |
+ *  +-+---+----+---------------------------+
+ *    ^
+ *    |
+ *    r1.base
+ *
+ * Expect that only the intersection of both regions is removed from the
+ * available memory pool. The regions counter and total size are updated.
  */
 static int memblock_remove_overlap_bottom_check(void)
 {
@@ -700,11 +739,21 @@ static int memblock_remove_overlap_bottom_check(void)
 /*
  * A test that tries to remove a region which is within the range of the
  * already existing entry (that is
- * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if the region is split into two - one that ends at r2.base and
- * second that starts at r2.base + size, with appropriate sizes. The test
- * also checks if the region counter and total size were updated to
- * expected values.
+ * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)):
+ *
+ *                  +----+
+ *                  | r2 |
+ *                  +----+
+ *  | +-------------+....+---------------+ |
+ *  | |     rgn1    | r1 |     rgn2      | |
+ *  +-+-------------+----+---------------+-+
+ *    ^
+ *    |
+ *    r1.base
+ *
+ * Expect that the region is split into two - one that ends at r2.base and
+ * another that starts at r2.base + size, with appropriate sizes. The
+ * region counter and total size are updated.
  */
 static int memblock_remove_within_check(void)
 {
-- 
2.32.0

