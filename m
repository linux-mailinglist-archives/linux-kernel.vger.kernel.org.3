Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697E5AF9CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIGCVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGCVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:21:49 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ADA8C00A;
        Tue,  6 Sep 2022 19:21:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VOvC7Cs_1662517303;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VOvC7Cs_1662517303)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 10:21:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] [SCSI] mpt fusion: remove unreachable code
Date:   Wed,  7 Sep 2022 10:18:13 +0800
Message-Id: <20220907021813.85650-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function mptctl_do_fw_download cannot execute return 0, delete the
invalid code.

drivers/message/fusion/mptctl.c:978 mptctl_do_fw_download() warn: ignoring unreachable code.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2086
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/message/fusion/mptctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 52c7020c9d19..72affe00dcec 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -975,7 +975,6 @@ mptctl_do_fw_download(MPT_ADAPTER *iocp, char __user *ufwbuf, size_t fwlen)
 		printk(MYIOC_s_WARN_FMT "(bad VooDoo)\n", iocp->name);
 		return -ENOMSG;
 	}
-	return 0;
 
 fwdl_out:
 
-- 
2.19.1.6.gb485710b

