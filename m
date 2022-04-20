Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359BC5086D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377969AbiDTLWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357141AbiDTLWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:22:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362740928
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r85so1638184oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocpsacXCMhu5GBT0i/LaXz+wmK5Kqsy/4v93G9iC2Rc=;
        b=mmplh0H/itlMHz2vLr1LN5tpZ4/fUG5mT1vmfD1oSsoCfI7cESf3kCCDptnBJXg7Mx
         loOp9QJykorv2QlNs1AOCAwtQ+/LnPF1D1H1JnnlOEzstsZkU4N/rS5pI6U4zK0D42VE
         e9jHrtKUBHBYe0pgX0M0RU//vwX8tgxU3p+bijtyizTTjshlC5OFGmiDgR1pETSH24/n
         B1dw7JJxMQgQP64KasBCOLD1DAgHesgfFeKM37Bw0YvNHSEHBDCId2w8YHwcU+rWhNCR
         UUqSTFgXVG6uaKQfmPi7rMdQk/NCIFcSMWzeugIZ6fIBdyl3fgU4utt3iGuS9w8YH0TN
         uIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocpsacXCMhu5GBT0i/LaXz+wmK5Kqsy/4v93G9iC2Rc=;
        b=u5hX+GVV11/gU/xpvt2TV07yusHWhydxRPOEBb9liT/Gv9hSAu3vvGKQJ0k5RbYHNg
         DJY6VoaLNzxFjUgjSlu120KEMifWS0URSeI5CFvCMjln0hE+/ZKHNuQw8R8S94Wqdiil
         McrZszM4lkJcreh8Cqb3uCmGGEpojT+ZFh0AGziVADWKG9fLN/TK9oMDuG6afRTQCC6P
         DAt3fyBl9hSxtryIoImJQwUZElvRufG6bJIJWmnheSvLIIvVG5k56hUgPkhTISZy0OQy
         MAGRunVDLxmX7ZHtQn4eYKzsuA/7xoY0TTmj36ovm5v1S0/Ll+N22hpgxm5ielkFAPZV
         ktAg==
X-Gm-Message-State: AOAM530T0/DvBqSYc3zRfopduq4l0mf58pYBuzMo40p+WWgbdmZn6pHU
        1djGo5oyi+lgih/eaOHra1E=
X-Google-Smtp-Source: ABdhPJzCLioSonUcKlvI1uTh9yYyuPILIAJL12KvTLTjIslEPEY32uLdlGClfc6dNR5E/EQZpzKwEw==
X-Received: by 2002:a05:6808:1b0a:b0:2fa:6fdd:e2ee with SMTP id bx10-20020a0568081b0a00b002fa6fdde2eemr1315310oib.237.1650453559240;
        Wed, 20 Apr 2022 04:19:19 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0105000000b005fbe5093eb0sm6374070otu.54.2022.04.20.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:19:18 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 2/3] memblock tests: update style of comments for memblock_reserve_*() functions
Date:   Wed, 20 Apr 2022 06:19:01 -0500
Message-Id: <6f385ad37eeb81331f9556fdddeced80ae32bded.1650452552.git.remckee0@gmail.com>
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

Update comments in memblock_reserve_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 70 +++++++++++++++++-------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index cdf112d25343..834d8705ff8a 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -306,8 +306,8 @@ static int memblock_add_checks(void)
  /*
   * A simple test that marks a memory block of a specified base address
   * and size as reserved and to the collection of reserved memory regions
-  * (memblock.reserved). It checks if a new entry was created and if region
-  * counter and total memory size were correctly updated.
+  * (memblock.reserved). Expect to create a new entry. The region counter
+  * and total memory size are updated.
   */
 static int memblock_reserve_simple_check(void)
 {
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
@@ -411,10 +425,19 @@ static int memblock_reserve_overlap_top_check(void)
  * A test that tries to mark two memory blocks as reserved, where the
  * second one overlaps with the end of the first entry (that is
  * r2.base < r1.base + r1.size).
- * It checks if two entries are merged into one region that starts at r1.base
- * and has size of two regions minus their intersection. It verifies that
- * memblock can still see only one entry and has a correct total size of the
- * reserved memory.
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
@@ -451,9 +474,18 @@ static int memblock_reserve_overlap_bottom_check(void)
  * A test that tries to mark two memory blocks as reserved, where the second
  * one is within the range of the first entry (that is
  * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if two entries are merged into one region that stays the
- * same. The counter and total size of available memory are expected to not be
- * updated.
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

