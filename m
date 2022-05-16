Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C87528D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbiEPS4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345184AbiEPS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:56:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F3165F1;
        Mon, 16 May 2022 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652727387; x=1684263387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BfbVbL6Hld/E/O04WsrHSldx5ETHMb9X0kAR36zcyzA=;
  b=iQmqRle8JSL02JSXoiIJB1iUDZHBEfGi0giTSmkwC8YSJn8rdIcmwlFP
   V82aeirR7HkA4zgdLdjda2Zs1Lw/+AjgHjGRXWJK479Krzn3RcMppnH57
   frqR2Kw0gWHHSca3crsWmlsaEWPinV6zYI+bfnjP7BQnmjJkJS6Lmne6t
   UmDp3NhlPCYABOHchlUDv00gcz0fA4tnah/worynr+ifVkhEdWiHjdFtY
   zuMbeFu0DvEWGrBviQNuVyFtVUN5OlMUIaNIixcVMqHMcb95BffTBw2pS
   Ra59kvec0yXgbxwY0nx+/GC3gKgWPXqX7+4tXXhM7dPsHpRa28D1vvp7/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258494611"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="258494611"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="660250203"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2022 11:56:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B3F1CE; Mon, 16 May 2022 21:56:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] pinctrl: intel: Drop unsued irqchip member in struct intel_pinctrl
Date:   Mon, 16 May 2022 21:56:18 +0300
Message-Id: <20220516185618.32448-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516185618.32448-1-andriy.shevchenko@linux.intel.com>
References: <20220516185618.32448-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no users of irqchip member in struct intel_pinctrl. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index c4fef03b663f..710341bb67cc 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -223,7 +223,6 @@ struct intel_pinctrl_context {
  * @pctldesc: Pin controller description
  * @pctldev: Pointer to the pin controller device
  * @chip: GPIO chip in this pin controller
- * @irqchip: IRQ chip in this pin controller
  * @soc: SoC/PCH specific pin configuration data
  * @communities: All communities in this pin controller
  * @ncommunities: Number of communities in this pin controller
@@ -236,7 +235,6 @@ struct intel_pinctrl {
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct gpio_chip chip;
-	struct irq_chip irqchip;
 	const struct intel_pinctrl_soc_data *soc;
 	struct intel_community *communities;
 	size_t ncommunities;
-- 
2.35.1

