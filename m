Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650A6573672
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiGMMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:35:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9992AF513D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657715739; x=1689251739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zrwi5+PlBQRZ7EjUbEaz5wspoDTCKzGSSJEjKjtrEXo=;
  b=B+FlTPEUWP73imZ0umxPaFv44IUomirWWfh6X84es+qIzgJRoDcdmVLn
   jEdfUKsg0AnCiL1X5uYloT6Y05e6bAhcwZEktZ2ZjxVfvH5jM1ojnl9TH
   adFg4Uzw+xdFLcQj+wUD3ywiXSU03h8cJx8obKxYaka4i7AXl9bBEfT71
   8cMALC4nriLRExVOEQXbhKCzd78Pz2Y4ewbM9JAjqSCcyG/GRuuiOJR2e
   mrKo09NmZB5LkW/YshcpGhvFIbarUFzFgO6HDepfGzNQDXk+Dyh7xjCZp
   g5uU40WlVkvUct2T4frTSbLRXDDOgUZ5biiX5lgVul833wh8hl7nrg3Ld
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286332790"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286332790"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="592976910"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf tests: Fix Convert perf time to TSC test for hybrid
Date:   Wed, 13 Jul 2022 15:34:57 +0300
Message-Id: <20220713123459.24145-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a couple more minor non-urgent fixes.


Adrian Hunter (2):
      perf tests: Stop Convert perf time to TSC test opening events twice
      perf tests: Fix Convert perf time to TSC test for hybrid

 tools/perf/tests/perf-time-to-tsc.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)


Regards
Adrian
