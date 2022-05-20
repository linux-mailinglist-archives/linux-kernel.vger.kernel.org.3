Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10452F10F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiETQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351860AbiETQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:47:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93F2FE4D;
        Fri, 20 May 2022 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653065249; x=1684601249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=27ITcLx4VEf1PQo7y9MvVOyX5nDwqeDNk3fCk+qepa4=;
  b=DieX39Jph8SWdUU6jkolhpXW8Ps6APWvuzke+iyAsjOBELyKsZRxckZ7
   bCoUSBBoG5h+9vreiEF5xeGpNTHkRluqPWX78D6cqpgooerlQKlFR7g6N
   iroVz6ncomUjj9z4bq+rE9qWyfDzlMcx865zP6j/w9kvTvQA5Zw3+WhOQ
   6quUpqke1gts4hzdU+dvl8SQ5B9y8iiaroIgU9WhrSEbpm/PoIlzBGSxU
   J12C1xGrKTyx0C/hYTv6NdVblvQkdZrJUJ6tl+zgUGPtsmFvZF/lfgA/W
   nAZWzElp2GfLH1r9mDWohYC0ZSUKNFppKi/K9+5ln5kj0EXpCkvVd7yxj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="333286763"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="333286763"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 09:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="743576808"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2022 09:47:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 13342109; Fri, 20 May 2022 19:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dipen Patel <dipenp@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Date:   Fri, 20 May 2022 19:47:26 +0300
Message-Id: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc validator is not happy:
  gpiolib-cdev.c:487: warning: Function parameter or member 'hdesc' not described in 'line'
  gpiolib-cdev.c:487: warning: Function parameter or member 'raw_level' not described in 'line'
  gpiolib-cdev.c:487: warning: Function parameter or member 'total_discard_seq' not described in 'line'
  gpiolib-cdev.c:487: warning: Function parameter or member 'last_seqno' not described in 'line'

Describe above mentioned parameters.

Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f5aa5f93342a..d0dc68d04059 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -421,6 +421,10 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @work: the worker that implements software debouncing
  * @sw_debounced: flag indicating if the software debouncer is active
  * @level: the current debounced physical level of the line
+ * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
+ * @raw_level: the line level at the time of event
+ * @total_discard_seq: the running counter of the discarded events
+ * @last_seqno: the last sequence number before debounce period expires
  */
 struct line {
 	struct gpio_desc *desc;
-- 
2.35.1

