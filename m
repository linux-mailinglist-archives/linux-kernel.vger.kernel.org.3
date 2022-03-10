Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D24D53FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiCJV6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiCJV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:58:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B10194172
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646949421; x=1678485421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/gf8r6mOTKWuhUaN23Rbq9Gs94tCRVlDDIvpuIpjvis=;
  b=Ve/Bj0rDVBcJ2sBX8JKJmxWFyY4j5eZAl+yMM9grkM5MhMqW+F4rz3ws
   irGDkIYa6fhSZLQQHjqJ3rGQkCdg6K59HOF+Jr4vt8QFnCerI4iiLpqS+
   1p3AT94ZMz7lfn1/eK+LSlc/utIu2PkXyKk8lteec23jpytIuxXALVjE/
   HfREkJXBevqnZTopHQjvVwX5ATpYjJxBltOpk7zewJCD8mLE7TKCz74Ml
   ClR26BMGllsU91WI1HLh5L2II9si6KhqwvXTCuJD2EBgmYu/2HntCyWIs
   6oc4+s5wuNYtbp588EyjTJvKMc6yKAZqL6KpH85RkTz7wC+I9F5yGWGXB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254218146"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254218146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:57:01 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="511081632"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 13:57:01 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add a third Alderlake CPU model number
Date:   Thu, 10 Mar 2022 13:56:52 -0800
Message-Id: <20220310215652.32025-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing suffix conventions only cover mobile/desktop/server options.
But this isn't any of those. Use "_N" as it matches the Intel naming
convention for this part.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Peter: What do you think about suffix proliferation? I tried to
get an answer about the target market segment for this CPU, but
didn't get an answer that is at all useful.

 arch/x86/include/asm/intel-family.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 048b6d5aff50..2f7b608f3e55 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -107,6 +107,7 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 
-- 
2.35.1

