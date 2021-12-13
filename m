Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761344735FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhLMUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:35:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:36156 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238005AbhLMUfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:35:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302205690"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302205690"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505062199"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 12:35:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6C97414F; Mon, 13 Dec 2021 22:35:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v1 2/2] uuid: Remove licence boilerplate text from the header
Date:   Mon, 13 Dec 2021 22:35:07 +0200
Message-Id: <20211213203507.54157-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
References: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove licence boilerplate text from the UAPI header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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
2.33.0

