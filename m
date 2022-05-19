Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031DE52DF47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiESV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiESV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:27:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9B6D951;
        Thu, 19 May 2022 14:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652995646; x=1684531646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YEslGaRlWEVd8rQfrjVOyqh7W4xppAWF9ITI8yuaqmA=;
  b=Aqw4cS3/t65JPN7NP6Q2HbatSjTOFy0XXPOVBZSMNbtn+OPcbTyF7wni
   kHWf/I5mfRAHzY70+6M7+obrWMlGSvcDqTvqm/qjfRTCr1d2SoRn/eoG/
   Rdusb4b8RB3/I1yjB6+vYpMDXIDmj9IDMqMuDknlpZsRdygQZS6l4XCDC
   8rX5mJsjYQ/xMHSqzL9i/D06sVvO2XvEZlS9vdGeLCqv1DGFLETA5dRHF
   cuqPZl57d5oFqxi7w8FoNNA3UHEh1pYRBqUTeCuAw1497715DOXbhul3W
   Q5qqJOvRsceYUonMZ3Bufld9ptyXUZNU68TyxiBUOQc/in2ESphD7+C4p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271208129"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="271208129"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="524296741"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2022 14:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 42026109; Fri, 20 May 2022 00:26:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: intel: Fix kernel doc format, i.e. add return sections
Date:   Fri, 20 May 2022 00:26:45 +0300
Message-Id: <20220519212645.47177-1-andriy.shevchenko@linux.intel.com>
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

  pinctrl-intel.c:865: warning: No description found for return value of 'intel_gpio_to_pin'
  pinctrl-intel.c:904: warning: No description found for return value of 'intel_pin_to_gpio'
  2 warnings

Add return sections to the kernel documentation of the above mentioned
functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index f882a31375ee..ffc045f7bf00 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -858,6 +858,9 @@ static const struct pinctrl_desc intel_pinctrl_desc = {
  * When coming through gpiolib irqchip, the GPIO offset is not
  * automatically translated to pinctrl pin number. This function can be
  * used to find out the corresponding pinctrl pin.
+ *
+ * Return: a pin number and pointers to the community and pad group, which
+ * the pin belongs to, or negative error code if translation can't be done.
  */
 static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
 			     const struct intel_community **community,
@@ -899,6 +902,8 @@ static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned int offset,
  * @pin: pin number
  *
  * Translate the pin number of pinctrl to GPIO offset
+ *
+ * Return: a GPIO offset, or negative error code if translation can't be done.
  */
 static __maybe_unused int intel_pin_to_gpio(struct intel_pinctrl *pctrl, int pin)
 {
-- 
2.35.1

