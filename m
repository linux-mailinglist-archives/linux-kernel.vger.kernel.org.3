Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C185744B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGNFwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGNFv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A62C647;
        Wed, 13 Jul 2022 22:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5B260AC9;
        Thu, 14 Jul 2022 05:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13CEC34115;
        Thu, 14 Jul 2022 05:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657777914;
        bh=oZ1DJE7ta+TUY0AU//gHvCymqStsXCfYx+hYKLfuHOY=;
        h=From:To:Cc:Subject:Date:From;
        b=ps6wHldfexq3aa+HAQROT1TeK3jSv9gLC233ourNb/0JnopdnnU+MKILLJotWC1bt
         WvSZh8PPQvcCVPFD9Go7mqWIuvQSXsMdgtAazOJ0MtIeWC6ku7XJFmsu4WGgUTWYJS
         8/uNGVTbsJ9NTyWfVjZ7+QAnMAlotgmpGVUJtvTUT92MM+Z6rPp6pDcwO8hNB59G/6
         ZSgcW4jYqP7k/CRln2YcLNy3v4ibkLqOY8b7u+elne9b9oaIDMT71RwLJvFustfJ6z
         +YX9Y5uGlsvBqZj0Inp9ydkwwKoXfb/EYXVtoMDRJ0KXq2edB9yUqu0qH5EbVdiAmf
         QcGRX++CReYUQ==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc/vm: move overcommit-accounting doc to admin-guide
Date:   Thu, 14 Jul 2022 13:51:42 +0800
Message-Id: <20220714055142.214728-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

Since the contents is mainly focus on a sysctl vm.overcommit_memory,
it's more suitable for admin-guide dir instead of vm/ dir.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/admin-guide/mm/index.rst                          | 1 +
 Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst  | 0
 Documentation/admin-guide/sysctl/vm.rst                         | 2 +-
 Documentation/filesystems/proc.rst                              | 2 +-
 Documentation/translations/zh_CN/admin-guide/mm/index.rst       | 1 +
 .../zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst      | 2 +-
 Documentation/translations/zh_CN/vm/index.rst                   | 1 -
 Documentation/vm/index.rst                                      | 1 -
 8 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst (100%)
 rename Documentation/translations/zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst (97%)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index c21b5823f126..b92de39a53d3 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -35,6 +35,7 @@ the Linux memory management.
    nommu-mmap
    numa_memory_policy
    numaperf
+   overcommit-accounting
    pagemap
    soft-dirty
    swap_numa
diff --git a/Documentation/vm/overcommit-accounting.rst b/Documentation/admin-guide/mm/overcommit-accounting.rst
similarity index 100%
rename from Documentation/vm/overcommit-accounting.rst
rename to Documentation/admin-guide/mm/overcommit-accounting.rst
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5c9aa171a0d3..4344006ae764 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -760,7 +760,7 @@ and don't use much of it.
 
 The default value is 0.
 
-See Documentation/vm/overcommit-accounting.rst and
+See Documentation/admin-guide/mm/overcommit-accounting.rst and
 mm/util.c::__vm_enough_memory() for more information.
 
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..ff2f42772975 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1109,7 +1109,7 @@ CommitLimit
               yield a CommitLimit of 7.3G.
 
               For more details, see the memory overcommit documentation
-              in vm/overcommit-accounting.
+              in admin-guide/mm/overcommit-accounting.
 Committed_AS
               The amount of memory presently allocated on the system.
               The committed memory is a sum of all of the memory which
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/index.rst b/Documentation/translations/zh_CN/admin-guide/mm/index.rst
index 702271c5b683..7304924d8131 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/index.rst
@@ -31,6 +31,7 @@ Linux内存管理有它自己的术语，如果你还不熟悉它，请考虑阅
 
    damon/index
    ksm
+   overcommit-accounting
 
 Todolist:
 * concepts
diff --git a/Documentation/translations/zh_CN/vm/overcommit-accounting.rst b/Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
similarity index 97%
rename from Documentation/translations/zh_CN/vm/overcommit-accounting.rst
rename to Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
index 8765cb118f24..04b6067d711d 100644
--- a/Documentation/translations/zh_CN/vm/overcommit-accounting.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/overcommit-accounting.rst
+:Original: Documentation/admin-guide/mm/overcommit-accounting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/vm/index.rst
index a1c6d529b6ff..00762b5cb174 100644
--- a/Documentation/translations/zh_CN/vm/index.rst
+++ b/Documentation/translations/zh_CN/vm/index.rst
@@ -34,7 +34,6 @@ TODO:待引用文档集被翻译完毕后请及时修改此处）
    memory-model
    mmu_notifier
    numa
-   overcommit-accounting
    page_frags
    page_owner
    page_table_check
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 575ccd40e30c..e5ba30c89552 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -52,7 +52,6 @@ above structured documentation, or deleted if it has served its purpose.
    memory-model
    mmu_notifier
    numa
-   overcommit-accounting
    page_migration
    page_frags
    page_owner
-- 
2.25.1

