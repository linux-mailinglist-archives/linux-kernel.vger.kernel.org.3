Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B864350FF11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiDZNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244037AbiDZNf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:35:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1E2DA96
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650979936; x=1682515936;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FU1VqHgCJofONW3qn+17xPIcVJ4K0V9AF2vcRUU6CZ4=;
  b=e/d1+tJV2EAyYJQ+xK5qxLYR66L+4bPNQMr2WNDBN1eVGFDUirLULWDx
   42UpPbu8/VXBw/hR6RC2FDh7W6U3mUtBqwI4JaT8+zQ8dFHvuojxmYOL3
   YWrTu8M+mnbrQic+heP2ANfLyhNBjkfin5PUavHAkx2NxudlIEA8uq/Tc
   WzjXVaFWoWajBe4//tJ1f4afECClEHVU9KQTISRufTWGivBEgEJfaQ9Hv
   qt0sdEGfC3epLq9vdluSroFFlcngUN/mhsS1BkLyzBitOkvqpBsvYAIjK
   /fSg7dmzfKB9DM+ucgw4WZ9gQn+YFz0zuRolfS2viJ67njUV1ZvfVsoey
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="246140439"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="246140439"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="705054110"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2022 06:32:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf intel-pt: Add link to the perf wiki's Intel PT page
Date:   Tue, 26 Apr 2022 16:32:13 +0300
Message-Id: <20220426133213.248475-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an EXAMPLE section and link to the perf wiki's Intel PT page.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index ff58bd4c381b..92532d0d3618 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1471,6 +1471,13 @@ In that case the --itrace q option is forced because walking executable code
 to reconstruct the control flow is not possible.
 
 
+EXAMPLE
+-------
+
+Examples can be found on perf wiki page "Perf tools support for Intel® Processor Trace":
+
+https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
+
 
 SEE ALSO
 --------
-- 
2.25.1

