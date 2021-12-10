Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7870F47058A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbhLJQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:26:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:49130 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236537AbhLJQ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639153401; x=1670689401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9MT7IQgZLZ55QTcQWiHFVeiOFKkIV7zcBGZPmiBcW9w=;
  b=bS/pNtrmDd/4oh7DvLRRA35dQx8yIUtjaIsamPV0uq9dkSvNgi6Q2MRt
   rwk488eweKJ/mk3sly0YIl2bh9m4QABtuqsLb/BzXpBULNJpiTFUj+aYz
   J3VjF18S3qLHctrUwgXSkI8ZnaXsBY74s01pmb2YW8zasD18ciln4xh0m
   ddQTbi/smhYy+u3N3zjN2MYlFUJg0+jcZfkybrU9IUSvJsM/iiT6wOzYx
   gljt5LfZKrf5HUf9qzmdEgwkYYl+tS2AoKS4N5lTtweRCF+upZXbhLkgM
   0EWNxy6gb/FsaokEITMhMHGBeounSZDmp4QuBtsmCumoIxKIfTMyqHBrH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225647099"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="225647099"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="503981817"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 08:23:04 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] perf intel-pt: Fixes
Date:   Fri, 10 Dec 2021 18:22:56 +0200
Message-Id: <20211210162303.2288710-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are a few fairly small Intel PT fixes. Backports would be needed
to apply before v5.15, so the stable tags reflect that.


Adrian Hunter (7):
      perf intel-pt: Fix some PGE usage
      perf intel-pt: Fix sync state
      perf intel-pt: Fix intel_pt_fup_event() assumptions
      perf intel-pt: Fix overflow state
      perf intel-pt: Fix next 'err' value, walking trace
      perf intel-pt: Fix missing 'instruction' events with 'q' option
      perf intel-pt: Fix error timestamp

 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 85 ++++++++++++++--------
 tools/perf/util/intel-pt.c                         |  1 +
 2 files changed, 56 insertions(+), 30 deletions(-)


Regards
Adrian
