Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6ED476A45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhLPGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLPGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:14:57 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 953C7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 22:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=hlvjmNz9Ta
        7zMTtduJCDWHluXR2XR4Uohbj95WOScZ4=; b=bQk0tpAWwXUMbCpYM6Tb6Q7ajp
        ZS+YeKWFAAh/6u6elisFrtE8nEvqtoHxEjC9wOeQUhw5SkA1uIU9Sk/AtAM3uPFY
        O9RoL0i3KFODRTg0rhE6V88fg/Z1TLU66aEx1vSYQlT2XJNMgAe5F615UAofxdSn
        9Cvw9wIW38GOZyaZk=
Received: from localhost.localdomain (unknown [106.11.196.150])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDX3GxT2bphT1F7AA--.949S4;
        Thu, 16 Dec 2021 14:14:44 +0800 (CST)
From:   zhuxinran <zhuran@mail.ustc.edu.cn>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        zhuxinran <zhuran@mail.ustc.edu.cn>
Subject: [PATCH V2] 9p/trans_virtio: Fix typo in the comment for p9_virtio_create()
Date:   Thu, 16 Dec 2021 14:14:39 +0800
Message-Id: <20211216061439.4186-1-zhuran@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDX3GxT2bphT1F7AA--.949S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XFykur1ftF1kJr13WFykXwb_yoWfKrbEka
        48Z39Fvr1UAFW3CrWUCw4rXrn2kw4fGF4UJ39xKayI934DAFs8W3ykKr9xX3W8Wr1DCrn3
        tFZ8Xwn0vw1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: x2kx2t3q6ptxnoox23vfohv3gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment for p9_virtio_create()
couldlook ==> could look

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


