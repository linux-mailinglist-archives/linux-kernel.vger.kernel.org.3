Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0554E94C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377449AbiFPSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFPSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC14EA38
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403931; x=1686939931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8WwxWdb6rTgViMMcGzyUr6TO3ZgMq57B9P6iGckJZk=;
  b=O5eo+l8VsE716oNHOnBFDUMDhtR/SSF68wuGTJU8rWUDc0NOzAwH01zh
   LX+0lYXu43bokiS1+Xk3SjFYpXllvTApLyLMz9E+SCDhACtbco2UuE+oL
   N6XATQc8u8ErPgynNvxpIrb3394N3eGpYXklUdZ1zsqZSdlsZ0G7zUM8C
   ha29hHrMOyrxW40GJXQmdmsQa8/M6n2jPA38AS2F/yg0C7s4j9oQS9ljL
   NJ2XJsevwwFKO+BMrXTULyxJoyvpa0C4srI2kcq6R9SQ8tJKVikl79EC2
   o+Fg8WtM99LzqQZhoyXOicsmIERG/kAfOqj6TgEBhR8dfIfT2dXA/hGWo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="340975525"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="340975525"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536547933"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 11:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10AED67; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/9] mfd: intel_soc_pmic: Move non-Intel Makefile entries to their own group
Date:   Thu, 16 Jun 2022 21:25:17 +0300
Message-Id: <20220616182524.7956-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a random position for couple of Makefile entries that are
disrupting Intel PMIC group. Move them to their own group.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 61db669f864c..30f5de657e88 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -172,6 +172,10 @@ obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
 
 obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
 
+obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
+mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
+obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
+
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
 obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
@@ -240,9 +244,6 @@ obj-$(CONFIG_INTEL_SOC_PMIC)		+= intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
-obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
-mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
-obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
 obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
-- 
2.35.1

