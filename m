Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C274C6FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiB1Osm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiB1OsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:48:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994701C905
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g39so21710214lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhOyf5GwOxdKBxOHGEH+WB1RGf3JKbPOT7zY+wvKvpo=;
        b=S+RYY8RZ9EY5+hvJbl5XGbgTDwm4dDMevg8gng2DAjAhl+hzUfE5UpuJSqCdFVEj6S
         1NTKYB/mBo70ZGoXWtvtyiM9JUFXiNDPjC15lzvTfVKFbE5L80OlYxlhfNBuerMl5G+n
         ui/eQHpHBct16ZEW+G8lmCPtNEM1H+hW3N+RF+/RaN8wopIAT19HIxjs9I0BRL6QrZ++
         R7L4VouiGAzcat4lhiB5eD4VzqEAFfMNMhp1JdxXgVlfJUcDnRk9ytRH1dbF0G9qaBh3
         2fGj7gsDXPyuxL7Kq+mujwCFhBMaxOsEGU21ox6+WMSjuDLRfWScfZE44aYCLm442trM
         IXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhOyf5GwOxdKBxOHGEH+WB1RGf3JKbPOT7zY+wvKvpo=;
        b=w5OmFiTtdkZaAXiWGDqLmTxZYtkNK+4iG4jjpqbLlTyahq1B6jI/eKTncpGxFuc4dX
         xA++OPIYikG2QdMG9xU+EzCab7vsuVfgXPTPPOK0MtDY/ue+BxivJiyVOK1GoCbB9Oib
         9r+yitONnDVUBFM3ZsC8rk8RgQ7wYhRB0itfww3fe1/5IpSZGrNlAGurjc7xX0FaMddL
         oQ/ErIHB+af5+QfHE/23tkt3Og4KvbOLmxvOjjIZM4JlqgcKFmL5oDNvxi9VzUfczDrQ
         P9+vTnItnjKsecWyuN7UFdR1REZ1EUgUV/MEb3lA1QaH81SMvEQ2TbnU/Jw0FwufKxFl
         KSgw==
X-Gm-Message-State: AOAM532WJh0WVLZKaZxIq1eqRI67OJKGPgCJEEAKzOY44jb47CofbGsv
        82uEwKNwEGU820o6K5QDAzE=
X-Google-Smtp-Source: ABdhPJyEeKoOELU4Hs0AN+LD8C7bjctTAL8b1xrVTD9IoYA74oJXqlKROxJpkA1Hu5bWjLvvy2pu4w==
X-Received: by 2002:a05:6512:34d4:b0:442:a9c5:8e37 with SMTP id w20-20020a05651234d400b00442a9c58e37mr13051807lfr.362.1646059653785;
        Mon, 28 Feb 2022 06:47:33 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:33 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 9/9] memblock tests: Add TODO and README files
Date:   Mon, 28 Feb 2022 15:46:51 +0100
Message-Id: <d5e39b9f7dcef177ebc14282727447bc21e3b38f.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the project, its structure and how to run it.
List what is left to implement and what the known issues are.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/README | 114 ++++++++++++++++++++++++++++++++++
 tools/testing/memblock/TODO   |  28 +++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 tools/testing/memblock/README
 create mode 100644 tools/testing/memblock/TODO

diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
new file mode 100644
index 000000000000..40c0ce50e7c2
--- /dev/null
+++ b/tools/testing/memblock/README
@@ -0,0 +1,114 @@
+=========================
+   Memblock simulator
+=========================
+
+
+Introduction
+---------------------
+
+Memblock is a boot time memory allocator[1] that manages memory regions before
+the actual memory management is initialized. Its APIs allow to register physical
+memory regions, mark them as available or reserved, allocate a block of memory
+within the requested range and/or in specific NUMA node, and many more.
+
+Because it is used so early in the booting process, testing and debugging it is
+difficult. This test suite, usually referred as memblock simulator, is
+an attempt at testing the memblock mechanism. It runs one monolithic test that
+consist of a series of checks that exercise both the basic operations and
+allocation functionalities of memblock. The main data structure of the boot time
+memory allocator is initialized at the build time, so the checks here reuse its
+instance throughout the duration of the test. To ensure that tests don't affect
+each other, region arrays are reset in between.
+
+As this project uses the actual memblock code and has to run in user space, some
+of the kernel definitions were stubbed in the introductory patch[2]. Most of
+them don't match the kernel implementation, so one should consult them first
+before making any significant changes to the project.
+
+
+Usage
+---------------------
+
+To run the tests, build the main target and run it:
+
+$ make; ./main
+
+A successful run produces no output. It is also possible to override different
+configuration parameters. For example, to simulate enabled NUMA, use:
+
+$ make NUMA=1
+
+For the full list of options, see `make help`.
+
+
+Project structure
+---------------------
+
+The project has one target, main, which calls a group of checks for basic and
+allocation functions. Tests for each group are defined in dedicated files, as it
+can be seen here:
+
+memblock
+|-- asm       ------------------,
+|-- lib                         |-- implement function and struct stubs
+|-- linux     ------------------'
+|-- scripts
+|    |-- Makefile.include        -- handles `make` parameters
+|-- tests
+|    |-- alloc_api.(c|h)         -- memblock_alloc tests
+|    |-- alloc_helpers_api.(c|h) -- memblock_alloc_from tests
+|    |-- alloc_nid_api.(c|h)     -- memblock_alloc_try_nid tests
+|    |-- basic_api.(c|h)         -- memblock_add/memblock_reserve/... tests
+|    |-- common.(c|h)            -- helper functions for resetting memblock;
+|-- main.c        --------------.   dummy physical memory definition
+|-- Makefile                     `- test runner
+|-- README
+|-- TODO
+|-- .gitignore
+
+
+Simulating physical memory
+--------------------------
+
+Some allocation functions clear the memory in the process, so it is required for
+memblock to track valid memory ranges. To achieve this, the test suite registers
+with memblock memory stored by test_memory struct. It is a small wrapper that
+points to a block of memory allocated via malloc. For each group of allocation
+tests, dummy physical memory is allocated, added to memblock, and then released
+at the end of the test run. The structure of a test runner checking allocation
+functions is as follows:
+
+int memblock_alloc_foo_checks(void)
+{
+	reset_memblock_attributes();     /* data structure reset */
+	dummy_physical_memory_init();    /* allocate and register memory */
+
+	(...allocation checks...)
+
+	dummy_physical_memory_cleanup(); /* free the memory */
+}
+
+There's no need to explicitly free the dummy memory from memblock via
+memblock_free() call. The entry will be erased by reset_memblock_regions(),
+called at the beginning of each test.
+
+
+Known issues
+---------------------
+
+1. Requesting a specific NUMA node via memblock_alloc_node() does not work as
+   intended. Once the fix is in place, tests for this function can be added.
+
+2. Tests for memblock_alloc_low() can't be easily implemented. The function uses
+   ARCH_LOW_ADDRESS_LIMIT marco, which can't be changed to point at the low
+   memory of the memory_block.
+
+
+References
+---------------------
+
+1. Boot time memory management documentation page:
+   https://www.kernel.org/doc/html/latest/core-api/boot-time-mm.html
+
+2. Introduce memblock simulator, lore link:
+https://lore.kernel.org/linux-mm/cover.1643796665.git.karolinadrobnik@gmail.com/
diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
new file mode 100644
index 000000000000..c25b2fdec45e
--- /dev/null
+++ b/tools/testing/memblock/TODO
@@ -0,0 +1,28 @@
+TODO
+=====
+
+1. Add verbose output (e.g., what is being tested and how many tests cases are
+   passing)
+
+2. Add flags to Makefile:
+   + verbosity level
+   + enable memblock_dbg() messages (i.e. pass "-D CONFIG_DEBUG_MEMORY_INIT"
+     flag)
+
+3. Add tests trying to memblock_add() or memblock_reserve() 129th region.
+   This will trigger memblock_double_array(), make sure it succeeds.
+   *Important:* These tests require valid memory ranges, use dummy physical
+                memory block from common.c to implement them. It is also very
+                likely that the current MEM_SIZE won't be enough for these
+                test cases. Use realloc to adjust the size accordingly.
+
+4. Add test cases using this functions (implement them for both directions):
+   + memblock_alloc_raw()
+   + memblock_alloc_exact_nid_raw()
+   + memblock_alloc_try_nid_raw()
+
+5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+   for the new region
+
+6. Update comments in tests/basic_api.c to match the style used in
+   tests/alloc_*.c
--
2.30.2

