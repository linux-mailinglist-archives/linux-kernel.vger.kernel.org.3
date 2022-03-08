Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C54D1979
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiCHNpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347186AbiCHNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:45:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD4249937
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:44:04 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCc2m742gzdfrf;
        Tue,  8 Mar 2022 21:42:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Mar
 2022 21:44:02 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <vitaly.wool@konsulko.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/8] A few cleanup patches for z3fold
Date:   Tue, 8 Mar 2022 21:43:03 +0800
Message-ID: <20220308134311.59086-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi,
This series contains a few patches to simplify the code, remove unneeded
code, fix obsolete comment and so on. More details can be found in the
respective changelogs. Thanks!

---
v1->v2:
  collect Reviewed-by tag. Thanks Vitaly, Souptick and David for review
  drop mm/z3fold: remove unneeded return value of z3fold_compact_page()
  split the enhance of reducing atomic_ops overhead into separate patch
---

Miaohe Lin (8):
  mm/z3fold: declare z3fold_mount with __init
  mm/z3fold: remove obsolete comment in z3fold_alloc
  mm/z3fold: minor clean up for z3fold_free
  mm/z3fold: remove unneeded page_mapcount_reset and ClearPagePrivate
  mm/z3fold: remove confusing local variable l reassignment
  mm/z3fold: move decrement of pool->pages_nr into
    __release_z3fold_page()
  mm/z3fold: remove redundant list_del_init of zhdr->buddy in
    z3fold_free
  mm/z3fold: remove unneeded PAGE_HEADLESS check in free_handle()

 mm/z3fold.c | 64 ++++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

-- 
2.23.0

