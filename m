Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A6554890
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357490AbiFVJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357194AbiFVJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:29:33 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B639818
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:26 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-101cdfddfacso13585507fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=kgkz2geQkKSUBJ36TO4bMC7bsJTG+GAVBJsvT9CSBn9zuR5zMQSGJqFNU/NxCoypsG
         YKY6Z1OqMwJwtgltM2b41HxcYYggPdYm7hADc2xLgRUlSuFbTm/SLaXwApAQ38sYyYVN
         Rlkr6xzYisk1urfGmn1vSFDMDViFWPBMkHQbdtENTBptf2EUTypLl0dqBhPsLOHmyfJG
         aVP3QYlqRRdnQdEtw+G2Kj17iyMDdyLP2bYmYWNu2RO6ClH9Kyf3rc8XUEVUx/32jGpc
         aJheEMs8MYn2InAf33kX+FzAynFaxSq/fsvhu2H9frszzCarnNr7YKzJ/4EwsY6iQuzx
         KvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=cbnJT66CvxRbHKW/tB+eE0D9aEr/WMsMMzzNcybBjDzIuxdlf7WLF8mhu2q6kTDtOl
         8TEUH0G9gM+XDmCfAAwkXdR/WIx4L19IfX/0NeNqjh1h8HP74Ih8QlX9Qb44tWU+T5VY
         5wWqQPKcAnLUhtH4VUFMBTPYO/Drf5z+6K/En979lHNGTml+h2WvsC7CHvFN5h4alm9X
         NhMCTh1dRpFpVqQV9MDk2//mMCMzoRHIeOAf1LEoM5uAW5DBwPBOlpGp7IyWAsBc71LV
         cigNuxnhjmNBe5rOI0m+l/YX9rZP/Ha95+BZ8ZN96bQ/kf9NDW4C65ynNbBj3Ua28kIc
         hcFg==
X-Gm-Message-State: AJIora8WFisfwBiTKcBsk8C15sfbMbMXT2Id5wE6WvgM0TAtBb/Gbx2X
        Ho7BG4q0eekN2rBoc3qyzok=
X-Google-Smtp-Source: AGRyM1vyCM96jx9X9mBgzkkjXQofVpIOX84M/3iQuwrvMEEX47TER/TEa1XYYtSucqBkXWRPsm73pg==
X-Received: by 2002:a05:6870:390d:b0:101:ab20:2763 with SMTP id b13-20020a056870390d00b00101ab202763mr1409224oap.233.1655890166077;
        Wed, 22 Jun 2022 02:29:26 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id p10-20020a0568301d4a00b0060be7487954sm10854113oth.26.2022.06.22.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:29:25 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 4/4] memblock tests: remove completed TODO items
Date:   Wed, 22 Jun 2022 04:29:09 -0500
Message-Id: <ae85d5e9fc0fa344064300c6db57ecbb37dd542e.1655889641.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
References: <cover.1655889641.git.remckee0@gmail.com>
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

