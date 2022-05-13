Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155C525E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378495AbiEMIpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345309AbiEMIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:45:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB202AACCF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652431512; x=1683967512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CT68I4ewIkuqVWmT6KOtSkTaikEh+Pzc19BSxGCw9Xs=;
  b=RhwXaw60kf7W3Cqz/u8VzTiqiYRTYX6oqUuXZ1TSNMGa1bFZh7fbf+QJ
   M0UGdYJ4Rr50E3PbDStpC9TNs3YCxf65IA7yRK/4FqhHArpkpIdVPAkBm
   IXwYdg30UsW2Bxq+9WrOB3EFeS7eC1+HT83+dSq5SoP89vOhfu+CZ3qJt
   VHM3JHV2OzmkpVALRTkzhOZELZbgvE5iE0KvHjAahLdVFX97HnRYxGHKM
   zNu8UmLGuYtHljcLk/yoCk/gWYnlNQsFNW5/qkeCIwZ+QLHSdQjSAaKvY
   7qsGkUMBEbJFLwUdgQcuLPiPug5w8u3N2N+a7nl8rTRDngVFEZVvRLLo9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333289060"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="333289060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="712312527"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.36.190])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:45:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Remove unused machines__find_host()
Date:   Fri, 13 May 2022 11:44:59 +0300
Message-Id: <20220513084459.6581-1-adrian.hunter@intel.com>
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

machines__find_host() does not exist. Remove declaration.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 0023165422aa..2b9fb34a38ca 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -162,7 +162,6 @@ void machines__process_guests(struct machines *machines,
 
 struct machine *machines__add(struct machines *machines, pid_t pid,
 			      const char *root_dir);
-struct machine *machines__find_host(struct machines *machines);
 struct machine *machines__find(struct machines *machines, pid_t pid);
 struct machine *machines__findnew(struct machines *machines, pid_t pid);
 struct machine *machines__find_guest(struct machines *machines, pid_t pid);
-- 
2.25.1

