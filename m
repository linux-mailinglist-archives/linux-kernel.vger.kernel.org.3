Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CDE59F214
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiHXDgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHXDgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:36:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B68786D1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:36:02 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCBXr6LNHzGpmB;
        Wed, 24 Aug 2022 11:34:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 11:36:00 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <bristot@kernel.org>, <mingo@redhat.com>, <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <zengheng4@huawei.com>
Subject: [PATCH 0/2] rv/monitors: fix sparse warning about lack of static qualifier
Date:   Wed, 24 Aug 2022 11:43:55 +0800
Message-ID: <20220824034357.2014202-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse tool complains about rv/monitors existing modules.

In order to prevent new modules from similar warning,
also modify the template files to avoid such warning.

Zeng Heng (2):
  rv/monitors: add 'static' qualifier for local symbols
  rv/dot2K: add 'static' qualifier for local variable

 kernel/trace/rv/monitors/wip/wip.c                      | 4 ++--
 kernel/trace/rv/monitors/wwnr/wwnr.c                    | 4 ++--
 tools/verification/dot2/dot2k_templates/main_global.c   | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_cpu.c  | 4 ++--
 tools/verification/dot2/dot2k_templates/main_per_task.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.25.1

