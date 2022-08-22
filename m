Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9959B7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiHVCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiHVCe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:34:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4056F24084
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661135665; x=1692671665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daaV3WZWukjbgGvbQ73mOCe8nI4eaN3LDyARuyKPkhs=;
  b=djx0SuOQZyvxJzHA0nfL06JEI/f0RAkArVfrht1reZgVZcduF/wvl0Cn
   ah4qmFwnsRj4QE9VPeiXLSYGsJjgEQjo7FSDddrBuqaxUUjyPKjNjOlxo
   zIFs89kZk/wFIF7j6XKn5vqubUQvi0Gjmibmp1v7rXIjFMm7MMMknK9LS
   2nIvHHmNjDj7SK8ENMUhylC7csLqOxaZW6y+vFUBskjNb3p6N/gtCIm2G
   bf+drfvdN42laTVu650MiK8msTqCxFcxWrgnosnkTNPIi0/qy4HjjzlgB
   GteUb0sXWjUSpTHc8rIFlEse2UHVeSEBxU8ongMNTU8z3uomj5DN++9Kd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357287547"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="357287547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 19:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="936851047"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2022 19:34:22 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] memblock test: Update TODO list
Date:   Mon, 22 Aug 2022 10:33:28 +0800
Message-Id: <20220822023332.127633-4-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822023332.127633-1-shaoqin.huang@intel.com>
References: <20220822023332.127633-1-shaoqin.huang@intel.com>
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

