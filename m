Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757B4477062
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhLPLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:35:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:20080 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhLPLf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:35:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="300243115"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="300243115"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="464641820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 03:35:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 377D6362; Thu, 16 Dec 2021 13:35:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] uuid: Remove licence boilerplate text from the header
Date:   Thu, 16 Dec 2021 13:35:52 +0200
Message-Id: <20211216113552.81199-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216113552.81199-1-andriy.shevchenko@linux.intel.com>
References: <20211216113552.81199-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove licence boilerplate text from the UAPI header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Christoph Hellwig <hch@lst.de>
---
v2: added tag (Christoph)
 include/uapi/linux/uuid.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/uapi/linux/uuid.h b/include/uapi/linux/uuid.h
index 32615dc5f0cf..c0f4bd9b040e 100644
--- a/include/uapi/linux/uuid.h
+++ b/include/uapi/linux/uuid.h
@@ -5,15 +5,6 @@
  *
  * Copyright (C) 2010, Intel Corp.
  *	Huang Ying <ying.huang@intel.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation;
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _UAPI_LINUX_UUID_H_
-- 
2.34.1

