Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A647279B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhLMKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:03:03 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:38111 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhLMJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:58:19 -0500
X-QQ-mid: bizesmtp49t1639389481t19mqcvx
Received: from localhost.localdomain.localdoma (unknown [116.7.245.180])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 13 Dec 2021 17:57:45 +0800 (CST)
X-QQ-SSF: 01400000002000C0L000B00A0000000
X-QQ-FEAT: F3yR32iATbg/2eudlVbeKR0UBxvUR3BA3TWwn8l3R5jDG7Q2yHCCFpWxQDbWi
        JJEc96y894LigGKKVoGgK7OjljM1W4QuzKYnA+01USY2xiWQQeCyjN/4cIKwP883hkav2W9
        H+XNHYkWGeNG8N0bbUz4Yeorpy9FHiSR9yD2v2RyUMhK7ZUF6KNYvQLRIMc5b6WPaRmUPOb
        b78jQCS10EbjV7zdoCVwdlg0ObIiy7xvwC/KcKgO4etZyUUn35EIen+FWAPB8dpO2UK3Bux
        Xg4E4Ogb4NDy29kWI/w/AMnVI3YuXV8NjU4QpVO0hjnZCoGN2G/X8NHVV+/Ysv38uwelrel
        omQGWUCitBe3hPx5/pb5nUAEOWrguJweovXivqHVigE7LbGewk=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, seanga2@gmail.com, weizhenliang@huawei.com,
        tangbin@cmss.chinamobile.com, zhaochongxi2019@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] tools/vm/page_owner_sort.c: delete invalid duplicate code
Date:   Mon, 13 Dec 2021 17:57:43 +0800
Message-Id: <20211213095743.3630-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that there is two invalid lines of duplicate code.
It's better to delete it.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index c9fedc1806d5..e76addb2bfe7 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -229,8 +229,6 @@ static void add_list(char *buf, int len)
 	list[list_size].pid = get_pid(buf);
 	list[list_size].ts_nsec = get_ts_nsec(buf);
 	list[list_size].free_ts_nsec = get_free_ts_nsec(buf);
-	memcpy(list[list_size].txt, buf, len);
-	list[list_size].txt[len] = 0;
 	list_size++;
 	if (list_size % 1000 == 0) {
 		printf("loaded %d\r", list_size);
-- 
2.31.1



