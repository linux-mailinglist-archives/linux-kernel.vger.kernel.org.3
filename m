Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B451405C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354062AbiD2Bwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiD2Bwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:52:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0411BB09D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:49:27 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KqFlP2fwwzQjCy;
        Fri, 29 Apr 2022 09:49:05 +0800 (CST)
Received: from huawei.com (10.67.174.96) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 09:49:26 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <chris.zjh@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] vt: defkeymap.c_shipped remove unused variables
Date:   Fri, 29 Apr 2022 09:48:14 +0800
Message-ID: <20220429014814.988829-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.96]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variables 'funcbufptr' 'funcbufsize' and 'funcbufleft' have
been initialized but not used, they are redundant and remove them.

--------

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/tty/vt/defkeymap.c_shipped | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index 094d95bf0005..80dee50bcb7a 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -185,10 +185,6 @@ char func_buf[] = {
 	'\033', '[', 'P', 0, 
 };
 
-char *funcbufptr = func_buf;
-int funcbufsize = sizeof(func_buf);
-int funcbufleft = 0;          /* space left */
-
 char *func_table[MAX_NR_FUNC] = {
 	func_buf + 0,
 	func_buf + 5,
-- 
2.31.0

