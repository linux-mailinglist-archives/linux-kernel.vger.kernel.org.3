Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674594E4B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiCWDNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCWDNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:13:51 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE87087C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:12:21 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 11:12:23 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 11:12:19 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>, <joel@joelfernandes.org>,
        <brauner@kernel.org>, <hridya@google.com>, <surenb@google.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH V2] android: binder: Fix duplicate included binder_trace.h
Date:   Wed, 23 Mar 2022 11:12:18 +0800
Message-ID: <1648005138-28311-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

drivers/android/binder.c: binder_trace.h is included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1 -> V2: modify title asm/pgtable.h -> binder_trace.h

 drivers/android/binder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c56..a12aa3c 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,7 +72,6 @@
 #include <linux/cacheflush.h>
 
 #include "binder_internal.h"
-#include "binder_trace.h"
 
 static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
-- 
2.7.4

