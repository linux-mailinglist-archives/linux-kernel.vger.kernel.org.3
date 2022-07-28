Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B005583E38
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiG1MBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbiG1MBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:01:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F71691E2;
        Thu, 28 Jul 2022 05:01:42 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ltq1J2w9SzjXZQ;
        Thu, 28 Jul 2022 19:58:44 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:39 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:38 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [PATCH 0/5] perf kwork: A couple of fixes according to review comments
Date:   Thu, 28 Jul 2022 19:58:49 +0800
Message-ID: <20220728115854.80399-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some issues are fixed based on the comments of several reviewers:
1. Add '--synth task' option for record (note from Namhyung)
2. Replace hard-coded initialization of nr_tracepoints with ARRAY_SIZE macro (note from Namhyung)
3. Fix spelling mistake: "PRINT_TIME_UNIT_MESC_WIDTH" -> "PRINT_TIME_UNIT_MSEC_WIDTH" (note from Namhyung)
4. Fix spelling mistake: "Captuer" -> "Capture" (note from Colin)
5. Add some {} for multiline for/if blocks (note from Arnaldo)

Modifying based on the latest commit (a061a8ad3f90) at acme/perf/core:
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

Yang Jihong (5):
  perf kwork: Add '--synth task' option for record
  perf kwork: Replace hard-coded initialization of nr_tracepoints with
    ARRAY_SIZE macro
  perf kwork: Fix spelling mistake: "Captuer" -> "Capture"
  perf kwork: Fix spelling mistake: "PRINT_TIME_UNIT_MESC_WIDTH" ->
    "PRINT_TIME_UNIT_MSEC_WIDTH"
  perf kwork: Add some {} for multiline for/if blocks

 tools/perf/builtin-kwork.c | 65 ++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 27 deletions(-)

-- 
2.30.GIT

