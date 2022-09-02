Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222B25AA600
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiIBCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 22:40:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D2343E53
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662086436; x=1693622436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daaV3WZWukjbgGvbQ73mOCe8nI4eaN3LDyARuyKPkhs=;
  b=VHQJD0Tz2pLMubfFsHuVAmrpIk+oMH+hLcnmpeGrH6C2SsNjEzV1cpxt
   Ly7gi+6WSI8D+0HetcFAhv1PfDFcT8jWm8Gw6UEGoYm4ie2fep9Xph431
   yKDgcv4CCM9OIeYP/jmSdJawHuWeHohfWtcC7BqUAy78PU5QwDUcx3KWn
   KmdSVJ7m0JH69vp5ZvOR9J82r3nwj5PR4WmP6IwQSUPbW2i1Ja1ih7XHe
   3cUfFgvyk26ZKKaEyVTMwP9ilTjLoTPFQfFbbUGZr9PihAnFxh2EA17Ns
   z5EOWXpbuNiC9NAnPM8MCDHF19U00O08z/eFR6jHcR1CWA6xg3bzuUHg7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="359835286"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="359835286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589841478"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 19:40:35 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] memblock test: Update TODO list
Date:   Fri,  2 Sep 2022 10:40:01 +0800
Message-Id: <20220902024007.58041-4-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902024007.58041-1-shaoqin.huang@intel.com>
References: <20220902024007.58041-1-shaoqin.huang@intel.com>
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

