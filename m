Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE44B7212
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiBOPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:30:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiBOPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:30:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA460BF949;
        Tue, 15 Feb 2022 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644938918; x=1676474918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A23AdMS/AOpsrP6iuq0nwUEpT+EvP0tV1UlgxSjJNVQ=;
  b=SlvW2nn88971vlNiVS4jsaSGCWTHTLjLHXaIbKbVqeuIIKLdEsvD/Ct1
   Dili49dIpg2u9TbaWc5nKaipD8TtPx2zHolrkr7LXWZxFJJEjAREY5fgV
   pvj3+XoOGq+xG4eaVgA7ggTh02pExwdTLgcNRriU/7VdhJNrxTCnyGWvE
   DcH1bLIskgyG/l0mg+hE0/zHa0prw9/5eHsMpT5A+eUOcENHgDu1BJPK3
   ZOg7lS7lH+dl7Vb9yXA3JOo6NULhW8rOH5vWnFgkfmi3wWL8zXZ/nNegV
   SUUZS8sTrEMIBSjyK1fBPqCa25mGKxilN2V+iqMmjX5/icN60YVWeltA5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250115605"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250115605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="502495976"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 07:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A26CC93; Tue, 15 Feb 2022 17:28:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/4] pinctrl: alderlake: Add Raptor Lake-S ACPI ID
Date:   Tue, 15 Feb 2022 17:27:58 +0200
Message-Id: <20220215152800.21104-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
References: <20220215152800.21104-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Raptor Lake-S PCH has the same GPIO hardware than Alder Lake-S PCH
but the ACPI ID is different. Add this new ACPI ID to the list of supported
devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-alderlake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/intel/pinctrl-alderlake.c b/drivers/pinctrl/intel/pinctrl-alderlake.c
index efb664f12b5d..51fb99cd64a2 100644
--- a/drivers/pinctrl/intel/pinctrl-alderlake.c
+++ b/drivers/pinctrl/intel/pinctrl-alderlake.c
@@ -416,6 +416,7 @@ static const struct intel_pinctrl_soc_data adls_soc_data = {
 
 static const struct acpi_device_id adl_pinctrl_acpi_match[] = {
 	{ "INTC1056", (kernel_ulong_t)&adls_soc_data },
+	{ "INTC1085", (kernel_ulong_t)&adls_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adl_pinctrl_acpi_match);
-- 
2.34.1

