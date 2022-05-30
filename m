Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6C537A40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiE3L6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbiE3L6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:58:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA57CB02;
        Mon, 30 May 2022 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653911879; x=1685447879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=24EPdI/dz5vGA6WlWmXpgkj9d8noMoEjT0TMJTdk5CE=;
  b=lm4li/LRmG+8GYI3G3hN7HgxNrvUM3mzkJyJUsP0r+tIdT2g134updjK
   pXO+JbxIRNdWCvXqu9mHWMLHcjMyE50w29q14/VJ5QhT+T4eP5prSumKA
   VH7ElOq9m4UQj3b/mqtKUdSgHTVuLVb1nOrJIyv/G9wW7arEZkLKAjjHh
   dHOWZpynPK86iPNoiDJ1dVkkOp1IP58g9oG/WvzxtNT9vlyEtp4D0lOND
   +Fs0ZQ9HmUIEmdenApzjwg61JwcaK3gtm4PtEhLLYjWf+YKEzAc1DVOIv
   VRr/DltJZMGAaL1N/5Es2ZyH8OdhS6s1IN9ZYIdBPq3kpijAyNsTqlmDo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="254856239"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="254856239"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 04:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="706132637"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 04:57:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63B641A7; Mon, 30 May 2022 14:57:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dave.hansen@linux.intel.com
Subject: [PATCH v1 1/1] MAINTAINERS: Update Intel pin control to Supported
Date:   Mon, 30 May 2022 14:57:50 +0300
Message-Id: <20220530115750.70470-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual status of the code is Supported.

Reported-by: dave.hansen@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2831a1a5b4c2..56dd473d5d59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15555,7 +15555,7 @@ F:	drivers/pinctrl/freescale/
 PIN CONTROLLER - INTEL
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Andy Shevchenko <andy@kernel.org>
-S:	Maintained
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git
 F:	drivers/pinctrl/intel/
 
-- 
2.35.1

