Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC59D5447E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiFIJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiFIJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:42:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71104488B0;
        Thu,  9 Jun 2022 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654767721; x=1686303721;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82EaOJdb4q3VlkGA9TJt8tLAW1WlT5f3xEFTSTdiiFc=;
  b=LhRJAX/I8a8Wb2MGlQtmUzhWOfJwVZmw1Lm5cYY7e7alFLcD0eLKNwXW
   X9xcSlLevY5CaNVE+OzT6Ao/J4ljM+0piWqtwjRsdbmHlkjHvAsFkuvqW
   oEl5CMEamfVDAnsK4dVVZaGD/6+ns90lAIwCmoTgvbjub/WjauPXNDDnP
   LzR9moZA1LvYCSTa7q6ovEigEEx7ai0vwgJ0ctimYygWw9ZY/0Lywklnh
   ij+6VH5Jkg2nsbiDQyxqe4TxlpF4qtioyOuKQUv+acUcB50QC3JAmBHuU
   vexU9R314mCABazEcXoxFZ9KvzqECtOCKKkKcglC9lXOzzXLNFi1mQaWy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="338986211"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="338986211"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 02:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683875465"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2022 02:41:57 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH v2 1/2] perf vendor events intel: Rename tremontx to snowridgex
Date:   Thu,  9 Jun 2022 17:42:21 +0800
Message-Id: <20220609094222.2030167-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Tremontx was an old name for Snowridgex, so rename Tremontx to Snowridgex.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
Change log:
  v2:
    * no change since v1.

 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 .../pmu-events/arch/x86/{tremontx => snowridgex}/cache.json     | 0
 .../arch/x86/{tremontx => snowridgex}/floating-point.json       | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json  | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/memory.json    | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/other.json     | 0
 .../pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json  | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-memory.json        | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-other.json         | 0
 .../arch/x86/{tremontx => snowridgex}/uncore-power.json         | 0
 .../arch/x86/{tremontx => snowridgex}/virtual-memory.json       | 0
 11 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/other.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-other.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/uncore-power.json (100%)
 rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/virtual-memory.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index f5a382421a60..9852bca98d59 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -40,7 +40,7 @@ GenuineIntel-6-8[CD],v1,tigerlake,core
 GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
-GenuineIntel-6-86,v1,tremontx,core
+GenuineIntel-6-86,v1,snowridgex,core
 GenuineIntel-6-96,v1,elkhartlake,core
 GenuineIntel-6-97,v1,alderlake,core
 GenuineIntel-6-9A,v1,alderlake,core
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/cache.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json b/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/frontend.json b/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/frontend.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/snowridgex/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/other.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/other.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
rename to tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
-- 
2.25.1

