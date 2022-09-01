Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E665A9549
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiIALBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiIALBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:01:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C5116E2E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662030052; x=1693566052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVjFF2PrM6dAz3NWg11gPo9wUvf69s9ymJGLw6hFwC0=;
  b=D4Nl6jfQ/2tj719SZwMY5RFIf755hLoHuQoVjjiXcPEXU0goS4uM6qq2
   ZW9v47FVBUyLw9PqO6bY88FgrRoCFakMJ9qg30s2sRcyRqdpd34ov4gzg
   au4LQJ679lnNt+70rXgFe13v1bMDZ0Ohl1UcGxGmWXgs9Nm2nE1vaVoJs
   WyzeVTnHBpuEp09jNatBBNg0mo6EhPxGDfMCmxkQ5/BSWqWItaxW74XVe
   URym8LhvHpWJ/1TyMBuEvkiHV03MudAL3VxRFFqeSWTljx+0alx9ul2Q4
   bjmHcSyE142HVsIKey4fk0gI/JDbdw9z5mfh+geezV67RyzkocQSrPUdI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294424805"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="294424805"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673799651"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.42.13])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:00:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf intel-pt: Improve man page layout slightly
Date:   Thu,  1 Sep 2022 14:00:30 +0300
Message-Id: <20220901110032.9226-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901110032.9226-1-adrian.hunter@intel.com>
References: <20220901110032.9226-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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

Improve man page layout slightly by adding blank lines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 3dc3f0ccbd51..d5ddb968bcf4 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -943,12 +943,15 @@ event packets are recorded only if the "pwr_evt" config term was used.  Refer to
 the config terms section above.  The power events record information about
 C-state changes, whereas CBR is indicative of CPU frequency.  perf script
 "event,synth" fields display information like this:
+
 	cbr:  cbr: 22 freq: 2189 MHz (200%)
 	mwait:  hints: 0x60 extensions: 0x1
 	pwre:  hw: 0 cstate: 2 sub-cstate: 0
 	exstop:  ip: 1
 	pwrx:  deepest cstate: 2 last cstate: 2 wake reason: 0x4
+
 Where:
+
 	"cbr" includes the frequency and the percentage of maximum non-turbo
 	"mwait" shows mwait hints and extensions
 	"pwre" shows C-state transitions (to a C-state deeper than C0) and
@@ -956,6 +959,7 @@ Where:
 	"exstop" indicates execution stopped and whether the IP was recorded
 	exactly,
 	"pwrx" indicates return to C0
+
 For more details refer to the Intel 64 and IA-32 Architectures Software
 Developer Manuals.
 
@@ -969,8 +973,10 @@ are quite important.  Users must know if what they are seeing is a complete
 picture or not. The "e" option may be followed by flags which affect what errors
 will or will not be reported.  Each flag must be preceded by either '+' or '-'.
 The flags supported by Intel PT are:
+
 		-o	Suppress overflow errors
 		-l	Suppress trace data lost errors
+
 For example, for errors but not overflow or data lost errors:
 
 	--itrace=e-o-l
@@ -980,9 +986,11 @@ decoded packets and instructions.  Note that this option slows down the decoder
 and that the resulting file may be very large.  The "d" option may be followed
 by flags which affect what debug messages will or will not be logged. Each flag
 must be preceded by either '+' or '-'. The flags support by Intel PT are:
+
 		-a	Suppress logging of perf events
 		+a	Log all perf events
 		+o	Output to stdout instead of "intel_pt.log"
+
 By default, logged perf events are filtered by any specified time ranges, but
 flag +a overrides that.
 
-- 
2.25.1

