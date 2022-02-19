Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC44BC8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiBSOcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:32:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiBSOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:31:59 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C354BF8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 06:31:33 -0800 (PST)
X-QQ-mid: bizesmtp63t1645281079tii7f3sb
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 19 Feb 2022 22:31:14 +0800 (CST)
X-QQ-SSF: 01400000002000C0N000B00A0000000
X-QQ-FEAT: FXvDfBZI5O5ET4AQmWTjT68XUTmv+yE0pNMFYLZeenm75W2EqwwENh4bZWHl+
        S9XnVUDbT9BQkIiigHC7lPJ31B/NT/6HzE14M4gMGP8ZewOasF0XaYh12qi9vvcosWdFLYO
        PCo6XyA9oODXvOfcp3E7WRYHnHtoEqRArtqKTAdTDN86C0yxiAtXUg145O4s7CzcJrFSzTJ
        DZQjt5xkKv2/8x6E1SNLc5bsQ7/3FUcnu3MPaPFSC4X7Opw7hnWtKNnjVJwQuVUTNR5dEFr
        9SNafKwDz+xT3/lIYnpc5ATLUo0wUdF+MoU4zr0FOq+tLV8aZ8Y1Lxg3Z4ncpTw5EcoNDOV
        UxCgdZKtCITHHxns9k=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     sfr@canb.auug.org.au, seanga2@gmail.com, songmuchun@bytedance.com,
        zhaochongxi2019@email.szu.edu.cn, weizhenliang@huawei.com,
        tangbin@cmss.chinamobile.com, zhangyinan2019@email.szu.edu.cn,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] tools/vm/page_owner_sort.c: Fix the instructions for use
Date:   Sat, 19 Feb 2022 22:31:06 +0800
Message-Id: <20220219143106.2805-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a discrepancy between the usage method and the code logic.

If we enable the -f option,
it should be
Filter out the information of blocks whose memory has been released.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index de7b547c26aa..c93984eb8c2f 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -252,7 +252,7 @@ static void usage(void)
 		"-a	Sort by memory allocate time.\n"
 		"-r	Sort by memory release time.\n"
 		"-c	Cull by comparing stacktrace instead of total block.\n"
-		"-f	Filter out the information of blocks whose memory has not been released.\n"
+		"-f	Filter out the information of blocks whose memory has been released.\n"
 	);
 }
 
-- 
2.31.1



