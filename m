Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD2472335
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhLMItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:49:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:36716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhLMIs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639385338; x=1670921338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1ln/cN5HQ1skeqqkXir4zy+WxBvzDn8aRxQxDOrZLm4=;
  b=Mi2XtnCNlvgSOHOOIuS2jSKxfIqsOLEVkeH5ZVnO1j79jREVGQI7VrNI
   btSWbGes7N3ZFGTvBG8blONgXVlB4s+0cDTmbMdb0pXJg12i7Xi6kQyHE
   ryuuNEuD1LesAMs05bVlx8hoqd9PV88ZEOvTJKruj4F5fh17NgdvjUwtF
   ncy8z/0IxjuYfmPS7PWYd989F9r6RFJB1prAX960xpoINzMLrBrxwW0S7
   xVue+l7UypLBWakEWPmFjUbfH5qU3j5hRWsW8RoCeeCEsfvODRzmMQFen
   9GtVSq6LoWioIpPFeoYd+Nk80KJ8rDDTcqMtF92HJgNcL1rUzMoOsiTtK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="236219300"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="236219300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="463308444"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 00:48:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/2] perf inject: Fix segfaults relating to in-place update
Date:   Mon, 13 Dec 2021 10:48:27 +0200
Message-Id: <20211213084829.114772-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 2 fixes to perf inject relating to in-place update.


Adrian Hunter (2):
      perf inject: Fix segfault due to close without open
      perf inject: Fix segfault due to perf_data__fd() without open

 tools/perf/builtin-inject.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)


Regards
Adrian
