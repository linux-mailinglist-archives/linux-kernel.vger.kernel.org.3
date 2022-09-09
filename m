Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B35B2DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIIEqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIIEpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:45:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF025F7D7;
        Thu,  8 Sep 2022 21:45:46 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MP3Jr2SvCznVCt;
        Fri,  9 Sep 2022 12:43:08 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 12:45:43 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <atrajeev@linux.vnet.ibm.com>, <eranian@google.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] perf sort: remove hist_entry__sort_list and sort__first_dimension declaration
Date:   Fri, 9 Sep 2022 12:45:41 +0800
Message-ID: <20220909044542.1087870-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
References: <20220909044542.1087870-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hist_entry__sort_list and sort__first_dimension have been removed
since commit cfaa154b2335 ("perf tools: Get rid of obsolete
hist_entry__sort_list"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 tools/perf/util/sort.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2ddc00d1c464..af14eb46c2b6 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -34,7 +34,6 @@ extern struct sort_entry sort_dso_to;
 extern struct sort_entry sort_sym_from;
 extern struct sort_entry sort_sym_to;
 extern struct sort_entry sort_srcline;
-extern enum sort_type sort__first_dimension;
 extern const char default_mem_sort_order[];
 
 struct res_sample {
@@ -295,7 +294,6 @@ struct block_hist {
 };
 
 extern struct sort_entry sort_thread;
-extern struct list_head hist_entry__sort_list;
 
 struct evlist;
 struct tep_handle;
-- 
2.25.1

