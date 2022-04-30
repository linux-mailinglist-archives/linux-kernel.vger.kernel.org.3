Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0015160DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiD3WxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiD3WxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:53:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E350D69486
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v65so12055903oig.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1m2/yma9+xrc4M9pvudxqT56p82zVBLGfgv/vF3VXE=;
        b=d7lqz/KT4zcyWw8uAp7ZSQyPV+F0vWQN4RK4FYzHN2KxY2mUMl3XsehUSGZu7fxJpL
         vBpNGIuSA9np4U4usS1oWlm5MYeebPhUIwbyNGvYb7wyJ2wskIhvT/np3z5tGVXqTLyc
         gAkwQNpR5CK+x0wUWPKJ1O991qo3QLlpqerXuZuEebeje7jYg8eYQs+WwjakMlggHjE/
         8NvUhAjBg7DDfj65tsElAJtVc3uPhby1eR5CWgl7I4YPL2MBJGR1lWF49FkKkEP1+rkc
         PnUroInfdqyJEiAXcmBPqOrrodBPw/Qi7OYo4XQ4kCm2z6NLOMnpvkHJMyJSubQiydF5
         KOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1m2/yma9+xrc4M9pvudxqT56p82zVBLGfgv/vF3VXE=;
        b=r2bcN4nIqhAkIm9xZ87Ec9sdgstRkCMXgfk+xOy22B4W2hcypJaC7FA5G33Kcs1i/x
         lbH8eQiMxuzaAdYObrMZG7NKQZKVt6OLjciTr8vrXdmGj2WOHrNkBwEEAHn6L/kgj4Ss
         ALeG9l/Vds7Rb4lMBTaSUAghA4FC4tZ+EXBj4I4MzB20qvKtZsC6DZ2k27ShUU+pBcXd
         eRxYa2E8VPeIFJStxOxPRgUR0r4jA5+buokprXXu4V7ORc/lu/x01Wg0qQ57hf+v3+95
         5N5Zz37l1KubaEtJuim5Rc+ONks144k1HFrTeazJSAsRa6KEZTMWXyNj7ZgH7C5JXVpC
         mTzg==
X-Gm-Message-State: AOAM530MXXTZmvCeHjlo3lYbeoZe+/NUO5hJie4+xHs8QdvH9bETt59y
        chMG/btGBqZC5T3NO60MBeU=
X-Google-Smtp-Source: ABdhPJz1IWYUVrgrrsrI8utFOAKEd0OVSn97ROtLuIa3Tx464K8UnqdVsJ5G3qTrKTknRycvRB1RRA==
X-Received: by 2002:a05:6808:30a9:b0:325:e5a7:1c49 with SMTP id bl41-20020a05680830a900b00325e5a71c49mr967205oib.153.1651358993118;
        Sat, 30 Apr 2022 15:49:53 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id h22-20020a056808015600b00325cda1ff95sm1026360oie.20.2022.04.30.15.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 15:49:52 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 1/5] memblock tests: update style of comments for memblock_add_*() functions
Date:   Sat, 30 Apr 2022 17:49:36 -0500
Message-Id: <3d735aef1d50e215d738519cd285a5b593710e13.1651357434.git.remckee0@gmail.com>
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

