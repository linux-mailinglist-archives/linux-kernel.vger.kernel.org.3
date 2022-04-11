Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90F4FC828
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiDKXjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDKXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:39:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515061EAEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649720225; x=1681256225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QDo1GPT+z8RAO9nmKofBNKMkWBwy3BGCKCS5D9UtiI=;
  b=ek9ozynEhvIH+ij6HrTAAGMRs9T/hiftsVltBhA/Q7x8EmBDnkqGwv1v
   ybuboz5DJ+lqGjrMz17t7E7pGGRjOf77OD616k7AdKzEZNCUzHY41sSMJ
   OCDfj9bVd6fSNu4TjeLqHorf030cH1Y0HGyA6Y8lrKJU4NCL3wLLdmmFt
   BkRYWNJCIhmdqAqNlN/jmeYuKm9U9VEUID9am/X0yxxQ2BVMMd17Ggj4X
   arlTVrCxWzdq33ZDlGk9W2K7tLwENTNj+UAfLAMTYwLTO6EdzCmbGORTu
   ILPpFbj0tn9yYyqZEKK8Mym+RVvYb6ZVYrXTpYkI0plQ6Nb8RJ0YF+ykv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="322683368"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="322683368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 16:37:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572469586"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 16:37:04 -0700
Date:   Mon, 11 Apr 2022 16:37:03 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: Add new Alderlake and Raptorlake CPU model numbers
Message-ID: <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
References: <20220310215652.32025-1-tony.luck@intel.com>
 <20220330134325.GM8939@worktop.programming.kicks-ass.net>
 <29d602962d6542bd90e877c104afcc7f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d602962d6542bd90e877c104afcc7f@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel is subdividing the mobile segment with additional models
with the same codename. Using the Intel "N" and "P" suffices
for these will be less confusing than trying to map to some
different naming convention.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

I think the earlier patch for Alderlake "N" got stuck in limbo
trying to resolve whether we should add the "_N" suffix to our list
of acceptable CPU model #define names. Now we have another one "_P".

Can we just take these, and move on?

 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 048b6d5aff50..def6ca121111 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -26,6 +26,7 @@
  *		_G	- parts with extra graphics on
  *		_X	- regular server parts
  *		_D	- micro server parts
+ *		_N,_P	- other mobile parts
  *
  *		Historical OPTDIFFs:
  *
@@ -107,8 +108,10 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.35.1

