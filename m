Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198146EAA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhLIPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:11:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:9205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhLIPLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:11:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="301499889"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="301499889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 07:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="516331656"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 07:08:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4AA86329; Thu,  9 Dec 2021 17:08:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] kernel.h: Include a note to discourage people from including it in headers
Date:   Thu,  9 Dec 2021 17:08:03 +0200
Message-Id: <20211209150803.4473-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include a note at the top to discourage people from including it in headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index ca9ba14f74a1..e18613ba4f27 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -1,4 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NOTE:
+ *
+ * This header has combined a lot of unrelated to each other stuff.
+ * The process of splitting its content is in progress while keeping
+ * backward compatibility. That's why it's highly recommended NOT to
+ * include this header inside another header file, especially under
+ * generic or architectural include/ directory.
+ */
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
-- 
2.33.0

