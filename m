Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B8505AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbiDRPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbiDRPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BDDB89B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:12:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhplN2TQmzfYx0;
        Mon, 18 Apr 2022 22:11:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 22:12:26 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <pintu@codeaurora.org>,
        <charante@codeaurora.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 00/12] A few cleanup and fixup patches for compaction
Date:   Mon, 18 Apr 2022 22:12:41 +0800
Message-ID: <20220418141253.24298-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few patches to clean up some obsolete comment,
remove unneeded return value and so on. Also we fix the possible NULL
pointer dereference. More details can be found in the respective
changelogs. Thanks!

Miaohe Lin (12):
  mm: compaction: remove unneeded return value of kcompactd_run
  mm: compaction: remove unneeded pfn update
  mm: compaction: remove unneeded assignment to isolate_start_pfn
  mm: compaction: clean up comment for sched contention
  mm: compaction: clean up comment about suitable migration target
    recheck
  mm: compaction: use COMPACT_CLUSTER_MAX in compaction.c
  mm: compaction: use helper compound_nr in isolate_migratepages_block
  mm: compaction: clean up comment about async compaction in
    isolate_migratepages
  mm: compaction: avoid possible NULL pointer dereference in
    kcompactd_cpu_online
  mm: compaction: make compaction_zonelist_suitable return false when
    COMPACT_SUCCESS
  mm: compaction: simplify the code in __compact_finished
  mm: compaction: make sure highest is above the min_pfn

 include/linux/compaction.h |  5 +--
 mm/compaction.c            | 87 ++++++++++++++------------------------
 mm/internal.h              |  2 +-
 3 files changed, 34 insertions(+), 60 deletions(-)

-- 
2.23.0

