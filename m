Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3250B890
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448060AbiDVNge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448031AbiDVNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:36:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5558E43
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:24 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 1-20020a4a0901000000b003296ea2104eso1401174ooa.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNoQl+sfpyAeueHKt3p64baur4SRIlT3Mj6rERAMI1U=;
        b=ZkZJH8DeJTV2QEF/sLGsBvw72C6OMsR+FICTZFvE7+T0kIjcKfM/AIiu/2y+GLDwbx
         igQ+D//IoSZCQsdhRTJHMcoMC0K64EiDvTREklRTVFJWHze/rAOPq8XzP+bQFz/scUDe
         D2+I34OCJPRgg6TG0RMs8Qy5ysy1AnHz7KuFXzTS52CYdkT2pgX32F1f22XM3SaE5GRJ
         v8zjKTTWXPZPrBFG4SMPCAPw3DDvm0NayjBpoTvzKTYyqqBt8dVmk+WzD/8GjwWPfqo3
         N1a23ieOTECnnDQcv09Dj6vtz0jnPdn/icxvv8n134KDhfdMOoFWoYI3fiXzI5bwPTpJ
         ZdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNoQl+sfpyAeueHKt3p64baur4SRIlT3Mj6rERAMI1U=;
        b=7cAqYMkdLI552UiOU3PIA34zdXNUCtv5l1ICzSdlL+P0TYrgyIGWVPDAna9ZhNXV6a
         O0vF0pR7v/RF4wybcnAkePZE+HyRi+AESzPxaOlD6euDgyyoUhpReFouqhbFwPdgD/mR
         ywDzynG9Jqkv8nSwSmnsaFLLo6O+jGDTiDuMSY6OotdP4DKj8lXBCoGGNDA+gIcToiqS
         ZcWrSykDC42EhaDsPDEN8sBGu+ZOgW8qchaeOgK3aimAW5j7WNedNd8n3wIcTZApGXt1
         ZM05aaKtm8qzs2ClrVqgH2UFVeUsdst+NI0IkNrcEkWb9HFE8VIHxlFnjhyK4jSLukae
         XKRA==
X-Gm-Message-State: AOAM530P/v69GcH4+Va2Tw4gg5pZMqlkC8lo4M/u9MaHnW/WMYezb7c1
        q1zYj7yP0zpt3Ofb85fp4Wc=
X-Google-Smtp-Source: ABdhPJxSU/zThx4wKmESf3C+FPCzLNZeY1V1RBDCVU/BjmOt+fWcoMfXS/9QAM9GK9EneSJf+MrSPA==
X-Received: by 2002:a4a:968e:0:b0:324:22c6:1a31 with SMTP id s14-20020a4a968e000000b0032422c61a31mr1553415ooi.93.1650634403983;
        Fri, 22 Apr 2022 06:33:23 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id c25-20020a0568301af900b0060579b0abe2sm708887otd.61.2022.04.22.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:33:23 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 4/5] memblock tests: update style of comments for memblock_free_*() functions
Date:   Fri, 22 Apr 2022 08:33:01 -0500
Message-Id: <4952e3dce1147685a7ad0ae41287348e9e3f7f68.1650633253.git.remckee0@gmail.com>
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

Update comments in memblock_free_*() functions to match the style used
in tests/alloc_*.c by rewording to make the expected outcome more apparent
and, if more than one memblock is involved, adding a visual of the
memory blocks.

If the comment has an extra column of spaces, remove the extra space at
the beginning of each line for consistency and to conform to Linux kernel
coding style.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c | 90 ++++++++++++++++++------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 08847dc5065e..f646350d370e 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -806,10 +806,17 @@ static int memblock_remove_checks(void)
 /*
  * A simple test that tries to free a memory block that was marked earlier
  * as reserved. By "freeing" a region we mean overwriting it with the next
- * entry in memblock.reserved. To check this is the case, the test reserves
- * two memory regions and verifies that the value of the latter was used to
- * erase r1 region.
- * The test also checks if the region counter and total size were updated.
+ * entry in memblock.reserved:
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
@@ -840,11 +847,22 @@ static int memblock_free_simple_check(void)
 	return 0;
 }
 
- /*
-  * A test that tries to free a region that was not marked as reserved
-  * (i.e. has no corresponding entry in memblock.reserved). It verifies
-  * that array, regions counter and total size were not modified.
-  */
+/*
+ * A test that tries to free a region that was not marked as reserved
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
@@ -875,10 +893,22 @@ static int memblock_free_absent_check(void)
 
 /*
  * A test that tries to free a region which overlaps with the beginning of
- * the already existing entry r1 (that is r1.base < r2.base + r2.size). It
- * checks if only the intersection of both regions is freed. The test also
- * checks if the regions counter and total size are updated to expected
- * values.
+ * the already existing entry r1 (that is r1.base < r2.base + r2.size):
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
@@ -913,9 +943,17 @@ static int memblock_free_overlap_top_check(void)
 
 /*
  * A test that tries to free a region which overlaps with the end of the
- * first entry (that is r2.base < r1.base + r1.size). It checks if only the
- * intersection of both regions is freed. The test also checks if the
- * regions counter and total size are updated to expected values.
+ * first entry (that is r2.base < r1.base + r1.size):
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
@@ -951,11 +989,21 @@ static int memblock_free_overlap_bottom_check(void)
 /*
  * A test that tries to free a region which is within the range of the
  * already existing entry (that is
- * (r1.base < r2.base) && (r2.base + r2.size < r1.base + r1.size)).
- * It checks if the region is split into two - one that ends at r2.base and
- * second that starts at r2.base + size, with appropriate sizes. It is
- * expected that the region counter and total size fields were updated t
- * reflect that change.
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
+ * another that starts at r2.base + size, with appropriate sizes. The
+ * region counter and total size fields are updated.
  */
 static int memblock_free_within_check(void)
 {
-- 
2.32.0

