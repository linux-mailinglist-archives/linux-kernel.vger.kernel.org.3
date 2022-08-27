Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA055A38C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiH0QjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiH0QjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:39:03 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785C3DBD5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:39:02 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661618334tqngeig9
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 28 Aug 2022 00:38:49 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: 6PjtIMncaiylZqezYaqQpiMOUK9GQBlyMKovMYCLnlaQp+x70+WttUwEw69f/
        vzLjZfJDUHY5w0q46YXwq2gGSyPA4WXv3F5fQgf5XTs2bicD3sQu43L3snbQ6ggqRZc5R4Y
        B53roUyaV8L9pgSqvOJkF9M7ej0A8HjbazW46aovidb+8WdirUqHOact+3T4UbBlcvoW7sA
        KbyhPksbjFn53y6H1xA3YdPjhCMIeKEnJK5rIR3W0JnkD0CWyJjs10tay9TSF4p90f4Evvs
        DgCpEyIkKL1AQSdFaMK1t/mVxe3QpZvgIikrpfre7Vow7KE0GyrefoawVfVhus/MuXZPQjE
        xK8GSpgstO/Y1oyWV9a9PAFS/PEcdtvEUCVHuo8OiUUxkS9sNk=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] dm: Remove the unneeeded variable
Date:   Sat, 27 Aug 2022 12:38:48 -0400
Message-Id: <20220827163848.24296-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable "sz" is unneeded, return 0 will be okay.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/md/dm-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index 0c6620e7b7bf..a4955eb96d6f 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -805,7 +805,6 @@ static int core_status(struct dm_dirty_log *log, status_type_t status,
 static int disk_status(struct dm_dirty_log *log, status_type_t status,
 		       char *result, unsigned int maxlen)
 {
-	int sz = 0;
 	struct log_c *lc = log->context;
 
 	switch(status) {
@@ -828,7 +827,7 @@ static int disk_status(struct dm_dirty_log *log, status_type_t status,
 		break;
 	}
 
-	return sz;
+	return 0;
 }
 
 static struct dm_dirty_log_type _core_type = {
-- 
2.35.1

