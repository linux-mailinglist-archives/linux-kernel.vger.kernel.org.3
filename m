Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1559544C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiHPH62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiHPH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C2F47F2;
        Mon, 15 Aug 2022 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626793; x=1692162793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hbLNyRcLgu/3RSFiCT5I9SBJfhTGwgIQFfI74KmSZMA=;
  b=LA8HKEpvMZzMPi9SqqTCewX2qz7PIIVnsBTvgeJr3TCVlpCzkc98ycon
   apLuVN4y0NZSQgJ/FouF41YVuECHnDeFRaAX2tCIpfkyhxkO3FQq3KwAh
   gfmXJjc0GixpELQFj7mzW4rLypBa1mO8obZvUUeBpr7L06/t34BUeb+XS
   GuCXhJAiuReKl5Yc+0kTvuPaoDPzSQHjtslsnTnWuCFC3185aT2RCGqy7
   oNG6mfj/eulbDVvnSNtS8QbozTmaumValQXnkdEnsAvZ53N23lJbp2cU/
   8cIN3VdJmyiEiW6kJjtCSDxcHHCrgmaY5txsDki8tYekWolw+exBlSWE/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130194"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130194"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953551"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:13:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 8/8] Documentation: x86: Remove obsolete x86_max_dies description
Date:   Tue, 16 Aug 2022 13:16:33 +0800
Message-Id: <20220816051633.17775-9-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816051633.17775-1-rui.zhang@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.25.1

