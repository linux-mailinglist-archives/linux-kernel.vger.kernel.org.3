Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F851D9A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441915AbiEFN4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441901AbiEFN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:56:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883F5640C;
        Fri,  6 May 2022 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651845153; x=1683381153;
  h=from:to:cc:subject:date:message-id;
  bh=9wDnsvS/6Z2OFFZgBJm5Wi0bWXc2LWpf6mCk4M3Kstg=;
  b=mnbe3M6PfByB77QEOzHeuw5JYZjSHpNqj/5i5g/e96TTdMZdNgKMGDBQ
   IFcKS4DXWM2OxS7yVrbtnyl1laHhASXNnxRu/6Ta4VwxA3jQNAwwLZ+xX
   PwjXGjnaGx1mmV/HYtqRumXx45YHvu+rzZE/9avRbaHekdWoBQI3GMRxc
   UKcJpc7zsecnF8Qnd58qqALe+3FuSuQ1jP1RT9eSp50/uoY+w1X8Ze7df
   wJGu609FfDFkZkTp+G3zFc+ID+gCvELuaht4iMzPMWGk30FUf9tXIzlud
   ZA/BhwCpQKqldq2XCytcJRyOwF3ZzzD2wg4vhlltGOcb6swVv+9oj+pIR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="266062738"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266062738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 06:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735709939"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 06:52:30 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] drivers/thermal/intel: Add TCC cooling support for RaptorLake platform
Date:   Fri,  6 May 2022 19:20:09 +0530
Message-Id: <20220506135009.22246-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TCC cooling support for the RaptorLake platform

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index cd80c7db4073..a9596e7562ea 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -81,6 +81,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
 	{}
 };
 
-- 
2.17.1

