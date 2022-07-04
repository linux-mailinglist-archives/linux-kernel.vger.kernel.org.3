Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1503564C59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiGDEHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiGDEHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:07:19 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DAB64E2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:07:18 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so11663436fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=CXtFVVhDssmaMEMzB8Z9hwROe/lTo/9YrFugbUkaEbsF299VkRWWXBrf1an+OLxr4J
         wcHrKwwGDbiqUROsxCAm0rsJPOvqYn3sUnKWMQbn2t4bs2TtoIg0RKNrtHlEKiRq7Kyn
         gNqMxa+D5fGFjR3imUEPfszS1bkgtlVjsStaWzhtCO6Y5J7qZYCoNJcBAnjVudVvtBWR
         c3JD5+zBUe6AsjbuCfYp4GbbvWiYa41gSRrjQC2VQQY4HuNYtoDQY90/FYM/NkVIq9uN
         0JnmWdna2BSjEkt1BTszBVdU282Hio/R8graVy4fH4DL4DmN18RsPYhFxy9qyMjOy99z
         V5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=twIP8tPHFctNqIQBkgE9gMLGOWkO9hQg07rjaIrwECKyJA/WpdS3P9yp0ooC4kHqKx
         nHAqBrv7vvX6hRenYjO3tc5hSJMmaW94t7isZCmW+UU9VAiIFe2F9KGjUkHoya6bwCLN
         nnAkxFB0alWOQrtBvPw0K1ngjli9g3vDYbWUcs/kuk+eYMFuizBmrQJgT4excGlpPZw0
         JyF/KVw5vT49Le8d6TdDZjchdWDIGvv04JJnbUXLGnR2Ft6xzdEexx2AWH9zB0dUWqIr
         IKUvgF53QJERGygoIYeGyQWje8hvh5kcKg5lXu++1vN+m/C4HqNBlrh4q3IGvV+SEBom
         CFGA==
X-Gm-Message-State: AJIora9FzaCWMrMGKAAZ33D0R4RevZ1Wo/BFkGdnlsrTT1BHF4kmD95E
        CS7ps4k4BPW31kIin0aoBG4=
X-Google-Smtp-Source: AGRyM1sSNUdCJUPdcclRZAW0PAMjcZtCijFce9D3FK1kJwjdVzPDFYA7+tZuyj6C/f42mntYYvmRMw==
X-Received: by 2002:a05:6870:9711:b0:101:ae38:6c85 with SMTP id n17-20020a056870971100b00101ae386c85mr16792968oaq.50.1656907637845;
        Sun, 03 Jul 2022 21:07:17 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id l83-20020aca3e56000000b0032f0fd7e1f8sm14116545oia.39.2022.07.03.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:07:17 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 4/4] memblock tests: remove completed TODO items
Date:   Sun,  3 Jul 2022 23:06:58 -0500
Message-Id: <6a3e74fcb51a07e8d9fbbcbe84bdb8aa8b00e843.1656907314.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656907314.git.remckee0@gmail.com>
References: <cover.1656907314.git.remckee0@gmail.com>
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

Remove completed items from TODO list.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index cd1a30d5acc9..33044c634ea7 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -1,25 +1,17 @@
 TODO
 =====
 
-1. Add verbose output (e.g., what is being tested and how many tests cases are
-   passing)
-
-2. Add flags to Makefile:
-   + verbosity level
-   + enable memblock_dbg() messages (i.e. pass "-D CONFIG_DEBUG_MEMORY_INIT"
-     flag)
-
-3. Add tests trying to memblock_add() or memblock_reserve() 129th region.
+1. Add tests trying to memblock_add() or memblock_reserve() 129th region.
    This will trigger memblock_double_array(), make sure it succeeds.
    *Important:* These tests require valid memory ranges, use dummy physical
                 memory block from common.c to implement them. It is also very
                 likely that the current MEM_SIZE won't be enough for these
                 test cases. Use realloc to adjust the size accordingly.
 
-4. Add test cases using this functions (implement them for both directions):
+2. Add test cases using this functions (implement them for both directions):
    + memblock_alloc_raw()
    + memblock_alloc_exact_nid_raw()
    + memblock_alloc_try_nid_raw()
 
-5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.34.1

