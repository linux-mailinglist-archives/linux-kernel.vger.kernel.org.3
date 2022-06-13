Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1577054A097
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351370AbiFMU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352344AbiFMUyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:25 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1740EBC28
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sz+nf
        NuzmTuxAWdpxnGUivML8lc4W2sa69qotAWBC68=; b=TaY8MJTgTCcfzI3ZkpTFM
        oxuciPRCVace/WcUpPU4vPH61SIaIZdWjcLbY12EolRjR3hGBgFj28fQ4sm/ik2U
        kffJ68iXugbX6wuHrrdZdd27lvN/7A1319TA6E1q4YMhq95nGJxR3HJO4nfktMds
        bs2W+GTXCKNMJwQfFnh6cI=
Received: from localhost.localdomain (unknown [1.203.64.79])
        by smtp11 (Coremail) with SMTP id D8CowAAHBP50nKdirxuRHg--.24745S4;
        Tue, 14 Jun 2022 04:22:37 +0800 (CST)
From:   jingyuwang <jingyuwang_vip@163.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, vbabka@suse.cz, ahalaney@redhat.com,
        Jason@zx2c4.com, mark-pk.tsai@mediatek.com
Cc:     linux-kernel@vger.kernel.org, jingyuwang <jingyuwang_vip@163.com>
Subject: [PATCH] Fix the following checkpatch error:
Date:   Tue, 14 Jun 2022 04:22:10 +0800
Message-Id: <20220613202210.31759-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAHBP50nKdirxuRHg--.24745S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4UCFy8Jw4UAFy5JrW8WFg_yoW3GFc_G3
        Z3Xr18JanrCFW2kr1FvF48try8Xw18XFnrGrn7CFyUA3WxXw1rKws7Gr1ayryxWr1akr98
        X3W5AayYyr17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRpT5lPUUUUU==
X-Originating-IP: [1.203.64.79]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaQ0fF1XlyIsGKAAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./scripts/checkpatch.pl --no-tree -f init/main.c
ERROR: Use of const init definition must use __initconst
+static const char *initcall_level_names[] __initdata = {

Signed-off-by: jingyuwang <jingyuwang_vip@163.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 0ee39cdcfcac..dc6188a3dd4e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1336,7 +1336,7 @@ static initcall_entry_t *initcall_levels[] __initdata = {
 };
 
 /* Keep these in sync with initcalls in include/linux/init.h */
-static const char *initcall_level_names[] __initdata = {
+static const char *initcall_level_names[] __initconst = {
 	"pure",
 	"core",
 	"postcore",
-- 
2.34.1