Update comments in memblock_add_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 85 ++++++++++++++++--------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index fbc1ce160303..ab8d71b1e24b 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -26,8 +26,8 @@ static int memblock_initialization_check(void)
 /*
  * A simple test that adds a memory block of a specified base address
  * and size to the collection of available memory regions (memblock.memory).
- * It checks if a new entry was created and if region counter and total memory
- * were correctly updated.
+ * Expect to create a new entry. The region counter and total memory get
+ * updated.
  */
 static int memblock_add_simple_check(void)
 {
@@ -53,10 +53,10 @@ static int memblock_add_simple_check(void)
 }
 
 /*
- * A simple test that adds a memory block of a specified base address, size
+ * A simple test that adds a memory block of a specified base address, size,
  * NUMA node and memory flags to the collection of available memory regions.
- * It checks if the new entry, region counter and total memory size have
- * expected values.
+ * Expect to create a new entry. The region counter and total memory get
+ * updated.
  */
 static int memblock_add_node_simple_check(void)
 {
@@ -87,9 +87,15 @@ static int memblock_add_node_simple_check(void)
 
 /*
  * A test that tries to add two memory blocks that don't overlap with one
- * another. It checks if two correctly initialized entries were added to the
- * collection of available memory regions (memblock.memory) and if this
- * change was reflected in memblock.memory's total size and region counter.
+ * another:
+ *
+ *  |        +--------+        +--------+  |
+ *  |        |   r1   |        |   r2   |  |
+ *  +--------+--------+--------+--------+--+
+ *
+ * Expect to add two correctly initialized entries to the collection of
+ * available memory regions (memblock.memory). The total size and
+ * region counter fields get updated.
  */
 static int memblock_add_disjoint_check(void)
 {
@@ -124,11 +130,21 @@ static int memblock_add_disjoint_check(void)
 }
 
 /*
- * A test that tries to add two memory blocks, where the second one overlaps
- * with the beginning of the first entry (that is r1.base < r2.base + r2.size).
- * After this, it checks if two entries are merged into one region that starts
- * at r2.base and has size of two regions minus their intersection. It also
- * verifies the reported total size of the available memory and region counter.
+ * A test that tries to add two memory blocks r1 and r2, where r2 overlaps
+ * with the beginning of r1 (that is r1.base < r2.base + r2.size):
+ *
+ *  |    +----+----+------------+          |
+ *  |    |    |r2  |   r1       |          |
+ *  +----+----+----+------------+----------+
+ *       ^    ^
+ *       |    |
+ *       |    r1.base
+ *       |
+ *       r2.base
+ *
+ * Expect to merge the two entries into one region that starts at r2.base
+ * and has size of two regions minus their intersection. The total size of
+ * the available memory is updated, and the region counter stays the same.
  */
 static int memblock_add_overlap_top_check(void)
 {
@@ -162,12 +178,21 @@ static int memblock_add_overlap_top_check(void)
 }
 
 /*
- * A test that tries to add two memory blocks, where the second one overlaps
- * with the end of the first entry (that is r2.base < r1.base + r1.size).
- * After this, it checks if two entries are merged into one region that starts
- * at r1.base and has size of two regions minus their intersection. It verifies
- * that memblock can still see only one entry and has a correct total size of
- * the available memory.
+ * A test that tries to add two memory blocks r1 and r2, where r2 overlaps
+ * with the end of r1 (that is r2.base < r1.base + r1.size):
+ *
+ *  |  +--+------+----------+              |
+ *  |  |  | r1   | r2       |              |
+ *  +--+--+------+----------+--------------+
+ *     ^  ^
+ *     |  |
+ *     |  r2.base
+ *     |
+ *     r1.base
+ *
+ * Expect to merge the two entries into one region that starts at r1.base
+ * and has size of two regions minus their intersection. The total size of
+ * the available memory is updated, and the region counter stays the same.
  */
 static int memblock_add_overlap_bottom_check(void)
 {
@@ -201,11 +226,19 @@ static int memblock_add_overlap_bottom_check(void)
 }
 
 /*
- * A test that tries to add two memory blocks, where the second one is
- * within the range of the first entry (that is r1.base < r2.base &&
- * r2.base + r2.size < r1.base + r1.size). It checks if two entries are merged
- * into one region that stays the same. The counter and total size of available
- * memory are expected to not be updated.
+ * A test that tries to add two memory blocks r1 and r2, where r2 is
+ * within the range of r1 (that is r1.base < r2.base &&
+ * r2.base + r2.size < r1.base + r1.size):
+ *
+ *  |   +-------+--+-----------------------+
+ *  |   |       |r2|      r1               |
+ *  +---+-------+--+-----------------------+
+ *      ^
+ *      |
+ *      r1.base
+ *
+ * Expect to merge two entries into one region that stays the same.
+ * The counter and total size of available memory are not updated.
  */
 static int memblock_add_within_check(void)
 {
@@ -236,8 +269,8 @@ static int memblock_add_within_check(void)
 }
 
 /*
- * A simple test that tries to add the same memory block twice. The counter
- * and total size of available memory are expected to not be updated.
+ * A simple test that tries to add the same memory block twice. Expect
+ * the counter and total size of available memory to not be updated.
  */
 static int memblock_add_twice_check(void)
 {
-- 
2.32.0

