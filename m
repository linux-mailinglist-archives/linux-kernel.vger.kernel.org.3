Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA29506289
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbiDSDUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDSDUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:20:49 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E3383;
        Mon, 18 Apr 2022 20:18:06 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 19 Apr
 2022 11:17:59 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 19 Apr
 2022 11:17:57 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <corbet@lwn.net>, <akpm@linux-foundation.org>
CC:     <yejiajian2018@email.szu.edu.cn>, <sfr@canb.auug.org.au>,
        <caoyixuan2019@email.szu.edu.cn>, <skhan@linuxfoundation.org>,
        <georgi.djakov@linaro.org>, <weizhenliang@huawei.com>,
        <hanshenghong2019@email.szu.edu.cn>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] doc/vm/page_owner.rst: Fix table display confusion
Date:   Tue, 19 Apr 2022 11:17:56 +0800
Message-ID: <1650338276-13687-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After make htmldocs, the table which is made of tab will
display all by line. so we make a standard table for STANDARD
FORMAT SPECIFIERS description.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 Documentation/vm/page_owner.rst | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 422d5fa99e84..9123e55669df 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -174,22 +174,29 @@ STANDARD FORMAT SPECIFIERS
 
 For --sort option:
 
-	KEY		LONG		DESCRIPTION
-	p		pid		process ID
-	tg		tgid		thread group ID
-	n		name		task command name
-	st		stacktrace	stack trace of the page allocation
-	T		txt		full text of block
-	ft		free_ts		timestamp of the page when it was released
-	at		alloc_ts	timestamp of the page when it was allocated
+        ====            ==========      ============================================
+        KEY             LONG            DESCRIPTION
+        ====            ==========      ============================================
+        p               pid             process ID
+        tg              tgid            thread group ID
+        n               name            task command name
+        st              stacktrace      stack trace of the page allocation
+        T               txt             full text of block
+        ft              free_ts         timestamp of the page when it was released
+        at              alloc_ts        timestamp of the page when it was allocated
         ator            allocator       memory allocator for pages
+        ====            ==========      ============================================
 
 For --curl option:
 
-	KEY		LONG		DESCRIPTION
-	p		pid		process ID
-	tg		tgid		thread group ID
-	n		name		task command name
-	f		free		whether the page has been released or not
-	st		stacktrace	stack trace of the page allocation
+        ====            ===========     ============================================
+        KEY             LONG            DESCRIPTION
+        ====            ===========     ============================================
+        p               pid             process ID
+        tg              tgid            thread group ID
+        n               name            task command name
+        f               free            whether the page has been released or not
+        st              stacktrace      stack trace of the page allocation
         ator            allocator       memory allocator for pages
+        ====            ===========     ============================================
+
-- 
2.7.4

