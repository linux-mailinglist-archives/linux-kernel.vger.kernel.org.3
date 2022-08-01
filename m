Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B639586853
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHALm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiHALmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:42:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446DD33424
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354130; x=1690890130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T03AW6mF/0gYDvkN7mrtXdooeMnD5rBdcAp5QgrlOgY=;
  b=mZl8eVn4ek0nMhYlk1dGDaU14pleLKChigUniuN88MpgS2GKO1Ngdxmy
   Q3aduGeE+Ga3eowjdi6DCB6okNm8QOPD3O12Y9Q1EgA4/0K5xTKakj97B
   sintebJYHjBkR13S03cIO2Ew8rCgre9X/taksDYG/kSGjrZc9UgeGCaFJ
   PGaWm10xF0mVh0Mac6ztJJfHYB1ura8wZPZ/6ngL00cwTBRn8vY6Kg57I
   pamh6AROX9ltLqt9y90O5eS3ndTr+sFYQ5ScifFFRwTkv5KrnIu4915gk
   oE7G3TF6ePUDsmmzoUwejDT93pmFp8ZeYsKkhxYp+WAcICCnq+ZdpqU5g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="269506059"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269506059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="605633509"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2022 04:42:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00DEE11C; Mon,  1 Aug 2022 14:42:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 03/10] mfd: intel_soc_pmic: Move non-Intel Makefile entries to their own group
Date:   Mon,  1 Aug 2022 14:42:04 +0300
Message-Id: <20220801114211.36267-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a random position for couple of Makefile entries that are
disrupting Intel PMIC group. Move them to their own group.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

v3: no changes
v2: added tags and rebased on top of new patch 1

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

