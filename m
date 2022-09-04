Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131F95AC256
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiIDEXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIDEXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:23:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66DB4D4E7
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:23:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4183035otb.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 21:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1Zf+3VluTf2veyGKPV597nMSAXr4oCS9VnEuD4NhVeQ=;
        b=QLhrVd8eJct8PH7G1zUmHfOHMCyHIYvSW0fZNbyH4dR5GWalC2H74+NgPHp76R72LJ
         gerIJTfagCqF/bJ7zTigZo5mfxpSFDf1OqGMOle98k5XUYqeV75mtnNHfjS4TJfHtVvG
         NM1tmyHOsBDl3DDqfHiY3+pfhgppX1LGas7qQ4ABX/AOa+FaWn9RJX3vJ5bHTPx7ztTQ
         j1u2bk9kNeDwo7LM12y8tAQGSyLAROLpVE0ulldpU5ocvZYlPe8VZn5NpWtMtLwA0anX
         Be/AHZgAp/qge+pSQwSa4y0rzJwlifvW1YcGgh2sc5/QCOjyKFhFnPpC5fwP1awO0emE
         7cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1Zf+3VluTf2veyGKPV597nMSAXr4oCS9VnEuD4NhVeQ=;
        b=Dkb2P88bue+ISDdyFglRITcbjswGZ9ESoAo5wdyAbc6XK6HKzGFewnpGfqCb8SjaHy
         ZMfjTLLSrLKqMc0INcmlFg8u0C0RQrSP98kCpR3f/8G0fa/evD/L+tw6FmhlGKiOoYZw
         tE4YV8n87NkL3n8fSsp0kBIgH+j3E4+4dCpAfLSThsmsiRPP6mcd/omVY4VMKyNmmCFi
         2mS1xvZvj+4r8MHqexxgH4SM9qNOOj0fb38cV+VB0RHOdus3e8daq3GpnnyF4G4eGun/
         iwLstg7YtZkHyAmR4AcTPXhPf8pacM+0RVenmn0eiObX/3/HMPxnj71ZOoXPD4KAEgRQ
         1QtQ==
X-Gm-Message-State: ACgBeo0JnU37OsHVU3L56BQIy5xEjNY0Cwhem1m77C+OxR0HQ4gnzLEh
        6B1/qjQSyDhKlDAM9/bsPC0=
X-Google-Smtp-Source: AA6agR4jh5armIKKqupi91gquZRzhVPMBXYvsakzn+kcELswsdOIUc7hqXcr+zsI2FXdxnWJncjsGQ==
X-Received: by 2002:a05:6830:1017:b0:637:163a:38db with SMTP id a23-20020a056830101700b00637163a38dbmr16546453otp.89.1662265430886;
        Sat, 03 Sep 2022 21:23:50 -0700 (PDT)
Received: from sophie (static-198-54-128-109.cust.tzulo.com. [198.54.128.109])
        by smtp.gmail.com with ESMTPSA id u42-20020a056870d5aa00b00120f7de7f6esm3196185oao.58.2022.09.03.21.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:23:50 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH] memblock tests: remove 'cleared' from comment blocks
Date:   Sat,  3 Sep 2022 23:23:37 -0500
Message-Id: <e8be24137e54e9f81a06af969ded82b319114d7a.1662264347.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tests in alloc_nid_api can now run either memblock_alloc_try_nid()
or memblock_alloc_try_nid_raw(). The comment blocks for these tests
should not refer to a 'cleared' region since that only applies to
memblock_alloc_try_nid(). Remove 'cleared' from the comment blocks so
that the comments are accurate for either memblock function.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_nid_api.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 8f25c90c2300..77f83f31c835 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -41,7 +41,7 @@ static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
  *        |                   |
  *        min_addr           max_addr
  *
- * Expect to allocate a cleared region that ends at max_addr.
+ * Expect to allocate a region that ends at max_addr.
  */
 static int alloc_try_nid_top_down_simple_check(void)
 {
@@ -95,7 +95,7 @@ static int alloc_try_nid_top_down_simple_check(void)
  *                 Aligned address
  *                 boundary
  *
- * Expect to allocate a cleared, aligned region that ends before max_addr.
+ * Expect to allocate an aligned region that ends before max_addr.
  */
 static int alloc_try_nid_top_down_end_misaligned_check(void)
 {
@@ -147,7 +147,7 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
  *         |               |
  *         min_addr        max_addr
  *
- * Expect to allocate a cleared region that starts at min_addr and ends at
+ * Expect to allocate a region that starts at min_addr and ends at
  * max_addr, given that min_addr is aligned.
  */
 static int alloc_try_nid_exact_address_generic_check(void)
@@ -201,7 +201,7 @@ static int alloc_try_nid_exact_address_generic_check(void)
  *           address    |
  *           boundary   min_add
  *
- * Expect to drop the lower limit and allocate a cleared memory region which
+ * Expect to drop the lower limit and allocate a memory region which
  * ends at max_addr (if the address is aligned).
  */
 static int alloc_try_nid_top_down_narrow_range_check(void)
@@ -649,7 +649,7 @@ static int alloc_try_nid_reserved_all_generic_check(void)
 /*
  * A test that tries to allocate a memory region, where max_addr is
  * bigger than the end address of the available memory. Expect to allocate
- * a cleared region that ends before the end of the memory.
+ * a region that ends before the end of the memory.
  */
 static int alloc_try_nid_top_down_cap_max_check(void)
 {
@@ -688,7 +688,7 @@ static int alloc_try_nid_top_down_cap_max_check(void)
 /*
  * A test that tries to allocate a memory region, where min_addr is
  * smaller than the start address of the available memory. Expect to allocate
- * a cleared region that ends before the end of the memory.
+ * a region that ends before the end of the memory.
  */
 static int alloc_try_nid_top_down_cap_min_check(void)
 {
@@ -736,7 +736,7 @@ static int alloc_try_nid_top_down_cap_min_check(void)
  *        |                       |
  *        min_addr                max_addr
  *
- * Expect to allocate a cleared region that ends before max_addr.
+ * Expect to allocate a region that ends before max_addr.
  */
 static int alloc_try_nid_bottom_up_simple_check(void)
 {
@@ -790,7 +790,7 @@ static int alloc_try_nid_bottom_up_simple_check(void)
  *                 Aligned address
  *                 boundary
  *
- * Expect to allocate a cleared, aligned region that ends before max_addr.
+ * Expect to allocate an aligned region that ends before max_addr.
  */
 static int alloc_try_nid_bottom_up_start_misaligned_check(void)
 {
@@ -844,7 +844,7 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
  *                      |
  *                      min_add
  *
- * Expect to drop the lower limit and allocate a cleared memory region which
+ * Expect to drop the lower limit and allocate a memory region which
  * starts at the beginning of the available memory.
  */
 static int alloc_try_nid_bottom_up_narrow_range_check(void)
@@ -1027,7 +1027,7 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
 /*
  * A test that tries to allocate a memory region, where max_addr is
  * bigger than the end address of the available memory. Expect to allocate
- * a cleared region that starts at the min_addr
+ * a region that starts at the min_addr.
  */
 static int alloc_try_nid_bottom_up_cap_max_check(void)
 {
@@ -1066,7 +1066,7 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
 /*
  * A test that tries to allocate a memory region, where min_addr is
  * smaller than the start address of the available memory. Expect to allocate
- * a cleared region at the beginning of the available memory.
+ * a region at the beginning of the available memory.
  */
 static int alloc_try_nid_bottom_up_cap_min_check(void)
 {
-- 
2.25.1

