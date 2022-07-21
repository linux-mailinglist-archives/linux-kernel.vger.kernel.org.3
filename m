Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528AE57C71B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiGUJIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGUJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9155D5BC;
        Thu, 21 Jul 2022 02:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262F161F25;
        Thu, 21 Jul 2022 09:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8EBC3411E;
        Thu, 21 Jul 2022 09:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658394522;
        bh=B9iP6qE7nPoeum7kN2F9VsPqrRUG04QNIW0sAV37Y48=;
        h=From:To:Cc:Subject:Date:From;
        b=O5Qw8UdFQrpwIBOwk28ekFS4IfjCePHCsug14SEjtFHHM0brqYZB8KVr29icb6WfM
         OaVJOh7yP90HRo/2/gCeXHiKXPCYrpkp2fvyPKNSyaDfvoVf10UR/aotPI1x1ZjyIo
         k0AUnoYd7Ij1Q9J8MAJVXt2b42uT00nZijzBTsxJJSfzwxd/MyBFzuf5lVHtsP9hE+
         rY//IzS69gZA/IcaWggJahZuRUnCkNG5ingspVhEF/QpEGf/XjBSmtUYeqx9RSl9p3
         6kwEdI61Y7HOOqcM0zPpDc33ui8b15FeIyiyrlllmV5Y9ITpIPfBU82AMsFn1qEajs
         kU5IXE8Z6GwHQ==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] doc/mm: move overcommit-accounting doc to admin-guide
Date:   Thu, 21 Jul 2022 17:08:34 +0800
Message-Id: <20220721090834.17130-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

Since the contents is mainly focus on a sysctl vm.overcommit_memory,
it's more suitable for admin-guide dir instead of mm/ dir.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/admin-guide/mm/index.rst                          | 1 +
 Documentation/{ => admin-guide}/mm/overcommit-accounting.rst    | 0
 Documentation/admin-guide/sysctl/vm.rst                         | 2 +-
 Documentation/filesystems/proc.rst                              | 2 +-
 Documentation/mm/index.rst                                      | 1 -
 Documentation/translations/zh_CN/admin-guide/mm/index.rst       | 1 +
 .../zh_CN/{ => admin-guide}/mm/overcommit-accounting.rst        | 2 +-
 Documentation/translations/zh_CN/mm/index.rst                   | 1 -
 8 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/{ => admin-guide}/mm/overcommit-accounting.rst (100%)
 rename Documentation/translations/zh_CN/{ => admin-guide}/mm/overcommit-accounting.rst (97%)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 1bd11118dfb1..9aea816493a5 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -35,6 +35,7 @@ the Linux memory management.
    nommu-mmap
    numa_memory_policy
    numaperf
+   overcommit-accounting
    pagemap
    shrinker_debugfs
    soft-dirty
diff --git a/Documentation/mm/overcommit-accounting.rst b/Documentation/admin-guide/mm/overcommit-accounting.rst
similarity index 100%
rename from Documentation/mm/overcommit-accounting.rst
rename to Documentation/admin-guide/mm/overcommit-accounting.rst
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9b833e439f09..ec611b8c620c 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -758,7 +758,7 @@ and don't use much of it.
 
 The default value is 0.
 
-See Documentation/mm/overcommit-accounting.rst and
+See Documentation/admin-guide/mm/overcommit-accounting.rst and
 mm/util.c::__vm_enough_memory() for more information.
 
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 47e95dbc820d..0ed8c9777d8c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1114,7 +1114,7 @@ CommitLimit
               yield a CommitLimit of 7.3G.
 
               For more details, see the memory overcommit documentation
-              in mm/overcommit-accounting.
+              in admin-guide/mm/overcommit-accounting.
 Committed_AS
               The amount of memory presently allocated on the system.
               The committed memory is a sum of all of the memory which
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 575ccd40e30c..e5ba30c89552 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -52,7 +52,6 @@ above structured documentation, or deleted if it has served its purpose.
    memory-model
    mmu_notifier
    numa
-   overcommit-accounting
    page_migration
    page_frags
    page_owner
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
diff --git a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst b/Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
similarity index 97%
rename from Documentation/translations/zh_CN/mm/overcommit-accounting.rst
rename to Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
index d8452d8b7fbb..04b6067d711d 100644
--- a/Documentation/translations/zh_CN/mm/overcommit-accounting.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/overcommit-accounting.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/mm/overcommit-accounting.rst
+:Original: Documentation/admin-guide/mm/overcommit-accounting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
index 2f53e37b8049..3d603c90364c 100644
--- a/Documentation/translations/zh_CN/mm/index.rst
+++ b/Documentation/translations/zh_CN/mm/index.rst
@@ -49,7 +49,6 @@ Linux内存管理文档
    memory-model
    mmu_notifier
    numa
-   overcommit-accounting
    page_frags
    page_migration
    page_owner
-- 
2.25.1

