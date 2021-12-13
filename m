Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F947322B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhLMQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:46:07 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:60102 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhLMQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:45:58 -0500
X-QQ-mid: bizesmtp54t1639413940txmmgyuj
Received: from Z2zz.localdomain (unknown [218.17.40.219])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 14 Dec 2021 00:45:32 +0800 (CST)
X-QQ-SSF: 0140000000200040C000B00A0000000
X-QQ-FEAT: HLlK6K2y+MeY6hDC/4WuxThwsnoVOG7HtMajX9N7ihXsht2dMqWBXJ0yXmNSw
        x0WBWaNpArrYXyO82HU1hBN8GPx8jWIh+n1tQv4+VdJQdPrrpJW6pUSWCdVTynwgFIXPYMQ
        JiidyAQYRjXXdoLWhnwBVbHWcGj5DDoGQANAIJ+sREP2YQ3G2c2YGN7sc8rwSRneRPk63Z3
        lhC0MbHINN4BZyxZd82z5GERBgRRCJHy2Y4ZAkiQ/o0+r4PTIV9DECMVHX/za2rGwWNVcQp
        ozNyZIk1T4xdnjAtJw0aHut4AoX/QlB4BFIClhszLReGTkQBERzPuwpg6WjXe/SkIS4jxot
        t5YEf56Ph3mGvH/brHPCavfpYgdEw==
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, seanga2@gmail.com, weizhenliang@huawei.com,
        tangbin@cmss.chinamobile.com, zhangshengju@cmss.chinamobile.com,
        zhaochongxi2019@email.szu.edu.cn, zhangyinan2019@email.szu.edu.cn,
        linux-kernel@vger.kernel.org, caoyixuan2019@email.szu.edu.cn,
        hanshenghong2019@email.szu.edu.cn
Subject: [PATCH 2/2] tools/vm/page_owner_sort.c: two trivial fixes
Date:   Tue, 14 Dec 2021 00:45:18 +0800
Message-Id: <20211213164518.2461-1-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) There is an unused variable. It's better to delete it.
2) One case is missing in the usage().

Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index c16774f09eeb..a2c6797e09f8 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -41,8 +41,6 @@ static struct block_list *list;
 static int list_size;
 static int max_size;
 
-struct block_list *block_head;
-
 int read_block(char *buf, int buf_size, FILE *fin)
 {
 	char *curr = buf, *const buf_end = buf + buf_size;
@@ -249,7 +247,8 @@ static void usage(void)
 		"-p	Sort by pid.\n"
 		"-a	Sort by memory allocate time.\n"
 		"-r	Sort by memory release time.\n"
-		"-c	cull by comparing stacktrace instead of total block.\n"
+		"-c	Cull by comparing stacktrace instead of total block.\n"
+		"-f	Filter out the information of blocks whose memory has not been released.\n"
 	);
 }
 
-- 
2.30.1



