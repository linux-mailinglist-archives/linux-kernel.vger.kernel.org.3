Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1450B7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiDVM6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiDVM6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:58:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4729EB3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:55:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w27-20020a056830061b00b00604cde931a0so5422826oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlCh/TROTMgIT0UvKXK2lUbRlqfaTVRDW2LmfRt6iMQ=;
        b=AJbIttGXYKk78W5ujsIsWzkCYa/lf9yqYlUkFmWdh+dOfiIsfjkBqdZvTqeY+FEdHk
         T4Z1NxZ2ZV3BMxxixFgPNPXVQxlnirDNMuNEvBsD0W/fzqvx2feMd0O5zyk97eoR4aoI
         pGBS/24bo2SoVROPArN5p5L1yLyjFt5eR/tpzUH4mAXc1Il6rf5b3dUBtFaPq9CGa3r5
         E5z3412okDrnVakO8y5zWGp7GO92hBFsX9L13JpwFE72FI3+i7MDnOv6kV+KOt86/e3i
         b8C4jHR5MPhngq5ZJYeR43obESWWbXPBWqxpgxgIbGMulrJgiiY524PiZbeu5tvvqIu9
         32hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlCh/TROTMgIT0UvKXK2lUbRlqfaTVRDW2LmfRt6iMQ=;
        b=t+Sb/TA+earhJCcRpA8TV3BEzeXRs6Kuatq48BeJQvVFRmF9PB0eWBE0VpM743n5iQ
         Gc0fQZvh64ldR48bt262sz3WO4ilZmxdgRRzzERBvbC3LGX7SEX70f6ypFzpqe+HegkN
         F7os6mxaKAeTgSejfPqHaD44q6SRHxJMNMFn5AbjhqKG4yq4uQ7vBc5ZVkIStGzHThCL
         JssMSiCTW/xzL9ej9ZCZE+JLTubOHAraGpn5+/MolSbK3BO82mhHveFtkv0woAg1nX/K
         nPd+9Qi1nlRxnqNDhZRjoDsx1AyyeMCi5JAA2Ou5ClX1s1VSnHFc8yJFFBDGLK/d9wKr
         W3MA==
X-Gm-Message-State: AOAM533xAi5oU876XkkVw0fhqHCZ2/JWuQdRlj0SZJjZNdN8WaJuiHrY
        Ij4QjsgryM3Ave5BRdW6gus=
X-Google-Smtp-Source: ABdhPJzj3jX9ErrJMhx2HpLiTi18uxQzIahd//wH6r+gPc5CcSmwvCpvIhvJZtoG1Z/cAYKJDOGvUw==
X-Received: by 2002:a05:6830:1256:b0:605:4674:d26a with SMTP id s22-20020a056830125600b006054674d26amr1683976otp.245.1650632153327;
        Fri, 22 Apr 2022 05:55:53 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000de98fe4869sm620837oab.35.2022.04.22.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:55:52 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 2/4] memblock tests: update style of comments for memblock_reserve_*() functions
Date:   Fri, 22 Apr 2022 07:55:36 -0500
Message-Id: <7e21d96491ed573f1f7823cfe56c4d8ced4f78fe.1650631746.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650631746.git.remckee0@gmail.com>
References: <cover.1650631746.git.remckee0@gmail.com>
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

Update comments in memblock_reserve_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

If the comment has an extra column of spaces, remove the extra space at
the beginning of each line for consistency and to conform to Linux kernel
coding style.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 82 ++++++++++++++++--------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index e96be0319ad4..75cd7479ee54 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -303,12 +303,12 @@ static int memblock_add_checks(void)
 	return 0;
 }
 
