Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA72F515187
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379491AbiD2RXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353856AbiD2RXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:23:11 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44E89084
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:19:47 -0700 (PDT)
X-QQ-mid: bizesmtp69t1651252771tiwj7d2n
Received: from localhost.localdomain ( [218.17.207.33])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 30 Apr 2022 01:19:23 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000000A0000000
X-QQ-FEAT: Nw/vDu2WDVBe46xp/lQfK5H1wHZk/IA0LX2WgfIshjKPF0PveIsObBibNE8X2
        klVO32IWTv60mUMmy4uPCqmcCpcArTjVULRzw0wpsOfMei4KI8xw1ZAHBjo5oEqABVzsmt1
        gPf1YvnnyCUgAFD6kXsCZZi8cJL2oWtQpXDrJa5hCGFnIjs+9o9qbdvNulGZE6rN9jozrgL
        m6+T0sULk5UICG0g8tdWtdcW8cPTH6+5aVjnAaqCNAkQSaHml6thMgMW+0bcMn5VCTzVPix
        Ff3ht8sndMWH3OXmb71lDehZYF0ibmPFRGo4PuFGcumyvTHiraiiAtOsdwHV6UbWvYP5bPG
        lHrBmzLRB6HphIiCSfKX6Tq2642QA==
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, akiyks@gmail.com, baihaowen@meizu.com,
        seakeel@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Yuhong Feng <yuhongf@szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and Describe details using table
Date:   Sat, 30 Apr 2022 01:18:44 +0800
Message-Id: <20220429171844.9673-1-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Co-developed-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Co-developed-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Co-developed-by: Chongxi Zhao <zhaochongxi2019@email.szu.edu.cn>
Co-developed-by: Jiajian Ye <yejiajian2018@email.szu.edu.cn>
Co-developed-by: Yuhong Feng <yuhongf@szu.edu.cn>
---
Hello Andrew,

In Commit 57f2b54a9379 ("Documentation/vm/page_owner.rst: update the
documentation") and Commit edc93abbcc6d ("tools/vm/page_owner_sort.c:
support sorting blocks by multiple keys"), some incorrect syntax
are used, which laeds to "build warning after merge of the mm tree".
Apologize for that!

This issue is trying to fix it.

Best,

	Shenghong Han
---
---
 Documentation/vm/page_owner.rst | 67 ++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 25622c715..f900ab99d 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -171,26 +171,47 @@ Usage
 
 STANDARD FORMAT SPECIFIERS
 ==========================
-::
-
-For --sort option:
-
-	KEY		LONG		DESCRIPTION
-	p		pid		process ID
-	tg		tgid		thread group ID
-	n		name		task command name
-	st		stacktrace	stack trace of the page allocation
-	T		txt		full text of block
-	ft		free_ts		timestamp of the page when it was released
-	at		alloc_ts	timestamp of the page when it was allocated
-        ator            allocator       memory allocator for pages
-
-For --curl option:
-
-	KEY		LONG		DESCRIPTION
-	p		pid		process ID
-	tg		tgid		thread group ID
-	n		name		task command name
-	f		free		whether the page has been released or not
-	st		stacktrace	stack trace of the page allocation
-        ator            allocator       memory allocator for pages
+
+1) `Table 1`_ for the ``--sort`` option.
+
+.. table:: Table 1
+   :name: Table 1
+
+   +--------+--------------+----------------------------------------------+
+   | KEY    | LONG         | DESCRIPTION                                  |
+   +========+==============+==============================================+
+   | p      | pid          | process ID                                   |
+   +--------+--------------+----------------------------------------------+
+   | tg     | tgid         | thread group ID                              |
+   +--------+--------------+----------------------------------------------+
+   | n      | name         | task command name                            |
+   +--------+--------------+----------------------------------------------+
+   | st     | stacktrace   | stack trace of the page allocation           |
+   +--------+--------------+----------------------------------------------+
+   | T      | txt          | full text of block                           |
+   +--------+--------------+----------------------------------------------+
+   | ft     | free_ts      | timestamp of the page when it was released   |
+   +--------+--------------+----------------------------------------------+
+   | at     | alloc_ts     | timestamp of the page when it was allocated  |
+   +--------+--------------+----------------------------------------------+
+   | ator   | allocator    | memory allocator for pages                   |
+   +--------+--------------+----------------------------------------------+
+
+2) `Table 2`_ for the ``--cull`` option.
+
+.. table:: Table 2
+   :name: Table 2
+
+   +--------+--------------+----------------------------------------------+
+   | KEY    | LONG         | DESCRIPTION                                  |
+   +========+==============+==============================================+
+   | p      | pid          | process ID                                   |
+   +--------+--------------+----------------------------------------------+
+   | tg     | tgid         | thread group ID                              |
+   +--------+--------------+----------------------------------------------+
+   | n      | name         | task command name                            |
+   +--------+--------------+----------------------------------------------+
+   | st     | stacktrace   | stack trace of the page allocation           |
+   +--------+--------------+----------------------------------------------+
+   | ator   | allocator    | memory allocator for pages                   |
+   +--------+--------------+----------------------------------------------+
-- 
2.30.1



