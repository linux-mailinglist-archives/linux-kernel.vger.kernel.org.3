Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1147705E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhLPLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:35:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:1120 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhLPLft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:35:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239689404"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239689404"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="662416101"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Dec 2021 03:35:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3E966178; Thu, 16 Dec 2021 13:35:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] uuid: Discourage people from using UAPI header in new code
Date:   Thu, 16 Dec 2021 13:35:51 +0200
Message-Id: <20211216113552.81199-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discourage people from using UAPI header in new code by adding a note.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Christoph Hellwig <hch@lst.de>
---
v2: added tag (Christoph)

Andrew, Cristoph asked you to take since UUID tree is kinda inactive now
and these are only two really small documentation changes.

 include/uapi/linux/uuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/uuid.h
index e5a7eecef7c3..32615dc5f0cf 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/uuid.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* DO NOT USE in new code! This is solely for MEI due to legacy reasons */
 /*
  * UUID/GUID definition
  *
-- 
2.34.1

