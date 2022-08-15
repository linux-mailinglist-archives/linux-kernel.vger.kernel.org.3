Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAC593100
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiHOOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiHOOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:48:40 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1366541
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:48:37 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 69FC65FD05;
        Mon, 15 Aug 2022 17:48:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660574915;
        bh=fTVbo8biG7sagxQxaFW0jpkwmxdEcRz9srcTt3ybBJE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kgtAkTBY/c7/rqoBjU5vu/lMDwMdE5ot01WRmbuIayP8EdW5kYP3gPEMSUukBFapA
         QwDsTmBIJRefSkovgxw1yeGsLAdOpTHxnJ4z7HQ5GIZjRTYfqDv5rYkUKVvrUjHJLW
         R6b34KWhJDDassMkwYoEU0zjYp37wcKbXgsvDITSPQe/ezsAOb0BcAB7SFBJPQrH32
         5iNH3aCVCPyy6n0YWUo6GQo59QBbb1HgZ/YsOSFGGuQ9Nb77bG7PjAEOWhGXO2XD7+
         m8NxKjE35Lc1AMDji50N33QpPvmOhHv+ug+6n/D0FRmmPee5WgzE4JrZrYg+Q/oJJz
         wwcsT5YAEaT5Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 17:48:33 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1] zsmalloc: zs_object_copy: replace email link to doc
Date:   Mon, 15 Aug 2022 17:48:25 +0300
Message-ID: <20220815144825.39001-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 12:17:00 #20121227
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails are not documentation.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 99d93a48cbe0..17641bde5432 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1559,8 +1559,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
          * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
          * calls must occurs in reverse order of calls to kmap_atomic().
          * So, to call kunmap_atomic(s_addr) we should first call
-         * kunmap_atomic(d_addr).  For more details see
-         * https://lore.kernel.org/linux-mm/5512421D.4000603@samsung.com/
+         * kunmap_atomic(d_addr). For more details see
+         * Documentation/mm/highmem
          */
         if (s_off >= PAGE_SIZE) {
             kunmap_atomic(d_addr);
-- 
2.25.1
