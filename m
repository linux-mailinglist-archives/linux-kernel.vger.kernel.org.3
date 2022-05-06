Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479AC51D9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441925AbiEFOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiEFN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:59:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F635DBE5;
        Fri,  6 May 2022 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651845376; x=1683381376;
  h=from:to:cc:subject:date:message-id;
  bh=98S21VI5IJ85HPl4gKniQ9tbcJ0oPC6mo8HQoRhUgyY=;
  b=PY5cRSf5xVxj1AR2vbXRWnjI83ysoK6XD6CxbkYmfYzQh30uSXYa0tSc
   o5CN52ODapMi79YZT4kchKuc4XB0VszfJ7UtZjf2MQHRfDh7W8frZhcC7
   qDNGwa1GnnXVPRL7Fro9VgkS+Bf/lbTd8DXGNR5PelNj7PlR2igVcFZiz
   OGkQSq+ndktHeCsT4IwAzTZ+2pOyiznSIrr4aNxeIqICfFdh2l/Lv5keU
   8rmW+tsZgF91O73fAB0GooTgs2LB/rCbP8HwpX3CzVPkllK9CQXh+SIkO
   sI8JC1vnY+1wkaElHgcJwWdH8yxx2mSvLKiLiVKLKrNheBE4trRl8+qbM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="250472354"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="250472354"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 06:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537899302"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2022 06:56:14 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: Add Power Limit4 support for RaptorLake SoC
Date:   Fri,  6 May 2022 19:23:52 +0530
Message-Id: <20220506135352.22427-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Power Limit4 support for RaptorLake SoC.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 1be45f36ab6c..9d23984d8931 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -140,6 +140,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
 	{}
 };
 
-- 
2.17.1

