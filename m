Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE347D55D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbhLVQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:45:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:62995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhLVQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640191537; x=1671727537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WegaZ0TOd3SsGdFDwHx1wl+dbnJ65m9gUFguUeYTD3k=;
  b=D/DHFTBWPUvvVCKWxN9j9OTFZvztDe9chQX2SRZikfH31fHlRlJCH6fw
   UddZkZIFl4js0R1aMBPYKsd/UzOxEP53Yp34GYjQjQNKbjRju3pw/xt0c
   yEusY+G8m4pCAdSrZT0OWdzeoq2pvNmxF13JaYPVwsVSQIfddlwn7dx6Y
   fvnTbQNpn6PwqOlIX/PyACAV08G6pOdixjNMs4kAkRTEk2Diw5GVmWqIR
   MmqPKFjXvkBEGjCWwF+6AMGl0/XAcaxYw2kwSJ6Kalb7gOsKMCMD/7htI
   gY6h7u1Mei6mh+UAbMxglIGM2Dj2hXEqDEhauUxuI9Jx88mJ+iQpUCuLp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227954821"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="227954821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 08:45:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="587064285"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 08:45:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0578FE; Wed, 22 Dec 2021 18:45:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
Date:   Wed, 22 Dec 2021 18:45:34 +0200
Message-Id: <20211222164534.67636-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
 include/sound/madera-pdata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/madera-pdata.h b/include/sound/madera-pdata.h
index e3060f48f108..58398d80c3de 100644
--- a/include/sound/madera-pdata.h
+++ b/include/sound/madera-pdata.h
@@ -9,7 +9,7 @@
 #ifndef MADERA_CODEC_PDATA_H
 #define MADERA_CODEC_PDATA_H
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #define MADERA_MAX_INPUT		6
 #define MADERA_MAX_MUXED_CHANNELS	4
-- 
2.34.1

