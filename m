Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8792E47D35E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhLVOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:04:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:24392 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245574AbhLVOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640181891; x=1671717891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=giZfMnI/ds4gAO8fynsSE17x7sVTJ3UvzV6jf6hUKkY=;
  b=jMFs2BGtXXC8PSRalNuPy8ExlJA4BXepPfo6bxgOEwP4w2PPauXS0Sok
   FW6VoFaCUU4Dg0x5q11V1CqaRYla+ur4pZaTkRdF0fVoRMXNVVGWdXjny
   yfkkFOb74LscVUfervIADeNQr33XmYs9rmUZjHoKu36s32ABCXOCGv+YF
   FqAMhlNh6HdNx2Wyj2e5hl5WTObL5tkPl3yjdfTgDhiTJD7ufRzFyLVU6
   ailGNnwNfKVqP5Qax50Jorft5YpwQdFCIKEXbfl+2MukEVgujX/9lHGOL
   moLLCPNA/PypUWeJIQXaZJG+4C/FZG8953nik4b/ouNrNgLl5PWCt2Ccb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="326927684"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="326927684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="466673312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 06:04:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF6AD23E; Wed, 22 Dec 2021 16:04:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: CPPC: Amend documentation in the comments
Date:   Wed, 22 Dec 2021 16:04:45 +0200
Message-Id: <20211222140445.69689-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's too hard to read the _CPC structure as it's commented.
Reshuffle indentation and style to make it readable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c | 59 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b62c87b8ce4a..182471f319fe 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -604,47 +604,30 @@ static bool is_cppc_supported(int revision, int num_ent)
 /*
  * An example CPC table looks like the following.
  *
- *	Name(_CPC, Package()
- *			{
- *			17,
- *			NumEntries
- *			1,
- *			// Revision
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x120, 2)},
- *			// Highest Performance
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x124, 2)},
- *			// Nominal Performance
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x128, 2)},
- *			// Lowest Nonlinear Performance
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x12C, 2)},
- *			// Lowest Performance
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x130, 2)},
- *			// Guaranteed Performance Register
- *			ResourceTemplate(){Register(PCC, 32, 0, 0x110, 2)},
- *			// Desired Performance Register
- *			ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)},
- *			..
- *			..
- *			..
- *
- *		}
+ *  Name (_CPC, Package() {
+ *      17,							// NumEntries
+ *      1,							// Revision
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x120, 2)},	// Highest Performance
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x124, 2)},	// Nominal Performance
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x128, 2)},	// Lowest Nonlinear Performance
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x12C, 2)},	// Lowest Performance
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x130, 2)},	// Guaranteed Performance Register
+ *      ResourceTemplate() {Register(PCC, 32, 0, 0x110, 2)},	// Desired Performance Register
+ *      ResourceTemplate() {Register(SystemMemory, 0, 0, 0, 0)},
+ *      ...
+ *      ...
+ *      ...
+ *  }
  * Each Register() encodes how to access that specific register.
  * e.g. a sample PCC entry has the following encoding:
  *
- *	Register (
- *		PCC,
- *		AddressSpaceKeyword
- *		8,
- *		//RegisterBitWidth
- *		8,
- *		//RegisterBitOffset
- *		0x30,
- *		//RegisterAddress
- *		9
- *		//AccessSize (subspace ID)
- *		0
- *		)
- *	}
+ *  Register (
+ *      PCC,	// AddressSpaceKeyword
+ *      8,	// RegisterBitWidth
+ *      8,	// RegisterBitOffset
+ *      0x30,	// RegisterAddress
+ *      9,	// AccessSize (subspace ID)
+ *  )
  */
 
 #ifndef init_freq_invariance_cppc
-- 
2.34.1

