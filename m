Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581D6537A48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiE3MAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiE3MAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:00:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A367CB1F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653912031; x=1685448031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ouav3TwG8lzXe/MdC2mRFtJxhn88S8RrP5ZlQzFCr94=;
  b=Tqr4SyBbaFPU7Xc1QsIAztEeaQEg6gkivpHY1/WyMizkntT2kjGrSyPo
   8eFTYem0Adcp6d8c5JPV1S3k1H/ZBAxtEmpErnQNbCUTCy+bZlWfxzgPG
   bKmuiXoMZCUxZ6aadhgRKJB7iofDgrvVs+JfUUkfOEVE3u8bAxajWkiRP
   nlByb19g5r+HDgmkDXOqb4WtVTcKLsk67AYwqWu6l5PTSzJLHc9pOnNwB
   NyJdtYXm2ZsJBFga/DuK/9Cgv0NfR+Ad/HIybuKREj7ItbxSSxa8rBsRJ
   fyyTVSQu9ru0LDDD5vEm1fbL7K51P6wL5S82rxvtRPBAyqSe7imX6BZQ1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="254856744"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="254856744"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 05:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="679115877"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 May 2022 05:00:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 562AA1A7; Mon, 30 May 2022 15:00:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dave.hansen@linux.intel.com
Subject: [PATCH v1 1/1] MAINTAINERS: Update Intel PMIC (MFD part) to Supported
Date:   Mon, 30 May 2022 15:00:15 +0300
Message-Id: <20220530120015.70543-1-andriy.shevchenko@linux.intel.com>
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
index bacb41953679..2831a1a5b4c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10028,7 +10028,7 @@ F:	drivers/gpio/gpio-*cove.c
 
 INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
-S:	Maintained
+S:	Supported
 F:	drivers/mfd/intel_soc_pmic*
 F:	include/linux/mfd/intel_soc_pmic*
 
-- 
2.35.1

