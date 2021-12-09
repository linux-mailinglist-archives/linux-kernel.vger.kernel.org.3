Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6546E901
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhLINV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:21:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43772 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLINVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FFC0CE25C2;
        Thu,  9 Dec 2021 13:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF58C004DD;
        Thu,  9 Dec 2021 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055895;
        bh=cGjJG9Y0KtC0r7X3ZCwpLsoPwAqXqoEmtJZuLNlHnrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7bFRd/As9m73q7wHv4PpLWzBczRGv9MAL2AS3ibo7KcdBVMtZTyqTitJUQmL0PQy
         +9bv3h4Kfv9wOWUJDJw+l/gfD47w1E3skhWe9G6oB9eAUyMebM92iu6VsHAjmGkL4+
         OjZyBpEar984+3hUYGAaSfstkQSoLjklfDKK4zlkSM/ba5IhvVEs7bOP+lYHIeAW7+
         GTxi1cM/e7JFTHN50gWV2J3ffE6RWhM+6wTSCm5T1h2lD/GH6R9BxC5AWRzaIAd7HV
         /0KgGdgoknomCIE8uTe/x8oixSecaCSDtjvdrmAGETKEykwguzc87v5SO3zBgjxpd1
         OXD5iIOPbTFbg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/6] Docs/admin-guide/mm/damon/usage: Remove redundant information
Date:   Thu,  9 Dec 2021 13:18:03 +0000
Message-Id: <20211209131806.19317-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209131806.19317-1-sj@kernel.org>
References: <20211209131806.19317-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON usage document mentions DAMON user space tool and programming
interface twice.  This commit integrates those and remove unnecessary
part.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 44 ++++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1ab9b714fca2..24137312f601 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -7,30 +7,30 @@ Detailed Usages
 DAMON provides below three interfaces for different users.
 
 - *DAMON user space tool.*
-  This is for privileged people such as system administrators who want a
-  just-working human-friendly interface.  Using this, users can use the DAMON’s
-  major features in a human-friendly way.  It may not be highly tuned for
-  special cases, though.  It supports both virtual and physical address spaces
-  monitoring.
+  `This <https://github.com/awslabs/damo>`_ is for privileged people such as
+  system administrators who want a just-working human-friendly interface.
+  Using this, users can use the DAMON’s major features in a human-friendly way.
+  It may not be highly tuned for special cases, though.  It supports both
+  virtual and physical address spaces monitoring.  For more detail, please
+  refer to its `usage document
+  <https://github.com/awslabs/damo/blob/next/USAGE.md>`_.
 - *debugfs interface.*
-  This is for privileged user space programmers who want more optimized use of
-  DAMON.  Using this, users can use DAMON’s major features by reading
-  from and writing to special debugfs files.  Therefore, you can write and use
-  your personalized DAMON debugfs wrapper programs that reads/writes the
-  debugfs files instead of you.  The DAMON user space tool is also a reference
-  implementation of such programs.  It supports both virtual and physical
-  address spaces monitoring.
+  :ref:`This <debugfs_interface>` is for privileged user space programmers who
+  want more optimized use of DAMON.  Using this, users can use DAMON’s major
+  features by reading from and writing to special debugfs files.  Therefore,
+  you can write and use your personalized DAMON debugfs wrapper programs that
+  reads/writes the debugfs files instead of you.  The `DAMON user space tool
+  <https://github.com/awslabs/damo>`_ is one example of such programs.  It
+  supports both virtual and physical address spaces monitoring.
 - *Kernel Space Programming Interface.*
-  This is for kernel space programmers.  Using this, users can utilize every
-  feature of DAMON most flexibly and efficiently by writing kernel space
-  DAMON application programs for you.  You can even extend DAMON for various
-  address spaces.
-
-Nevertheless, you could write your own user space tool using the debugfs
-interface.  A reference implementation is available at
-https://github.com/awslabs/damo.  If you are a kernel programmer, you could
-refer to :doc:`/vm/damon/api` for the kernel space programming interface.  For
-the reason, this document describes only the debugfs interface
+  :doc:`This </vm/damon/api>` is for kernel space programmers.  Using this,
+  users can utilize every feature of DAMON most flexibly and efficiently by
+  writing kernel space DAMON application programs for you.  You can even extend
+  DAMON for various address spaces.  For detail, please refer to the interface
+  :doc:`document </vm/damon/api>`.
+
+
+.. _debugfs_interface:
 
 debugfs Interface
 =================
-- 
2.17.1

