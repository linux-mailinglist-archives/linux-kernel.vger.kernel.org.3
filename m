Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7CF591408
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiHLQin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiHLQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B902AFAFD;
        Fri, 12 Aug 2022 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322297; x=1691858297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8+jqmugnVsH0frOupwOifNzvz5V3RPADMrdmswfiq3o=;
  b=Z/B+n6ExC8T0RbUzYPAZpQNGYsTKcefwvSsg3tWzlVj/+55TudWuWnbi
   1/D3ockSH4Bc8L2x4H72V8fJj+IWg0ac4DVD7PcetCjpv9JDv3fWsCWse
   DS+kBvWlBPvgkUE+0E/PEojVYLXR/S3+rWPBfzIWs1/TO3OwzwpZDbJLb
   sRTZ2I51KYgq92jz8vdJ6eswYvSv3AO10qrF1QiFxeeTXaLfWw8Qn07/f
   7Nrj99h7ZYkZcuvHJSQxd5D2OJ1JuPk7G+sNNWbQrzqHzxtZekMarZ+4U
   QfBh0rHhzNaTCMwX1jL0WYJFinmm8+UTU3HO70Dmyr6TZCzm1Ft5vl0jA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921641"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012321"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:38:13 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 6/7] Documentation: x86: Remove obsolete x86_max_dies description
Date:   Sat, 13 Aug 2022 00:41:43 +0800
Message-Id: <20220812164144.30829-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812164144.30829-1-rui.zhang@intel.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo_x86.x86_max_dies is introduced in commit 7745f03eb395
("x86/topology: Add CPUID.1F multi-die/package support") and then
removed in commit 14d96d6c06b5
("x86/topology: Create topology_max_die_per_package()").

Remove the obsolete cpuinfo_x86.x86_max_dies description.

Fixes: 14d96d6c06b5 ("x86/topology: Create topology_max_die_per_package()")
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/x86/topology.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index c5eb5bc42380..fbef91b1ee5e 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -52,10 +52,6 @@ AMD nomenclature for package is 'Node'.
     The maximum possible number of cores in a package. This information is
     retrieved via CPUID.
 
-  - cpuinfo_x86.x86_max_dies:
-
-    The number of dies in a package. This information is retrieved via CPUID.
-
   - cpuinfo_x86.cpu_die_id:
 
     The physical ID of the die. This information is retrieved via CPUID.
-- 
2.34.1

