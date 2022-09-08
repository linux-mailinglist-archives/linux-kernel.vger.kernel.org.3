Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D252D5B1236
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIHBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIHBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:52:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43FA99279;
        Wed,  7 Sep 2022 18:52:22 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MNMWG21cHznV2h;
        Thu,  8 Sep 2022 09:49:46 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:52:20 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:52:20 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf lock: Remove redundant word 'contention' in help message
Date:   Thu, 8 Sep 2022 09:48:54 +0800
Message-ID: <20220908014854.151203-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before:
  # perf lock -h

   Usage: perf lock [<options>] {record|report|script|info|contention|contention}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)
          --kallsyms <file>
                            kallsyms pathname
          --vmlinux <file>  vmlinux pathname

After:
  # perf lock -h

   Usage: perf lock [<options>] {record|report|script|info|contention}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)
          --kallsyms <file>
                            kallsyms pathname
          --vmlinux <file>  vmlinux pathname

Fixes: 528b9cab3b81 ("perf lock: Add 'contention' subcommand")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-lock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index dd11d3471baf..ea40ae52cd2c 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1874,8 +1874,7 @@ int cmd_lock(int argc, const char **argv)
 		NULL
 	};
 	const char *const lock_subcommands[] = { "record", "report", "script",
-						 "info", "contention",
-						 "contention", NULL };
+						 "info", "contention", NULL };
 	const char *lock_usage[] = {
 		NULL,
 		NULL
-- 
2.30.GIT

