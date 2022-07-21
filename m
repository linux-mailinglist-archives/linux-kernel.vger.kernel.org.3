Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D957C4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGUHAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiGUHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:00:01 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A8657969A;
        Thu, 21 Jul 2022 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P7Abi
        l4H36otn2wsbYWWyQKJi103I/rzypr3iHP5Q2k=; b=jdDxLuWNQwuVWNriNgsy/
        3qtsnRh6zmafiCMFt7e68lnab2Sn/WXYuQIDT9/MmLyRsLo1t/eSEL/z/eT6QDB4
        MfpctHx53psDM5o2y/9AwbR/5StG6dEGWznvbYiyIpF9saYzapKcMSmf0V+I9H+v
        zwN2FsCBKv9qnKNpX9B3Uo=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp3 (Coremail) with SMTP id G9xpCgD3fV5o+dhiXse4QQ--.3284S2;
        Thu, 21 Jul 2022 14:59:55 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] s390/sthyi: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 14:59:50 +0800
Message-Id: <20220721065950.47992-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgD3fV5o+dhiXse4QQ--.3284S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFykWry3KFykGFyDAF15twb_yoW3Jwb_J3
        WxCw4kWw40y3yIvry8Zr4S9ryvkanYgFZYyrs2g3y7XFyDKrZxZ3sYvF4UGrn5Xws8JrZ3
        XF93W390va4qkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRd-PYUUUUUU==
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJQtFZGAJpJjHbAAAsx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 arch/s390/kernel/sthyi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/sthyi.c b/arch/s390/kernel/sthyi.c
index 4d141e2c132e..dfc350fab384 100644
--- a/arch/s390/kernel/sthyi.c
+++ b/arch/s390/kernel/sthyi.c
@@ -250,7 +250,7 @@ static void fill_diag_mac(struct sthyi_sctns *sctns,
 	sctns->mac.infmval1 |= MAC_CNT_VLD;
 }
 
-/* Returns a pointer to the the next partition block. */
+/* Returns a pointer to the next partition block. */
 static struct diag204_x_part_block *lpar_cpu_inf(struct lpar_cpu_inf *part_inf,
 						 bool this_lpar,
 						 void *diag224_buf,
-- 
2.25.1

