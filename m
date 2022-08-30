Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70585A5907
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiH3Bvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiH3Bv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:51:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA6A74D9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661824285; x=1693360285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daaV3WZWukjbgGvbQ73mOCe8nI4eaN3LDyARuyKPkhs=;
  b=j8F+97IQs6V5MXdm25G0kux5PlHq9exmfe9aIXOwaLflFeKBPHDNl3G+
   mb7Q/DaBt7YQjBCPz9RuKOQQ3Rm7Aje5Xmw9yuFwqZySnM6lTIvGJtgnJ
   eCFJsmGm6fhf/S6jxTrgrX6vPL90jx2TrjuHbpRlCuxxmSqSmk7RhnVTn
   gpvwr7BEu/x14nmrZo7isAFOG+i9cdpdCiuME2Qkn36jeMDPM/9qrwgFG
   eTqxOF0r34gjDDWYsgFHspCisVH9zsWZ5Nh08KMvDkacT0mG7IOAa3uCq
   9tohSjThk2emUBymI5c++mr8ByYtm1y/a/DgRXF+6v/cdfmgFCcZ5d8UU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296330195"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="296330195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641167077"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 18:51:16 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] memblock test: Update TODO list
Date:   Tue, 30 Aug 2022 09:49:19 +0800
Message-Id: <20220830014925.162718-4-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830014925.162718-1-shaoqin.huang@intel.com>
References: <20220830014925.162718-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Remove the completed items from TODO list.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 tools/testing/memblock/TODO | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index 33044c634ea7..503cc96fcdc3 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -1,17 +1,10 @@
 TODO
 =====
 
-1. Add tests trying to memblock_add() or memblock_reserve() 129th region.
-   This will trigger memblock_double_array(), make sure it succeeds.
-   *Important:* These tests require valid memory ranges, use dummy physical
-                memory block from common.c to implement them. It is also very
-                likely that the current MEM_SIZE won't be enough for these
-                test cases. Use realloc to adjust the size accordingly.
-
-2. Add test cases using this functions (implement them for both directions):
+1. Add test cases using this functions (implement them for both directions):
    + memblock_alloc_raw()
    + memblock_alloc_exact_nid_raw()
    + memblock_alloc_try_nid_raw()
 
-3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+2. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.34.1

