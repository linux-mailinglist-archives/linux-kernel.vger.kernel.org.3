Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D755C1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbiF0Wf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiF0WfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:35:20 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FF18B02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:19 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w83so14868126oiw.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=R40+st7n8bK+eV4IFBb9tHvqyBFduB4ioLmqU3xul880XnefKDhtRaR04BQTpmeKeL
         yBanLZidYKjfSZvfskhgkEjPZ0BmIOOLWdh0chrSAqBQQ/SschgLY1MOVZGPLTAblMFT
         sUgUIU65pAGllcGy8ETb7TOHmJoWzI+Oq6cI3sxHiBYXU2gC+puKq1E56KPQ0PoklB+K
         rifFfzTPNpnPEor7bIPAh2h9U5SipnO56wWhBe+XcKm+T3RCYUCIggXiz2bVa5RO02KG
         FBA2cbEXqf9CyYxgCC59E7V7Jq8Z5tDN6lnLTmRuLuD3JM9t5k6lIwTmuKaQ9+svKjwd
         f0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDwC4vjOEjWZbqEneYaa93PfkH0X3bD2FesquY/4DR0=;
        b=2/30USeUE3vlgPtq34nUR1k5DgZabCTQaGrN6ALdD5DWjIvBj7bOfP9vmzH3nNVYlp
         ZNR5BwcSA+TOXVPhAZSPkx5PB0fjFZWRvj5XgIRQPYAsaSnjtmFf418okQogqJPgaF8k
         eZKNJlW74RoY3MG8q7BTMh6dTvwfffgW4PYR672bmaK585DE79bycBbYkrahXZk88ZqN
         bSz4sUTTgYd0dayBrBjFq9TMqbkgMZLnufLy0plJ7thOtxkSnaJVylZo/Txf3mSOIO0u
         oLRPrzZLAgFh1ER70O4aFgIJHYXBM+J52uXyp2sX1uaY1vD96tV/+Zv7+ExuU/ydtOPR
         kM+g==
X-Gm-Message-State: AJIora8J5JgOauvW+XOgX1V3w2yLlRJJGE1D/JCyxDjh4w+SqhqBFdjp
        11gxzj2nCLk0ICE9T0SeBUg=
X-Google-Smtp-Source: AGRyM1uGuzpSHGJe6Y+NuWr5CrNhOjdG5PNR1gTZzBQdCC2/JmehuDVkihCx98yC7PxdYO3hHzNP+Q==
X-Received: by 2002:a05:6808:f8b:b0:335:7cb9:f6df with SMTP id o11-20020a0568080f8b00b003357cb9f6dfmr2903741oiw.105.1656369318707;
        Mon, 27 Jun 2022 15:35:18 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id f19-20020a056830057300b0060bd2d06a1csm7140772otc.47.2022.06.27.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:35:18 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 4/4] memblock tests: remove completed TODO items
Date:   Mon, 27 Jun 2022 17:34:30 -0500
Message-Id: <3f2da4dc9ed0d30cf0fb8041077ed640886152d8.1656368930.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656368930.git.remckee0@gmail.com>
References: <cover.1656368930.git.remckee0@gmail.com>
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

