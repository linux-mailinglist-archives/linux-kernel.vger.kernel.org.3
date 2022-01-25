Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770E649BCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiAYUV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:21:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:36582 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231707AbiAYUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643142080; x=1674678080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=irQ3/6gwBL9yizU5uUBclawuANglylnqeXDX3dUW+3M=;
  b=G9HHXI4g5N0BXoa51DwKu3YN3CzLGPTl1U4laIYCOwfVKz6VIhIH8KRW
   fdSFRgwFrL17kNjl5hdoDC9Lkxho5cjlx5LImZsSQ5EMBMIU7uiG3HVQV
   NKbRW89mx3wr2kZTRJvOx4scjTsrn+3j7pMyjVNxT8KLcr82YHFx9Tlqd
   mhgqIIbMRLaJESyVPkGJb8fqD2MgPrqPUAq/X+ukn9sSuJgjwUkbAmpyW
   l0oAFgwUs848r0aftlSUUKUci8tSv90qQiaPzkBKnb1BfcSi37+f6wFoD
   /y8tzBM5L58CC2BWCQaYSlFpef5wqBxwEBuLnNICnKpDbBkWOGxm4KLUV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245242271"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="245242271"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 12:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477249112"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 12:21:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A8921F1; Tue, 25 Jan 2022 22:21:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 3/4] fbtft: Kill outdated documentation
Date:   Tue, 25 Jan 2022 22:21:16 +0200
Message-Id: <20220125202118.63362-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is in maintenance mode, i.e. no new drivers will be accepted,
and for a long time it is part of the kernel, means no need to clone any
separate sources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbtft/README | 32 --------------------------------
 drivers/video/fbtft/TODO   |  3 ---
 2 files changed, 35 deletions(-)
 delete mode 100644 drivers/video/fbtft/README
 delete mode 100644 drivers/video/fbtft/TODO

diff --git a/drivers/video/fbtft/README b/drivers/video/fbtft/README
deleted file mode 100644
index ba4c74c92e4c..000000000000
--- a/drivers/video/fbtft/README
+++ /dev/null
@@ -1,32 +0,0 @@
-  FBTFT
-=========
-
-Linux Framebuffer drivers for small TFT LCD display modules.
-The module 'fbtft' makes writing drivers for some of these displays very easy.
-
-Development is done on a Raspberry Pi running the Raspbian "wheezy" distribution.
-
-INSTALLATION
-  Download kernel sources
-
-  From Linux 3.15
-    cd drivers/video/fbdev/fbtft
-    git clone https://github.com/notro/fbtft.git
-
-    Add to drivers/video/fbdev/Kconfig:   source "drivers/video/fbdev/fbtft/Kconfig"
-    Add to drivers/video/fbdev/Makefile:  obj-y += fbtft/
-
-  Before Linux 3.15
-    cd drivers/video
-    git clone https://github.com/notro/fbtft.git
-
-    Add to drivers/video/Kconfig:   source "drivers/video/fbtft/Kconfig"
-    Add to drivers/video/Makefile:  obj-y += fbtft/
-
-  Enable driver(s) in menuconfig and build the kernel
-
-
-See wiki for more information: https://github.com/notro/fbtft/wiki
-
-
-Source: https://github.com/notro/fbtft/
diff --git a/drivers/video/fbtft/TODO b/drivers/video/fbtft/TODO
deleted file mode 100644
index e72a08bf221c..000000000000
--- a/drivers/video/fbtft/TODO
+++ /dev/null
@@ -1,3 +0,0 @@
-* convert all these over to drm_simple_display_pipe and submit for inclusion
-  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
-  drivers anymore.
-- 
2.34.1

