Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C25B1FD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiIHN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiIHN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:57:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC96FCA07;
        Thu,  8 Sep 2022 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645421; x=1694181421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kIBmOg7nAw3e6GJ9GuSaAoJE5QHCnDlDc9NHWzv4Oac=;
  b=m93FZR1Mb7gITs9O9dgcO0X00H6iiZ/8KiiSV4VTgqfq0CtfUPX78S0S
   Z1Gt868Ojnj5Z5wLwh+JgdWLJMTgLmU/7R+GjjscRKkfMjynzcODIAjVf
   o3BS4f0IBBhaq6q+tIUkPMt1VCLrpMrbAbx7btGKkkwk2EI3Rh/ULYWTK
   iMjjJP8JmlYTu+/ykjVrX5yIYFAkohFl2HTiIOmun+VKRhoQxKm2PUHOy
   vFzsS3yJezeaayuZzqHamDbjyNfCTn3bsZmoE5BtBY1s36CupFM/xe8Rj
   ZXgBL/8/6NLonGFn7yljGuQcf4FsNNaUyzX7QaGb/Kq1dE+K9koZB2sHd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297174068"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297174068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704012690"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 06:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3AE26D1; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 8/9] pwm: lpss: Add a comment to the bypass field
Date:   Thu,  8 Sep 2022 16:56:57 +0300
Message-Id: <20220908135658.64463-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to the bypass field based on the commit b997e3edca4f
("pwm: lpss: Set enable-bit before waiting for update-bit
to go low").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 839622964b2a..0249c01befd5 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -29,6 +29,11 @@ struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
 	unsigned int npwm;
 	unsigned long base_unit_bits;
+	/*
+	 * Some versions of the IP may stuck in the state machine if enable
+	 * bit is not set, and hence update bit will show busy status till
+	 * the reset. For the rest it may be otherwise.
+	 */
 	bool bypass;
 	/*
 	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
-- 
2.35.1

