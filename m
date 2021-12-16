Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370F7476879
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhLPDIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbhLPDIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:08:54 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60C83C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=w1vsd7Ganf
        bTXy86A2IeFU7xbgNKpgAWPzP/c6CKamE=; b=g2kIdfjkrZ5wS6F0JaJfzCMcxq
        3otmN4Vji2nZ1yida2pXjtGnIO9FFmpg5KJ078Y51mmDe83sFic/tinCVokU4FVZ
        KYI07Ptwsct6hyCwMiP3BbT36Z/6C+00KgmNrO0a9S3haE9JamMYHeuhtAf+kW2w
        WB8Mpl9lANQOhGaPs=
Received: from localhost.localdomain (unknown [106.11.196.156])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXn2+2rbphTDl6AA--.300S4;
        Thu, 16 Dec 2021 11:08:39 +0800 (CST)
From:   zhuxinran <zhuran@mail.ustc.edu.cn>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        zhuxinran <zhuran@mail.ustc.edu.cn>
Subject: [PATCH] virtio: fix spelling error
Date:   Thu, 16 Dec 2021 11:08:36 +0800
Message-Id: <20211216030836.81989-1-zhuran@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCXn2+2rbphTDl6AA--.300S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF1xur4Uur4UZrW5ArWfuFg_yoWfCwbEka
        48X39Fvr1UAFW3CrWUCw4rXrn2kw4xWa1UX39xKayI934DXFs8W3ykKr9xX3W8Wr4DCrn7
        tFWDXrn0vw13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: x2kx2t3q6ptxnoox23vfohv3gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

start my first kernel patch commit

Signed-off-by: zhuxinran <zhuran@mail.ustc.edu.cn>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index bd5a89c4960d..f7dc561ca516 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -648,7 +648,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
  * @args: args passed from sys_mount() for per-transport options (unused)
  *
  * This sets up a transport channel for 9p communication.  Right now
- * we only match the first available channel, but eventually we couldlook up
+ * we only match the first available channel, but eventually we could look up
  * alternate channels by matching devname versus a virtio_config entry.
  * We use a simple reference count mechanism to ensure that only a single
  * mount has a channel open at a time.
-- 
2.33.1


