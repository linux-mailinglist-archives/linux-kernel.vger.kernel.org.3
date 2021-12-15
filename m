Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCD475415
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhLOIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:08:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:41309 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240718AbhLOIIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639555696; x=1671091696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0EmnQdKzHYYleosSR73R3znjQB6l1duIBaYw3sMSig8=;
  b=Ua+5kw1UiD+5r1n7+EXq7UJu2Fc3t2JFFH1XWCrG7ZqBuzdcxZRyVU2z
   QLDIj7ww4iLsvLK2anQFDuoc+dW4Wa1cmfnpXwIoOpyFHK4omcvdpB2rg
   /nRcJYIBepdMS3nR9apXZc+0hd+w4nt916tpo5nEJ2W8ex2GgPClRVhK/
   cBGYI/sZHG05WhLegL+OZbSGpDIikqSzG9nD2fD5+DOxO244XMKgqjisM
   H2srq9P7dxmQVI2+a8uZ8jdtlPnOsRnQk2uBBjPOmlFGXhzxxyJUZfvdS
   q++//rTT7pDogv+ceExOSi2oe3B5u6Z+Gy0+rJk3WuQuHqmzr9Ah6VYpt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="302550159"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="302550159"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 00:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505699354"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 00:06:37 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/3] perf intel-pt: 3 more small fixes
Date:   Wed, 15 Dec 2021 10:06:33 +0200
Message-Id: <20211215080636.149562-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 3 more small fixes.


Adrian Hunter (3):
      perf intel-pt: Fix parsing of VM time correlation arguments
      perf script: Fix CPU filtering of a script's switch events
      perf scripts python: intel-pt-events.py: Fix printing of switch events

 tools/perf/builtin-script.c                  |  2 +-
 tools/perf/scripts/python/intel-pt-events.py | 23 +++++++++++++----------
 tools/perf/util/intel-pt.c                   |  1 +
 3 files changed, 15 insertions(+), 11 deletions(-)


Regards
Adrian
