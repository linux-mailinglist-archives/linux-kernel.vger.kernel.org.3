Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418675160E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbiD3Wxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiD3WxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:53:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471777C17A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:50:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso7523835otj.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HLWFM+tx2KwN5HOVNTRmgPm5n3Gwj/LoS/zXb/aBvk=;
        b=L/t3SMdiq0R8WE60sg4aJiN6cEG5iQI0zdwEZsZsT0FYi8peSasDMq0FnerMLj0Tnj
         /xJKAGrj6rANvcm3TVT7OVUmw5tiuZCUbhjMI+P6DK8DImEdR8M9/w6A1PFnVsBiFRRX
         KvkMBzmx2TK6Q7A5JBHd7t/qwh3oElxb18USZAenH/sUV5Gl4Sgut4W55nntSXx5tpVM
         lKTMV+/oGDy4adkTteeixwPHJQO+cojcDLBpb13BgRmgz/TY64ct3hVxsF/9rR6ir4Nx
         hosgnaOpvVM5L+c6Yjdo9JMZ4jXYSlyR9FMbgbJmthkSP9xasiybesp1UssF0Qv0gBMu
         6KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HLWFM+tx2KwN5HOVNTRmgPm5n3Gwj/LoS/zXb/aBvk=;
        b=g5ZKEjvUZZhyN/k9cXP2KVhc3ccJ7QzsFFOrc94at31E9cGGb4ZDuuRG5CXt7tMKeQ
         PmMFEyG85UdlKqhiJo/QXsTaMVx5cJAGvOoGDnKy3jYbElzslKNmz9DQMmoFg/MzM459
         /GQbn0DUpdwYZSgsM4lCc8GlMV0WMXTKEpLRi69X4SH1aQP+u4wcJgniHETMNj2i30l2
         d/icDjb/wLAV1z5kFHYDAy8DjVWtayXquGGE+fRTH4LLx9bLtcolRKGd5pnp++uX+vbd
         tHVeEah/hHtGOaF6j2gBcttPXyy+AVsE5/jBovZIk6Mkk3n6S4Bpn6ctYZ1ZNmYCFG9V
         ibBw==
X-Gm-Message-State: AOAM532OW9+Ir4s8CUw9jaaS6cpaZ4wHFRLVp73/Dm4BnNqhJlSAtRT/
        kvS9UoDa8vdTuMNm9jr17HIQxmxS8YY=
X-Google-Smtp-Source: ABdhPJzz4ZyfwMqmDCjlmro6vvBy4B59tHcAdE+lyX61Oxu7SxwE0PSIYZaFk7+JfwZJOrIbl5wyyQ==
X-Received: by 2002:a9d:5a19:0:b0:5cd:9ca0:898b with SMTP id v25-20020a9d5a19000000b005cd9ca0898bmr2073134oth.318.1651359000508;
        Sat, 30 Apr 2022 15:50:00 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q4-20020a056870028400b000e5aa7f2cadsm4418993oaf.3.2022.04.30.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:50:00 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 4/5] memblock tests: update style of comments for memblock_free_*() functions
Date:   Sat, 30 Apr 2022 17:49:39 -0500
Message-Id: <9256c86a6be96e5270670b3cd8a17ec2593646c9.1651357434.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651357434.git.remckee0@gmail.com>
References: <cover.1651357434.git.remckee0@gmail.com>
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

Update comments in memblock_free_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

If the comment has an extra column of spaces, remove the extra space at
the beginning of each line for consistency and to conform to Linux kernel
coding style.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 102 +++++++++++++++++------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 37b7cc075b0f..a7bc180316d6 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -806,12 +806,19 @@ static int memblock_remove_checks(void)
 }
 
 /*
- * A simple test that tries to free a memory block that was marked earlier
- * as reserved. By "freeing" a region we mean overwriting it with the next
- * entry in memblock.reserved. To check this is the case, the test reserves
- * two memory regions and verifies that the value of the latter was used to
- * erase r1 region.
- * The test also checks if the region counter and total size were updated.
+ * A simple test that tries to free a memory block r1 that was marked
+ * earlier as reserved. By "freeing" a region we mean overwriting it with
+ * the next entry r2 in memblock.reserved:
+ *
+ *  |              ......           +----+ |
+ *  |              : r1 :           | r2 | |
+ *  +--------------+----+-----------+----+-+
+ *                                  ^
+ *                                  |
+ *                                  rgn.base
+ *
+ * Expect to reserve two memory regions and then erase r1 region with the
+ * value of r2. The region counter and total size are updated.
  */
 static int memblock_free_simple_check(void)
 {
@@ -842,11 +849,22 @@ static int memblock_free_simple_check(void)
 	return 0;
 }
 
