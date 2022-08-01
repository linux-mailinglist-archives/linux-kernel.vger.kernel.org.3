Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83128586825
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiHALaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHALa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:30:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742365BC;
        Mon,  1 Aug 2022 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659353426; x=1690889426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwmzK4Q3FX296ZwWrVPKXYCI6LiXwe1b/aPBo9GUgfA=;
  b=fXkLGySnisBZrTnq4FiTuHnH8OWRpKZE4tTPYTaO6ff7fEHJDWezDqeb
   EIXPfUzWMygLHcwZsuuiH+NLTIvJTC8PdEMCxJwd6pCk5XKI7E67Wrg8B
   oKPMboxGZUOHuyAF5aD+AzB37ITYOrybk/H/Wx1bkSrKKFCleCB50oABz
   hPddq196UIzBwAaJDtmpfk0o76/Uulnd21iUPRA7U1pa5L8EKU4Lm8Fsr
   VAsSCQu58k1ByTUOMl3uqq0tIkqRxdHF8qMo+/loTs0yfvHff2nnBdsdp
   lbBQurJKhhYf1mPRa/ScR4L7DP2cKAcEacu857GPsL5e9PhUywAlwyRuP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375425839"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375425839"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552483224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2022 04:30:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12A5F86; Mon,  1 Aug 2022 14:30:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 3/4] platform/x86: pmc_atom: Make terminator entry uniform
Date:   Mon,  1 Aug 2022 14:30:17 +0300
Message-Id: <20220801113018.9882-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
References: <20220801113018.9882-1-andriy.shevchenko@linux.intel.com>
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

Make terminator entry uniform by dropping:
 - trailing commas
 - anything inside curly braces

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/pmc_atom.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 4c3d6b48d2f0..8d91999446f5 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -60,7 +60,7 @@ static const struct pmc_clk byt_clks[] = {
 		.freq = 19200000,
 		.parent_name = "xtal",
 	},
-	{},
+	{}
 };
 
 static const struct pmc_clk cht_clks[] = {
@@ -69,7 +69,7 @@ static const struct pmc_clk cht_clks[] = {
 		.freq = 19200000,
 		.parent_name = NULL,
 	},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map d3_sts_0_map[] = {
@@ -105,7 +105,7 @@ static const struct pmc_bit_map d3_sts_0_map[] = {
 	{"LPSS2_F5_I2C5",	BIT_LPSS2_F5_I2C5},
 	{"LPSS2_F6_I2C6",	BIT_LPSS2_F6_I2C6},
 	{"LPSS2_F7_I2C7",	BIT_LPSS2_F7_I2C7},
-	{},
+	{}
 };
 
 static struct pmc_bit_map byt_d3_sts_1_map[] = {
@@ -113,21 +113,21 @@ static struct pmc_bit_map byt_d3_sts_1_map[] = {
 	{"OTG_SS_PHY",		BIT_OTG_SS_PHY},
 	{"USH_SS_PHY",		BIT_USH_SS_PHY},
 	{"DFX",			BIT_DFX},
-	{},
+	{}
 };
 
 static struct pmc_bit_map cht_d3_sts_1_map[] = {
 	{"SMB",			BIT_SMB},
 	{"GMM",			BIT_STS_GMM},
 	{"ISH",			BIT_STS_ISH},
-	{},
+	{}
 };
 
 static struct pmc_bit_map cht_func_dis_2_map[] = {
 	{"SMB",			BIT_SMB},
 	{"GMM",			BIT_FD_GMM},
 	{"ISH",			BIT_FD_ISH},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map byt_pss_map[] = {
@@ -149,7 +149,7 @@ static const struct pmc_bit_map byt_pss_map[] = {
 	{"OTG_VCCA",		PMC_PSS_BIT_OTG_VCCA},
 	{"USB",			PMC_PSS_BIT_USB},
 	{"USB_SUS",		PMC_PSS_BIT_USB_SUS},
-	{},
+	{}
 };
 
 static const struct pmc_bit_map cht_pss_map[] = {
@@ -172,7 +172,7 @@ static const struct pmc_bit_map cht_pss_map[] = {
 	{"DFX_CLUSTER3",	PMC_PSS_BIT_CHT_DFX_CLUSTER3},
 	{"DFX_CLUSTER4",	PMC_PSS_BIT_CHT_DFX_CLUSTER4},
 	{"DFX_CLUSTER5",	PMC_PSS_BIT_CHT_DFX_CLUSTER5},
-	{},
+	{}
 };
 
 static const struct pmc_reg_map byt_reg_map = {
@@ -422,8 +422,7 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
 		},
 	},
-
-	{ /*sentinel*/ }
+	{}
 };
 
 static int pmc_setup_clks(struct pci_dev *pdev, void __iomem *pmc_regmap,
@@ -503,7 +502,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
 static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_VLV_PMC), (kernel_ulong_t)&byt_data },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_CHT_PMC), (kernel_ulong_t)&cht_data },
-	{ 0, },
+	{}
 };
 
 static int __init pmc_atom_init(void)
-- 
2.35.1

