Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFF49BCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiAYUVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:21:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:32383 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbiAYUVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643142085; x=1674678085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zue4ppucen/ANYQA3c/xAkoOYydv3PMPDvmLNWSzoI=;
  b=fMS+0UxDVKq//sO/sdRxpq48Q8rVPiOX9LD+IVeW/mHte5hE71TX20ms
   AX8SJhHaQIUDbI9coQ5+orYdnD59rOO1dI2lvIXCI9477/592ZgXAWKiZ
   mUhwAswuWDEFHQLV7tyqWM2fny061Jdk13GG5c1DletZItgVDFMxx3gZV
   Bowk0JHhPh0LFFb4uFmkBRscKLYBpxe8D3xDz3GZwfcpnTIb6JJiyW57F
   eXTMWMlTYuJZS605ZQN52ttN4Y7uHvB1fP92DJHEsJlPyJI2CeIMy+EmK
   qhJVCLwGNljiehqqyaJKeMOmwoJps9DVWB64FGD8Nm1nfuFMl8qOJSNOP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="229983923"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="229983923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 12:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="495130326"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2022 12:21:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67655B9; Tue, 25 Jan 2022 22:21:22 +0200 (EET)
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
Subject: [PATCH v1 1/4] fbtft: Unorphan the driver
Date:   Tue, 25 Jan 2022 22:21:14 +0200
Message-Id: <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's maintain occasional fixes to the fbtft driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..16e614606ac1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7372,9 +7372,11 @@ F:	Documentation/fault-injection/
 F:	lib/fault-inject.c
 
 FBTFT Framebuffer drivers
+M:	Andy Shevchenko <andy@kernel.org>
 L:	dri-devel@lists.freedesktop.org
 L:	linux-fbdev@vger.kernel.org
-S:	Orphan
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-fbtft.git
 F:	drivers/staging/fbtft/
 
 FC0011 TUNER DRIVER
-- 
2.34.1

