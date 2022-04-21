Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B850A66D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390477AbiDURB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiDURBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:01:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3BB49CB1;
        Thu, 21 Apr 2022 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650560343; x=1682096343;
  h=from:to:cc:subject:date:message-id;
  bh=HqgMig3aen+5pw0uDZjc5+jukF0A9E8DbTxEMgC0qo0=;
  b=FUgkPjW/n/aFOPR+gK8EPaOoTJnWwVKotG2Bcu99eyN1HgdJHDRBi+em
   6YGgZH4bBfqmiZrvllp5OvHs0iaMHcSe/b1qMsiP9GtPNeNcz/5Ls5CqI
   LNxUiyCe8+9OyBAUL6nW5pbdXYbCm+SQTIM2Ed/eAnudmF0R4fVKpu6k4
   85rc7n+vFfY0yidlzWQ96wO4+l0B+hIWSjdoJWmjsN7ID+le/fjtcwkrp
   cNpAn/pZZRklvXDxU/ooCsRZdl9gQXWbxV1CwC4sJxtC9y5CthqTPUab+
   /uD1z0lD1igFD5cL4pFKCG8PCWnqI/jfzl/AC5ohUGSfFORL8MhbQOFyn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251735182"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="251735182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="555874855"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2022 09:58:54 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, lenb@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sumeet.r.pawnikar@intel.com
Subject: [PATCH] ACPI: DPTF: Correct description of INT3407 / INT3532 attributes
Date:   Thu, 21 Apr 2022 22:25:43 +0530
Message-Id: <20220421165543.435-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate comments of PBSS for Battery steady state power and
correct the typo for PMAX Maximum platform power.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/dptf/dptf_power.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index dc1f52a5b3f4..1f2e6c29773b 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -12,14 +12,12 @@
 /*
  * Presentation of attributes which are defined for INT3407 and INT3532.
  * They are:
- * PMAX : Maximum platform powe
+ * PMAX : Maximum platform power
  * PSRC : Platform power source
  * ARTG : Adapter rating
  * CTYP : Charger type
- * PBSS : Battery steady power
  * PROP : Rest of worst case platform Power
  * PBSS : Power Battery Steady State
- * PBSS : Power Battery Steady State
  * RBHF : High Frequency Impedance
  * VBNL : Instantaneous No-Load Voltage
  * CMPP : Current Discharge Capability
-- 
2.17.1

