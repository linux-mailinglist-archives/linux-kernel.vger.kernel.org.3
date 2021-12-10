Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B508470065
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhLJMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:05:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:41358 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236854AbhLJMFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:05:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238557473"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238557473"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 04:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="517198486"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Dec 2021 04:01:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1EC55109; Fri, 10 Dec 2021 14:02:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 1/1] media: dmxdev: drop unneeded <linux/kernel.h> inclusion from other headers
Date:   Fri, 10 Dec 2021 14:02:01 +0200
Message-Id: <20211210120201.35635-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no evidence we need kernel.h inclusion in certain headers.
Drop unneeded <linux/kernel.h> inclusion from other headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/media/dmxdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/media/dmxdev.h b/include/media/dmxdev.h
index baafa3b8aca4..63219a699370 100644
--- a/include/media/dmxdev.h
+++ b/include/media/dmxdev.h
@@ -21,7 +21,6 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
-#include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/timer.h>
 #include <linux/wait.h>
-- 
2.33.0

