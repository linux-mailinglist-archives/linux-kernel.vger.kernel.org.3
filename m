Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C319158613E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiGaUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGaUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:13:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B8E0F8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659298382; x=1690834382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YZA9bi9pjAsMWfJUkJDUw8L7ltUmBL/R/tlgnMG7mc=;
  b=mep5MZbhczPwiU1zZ2nxrLgTj1+/BhrXRFyCLCDK+PWTBa61lUS89uFD
   U0+strJt7Cudgysy54lE86Gwo0pc2iwYwA7UGs1fsnrXH9oPwl79yMNX0
   6bZlGB2lGBRotSUV+VxfG5D89NGEhlhbEpvQVLgWO9sK55EDRC0NJqou1
   O4gkj48R5fu+cyJ+lEMGxmor4k/eLEuCxNJ/PeCYcKh2hajPom6OlPgfW
   Ascq1mlgZq1jxXKVWEprU6DlYAMl5mEJ2Hymd+IzYMXVbbb5N4PsLvXwO
   cATwAAD7R5lB6MNG1p3iZovg8Q9ifMvgFbuat1WJhmVycFM/JtWjYfhzI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="286581530"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="286581530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 13:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="691258313"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2022 13:13:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F7EC41F; Sun, 31 Jul 2022 23:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 10/10] mfd: intel_soc_pmic_crc: Update the copyright year
Date:   Sun, 31 Jul 2022 23:12:58 +0300
Message-Id: <20220731201258.11262-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the copyright year to be 2012-2014, 2022.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added tags and rebased on top of new patch 1

 drivers/mfd/intel_soc_pmic_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index bbb30060d2fb..40f14a0c0790 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -2,7 +2,7 @@
 /*
  * Device access for Crystal Cove PMIC
  *
- * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
+ * Copyright (C) 2012-2014, 2022 Intel Corporation. All rights reserved.
  *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
-- 
2.35.1

