Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D65160DD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbiD3Wx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiD3WxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:53:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94E69486
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so4975616ote.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bG37rvcep9NRYqYV++Ee/JVfkX0YlgX6zU5PsGTmvc8=;
        b=ME9eSKKJT4KOyft/ekv2IQm9FhMq0P5+6hW4Iiq5+V3dpm5nQRjUpk1v2xNulr78Gk
         ygckxMsgCyRrO1RplfI69ubjhYPSA4fY5SLfmHd+A2kIDpq3ksoFTkccWldjpnyrTQon
         bLTr6Ah3sMN81SVd1GLAH4RSZt3GdoBsWibhQDWr44Vw6nFLXiiJB0j/gYoDder5vEWQ
         i7wl7AH3I95BQvP0n1fgusm0XAUgjAnRt331mvvSh2r3DAkXBnlIiMOps3MhHskWlk3H
         BW5o7FQxkAOzGlQrHWry+6lFNwivrOzjlKozQcmL0HLJhEsDjh4HL1UdFfNbwvDNWQAW
         NKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bG37rvcep9NRYqYV++Ee/JVfkX0YlgX6zU5PsGTmvc8=;
        b=Rr4LyO1QPY11Z2yjS2UHYdfT1tPN/5Ryz9K5Q+bWDG0Rv8S3984lgAO8n0gy/lg0jZ
         TC6hGlxB7NRTfx1qBoow5vkMXaPmqgsSaezQ64bTI9seuJD2A105qXNnKStDZE7dvtZX
         N1FC8kBVUMBEqMFbTL5LVG8KPGrMMPpBuS3nvdetAu+KMHlalpeNIHt8/Legyze+Nddv
         Ka60FwUl8c/mV/MBQSvBPU9ViG0+rGFpri369czJMzbISwIayK767T7YLK5iin3olsgB
         iMofGBjYxRZ8UlItGLVb1e+8S0X8CAVRoBSmqZH1TmO4fVDetRs5u8UilXPRBuFdyJGP
         Vh4w==
X-Gm-Message-State: AOAM532NUVk/dQDdy/pbTGY42AsRV2cWgtSmQMHx2Hsu3eCYBo7xev0t
        g25Rs7RKr1LnvYOa5JmH+NXH0khXTG8=
X-Google-Smtp-Source: ABdhPJznJm1itKSDf/m3vlvnbHvAEbJUxILanJO1EwBl14QPFWK3jBHS5Zl3rl/4097Q+dlYgTWQ3w==
X-Received: by 2002:a9d:6a4d:0:b0:605:df01:9858 with SMTP id h13-20020a9d6a4d000000b00605df019858mr1980565otn.87.1651358995614;
        Sat, 30 Apr 2022 15:49:55 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id bf22-20020a056808191600b00325cda1ff92sm1035946oib.17.2022.04.30.15.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:49:55 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 2/5] memblock tests: update style of comments for memblock_reserve_*() functions
Date:   Sat, 30 Apr 2022 17:49:37 -0500
Message-Id: <c3c31797a61bccab08cd4b95a63304c4584ded44.1651357434.git.remckee0@gmail.com>
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

Update comments in memblock_reserve_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

If the comment has an extra column of spaces, remove the extra space at
the beginning of each line for consistency and to conform to Linux kernel
coding style.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 94 ++++++++++++++++--------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index ab8d71b1e24b..6054b83962ca 100644
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
@@ -368,13 +373,22 @@ static int memblock_reserve_disjoint_check(void)
 }
 
 /*
- * A test that tries to mark two memory blocks as reserved, where the
- * second one overlaps with the beginning of the first (that is
- * r1.base < r2.base + r2.size).
- * It checks if two entries are merged into one region that starts at r2.base
- * and has size of two regions minus their intersection. The test also verifies
- * that memblock can still see only one entry and has a correct total size of
- * the reserved memory.
+ * A test that tries to mark two memory blocks r1 and r2 as reserved,
+ * where r2 overlaps with the beginning of r1 (that is
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
@@ -408,13 +422,22 @@ static int memblock_reserve_overlap_top_check(void)
 }
 
 /*
- * A test that tries to mark two memory blocks as reserved, where the
- * second one overlaps with the end of the first entry (that is
- * r2.base < r1.base + r1.size).
- * It checks if two entries are merged into one region that starts at r1.base
- * and has size of two regions minus their intersection. It verifies that
- * memblock can still see only one entry and has a correct total size of the
- * reserved memory.
+ * A test that tries to mark two memory blocks r1 and r2 as reserved,
+ * where r2 overlaps with the end of r1 (that is
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
@@ -448,12 +471,21 @@ static int memblock_reserve_overlap_bottom_check(void)
 }
 
 /*
- * A test that tries to mark two memory blocks as reserved, where the second
- * one is within the range of the first entry (that is
- * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if two entries are merged into one region that stays the
- * same. The counter and total size of available memory are expected to not be
- * updated.
+ * A test that tries to mark two memory blocks r1 and r2 as reserved,
+ * where r2 is within the range of r1 (that is
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

