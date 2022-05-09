Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4401251FDDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiEINSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiEINSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F402A8058
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxhSS3sMYzhYwJ;
        Mon,  9 May 2022 21:13:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:13:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 00/15] A few cleanup patches for swap
Date:   Mon, 9 May 2022 21:14:01 +0800
Message-ID: <20220509131416.17553-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few patches to fix the comment, remove unneeded
return value, use some helpers and so on. More details can be found in
the respective changelogs. Thanks!

Miaohe Lin (15):
  mm/swap: use helper is_swap_pte() in swap_vma_readahead
  mm/swap: use helper macro __ATTR_RW
  mm/swap: fold __swap_info_get() into its sole caller
  mm/swap: remove unneeded return value of free_swap_slot
  mm/swap: print bad swap offset entry in get_swap_device
  mm/swap: remove buggy cache->nr check in refill_swap_slots_cache
  mm/swap: remove unneeded p != NULL check in __swap_duplicate
  mm/swap: make page_swapcount and __lru_add_drain_all
  mm/swap: avoid calling swp_swap_info when try to check
    SWP_STABLE_WRITES
  mm/swap: break the loop if matching device is found
  mm/swap: add helper swap_offset_available()
  mm/swap: fix the obsolete comment for SWP_TYPE_SHIFT
  mm/swap: clean up the comment of find_next_to_unuse
  mm/swap: fix the comment of get_kernel_pages
  mm/swap: fix comment about swap extent

 include/linux/swap.h       | 11 +----
 include/linux/swap_slots.h |  2 +-
 include/linux/swapops.h    |  4 +-
 mm/memory.c                |  2 +-
 mm/swap.c                  |  6 +--
 mm/swap_slots.c            |  6 +--
 mm/swap_state.c            |  8 +---
 mm/swapfile.c              | 86 ++++++++++++++++----------------------
 8 files changed, 50 insertions(+), 75 deletions(-)

-- 
2.23.0

