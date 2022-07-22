Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73057DEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiGVKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGVKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:05:29 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DEA826AD6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x2mwE
        zHTzf1BuebLi+ZLWyUWAP+iN6mtVQKRbMv7/I8=; b=hVISmQrhtmXPMcxowh3+/
        CjF2bUcd7sy8QHa4f9PSec1OYNMRSFGZVzUcbtGd73GwDv3761ik3xa2RT1Cqriu
        OCp6OTX0NZ7NEiyPtxKDXJ3m+6wRW6hNSJDAN+iv6ikXXdr8szbL4p4Fq8Nl2QMI
        DGIWCEkGWrtMKguQCa2cv8=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgBneXRfdtpinwouPw--.8068S2;
        Fri, 22 Jul 2022 18:05:21 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] kernfs: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:05:18 +0800
Message-Id: <20220722100518.79741-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBneXRfdtpinwouPw--.8068S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyfZF48uF4UGF1fuFWrAFb_yoWfWrg_GF
        ykAa4xCw4jyF1xZw48uwsavFZ0vas8ZF1Fka1rK39xXw1UJ398Arn5Awn7Ar1rXF13AFWk
        u3Z2g3s0qrW3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtzuX3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxRGZGB0LoTtqAAAsO
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
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index baff4b1d40c7..b3ec34386b43 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -307,7 +307,7 @@ static ssize_t kernfs_fop_read_iter(struct kiocb *iocb, struct iov_iter *iter)
  * There is no easy way for us to know if userspace is only doing a partial
  * write, so we don't support them. We expect the entire buffer to come on
  * the first write.  Hint: if you're writing a value, first read the file,
- * modify only the the value you're changing, then write entire buffer
+ * modify only the value you're changing, then write entire buffer
  * back.
  */
 static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.25.1

