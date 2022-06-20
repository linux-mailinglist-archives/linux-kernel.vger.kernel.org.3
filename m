Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A15517B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbiFTLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiFTLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB9FE4;
        Mon, 20 Jun 2022 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725485; x=1687261485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UdN0g13qcTNPn5ZNJ6qrKqpCS6O6eQthWK04gSFXGyY=;
  b=IOYPyG6aOJn7vnDbuf1e6HWn5Zx8zX2X8A+0Ig5m9z5HJYijTD4ssn9S
   y5KUJHH9pna+m30HE1+9B9asDDCOpzqWAxz6daQOKhYyyTGrM2jn8Lmc6
   8Acbz4RHLeiAX/37hLqCC4RKnC2940vveK/HdAfZP6NAyGcLgxQxMxEZd
   vLOop9LUgGqyX8ahI+dIBriv2VZzCBMwt5euFdEYF0JjMVuH6RNa7DKNv
   BK9sPc8GtEeUiCT6NkZ4AyKQCVklP/vUKfiWto+L9lRlIQiIkmvQ4M/pM
   eZHwd5kLzYVcGTxvqiPpoizd8UNk1tS1Tn1TNxwdI91rxHsy3OOAUyT1d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280604256"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280604256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584582457"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 20 Jun 2022 04:44:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F075759B; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 7/7] pinctrl: intel: Drop no more used members of struct intel_pingroup
Date:   Mon, 20 Jun 2022 14:44:39 +0300
Message-Id: <20220620114439.31491-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more used members in the struct intel_pingroup, drop them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index 69ff0598263c..65628423bf63 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -24,17 +24,11 @@ struct device;
 
 /**
  * struct intel_pingroup - Description about group of pins
- * @name: Name of the groups
- * @pins: All pins in this group
- * @npins: Number of pins in this groups
  * @grp: Generic data of the pin group (name and pins)
  * @mode: Native mode in which the group is muxed out @pins. Used if @modes is %NULL.
  * @modes: If not %NULL this will hold mode for each pin in @pins
  */
 struct intel_pingroup {
-	const char *name;
-	const unsigned int *pins;
-	size_t npins;
 	struct pingroup grp;
 	unsigned short mode;
 	const unsigned int *modes;
@@ -159,9 +153,6 @@ struct intel_community {
  */
 #define PIN_GROUP(n, p, m)								\
 	{										\
-		.name = (n),					\
-		.pins = (p),					\
-		.npins = ARRAY_SIZE((p)),			\
 		.grp = PINCTRL_PINGROUP((n), (p), ARRAY_SIZE((p))),			\
 		.mode = __builtin_choose_expr(__builtin_constant_p((m)), (m), 0),	\
 		.modes = __builtin_choose_expr(__builtin_constant_p((m)), NULL, (m)),	\
-- 
2.35.1

