Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11A4735FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhLMUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:35:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:34147 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhLMUfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:35:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237559646"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="237559646"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464786290"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 12:35:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D054B144; Mon, 13 Dec 2021 22:35:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v1 1/2] uuid: Discourage people from using UAPI header in new code
Date:   Mon, 13 Dec 2021 22:35:06 +0200
Message-Id: <20211213203507.54157-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discourage people from using UAPI header in new code by adding a note.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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
2.33.0

