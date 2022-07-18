Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69127578234
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiGRMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGRMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039E252B5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147015; x=1689683015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B275jqSskAz5hYN2MmXTvIVi2LsrWTqJUrMNf52jawI=;
  b=c1LLJdPsIPE2cNjMX3dixLrz2rhm6ab6yNYXHGAIUM/BIHSHoSZ8UfqE
   sNvEnr5zTxgNuXm6QyfgXPlH1DAHNHEpg97Vk+7UEGKYD354c8+ua+y9U
   6D/qrLY26u8+KRvbIpJS0H9cMMOlOMianyWunlsM0OZozV58cRMAyqlKB
   FeJ5LmYUsEfA8yfj9LwWlpDEWP9NwopdB80AROsw7fel9WbDOk0gxVEFr
   /9JDP9aeaHLIpFzccVvpRdMfTmju9kBCKV7jTnNBCFjYoSxBBtcvazhKC
   +LSas8hNiQkGOXMScnAw+BRxOVRDSAEoNZzWthP0F2YCC5hJcXPEAblPT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="284962501"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="284962501"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="843255554"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2022 05:23:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 76804419; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 7/9] mfd: intel_soc_pmic_crc: Update the copyright year
Date:   Mon, 18 Jul 2022 15:23:26 +0300
Message-Id: <20220718122328.8287-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 drivers/mfd/intel_soc_pmic_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index bb3cc1a808f0..0e5aae7ae9ad 100644
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

