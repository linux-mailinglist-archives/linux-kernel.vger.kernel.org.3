Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7983B515391
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379774AbiD2SYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiD2SXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:23:49 -0400
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572BBCAA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:20:25 -0700 (PDT)
X-QQ-mid: bizesmtp75t1651256417t3pqy8m5
Received: from localhost.localdomain ( [218.17.40.143])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 30 Apr 2022 02:20:04 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000000
X-QQ-FEAT: 0VgNaGdhy9jE04pHOl41aWOCkkXpoW1RGwsj334NJGltLwKEyscE54hJ1uadd
        zva35/4EUP37SZNbdfBrJdLzzNQi+sut1lyd0iriTsCciDOKUljbx55r96+Ecx65dr7BdLA
        1wMg472tpLtIQj0tYismmZ99wUq2UrhIg5jGpo2RFfhJi3pE3nIZEVyjucdGO9IFnqZKA00
        zrXtgzSlfdB99y3rWLP4wiahTaLUSIPrLTFCeIFqUx8DmK3C27T8lKAzLhijJ4bpOVP6x/I
        BgvbY8XOdrIChCinjC5KXqEf8QAfKMptg9B0hEV/+JwC2huyFebd5InYriuwOhZINCEK+Hq
        OdkAnVz5sP8BkrM6Uw=
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, akiyks@gmail.com, baihaowen@meizu.com,
        seakeel@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, caoyixuan2019@email.szu.edu.cn,
        yejiajian2018@email.szu.edu.cn, yuhongf@szu.edu.cn,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and Describe details using table
Date:   Sat, 30 Apr 2022 02:19:26 +0800
Message-Id: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some syntax errors exist in "page_owner.rst". Thanks to Akira Yokosawa and
Haowen Bai for tips to help improve the documentation.

We try to fix them. Hope that the Documentation is showed as we expect.

Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Fixes: edc93abbcc6d ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")

---
Thanks Jonathan's suggestion.

This fix is a simpler than before.
And yes, It has built in my machine.

Best,

	Shenghong Han
---
---
 Documentation/vm/page_owner.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 25622c715..0ecb4a739 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -171,11 +171,12 @@ Usage
 
 STANDARD FORMAT SPECIFIERS
 ==========================
-::
 
-For --sort option:
+1) For --sort option.
 
+	====		==========	===========
 	KEY		LONG		DESCRIPTION
+	====		==========	===========
 	p		pid		process ID
 	tg		tgid		thread group ID
 	n		name		task command name
@@ -183,14 +184,18 @@ For --sort option:
 	T		txt		full text of block
 	ft		free_ts		timestamp of the page when it was released
 	at		alloc_ts	timestamp of the page when it was allocated
-        ator            allocator       memory allocator for pages
+	ator		allocator	memory allocator for pages
+	====		==========	===========
 
-For --curl option:
+2) For --curl option.
 
+	====		==========	===========
 	KEY		LONG		DESCRIPTION
+	====		==========	===========
 	p		pid		process ID
 	tg		tgid		thread group ID
 	n		name		task command name
 	f		free		whether the page has been released or not
 	st		stacktrace	stack trace of the page allocation
-        ator            allocator       memory allocator for pages
+	ator		allocator	memory allocator for pages
+	====		==========	===========
-- 
2.30.1



