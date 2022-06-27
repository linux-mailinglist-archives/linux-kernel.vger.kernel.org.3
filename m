Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740FB55DC38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiF0H1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiF0H1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:27:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECDE35F99;
        Mon, 27 Jun 2022 00:27:12 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb93MW7li8r1fAA--.5898S2;
        Mon, 27 Jun 2022 15:27:08 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] modpost: Add line break in the section mismatch warning
Date:   Mon, 27 Jun 2022 15:27:08 +0800
Message-Id: <1656314828-3544-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxb93MW7li8r1fAA--.5898S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UWF1UZF1fJryfuFyUZFb_yoW8Aw48pa
        yFk3sruryIyr4vqayIkrykZ347J34rWF93C3srCw4Dursruw1kZF97AF4xZF90yFWrAFWF
        qF48trn5uayqk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
        6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUVT5LUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section mismatch warning may be too long, add a line break
to make it more readable.

Without this patch:

  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
The symbol prom_init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

With this patch:

  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
The symbol prom_init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

This is based on Linux 5.19-rc4.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: update the commit message

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 620dc8c..4cc894f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1320,8 +1320,8 @@ static void report_sec_mismatch(const char *modname,
 	get_pretty_name(from_is_func, &from, &from_p);
 	get_pretty_name(to_is_func, &to, &to_p);
 
-	warn("%s(%s+0x%llx): Section mismatch in reference from the %s %s%s "
-	     "to the %s %s:%s%s\n",
+	warn("%s(%s+0x%llx): Section mismatch in reference\n"
+	     "from the %s %s%s to the %s %s:%s%s\n",
 	     modname, fromsec, fromaddr, from, fromsym, from_p, to, tosec,
 	     tosym, to_p);
 
-- 
2.1.0

