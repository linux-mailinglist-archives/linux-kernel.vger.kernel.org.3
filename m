Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F347C5844EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiG1Rcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Rcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:32:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB36FA1D;
        Thu, 28 Jul 2022 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659029553; x=1690565553;
  h=from:to:cc:subject:date:message-id;
  bh=nxECpsQv3k/IAi03chUuVK2iod+aGpSLArSaR5fV8dk=;
  b=nuqvCvgxq/Mb1zlt5oZqTW74jgHfM5fC4DhMQxICEbTXg0sb56X4p5d1
   xfM4VAkXAZEP6V0KLqfXkhEJvQI28zgUUnr5+qayLuB9VNU4pkwX5IMIP
   JT2oylNsym6Bij/W1swBMZWFpPmmO9vfjChca7rq1SD/sP8wezx2nGTui
   i4FvEb70hJZm7+WYbU+mThYNligw6UVRDtWvVDH9Y3v9GR/XcVhm5UXs7
   LEHnYxUtNVP1Ig+MLbmjpfOUeh78EoQKQckmxEwI2LqtRCcaXqTNPNbV1
   YC+MhcxxzcnmP8vddVD35uNX2JfqQW5yFq7PbgjKpd3TeVCla65fA8a13
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374875950"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="374875950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 10:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="659830926"
Received: from srpawnik-desktop.iind.intel.com ([10.223.107.152])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2022 10:32:31 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sumeet.r.pawnikar@intel.com
Subject: [PATCH] thermal: intel: Add TCC cooling support for Alder Lake-N and Raptor Lake-P
Date:   Thu, 28 Jul 2022 23:24:56 +0530
Message-Id: <20220728175456.2796-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alder Lake-N and Raptor Lake-P to the list of processor models
supported by the Intel TCC cooling driver.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index a9596e7562ea..95adac427b6f 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -81,7 +81,9 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
 	{}
 };
 
-- 
2.17.1

