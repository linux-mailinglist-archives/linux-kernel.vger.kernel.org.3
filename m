Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD0F5ADDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiIFD0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFDZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:25:54 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EED013FA14;
        Mon,  5 Sep 2022 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QAbFV
        mFnZEYCK9bR4JBdapC1qdET+Fj8spsT+JJTRWg=; b=eQW6CVoxaNm5mkh2bOxDa
        8rZoZ5zcTy1n0oAqbk0HwydLsrdGk/b6oG8IVqyaaXVjYiyEuYUxHeIbcyPw+6be
        YqgkSu1/wTJDZE8Cut9qKR/c94ZParLidSiLPdA8jj4IzIRSWskBSzv5gRKAOabI
        i3LsCbwvj5MG9tQjGyTdPc=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp5 (Coremail) with SMTP id HdxpCgBHISCJvRZjVCHJaA--.36756S2;
        Tue, 06 Sep 2022 11:24:59 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     sfrench@samba.org
Cc:     pc@cjr.nz, lsahlber@redhat.com, sprasad@microsoft.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] cifs: misc: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 11:24:35 +0800
Message-Id: <20220906032435.932451-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBHISCJvRZjVCHJaA--.36756S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5JF47tryfCrg_yoW3XrX_Gw
        4kC3yqgrWUuF1Skw13Kw4S9F10ya15K395Cr1fArZ8Gay5Ca98Ga95tr4Sya4DWr4ktry3
        Jw45JF9FyrnrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbEoGtUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgt0+1Zcem5YyAAAs0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 fs/cifs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 87f60f736731..c6679398fff9 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -824,7 +824,7 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 	free_dentry_path(page);
 }
 
-/* parses DFS refferal V3 structure
+/* parses DFS referral V3 structure
  * caller is responsible for freeing target_nodes
  * returns:
  * - on success - 0
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

