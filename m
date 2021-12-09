Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE046E87F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhLIMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:34:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:45944 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhLIMeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:34:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="235597818"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="235597818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="658741893"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2021 04:30:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AC04329; Thu,  9 Dec 2021 14:30:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] percpu_ref: Replace kernel.h with the necessary inclusions
Date:   Thu,  9 Dec 2021 14:30:33 +0200
Message-Id: <20211209123033.3492-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/percpu-refcount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index b31d3f3312ce..d73a1c08c3e3 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -51,9 +51,9 @@
 #define _LINUX_PERCPU_REFCOUNT_H
 
 #include <linux/atomic.h>
-#include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
+#include <linux/types.h>
 #include <linux/gfp.h>
 
 struct percpu_ref;
-- 
2.33.0

