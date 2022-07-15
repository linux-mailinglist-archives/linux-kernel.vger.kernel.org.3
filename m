Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6157598C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiGOCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:23:59 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6EF22B39
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZFrL+
        esrBW1XZQlSQnIERY71zAGJkbXasx766tTW6l4=; b=IpNlXPq6CDsKy0qkFPlNv
        9KXIteCV5Vhw7Cqw5gzsvFGBmcoJFrH5UTnmmsa+PhY0aSV6HbgusTRymgRdj8cy
        YpNTmMwupKEuSx4NBDs1WdPRDqGnkDjqWqP7MJO2FL9IJ9JP0VQ6gYU51krooC1L
        YtgxoE5aUPc8difBKfTTfo=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp10 (Coremail) with SMTP id DsCowACHRhegz9BiBfDLNA--.47419S2;
        Fri, 15 Jul 2022 10:23:30 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     luisbg@kernel.org, salah.triki@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/befs: Fix spelling typo in comment
Date:   Fri, 15 Jul 2022 10:23:00 +0800
Message-Id: <20220715022300.427979-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACHRhegz9BiBfDLNA--.47419S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GrWxZw1xGrg_yoW3Xwb_CF
        s2y3yxZ3yUtr4rtw48K39aqF1Fyw42gw15Grn8GrZIg3y7Aan8Xa95trWSya4DWr4Iga98
        WFWDJFykuF17JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnc_-DUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBthU-+11uPoYsUQAAsR
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/befs/linuxvfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index be383fa46b12..9d6b3d17cb2a 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -785,7 +785,7 @@ static int befs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-/* This function has the responsibiltiy of getting the
+/* This function has the responsibility of getting the
  * filesystem ready for unmounting.
  * Basically, we free everything that we allocated in
  * befs_read_inode
-- 
2.25.1

