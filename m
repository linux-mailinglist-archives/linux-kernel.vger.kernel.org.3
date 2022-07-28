Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119A583E90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbiG1MUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiG1MUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:20:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46D9DD1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:20:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LtqRn5VSZzmVJh;
        Thu, 28 Jul 2022 20:18:13 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Jul
 2022 20:20:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/6] A few cleanup patches for hugetlb_cgroup
Date:   Thu, 28 Jul 2022 20:19:43 +0800
Message-ID: <20220728121949.20985-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few cleaup patches to remove unneeded header file,
use helper macro, remove unneeded return value and so on. More details
can be found in the respective changelogs.
Thanks!

Miaohe Lin (6):
  hugetlb_cgroup: remove unneeded nr_pages > 0 check
  hugetlb_cgroup: remove unneeded header file
  hugetlb_cgroup: hugetlbfs: use helper macro SZ_1{K,M,G}
  hugetlb_cgroup: remove unneeded return value
  hugetlb_cgroup: use helper macro NUMA_NO_NODE
  hugetlb_cgroup: use helper for_each_hstate and hstate_index

 include/linux/hugetlb_cgroup.h | 19 ++++++++-----------
 mm/hugetlb_cgroup.c            | 28 ++++++++++++----------------
 2 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.23.0

