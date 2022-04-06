Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0214F5FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiDFNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDFNbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:31:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EF6E674212
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:30:26 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxusyWa01iAhAZAA--.30206S5;
        Wed, 06 Apr 2022 18:29:43 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Remove redundant file of PTRACE SUPPORT entry
Date:   Wed,  6 Apr 2022 18:29:41 +0800
Message-Id: <1649240981-11024-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1649240981-11024-1-git-send-email-yangtiezhu@loongson.cn>
References: <1649240981-11024-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxusyWa01iAhAZAA--.30206S5
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7k0a2IF6F4UM7kC6x804xWl14x267AK
        xVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IE
        w2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84
        ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxd
        M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
        wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwV
        W8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrAwsUUUUU
        =
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In MAINTAINERS PTRACE SUPPORT entry, the file include/uapi/linux/ptrace.h
is redundant, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d4..881e3ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15959,7 +15959,6 @@ F:	include/asm-generic/syscall.h
 F:	include/linux/ptrace.h
 F:	include/linux/regset.h
 F:	include/uapi/linux/ptrace.h
-F:	include/uapi/linux/ptrace.h
 F:	kernel/ptrace.c
 
 PULSE8-CEC DRIVER
-- 
2.1.0

