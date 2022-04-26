Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352AA50F1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbiDZHLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbiDZHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:10:53 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3738196;
        Tue, 26 Apr 2022 00:07:17 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 15:07:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 15:07:15 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <corbet@lwn.net>, <alexs@kernel.org>, <siyanteng01@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <siyanteng@loongson.cn>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH 0/2] sync with original text Documentation/vm/page_owner.rst
Date:   Tue, 26 Apr 2022 15:07:07 +0800
Message-ID: <1650956829-31013-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series will sync the translation of zh_CN as below:

Commit 8bd16bc0a081 ("tools/vm/page_owner_sort.c: support sorting blocks
by multiple keys") add sorting blocks by multiple keys usage
description.

Commit 78a0b94f3829 ("tools/vm/page_owner_sort.c: support for multi-value
selection in single argument") add multi-value selection in single
argument usage description.

Commit c89b3ad2dea2 ("doc/vm/page_owner.rst: remove content related to -c
option") remove  -c option usage description.

Commit 9c8a0a8e599f ("tools/vm/page_owner_sort.c: support for user-defined
culling rules") add user-defined culling rules usage description.

Commit 8ea8613a616a ("tools/vm/page_owner_sort.c: support for selecting by
PID, TGID or task command name") add selecting by PID, TGID or task
command name usage description.

Commit 194d52d771b8 ("tools/vm/page_owner_sort: support for sorting by
task command name") add sorting by task command name usage description.

But the original text table which is made of tab will display all
by one line. so we make a standard table for STANDARD FORMAT SPECIFIERS
description. I fix it up togeter by this patches series.


Haowen Bai (2):
  docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
  doc/vm/page_owner.rst: Fix table display confusion

 Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
 Documentation/vm/page_owner.rst                    | 34 +++++++-----
 2 files changed, 80 insertions(+), 15 deletions(-)

-- 
2.7.4