- /*
-  * A test that tries to free a region that was not marked as reserved
-  * (i.e. has no corresponding entry in memblock.reserved). It verifies
-  * that array, regions counter and total size were not modified.
-  */
+/*
+ * A test that tries to free a region r2 that was not marked as reserved
+ * (i.e. has no corresponding entry in memblock.reserved):
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
+ * The array, regions counter and total size are not modified.
+ */
 static int memblock_free_absent_check(void)
 {
 	struct memblock_region *rgn;
@@ -876,11 +894,23 @@ static int memblock_free_absent_check(void)
 }
 
 /*
- * A test that tries to free a region which overlaps with the beginning of
- * the already existing entry r1 (that is r1.base < r2.base + r2.size). It
- * checks if only the intersection of both regions is freed. The test also
- * checks if the regions counter and total size are updated to expected
- * values.
+ * A test that tries to free a region r2 that overlaps with the beginning
+ * of the already existing entry r1 (that is r1.base < r2.base + r2.size):
+ *
+ *     +----+
+ *     | r2 |
+ *     +----+
+ *  |    ...+--------------+               |
+ *  |    :  |    r1        |               |
+ *  +----+--+--------------+---------------+
+ *       ^  ^
+ *       |  |
+ *       |  rgn.base
+ *       |
+ *       r1.base
+ *
+ * Expect that only the intersection of both regions is freed. The
+ * regions counter and total size are updated.
  */
 static int memblock_free_overlap_top_check(void)
 {
@@ -914,10 +944,18 @@ static int memblock_free_overlap_top_check(void)
 }
 
 /*
- * A test that tries to free a region which overlaps with the end of the
- * first entry (that is r2.base < r1.base + r1.size). It checks if only the
- * intersection of both regions is freed. The test also checks if the
- * regions counter and total size are updated to expected values.
+ * A test that tries to free a region r2 that overlaps with the end of
+ * the already existing entry r1 (that is r2.base < r1.base + r1.size):
+ *
+ *                   +----------------+
+ *                   |       r2       |
+ *                   +----------------+
+ *  |    +-----------+.....                |
+ *  |    |       r1  |    :                |
+ *  +----+-----------+----+----------------+
+ *
+ * Expect that only the intersection of both regions is freed. The
+ * regions counter and total size are updated.
  */
 static int memblock_free_overlap_bottom_check(void)
 {
@@ -951,13 +989,23 @@ static int memblock_free_overlap_bottom_check(void)
 }
 
 /*
- * A test that tries to free a region which is within the range of the
- * already existing entry (that is
- * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if the region is split into two - one that ends at r2.base and
- * second that starts at r2.base + size, with appropriate sizes. It is
- * expected that the region counter and total size fields were updated t
- * reflect that change.
+ * A test that tries to free a region r2 that is within the range of the
+ * already existing entry r1 (that is
+ * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)):
+ *
+ *                    +----+
+ *                    | r2 |
+ *                    +----+
+ *  |    +------------+....+---------------+
+ *  |    |    rgn1    | r1 |     rgn2      |
+ *  +----+------------+----+---------------+
+ *       ^
+ *       |
+ *       r1.base
+ *
+ * Expect that the region is split into two - one that ends at r2.base and
+ * another that starts at r2.base + r2.size, with appropriate sizes. The
+ * region counter and total size fields are updated.
  */
 static int memblock_free_within_check(void)
 {
-- 
2.32.0

