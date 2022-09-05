Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415455ACA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbiIEGD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiIEGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:02:59 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B52A226CC;
        Sun,  4 Sep 2022 23:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NuQKC
        dUKXx4rdmXZtnmMfxCywS0bFuHMt9usoaCMfzQ=; b=pNxU3WvpHndfCzwVtruhR
        bYikoVyrvnXsdp8oywMTbrT1Lc6nzZ1vTErSzeyVyWazTQ58PVr4k4tjmisZwiD5
        Y6muPwyLnK6HpkYHdpQTDB5RXku/9QT2jQsPG9HfIexthrR+zDPeFsFZTp3G62Y+
        LVE+qWfT+a8GskVs/Svx/4=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgBHIYv2kBVjLCX6aw--.29817S2;
        Mon, 05 Sep 2022 14:02:32 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/overlayfs/file.c: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 14:02:23 +0800
Message-Id: <20220905060223.1819929-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBHIYv2kBVjLCX6aw--.29817S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Xr4furWDXFb_yoW3twb_Wr
        yvvw40vrW5tayfZr45Cr1aqF9Yv3WYkry3JryYqr4UA395A398C3yvkF1xAryDurWrGrn8
        Ww1DXry7W34kJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1eyI5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBtgtz+11uQWOdnQAAsk
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
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index daff601b5c41..d17faeb014e5 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,7 +34,7 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 		return 'm';
 }
 
-/* No atime modificaton nor notify on underlying */
+/* No atime modification nor notify on underlying */
 #define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
 
 static struct file *ovl_open_realfile(const struct file *file,
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

