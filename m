Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8852F986
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 09:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbiEUHVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEUHVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 03:21:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065C4BFED;
        Sat, 21 May 2022 00:21:46 -0700 (PDT)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4w3Q4bZRzgY81;
        Sat, 21 May 2022 15:20:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 15:21:43 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 21 May
 2022 15:21:43 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v2 0/6] multiple cleanup patches for bfq
Date:   Sat, 21 May 2022 15:35:17 +0800
Message-ID: <20220521073523.3118246-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - add missing blank line in patch 1.
 - remove patch 7,8, since they are wrong.
 - add reviewed-by tag

There are no functional changes in this patchset, just some places
that I think can be improved during code review.

This patchset is rebased based on this patchset:
https://lore.kernel.org/all/20220428120837.3737765-1-yukuai3@huawei.com/

Previous version:
v1: https://lore.kernel.org/all/20220514090522.1669270-1-yukuai3@huawei.com/

Yu Kuai (6):
  block, bfq: cleanup bfq_weights_tree add/remove apis
  block, bfq: cleanup __bfq_weights_tree_remove()
  block, bfq: factor out code to update 'active_entities'
  block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
  block, bfq: cleanup bfq_activate_requeue_entity()
  block, bfq: remove dead code for updating 'rq_in_driver'

 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.c | 38 +++----------------
 block/bfq-iosched.h | 11 ++----
 block/bfq-wf2q.c    | 91 ++++++++++++++++++++-------------------------
 4 files changed, 51 insertions(+), 91 deletions(-)

-- 
2.31.1

