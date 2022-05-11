Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8452332E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiEKMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiEKMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:35:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6A229FDB;
        Wed, 11 May 2022 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652272524; x=1683808524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Je/CmY6LFJJ+98sC3rY/TSh1qdSn/Cb5VGUlE6ISu8s=;
  b=aV6oV++U5vWKWaNJSoJMjZaV2ltI2R66OuLIYoGhk/dqXg7DTzZaFPJN
   IgXI89luqM9nHVm+QHtEKHvX0Ld3fXeLTOi4igyUFO6RShAnKHdesiYZG
   JHF5APgleWyVVGwdyDh4OyV4a2rTvXaZDGvQ3qvWByvi8j8AtM0/uOyOF
   zo62DMUUuUNfJo9ehijQDKGN76TRwP6ybysdsixRzsFoipElzREZUTiGg
   UNJBz2/2EzJssVXr+Ooai2aK9feCKMLgztF9F0ZxXx7pX4i8DQiNV5ZkF
   4VFQ+PstJfgL5SS98f8reIoHNPrSCuTFEBnYKTZBFUZYaW0KcXUYWASTL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332719981"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="332719981"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 05:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="697557186"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2022 05:35:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00074D2; Wed, 11 May 2022 15:34:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: broxton: Add module alias for Intel Apollo Lake
Date:   Wed, 11 May 2022 15:34:21 +0300
Message-Id: <20220511123421.88439-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have platform device IDs for Broxton and Apollo Lake, but
module alias is provided only for the former. Make it consistent
by providing an alias for Apollo Lake.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-broxton.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/intel/pinctrl-broxton.c b/drivers/pinctrl/intel/pinctrl-broxton.c
index 2be7e414f803..fb15cd10a32f 100644
--- a/drivers/pinctrl/intel/pinctrl-broxton.c
+++ b/drivers/pinctrl/intel/pinctrl-broxton.c
@@ -1035,4 +1035,5 @@ module_exit(bxt_pinctrl_exit);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Broxton SoC pinctrl/GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:apollolake-pinctrl");
 MODULE_ALIAS("platform:broxton-pinctrl");
-- 
2.35.1

