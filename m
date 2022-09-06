Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8475AEFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiIFQJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiIFQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:08:51 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA43364EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Avs+l
        kNxs6NZXbIVlOQF+VhUGa8d5JIFiKFcr6zVKnE=; b=KU/WK+FeSv3nJFfMvmbHi
        ANdeHLMEt8yMqQGm3tEz9wm2ihQ7naMVrTnQV3Qg8GJ8xnPPfqAUxXu4oAEWG75A
        nKLGYL5FZd8BRBsnREl47l3LFxenX1VSr29H4gayA2tUSjqQCsZPB5xmpIzj23FG
        1Qh/ufr4pTKlVSfFJbyEI0=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp11 (Coremail) with SMTP id D8CowACnj9EpaBdjG4wsAQ--.54244S4;
        Tue, 06 Sep 2022 23:33:08 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] powerpc: remove redundant space
Date:   Tue,  6 Sep 2022 23:32:55 +0800
Message-Id: <20220906153255.6688-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACnj9EpaBdjG4wsAQ--.54244S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW5Jr4UXF1rtFWktryDAwb_yoW8Jw1kpr
        n7ta4FkFs5Ar1rJr1vga1Ygry7XrnrArWavw4jy397AF1UZrs5JF4F9r9xXF15tFyUua1S
        9FZ3uF1Sya1UC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRI31NUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoBV0F1zmWFxfuQABsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit remmove redundant space in arch/powerpc/sysdev/mmio_nvram.c

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 arch/powerpc/sysdev/mmio_nvram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/mmio_nvram.c b/arch/powerpc/sysdev/mmio_nvram.c
index eb48210ef98e..cc15b161ada6 100644
--- a/arch/powerpc/sysdev/mmio_nvram.c
+++ b/arch/powerpc/sysdev/mmio_nvram.c
@@ -35,7 +35,7 @@ static ssize_t mmio_nvram_read(char *buf, size_t count, loff_t *index)
 	memcpy_fromio(buf, mmio_nvram_start + *index, count);
 
 	spin_unlock_irqrestore(&mmio_nvram_lock, flags);
-	
+
 	*index += count;
 	return count;
 }
@@ -71,7 +71,7 @@ static ssize_t mmio_nvram_write(char *buf, size_t count, loff_t *index)
 	memcpy_toio(mmio_nvram_start + *index, buf, count);
 
 	spin_unlock_irqrestore(&mmio_nvram_lock, flags);
-	
+
 	*index += count;
 	return count;
 }
@@ -117,7 +117,7 @@ int __init mmio_nvram_init(void)
 	}
 	nvram_addr = r.start;
 	mmio_nvram_len = resource_size(&r);
-	if ( (!mmio_nvram_len) || (!nvram_addr) ) {
+	if ((!mmio_nvram_len) || (!nvram_addr)) {
 		printk(KERN_WARNING "nvram: address or length is 0\n");
 		ret = -EIO;
 		goto out;

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
-- 
2.34.1

