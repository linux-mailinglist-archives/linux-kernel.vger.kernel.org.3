Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FC5086D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377978AbiDTLWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377969AbiDTLWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:22:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D83C70A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r85so1638034oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDJLRabuQJj3syOFUDJSDmCnEvak7iaR6PEx0BgfcbE=;
        b=KH29lOPOenBJ5J2hq2vFGKN+J/H5njXUX7QRIivIVMGUpxMMYOOWlPwYm9+J/9SRML
         lYGLaLfQ6L/WIgIgENJblT/aPveWE6WyH6xFG1QpBM5RRn/e6aXI4uM0BgTfbOhimyHT
         /Pp95UtvXJ+r0uD5Vn+a0KqaH6c92NnembOH+dveEGb61PEUvAsHmdMqqBs8hE20U8e8
         Z/jtnqq3pr4668O8pMWF4JashWesSs9L80PXTO6V+Olt5QVVlIQ37tlD4TeZFeN2pALu
         3rSBC3l2zSOZG2Bg0eTU3wqAhUEUHN/T9GG4rJHE6JEOnek0fvK0IbJzlKQkMTifNTI7
         T8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDJLRabuQJj3syOFUDJSDmCnEvak7iaR6PEx0BgfcbE=;
        b=YUCZzSDNGwA+WE3T2/Gdrd3rNOJOb1tHT8m/J1hTjLbtUh7aifdFkjV0G1N3Mon93P
         adJfOKzPyhrxGFm2fsw181m+WzUZQfGZlYVgFeO5zv624MjhZ8foS2f3DAW5EHxGYlAm
         Dc3ANG13o4J6ZpATgNn8A/97lE9GazcaG7y/aqoWjGQiSTJpPImCtg+ppHI1Ufj1h/kJ
         gchuWsVErpwBGm3YFCgYYclwLojmL3ZETdGtpn9OrgvSCZRsccdfzBsp+ofqG6eel0Rs
         nDsQXKFTa517aAQ95htgqVgS8yDfaqeLPYQOH+DR7komYhrxCnC8Qrg7WuF89x5cNnze
         SwtQ==
X-Gm-Message-State: AOAM533F8++DMA3q6iGigvd/jNNTwR6EjGb/IgL+UAE43d5QMtPiOytL
        UKP05JkoNeTsSueca0g6y6PxioU2wG8xiw==
X-Google-Smtp-Source: ABdhPJwaEwD0/ZAaRKhv6NAb6Yvy6whTC/ZCrTYJO+a6+wsufJPu1I83zjDCtkI5oHirQNCaTXTxxw==
X-Received: by 2002:a05:6808:1244:b0:322:6925:3f4f with SMTP id o4-20020a056808124400b0032269253f4fmr1402356oiv.39.1650453556416;
        Wed, 20 Apr 2022 04:19:16 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id b16-20020a056870471000b000e5caa2b264sm3554224oaq.20.2022.04.20.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:19:16 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/3] memblock tests: update style of comments for memblock_add_*() functions
Date:   Wed, 20 Apr 2022 06:19:00 -0500
Message-Id: <0004a1a720c5c15ba16cb9f2fb226f57276de2c0.1650452552.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650452552.git.remckee0@gmail.com>
References: <cover.1650452552.git.remckee0@gmail.com>
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

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 75 +++++++++++++++++-------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index fbc1ce160303..cdf112d25343 100644
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
@@ -55,8 +55,8 @@ static int memblock_add_simple_check(void)
 /*
  * A simple test that adds a memory block of a specified base address, size
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
@@ -125,10 +131,20 @@ static int memblock_add_disjoint_check(void)
 
 /*
  * A test that tries to add two memory blocks, where the second one overlaps
- * with the beginning of the first entry (that is r1.base < r2.base + r2.size).
- * After this, it checks if two entries are merged into one region that starts
- * at r2.base and has size of two regions minus their intersection. It also
- * verifies the reported total size of the available memory and region counter.
+ * with the beginning of the first entry (that is r1.base < r2.base + r2.size):
+ *
+ *  |    +----+----+------------+          |
+ *  |    |   r|2   |   r1       |          |
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
@@ -163,11 +179,20 @@ static int memblock_add_overlap_top_check(void)
 
 /*
  * A test that tries to add two memory blocks, where the second one overlaps
- * with the end of the first entry (that is r2.base < r1.base + r1.size).
- * After this, it checks if two entries are merged into one region that starts
- * at r1.base and has size of two regions minus their intersection. It verifies
- * that memblock can still see only one entry and has a correct total size of
- * the available memory.
+ * with the end of the first entry (that is r2.base < r1.base + r1.size):
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
@@ -203,9 +228,17 @@ static int memblock_add_overlap_bottom_check(void)
 /*
  * A test that tries to add two memory blocks, where the second one is
  * within the range of the first entry (that is r1.base < r2.base &&
- * r2.base + r2.size < r1.base + r1.size). It checks if two entries are merged
- * into one region that stays the same. The counter and total size of available
- * memory are expected to not be updated.
+ * r2.base + r2.size < r1.base + r1.size).
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

