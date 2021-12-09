Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF446E902
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhLINWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:22:01 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43790 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhLINVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23FFDCE25C4;
        Thu,  9 Dec 2021 13:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78F2C341C3;
        Thu,  9 Dec 2021 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055896;
        bh=/ttFN3eSciKNUE5fSV4TMsI/toseuwV9QrzeM0zwrU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpTcUDjvvrtIOZanOTBRCQ+o1lqYG9W3U2hVeDd6SuXDDtkyTFXole99UZi3alFUM
         VuOthHNIbLiel0ZXwdWPN2eiolX5cRVO9vNkBG94Pr7yKC344oeq935U8mwFP1nE+3
         epzZM5FTHYpqVUPTZAAFp78z081PeK78R3WLnx95RNtYtjmDLHd0Gy/Zk/UAXSbpIM
         rv6W6GSPWyDDnGt9xOEjyNDgfiAEOZhG40LjybR/E2ugNCDdMqrBgjUAzv/JkRxG2q
         92wBuHA9yMgNFGb051/Fl0uitxzWyAtdoWk6VLVBqsm5UUyOVl2Kw9fKaa5Ik+7BaW
         0BtpzzXzWXP7w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/6] Docs/admin-guide/mm/damon/usage: Mention tracepoint at the beginning
Date:   Thu,  9 Dec 2021 13:18:04 +0000
Message-Id: <20211209131806.19317-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209131806.19317-1-sj@kernel.org>
References: <20211209131806.19317-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get detailed monitoring results from the user space, users need to
use the damon_aggregated tracepoint.  This commit adds a brief mention
of it at the beginning of the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 24137312f601..846c85bf4b9d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -21,7 +21,10 @@ DAMON provides below three interfaces for different users.
   you can write and use your personalized DAMON debugfs wrapper programs that
   reads/writes the debugfs files instead of you.  The `DAMON user space tool
   <https://github.com/awslabs/damo>`_ is one example of such programs.  It
-  supports both virtual and physical address spaces monitoring.
+  supports both virtual and physical address spaces monitoring.  Note that this
+  interface provides only simple :ref:`statistics <damos_stats>` for the
+  monitoring results.  For detailed monitoring results, DAMON provides a
+  :ref:`tracepoint <tracepoint>`.
 - *Kernel Space Programming Interface.*
   :doc:`This </vm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
@@ -215,6 +218,8 @@ If the value is higher than ``<high mark>`` or lower than ``<low mark>``, the
 scheme is deactivated.  If the value is lower than ``<mid mark>``, the scheme
 is activated.
 
+.. _damos_stats:
+
 Statistics
 ~~~~~~~~~~
 
@@ -268,6 +273,8 @@ the monitoring is turned on.  If you write to the files while DAMON is running,
 an error code such as ``-EBUSY`` will be returned.
 
 
+.. _tracepoint:
+
 Tracepoint for Monitoring Results
 =================================
 
-- 
2.17.1

