Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA750F1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbiDZHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbiDZHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:10:53 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589E538198;
        Tue, 26 Apr 2022 00:07:17 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 Apr
 2022 15:07:15 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 26 Apr
 2022 15:07:15 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <corbet@lwn.net>, <alexs@kernel.org>, <siyanteng01@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <siyanteng@loongson.cn>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
Date:   Tue, 26 Apr 2022 15:07:09 +0800
Message-ID: <1650956829-31013-3-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650956829-31013-1-git-send-email-baihaowen@meizu.com>
References: <1650956829-31013-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After make htmldocs, the table which is made of tab will
display all by one line. so we make a standard table for STANDARD
FORMAT SPECIFIERS description.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 Documentation/vm/page_owner.rst | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 422d5fa99e84..a8505e3a3044 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -174,22 +174,28 @@ STANDARD FORMAT SPECIFIERS
 
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
-- 
2.7.4

