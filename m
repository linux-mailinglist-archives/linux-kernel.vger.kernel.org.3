Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15B4768B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 04:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhLPDdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 22:33:05 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43596 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233370AbhLPDdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 22:33:04 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvNxts7phuEwBAA--.5634S3;
        Thu, 16 Dec 2021 11:33:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rapidio: remove not used macro definition in rio_ids.h
Date:   Thu, 16 Dec 2021 11:33:00 +0800
Message-Id: <1639625581-22867-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639625581-22867-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639625581-22867-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvNxts7phuEwBAA--.5634S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw15Cry5GFWfXw4xCFW5Awb_yoWkZrb_Gw
        4UZrZ7Cr1UCFs2yw48tr9093W5X3srWr1kuw1fCrySyr1jyr45Jw45KF97AryFgrWFqrsa
        qa1kt3WSvw17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUxyv3DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of RIO_VID_FREESCALE, RIO_DID_MPC8560, RIO_DID_TSI500,
RIO_DID_TSI576 and RIO_DID_TSI721 are not used for many years in the
current code, so just remove them.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/rio_ids.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/rio_ids.h b/include/linux/rio_ids.h
index 4846f72..e74d884 100644
--- a/include/linux/rio_ids.h
+++ b/include/linux/rio_ids.h
@@ -9,15 +9,10 @@
 #ifndef LINUX_RIO_IDS_H
 #define LINUX_RIO_IDS_H
 
-#define RIO_VID_FREESCALE		0x0002
-#define RIO_DID_MPC8560			0x0003
-
 #define RIO_VID_TUNDRA			0x000d
-#define RIO_DID_TSI500			0x0500
 #define RIO_DID_TSI568			0x0568
 #define RIO_DID_TSI572			0x0572
 #define RIO_DID_TSI574			0x0574
-#define RIO_DID_TSI576			0x0578 /* Same ID as Tsi578 */
 #define RIO_DID_TSI577			0x0577
 #define RIO_DID_TSI578			0x0578
 
@@ -33,7 +28,6 @@
 #define RIO_DID_IDTCPS1616		0x0379
 #define RIO_DID_IDTVPS1616		0x0377
 #define RIO_DID_IDTSPS1616		0x0378
-#define RIO_DID_TSI721			0x80ab
 #define RIO_DID_IDTRXS1632		0x80e5
 #define RIO_DID_IDTRXS2448		0x80e6
 
-- 
2.1.0