- /*
-  * A simple test that marks a memory block of a specified base address
-  * and size as reserved and to the collection of reserved memory regions
-  * (memblock.reserved). It checks if a new entry was created and if region
-  * counter and total memory size were correctly updated.
-  */
+/*
+ * A simple test that marks a memory block of a specified base address
+ * and size as reserved and to the collection of reserved memory regions
+ * (memblock.reserved). Expect to create a new entry. The region counter
+ * and total memory size are updated.
+ */
 static int memblock_reserve_simple_check(void)
 {
 	struct memblock_region *rgn;
@@ -330,10 +330,15 @@ static int memblock_reserve_simple_check(void)
 }
 
 /*
- * A test that tries to mark two memory blocks that don't overlap as reserved
- * and checks if two entries were correctly added to the collection of reserved
- * memory regions (memblock.reserved) and if this change was reflected in
- * memblock.reserved's total size and region counter.
+ * A test that tries to mark two memory blocks that don't overlap as reserved:
+ *
+ *  |        +--+      +----------------+  |
+ *  |        |r1|      |       r2       |  |
+ *  +--------+--+------+----------------+--+
+ *
+ * Expect to add two entries to the collection of reserved memory regions
+ * (memblock.reserved). The total size and region counter for
+ * memblock.reserved are updated.
  */
 static int memblock_reserve_disjoint_check(void)
 {
@@ -370,11 +375,20 @@ static int memblock_reserve_disjoint_check(void)
 /*
  * A test that tries to mark two memory blocks as reserved, where the
  * second one overlaps with the beginning of the first (that is
- * r1.base < r2.base + r2.size).
- * It checks if two entries are merged into one region that starts at r2.base
- * and has size of two regions minus their intersection. The test also verifies
- * that memblock can still see only one entry and has a correct total size of
- * the reserved memory.
+ * r1.base < r2.base + r2.size):
+ *
+ *  |  +--------------+--+--------------+  |
+ *  |  |       r2     |  |     r1       |  |
+ *  +--+--------------+--+--------------+--+
+ *     ^              ^
+ *     |              |
+ *     |              r1.base
+ *     |
+ *     r2.base
+ *
+ * Expect to merge two entries into one region that starts at r2.base and
+ * has size of two regions minus their intersection. The total size of the
+ * reserved memory is updated, and the region counter is not updated.
  */
 static int memblock_reserve_overlap_top_check(void)
 {
@@ -410,11 +424,20 @@ static int memblock_reserve_overlap_top_check(void)
 /*
  * A test that tries to mark two memory blocks as reserved, where the
  * second one overlaps with the end of the first entry (that is
- * r2.base < r1.base + r1.size).
- * It checks if two entries are merged into one region that starts at r1.base
- * and has size of two regions minus their intersection. It verifies that
- * memblock can still see only one entry and has a correct total size of the
- * reserved memory.
+ * r2.base < r1.base + r1.size):
+ *
+ *  |  +--------------+--+--------------+  |
+ *  |  |       r1     |  |     r2       |  |
+ *  +--+--------------+--+--------------+--+
+ *     ^              ^
+ *     |              |
+ *     |              r2.base
+ *     |
+ *     r1.base
+ *
+ * Expect to merge two entries into one region that starts at r1.base and
+ * has size of two regions minus their intersection. The total size of the
+ * reserved memory is updated, and the region counter is not updated.
  */
 static int memblock_reserve_overlap_bottom_check(void)
 {
@@ -450,10 +473,19 @@ static int memblock_reserve_overlap_bottom_check(void)
 /*
  * A test that tries to mark two memory blocks as reserved, where the second
  * one is within the range of the first entry (that is
- * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if two entries are merged into one region that stays the
- * same. The counter and total size of available memory are expected to not be
- * updated.
+ * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)):
+ *
+ *  | +-----+--+---------------------------|
+ *  | |     |r2|          r1               |
+ *  +-+-----+--+---------------------------+
+ *    ^     ^
+ *    |     |
+ *    |     r2.base
+ *    |
+ *    r1.base
+ *
+ * Expect to merge two entries into one region that stays the same. The
+ * counter and total size of available memory are not updated.
  */
 static int memblock_reserve_within_check(void)
 {
@@ -485,7 +517,7 @@ static int memblock_reserve_within_check(void)
 
 /*
  * A simple test that tries to reserve the same memory block twice.
- * The region counter and total size of reserved memory are expected to not
+ * Expect the region counter and total size of reserved memory to not
  * be updated.
  */
 static int memblock_reserve_twice_check(void)
-- 
2.32.0

