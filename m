Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B60C497A74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiAXImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242231AbiAXImJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013729; x=1674549729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pl2pkrdOQVTwaNmjqrWzlum3YSqpF2TAphbkwz+JXjY=;
  b=Bt0N+8dSuxjxikn09TKXmC4yMFjWsFspzeJqsaFEqECz2XiMqhvlbHyE
   C+iXn5i6qQ8Z5uhc0Kw/EOGUIbSgtjviQ3rn0J/v9a8SRTBUg/vywXido
   BKhLpTog1+LQUFZvhf8Uiu3/oHfbCWc0EqxOy4No1nRfW/Mi20mz6oi9H
   U2S+Db8HZcrkmMpv3Pua5owIg/GnELZTjw/OvPn7n4S5Lmy39AuTo21BS
   TryiU27G/v+CDSW3Cd5BaBFNLKl6ROnmrLkC6GF12bJB9htChLsGbjFZR
   U7YMFJ5HodQhu1iybUrZoHefjFbj3q0KNSMelwxcDWRyZAzJJG0vHWxtj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778325"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627416947"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:07 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] perf intel-pt: pkt-decoder: Remove misplaced linebreak
Date:   Mon, 24 Jan 2022 10:41:38 +0200
Message-Id: <20220124084201.2699795-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor whitespace fix up.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 4bd154848cad..fada96746705 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -197,8 +197,7 @@ static int intel_pt_get_mnt(const unsigned char *buf, size_t len,
 		return INTEL_PT_NEED_MORE_BYTES;
 	packet->type = INTEL_PT_MNT;
 	memcpy_le64(&packet->payload, buf + 3, 8);
-	return 11
-;
+	return 11;
 }
 
 static int intel_pt_get_3byte(const unsigned char *buf, size_t len,
-- 
2.25.1

